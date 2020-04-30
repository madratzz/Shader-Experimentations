// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Raza/LightmapShaders/Unlit/AlphaCutout"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Lightmap("Lightmap", 2D) = "white" {}
		_Cutoff("Cutoff", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 2.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
		};

		uniform sampler2D _Albedo;
		uniform half4 _Albedo_ST;
		uniform half _Cutoff;
		uniform sampler2D _Lightmap;
		uniform half4 _Lightmap_ST;


		half4 AlphaClip4( half4 ColIn , half Cutoff )
		{
			if (ColIn[3] < Cutoff) discard; return ColIn;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			half4 ColIn4 = tex2D( _Albedo, uv_Albedo );
			half Cutoff4 = _Cutoff;
			half4 localAlphaClip4 = AlphaClip4( ColIn4 , Cutoff4 );
			float2 uv2_Lightmap = i.uv2_texcoord2 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			o.Emission = ( localAlphaClip4 * tex2D( _Lightmap, uv2_Lightmap ) ).xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
0;73;1259;703;1152.128;230.3218;1;True;True
Node;AmplifyShaderEditor.SamplerNode;1;-804.5,-184.5;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-784.0459,72.32095;Inherit;False;Property;_Cutoff;Cutoff;2;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-586.5,233.5;Inherit;True;Property;_Lightmap;Lightmap;1;0;Create;True;0;0;False;0;-1;None;None;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;4;-474.5,-66.5;Inherit;False;if (ColIn[3] < Cutoff) discard@ return ColIn@;4;False;2;True;ColIn;FLOAT4;0,0,0,0;In;;Float;False;True;Cutoff;FLOAT;0;In;;Float;False;AlphaClip;True;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-231.5,47.5;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Half;False;True;-1;0;ASEMaterialInspector;0;0;Unlit;Raza/LightmapShaders/Unlit/AlphaCutout;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;4;1;5;0
WireConnection;3;0;4;0
WireConnection;3;1;2;0
WireConnection;0;2;3;0
ASEEND*/
//CHKSM=41952D5F29DE0048FA43AC034C77666475EC2AFB