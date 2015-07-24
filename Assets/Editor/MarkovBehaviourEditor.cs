using System;
using UnityEditor;
using UnityEngine;


[CustomEditor (typeof(MarkovBehaviour))]
public class MarkovBehaviourEditor : Editor
{
	public override void OnInspectorGUI () {

		MarkovBehaviour myScript = (MarkovBehaviour)target;



		EditorGUILayout.BeginVertical();

		myScript.text = GUILayout.TextArea (myScript.text);


		if(GUILayout.Button("MarkovIt!"))
		{
			myScript.MarkovIt ();
		}

		if(GUILayout.Button("LearnIt!"))
		{
			myScript.LearnIt ();
		}

		EditorGUILayout.EndVertical();
	}
}

