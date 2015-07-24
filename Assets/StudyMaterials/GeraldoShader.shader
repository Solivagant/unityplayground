Shader "Custom/GeraldoShader" {
	Properties {
		_Color1 ("Color 1", Color) = (1,1,1,1)
		_Color2 ("Color 2", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "red" {}
		_NoiseTex ("Noise", 2D) = "red" {}

		_Amount ("Extrusion Amount", Range(-1,1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		// #pragma surface surf Standard fullforwardshadows

		//surface shader using the lambertian reflectance lighting model, an ideal matte or diffusely reflecting surface
		// The apparent brightness of a Lambertian surface to an observer is the same regardless of the observer's angle of view.
		#pragma surface surf Lambert  vertex:vert

		// vertex:vert fragment frag//(containes a surface and a verte x shader)

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NoiseTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_NoiseTex;
		};

		fixed4 _Color1;
		fixed4 _Color2;
		fixed4 _MixedColor;

		float _Amount;

		//moves vertices along their normal
		//on 2D textures ends up as simply moving the Z index, since all of the 2d object has the same normal
		void vert (inout appdata_full v) {
		    v.vertex.xyz += v.normal * _Amount;
		}

		// fixed4 frag(float4 sp:VPOS) : SV_Target {
           

  //       }

        //Time parameter to have the stuff moving
        //variants and uniforms

		//Generating random values:
		//What you generally do when you want a random value in a pixel shader is to pass in a texture containing noise. While it's not actually "random" - it looks random.

		//The surface function doesn’t use any data from the original 3D model; despite this, Cg / HLSL requires a input struct to be defined.
		void surf (Input IN, inout SurfaceOutput o) {
			//Random value
			fixed4 random = tex2D(_NoiseTex, IN.uv_NoiseTex);

			_MixedColor = fixed4(_Color1.x, _Color2.y, _Color2.z, _Color1.w);

			// Albedo comes from a texture tinted by color
			fixed4 color = tex2D (_MainTex, IN.uv_MainTex) * _MixedColor;

			o.Albedo = color.rgb;
			// o.Albedo = fixed3((((int)(_Time.y*100000))%100)/100, (((int)(_Time.y*100000))%100)/100, (((int)(_Time.y*100000))%100)/100);
			// o.Albedo = fixed3((((int)(_Time.y))%100)/100, (((int)(_Time.y))%100)/100, (((int)(_Time.y))%100)/100);

			int magicNumber = 10;

			// o.Albedo = fixed3((((int)(_Time.y))%magicNumber)/magicNumber, (((int)(_Time.y))%magicNumber)/magicNumber, (((int)(_Time.y))%magicNumber)/magicNumber);
			
			//currently is capped and comes back to beginning but its not smooth cause its int, need to fix
			// o.Albedo = fixed3((((int)_Time.y)%magicNumber)/magicNumber, (((int)_Time.y)%magicNumber)/magicNumber, (((int)_Time.y)%magicNumber)/magicNumber);
			o.Alpha = color.a;
			o.Emission = random;
			// o.Emission = random;
			o.Gloss = 1;

			// o.Specular = 
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
