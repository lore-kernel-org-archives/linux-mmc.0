From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Wed, 15 Sep 2010 22:26:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009152222400.19366@xanadu.home>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009072119210.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
 <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com>
 <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:42749 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab0IPC0G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 22:26:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8T00LVLIRDXL60@VL-MR-MRZ20.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 15 Sep 2010 22:26:01 -0400 (EDT)
In-reply-to: <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On Wed, 15 Sep 2010, Bing Zhao wrote:

> If CMD7 is sent _before_ client driver's resume handler is called, 
> while 8686 card is in sleep mode, it will fail. If CMD7 is sent 
> _after_ client driver's resume handler is called, it should succeed.

Maybe that's what we should do in the powered suspend case then.

> By the way, a patch "mmc: fix all hangs related to mmc/sd card 
> insert/removal during suspend/resume" 
> (4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e by Maxim Levitsky) has 
> removed the call to mmc_detect_change() in mmc_resume_host().

If a card is removed while the host is suspended, then this should be 
detected.


Nicolas
