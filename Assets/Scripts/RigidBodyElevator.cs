using UnityEngine;
using System.Collections;
using DG.Tweening;

public class RigidBodyElevator : MonoBehaviour {

    public float maxY;
    public float minY;
    public float duration;

    private Rigidbody _rb;

	// Use this for initialization
	void Start () {
        _rb = GetComponent<Rigidbody>();
        Down();
	}

    void Up()
    {
        _rb.DOMoveY(maxY, duration).SetEase(Ease.InOutQuad).OnComplete(() => Down());
    }

    void Down()
    {
        _rb.DOMoveY(minY, duration).SetEase(Ease.InOutQuad).OnComplete(() => Up());
    }
}
