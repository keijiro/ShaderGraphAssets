using UnityEngine;
using Klak.Chromatics;

[ExecuteInEditMode]
public class CosineGradientSetter : MonoBehaviour
{
    [SerializeField] CosineGradient _gradient = CosineGradient.DefaultGradient;
    [SerializeField] string _propertyName = "_Gradient";

    MaterialPropertyBlock _block;

    void Update()
    {
        var renderer = GetComponent<Renderer>();
        if (renderer == null) return;

        if (_block == null) _block = new MaterialPropertyBlock();

        renderer.GetPropertyBlock(_block);
        _block.SetMatrix(_propertyName, _gradient);
        renderer.SetPropertyBlock(_block);
    }
}
