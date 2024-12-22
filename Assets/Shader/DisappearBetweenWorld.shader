Shader "Unlit/DisappearBetweenWorld"
{
  Properties
    {
        
        _TexWorld2("Texture World 2 ", 2D) = "purple" {}
        
        _Noise("Noise Texture",2D)="black" {}
        
    }
    SubShader
    {
        Tags {"RenderPipeline"="UniversalRenderPipeline" "Queue" = "Transparent"  }

        Pass
        { 
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            HLSLPROGRAM
            
             
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
           
            float4 _Position;
            float _Radius;

            TEXTURE2D(_TexWorld2);
            SAMPLER(sampler_TexWorld2);
            float4 _TexWorld2_ST;

            sampler2D _Noise;

            float _EdgeRadius;

            float4 _EdgeColor;
            
            #pragma vertex vert
            #pragma fragment frag

            struct Input
            {
                float4 positionOS:POSITION;
                float2 uv:TEXCOORD0;
            };

            struct v2f
            {
                float4 positionCS:SV_POSITION;
                float4 positionWS:TEXCOORD1;
                float2 uv:TEXCOORD0;
            };


            v2f vert (Input vertInput)
            {
                v2f ret;
                ret.positionCS = mul(UNITY_MATRIX_MVP, vertInput.positionOS);
                ret.positionWS = mul(UNITY_MATRIX_M, vertInput.positionOS) ;

                ret.uv = TRANSFORM_TEX(vertInput.uv, _TexWorld2);
                return ret;
            }

            float4 frag (v2f fragInput) : SV_Target
            {
                float4 color1 = {0,0,0,0};
                float4 color2 = SAMPLE_TEXTURE2D(_TexWorld2, sampler_TexWorld2, fragInput.uv);
                
                
                float4 Distance = distance(fragInput.positionWS,_Position);
                float4 Sphere = saturate(Distance/_Radius);

                float4 ntop = tex2D(_Noise,fragInput.positionWS.xz+_Time);
                Sphere= Sphere + (ntop*Sphere);
                
                
                float CutOff= step(0.5,Sphere);

                
                float4 FinalColor = lerp(color2,color1,CutOff);

                float Edge =step(Sphere.r,0.5+_EdgeRadius)*CutOff;

                float4 FinalEdgeColor = Edge*_EdgeColor;
                
                return FinalColor+FinalEdgeColor;
                
            }
            ENDHLSL
        }
    }
}
