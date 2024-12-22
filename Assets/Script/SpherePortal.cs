using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class SpherePortal : MonoBehaviour
{
    [SerializeField]
    private float SphereRadius = 1;
    
    [SerializeField]
    private Color EdgeColor= Color.white ;

    [SerializeField]
    private float EdgeRadius= 0.05f;

    private Vector3 _lastPosition;
    private float _lastRadius;
    private Color _lastEdgeColor;
    private float _lastedgeRadius;
    

    void Update()
    {
        if (_lastPosition != transform.position)
        {
            Shader.SetGlobalVector("_Position", transform.position);
            _lastPosition = transform.position;
        }

        if (_lastRadius != SphereRadius)
        {
            Shader.SetGlobalFloat("_Radius",Mathf.Abs(SphereRadius));
            _lastedgeRadius = SphereRadius;
        }

        if (_lastEdgeColor != EdgeColor)
        {
            Shader.SetGlobalColor("_EdgeColor",EdgeColor);
            _lastEdgeColor = EdgeColor;
        }

        if (_lastedgeRadius != EdgeRadius)
        {
            Shader.SetGlobalFloat("_EdgeRadius",Mathf.Abs(EdgeRadius));
            _lastedgeRadius = EdgeRadius;
        }
        
    }
}





























/*
 
  [SerializeField]
    private float radius = 0f;
    
    private Vector3 _lastPos = new Vector3(0, 0, 0);
    private float _LastRadius = 0;
    
    
    
 if (_lastPos != transform.position)
        {
            Shader.SetGlobalVector("_Position",transform.position);
            _lastPos = transform.position;
        }

        if (_LastRadius != radius)
        {
            Shader.SetGlobalFloat("_Radius",radius);
            _LastRadius = radius;
        }
        
*/