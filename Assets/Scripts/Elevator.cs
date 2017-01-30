using UnityEngine;
using System.Collections;
using DG.Tweening;

public class Elevator : MonoBehaviour {

    public float maxY;
    public float minY;
    public float duration;

	// Use this for initialization
	void Start () {
        Down();
	}

    void Up()
    {
        transform.DOMoveY(maxY, duration).SetEase(Ease.InOutQuad).OnComplete(() => Down());
    }

    void Down()
    {
        transform.DOMoveY(minY, duration).SetEase(Ease.InOutQuad).OnComplete(() => Up());
    }
}
