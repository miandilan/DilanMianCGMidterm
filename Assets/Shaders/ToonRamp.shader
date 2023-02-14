Shader "Custom/ToonRamp"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)//our standard properties
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _myBump("Bump Texture", 2D) = "bump" {}//These are the addition of our detailed bump texture
        _mySlider("Bump Amount", Range(0,10)) = 1
    }
    SubShader
    {
       

        CGPROGRAM
    #pragma surface surf Ramp//this ensures the program compiles as a ramp surface shader

    sampler2D _Ramp;

    half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten) {
        half NdotL = dot(s.Normal, lightDir);//dot product of the surface normal and light direction, its the cosine angle between them
        half diff = NdotL * 0.5 + 0.5;//diffuse lighting 
        half3 ramp = tex2D(_Ramp, float(diff)).rgb;//ramp effect with the colors of the diffuse lighting
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * ramp * atten;//the creation of the final outputted colors
        c.a = s.Alpha;
        return c;
    }

    struct Input {
        float2 uv_MainTex;//the outputted texture uv coords
        float2 uv_myBump;//This should unlock the bump texture coords
        float3 viewDir;
    };

    sampler2D _MainTex;
    float4 _Color;
    sampler2D _myBump;
    half _mySlider;//This can let you use the slider

    void surf(Input IN, inout SurfaceOutput o) {
        o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color.rgb; //the colors are applied through the albedo for each uv coordinate
        o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
        o.Normal = float3(_mySlider, _mySlider, 1);
    }
    ENDCG
    }
    FallBack "Diffuse"
}
