using UnityEngine;
using System.Collections;

public class DualTexSwitch : MonoBehaviour {

    public float switchSpeed;

    private Renderer _renderer;
    private bool _add;
    private float _value;

	void Start () {
        _renderer = GetComponent<Renderer>();
        _add = true;
	}
	
	// Update is called once per frame
	void Update () {

        _value = _renderer.material.GetFloat("_Tween");

        if (_add) {
            _value += 0.01f * switchSpeed * Time.deltaTime;

            _renderer.material.SetFloat("_Tween", _value);

            if (_value >= 1)
                _add = false;
        }
        else
        {
            _value -= 0.01f * switchSpeed * Time.deltaTime;

            _renderer.material.SetFloat("_Tween", _value);

            if (_value <= 0)
                _add = true;
        }
	}
}
