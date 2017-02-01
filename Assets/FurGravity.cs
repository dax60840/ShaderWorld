using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FurGravity : MonoBehaviour {

    public float velocityImpact;

    private Renderer _rend;
    private Rigidbody _rb;
    private Vector3 _gValue;

    void Start () {
        _rend = GetComponent<Renderer>();
        _rb = GetComponent<Rigidbody>();
        _gValue = _rend.material.GetVector("_Gravity");
    }
	
	// Update is called once per frame
	void Update () {

        if(-transform.up.normalized != _gValue.normalized)
            _rend.material.SetVector("_Gravity", _gValue + transform.up * velocityImpact);

    }
}
