using UnityEngine;
using System.Collections;
using DG.Tweening;

public class TwoTargets : MonoBehaviour
{

    public GameObject target1;
    public GameObject target2;
    public float time;

    private bool _target1;
    private bool _moving;

    // Update is called once per frame
    void Update()
    {
        if (_target1 && !_moving)
        {
            _moving = true;
            transform.DOMoveX(target2.transform.position.x, time).SetEase(Ease.InOutBack).OnComplete(() => { _target1 = false; _moving = false; });
        }
        else if (!_target1 && !_moving)
        {
            _moving = true;
            transform.DOMoveX(target1.transform.position.x, time).SetEase(Ease.InOutBack).OnComplete(() => { _target1 = true; _moving = false; });
        }
    }
}
