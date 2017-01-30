using UnityEngine;
using System.Collections;

public class Move : MonoBehaviour {

    public float speed;

	// Update is called once per frame
	void Update () {

	    if(Input.GetAxisRaw("Horizontal") != 0 || Input.GetAxisRaw("Vertical") != 0)
        {
            var x = Input.GetAxis("Horizontal") * speed * Time.deltaTime;
            var z = Input.GetAxis("Vertical") * speed * Time.deltaTime;
            transform.position += new Vector3(x, 0, z);

        }
	}
}
