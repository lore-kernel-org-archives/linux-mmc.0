From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Tue, 7 Sep 2010 19:10:08 -0700
Message-ID: <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009072119210.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:35982 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab0IHCKO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2010 22:10:14 -0400
In-Reply-To: <alpine.LFD.2.00.1009072119210.19366@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Nicolas,

> -----Original Message-----
> From: Nicolas Pitre [mailto:nico@fluxnic.net]
> Sent: Tuesday, September 07, 2010 6:29 PM
> To: Bing Zhao
> Cc: linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball; Andrew Morton
> Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
> 
> On Tue, 7 Sep 2010, Bing Zhao wrote:
> 
> > Thanks for the hint.
> >
> > The new patch skips reading CCCR, common CIS, and validation of
> > vendor/device IDs inside mmc_sdio_init_card() when powered_resume is
> > not zero.
> 
> Why do you skip the reading of the CIS and IDs validation?  That's
> basically the main reason for still calling mmc_sdio_init_card().  And
> that only requires CMD 52 so that should be fine.

While the system is suspended, the SDIO card could be in sleep mode (deep sleep or IEEE Power Save) as well. Reading CIS or any other CMD52 will fail if the card happens to be in sleep at this moment. If we skip re-initialization (including CCCR/CIS and IDs validation), mmc_sdio_init_card() returns success. Then the client driver's resume() handler will be called and the card can be woken up by client driver.

Regards,

Bing

> 
> 
> Nicolas
