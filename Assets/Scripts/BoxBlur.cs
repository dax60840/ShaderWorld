using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class BoxBlur : MonoBehaviour {

    public Material effectMaterial;
    [Range(0, 10)]
    public int iterations;
    [Range(0, 4)]
    public int downRes;

    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        int width = src.width >> downRes;
        int height = src.height >> downRes;


        RenderTexture rt = RenderTexture.GetTemporary(width, height);
        Graphics.Blit(src, rt);

        for(int i = 0; i < iterations; i++)
        {
            RenderTexture rt2 = RenderTexture.GetTemporary(width, height);
            Graphics.Blit(rt, rt2, effectMaterial);
            RenderTexture.ReleaseTemporary(rt);
            rt = rt2;
        }

        Graphics.Blit(rt, dst);
        RenderTexture.ReleaseTemporary(rt);
    }
}