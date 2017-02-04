using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class FurGravity : MonoBehaviour {

    public float time;
    public float weight;

    private Renderer _rend;
    private Vector3 _gValue;
    private Vector3 _lastposition;
    private Vector3 _velocity;

    void Start () {
        _rend = GetComponent<Renderer>();
        _gValue = _rend.material.GetVector("_Gravity");
        _lastposition = transform.position;
    }
	
	// Update is called once per frame
	void Update ()
    {
        _velocity = Vector3.Lerp( _velocity, (transform.position - _lastposition), Time.deltaTime);
        _lastposition = transform.position;
        Vector3 targetVector = (-(_velocity * weight)- Vector3.up) * _gValue.y;
        DOTween.To(() => (Vector3)_rend.material.GetVector("_Gravity"), (x) => _rend.material.SetVector("_Gravity", x), targetVector, time * _velocity.magnitude);
    }

}
