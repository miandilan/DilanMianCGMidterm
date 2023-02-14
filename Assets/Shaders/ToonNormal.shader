Shader "Custom/ToonNormal"{
    Properties{
        _MainTex("Texture", 2D) = "white" {}
        _NormalMap("Normal Map", 2D) = "bump" {}
        _ToonRamp("Toon Ramp", 2D) = "white" {}
        _Blend("Blend", Range(0, 1)) = 0.5
    }

        SubShader{
            Tags {"RenderType" = "Opaque"}
            LOD 200

            Pass {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                struct appdata {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal : NORMAL;
                };

                struct v2f {
                    float2 uv : TEXCOORD0;
                    float3 normal : TEXCOORD1;
                    float3 viewDir : TEXCOORD2;
                    float4 vertex : SV_POSITION;
                };

                sampler2D _MainTex;
                sampler2D _NormalMap;
                sampler2D _ToonRamp;
                float _Blend;

                v2f vert(appdata v) {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = v.uv;
                    o.normal = normalize(v.normal);
                    o.viewDir = normalize(-o.vertex.xyz);
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target {
                    fixed4 col = tex2D(_MainTex, i.uv);
                    float3 normal = UnpackNormal(tex2D(_NormalMap, i.uv));
                    float3 toonColor = tex2D(_ToonRamp, col.r).rgb;
                    float diffuse = max(dot(i.normal, i.viewDir), 0);
                    diffuse = pow(diffuse, 4);
                    float3 diffuseColor = diffuse * col.rgb;
                    float3 normalColor = diffuse * normal.rgb * col.rgb;
                    float3 blendedColor = lerp(diffuseColor, normalColor, _Blend);
                    blendedColor = lerp(toonColor, blendedColor, _Blend);
                    return fixed4(blendedColor, 1);
                }
                ENDCG
            }
        }
            FallBack "Diffuse"
}
