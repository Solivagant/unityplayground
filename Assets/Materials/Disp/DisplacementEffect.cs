using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class DisplacementEffect : MonoBehaviour
{
    [Range(-1, +1)]
    public float strength;
    public Material material;

    // Postprocess the image
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (strength == 0)
        {
            Graphics.Blit(source, destination);
            return;
        }

        material.SetFloat("_Strength", strength);
        Graphics.Blit(source, destination, material);
    }
}