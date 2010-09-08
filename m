From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Tue, 07 Sep 2010 21:28:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009072119210.19366@xanadu.home>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:26056 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab0IHB2e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2010 21:28:34 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8E00J2CMRLJQ80@VL-MO-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 07 Sep 2010 21:28:33 -0400 (EDT)
In-reply-to: <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

On Tue, 7 Sep 2010, Bing Zhao wrote:

> Thanks for the hint.
> 
> The new patch skips reading CCCR, common CIS, and validation of 
> vendor/device IDs inside mmc_sdio_init_card() when powered_resume is 
> not zero.

Why do you skip the reading of the CIS and IDs validation?  That's 
basically the main reason for still calling mmc_sdio_init_card().  And 
that only requires CMD 52 so that should be fine.


Nicolas
