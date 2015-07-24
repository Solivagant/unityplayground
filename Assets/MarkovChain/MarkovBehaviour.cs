using System;
using UnityEngine;
using System.Collections.Generic;
using Markov;

public class MarkovBehaviour : MonoBehaviour
{
	MarkovChain markov;
	public string text = "I am silently ignoring bad ids because they are entered by content editors who want to pull in certain images on to their pages, however I can put validation on the field to stop that from happening I suppose";

	void Start()
	{
		markov = new MarkovChain();
		markov.Load(text);
	}

	public void MarkovIt()
	{

		Debug.Log(markov.Output());
	}

	public void LearnIt()
	{
		markov.Load(text);
	}
}

