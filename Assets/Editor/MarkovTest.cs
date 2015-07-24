using System;
using System.Collections.Generic;
using System.Threading;
using NUnit.Framework;
using UnityEngine;

[TestFixture]
[Category("Markov Tests")]
public class MarkovTest
{
	[Test]
	public void MarkovChainTest()
	{
		string text = "I am silently ignoring bad ids because they are entered by content editors who want to pull in certain images on to their pages, however I can put validation on the field to stop that from happening I suppose";

		Markov.MarkovChain markov = new Markov.MarkovChain();
		markov.Load(text);

		Debug.Log (markov.Output ());
	}


}
