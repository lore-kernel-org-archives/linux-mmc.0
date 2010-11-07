From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Sat, 06 Nov 2010 21:44:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011062139370.18581@xanadu.home>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:17594 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0KGBob (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2010 21:44:31 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBH007P0RHXSV00@vl-mo-mrz23.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sat, 06 Nov 2010 21:44:21 -0400 (EDT)
In-reply-to: <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linus.Walleij@stericsson.com" <linus.Walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, 6 Nov 2010, Philip Rakity wrote:

> 
> We need a way to specify
> 
> a) Hardware can support clock gating setting the clock to 0 in the 
> call to set_ios (with hardware clock gating enabled) becomes a no-op 
> so some care is needed which is why I suggested another field in the 
> ios structure.

Why should the core code care?

What difference is there with the core telling the controller driver to 
set the clock to a frequency of 0 ?


Nicolas
