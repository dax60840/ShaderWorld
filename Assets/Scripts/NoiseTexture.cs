﻿using UnityEngine;
using System.Collections;

public class NoiseTexture : MonoBehaviour {

    public bool sendTexture;
    public int pixWidth;
    public int pixHeight;
    public float xOrg;
    public float yOrg;
    public float scale = 1.0F;
    public float ceil = 0;
    public float rotation = 15;
    private Texture2D noiseTex;
    private Color[] pix;
    private Renderer rend;

    void Start()
    {
        rend = GetComponent<Renderer>();
        noiseTex = new Texture2D(pixWidth, pixHeight);
        pix = new Color[noiseTex.width * noiseTex.height];
        rend.material.mainTexture = noiseTex;
        CalcNoise();
        if (sendTexture)
        {
            rend.material.SetTexture("_FurTex", noiseTex);
        }
    }

    void Update()
    {
        transform.Rotate(rotation * Time.deltaTime, 0, 0);
    }

    void CalcNoise()
    {
        float y = 0.0F;
        while (y < noiseTex.height)
        {
            float x = 0.0F;
            while (x < noiseTex.width)
            {
                float xCoord = xOrg + x / noiseTex.width * scale;
                float yCoord = yOrg + y / noiseTex.height * scale;
                float sample = Mathf.PerlinNoise(xCoord, yCoord);
                if (sample > ceil)
                {
                    sample = 1;
                }
                pix[(int)(y * noiseTex.width + x)] = new Color(sample, sample, sample, 1 - sample);
                x++;
            }
            y++;
        }
        noiseTex.SetPixels(pix);
        noiseTex.Apply();
    }
}
