From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Sun, 07 Nov 2010 23:33:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011072328300.18581@xanadu.home>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
 <alpine.LFD.2.00.1011062139370.18581@xanadu.home>
 <AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:58046 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab0KHEdq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 23:33:46 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBJ006BWTZV2X90@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sun, 07 Nov 2010 23:33:31 -0500 (EST)
In-reply-to: <AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linus.Walleij@stericsson.com" <linus.Walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sun, 7 Nov 2010, Philip Rakity wrote:

> 
> On Nov 6, 2010, at 6:44 PM, Nicolas Pitre wrote:
> 
> > On Sat, 6 Nov 2010, Philip Rakity wrote:
> > 
> >> 
> >> We need a way to specify
> >> 
> >> a) Hardware can support clock gating setting the clock to 0 in the 
> >> call to set_ios (with hardware clock gating enabled) becomes a no-op 
> >> so some care is needed which is why I suggested another field in the 
> >> ios structure.
> > 
> > Why should the core code care?
> > 
> > What difference is there with the core telling the controller driver to 
> > set the clock to a frequency of 0 ?
> 
> When h/w clock gating is enabled then sd clocks are disabled/enabled 
> by the sd controller; there is nothing for the core/ layer to do.

OK, then that could be an optimization.

> I am concerned that having the core/ layer ask for clocks off and on 
> is
> 
> a) not needed when h/w clock gating is enabled

Sure, but right now it shouldn't be enabled just yet.  Making sure that 
the software version works well should be done first.

> b) may invoke bad behavior in the controller

That would be a really bad controller.

> c) is not optimal since the h/w is already handling this. --

Agreed.  But again let's make sure that the software version works 
first.  Then adding support for hardware clock gating would be really 
simple.


Nicolas
