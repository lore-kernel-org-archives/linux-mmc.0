From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Wed, 15 Sep 2010 17:27:10 -0700
Message-ID: <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
	 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
	 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
	 <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
	 <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
	 <alpine.LFD.2.00.1009072119210.19366@xanadu.home>
	 <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
 <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:41768 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0IPA2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 20:28:33 -0400
In-Reply-To: <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

Hi Sahitya,

> -----Original Message-----
> From: Sahitya Tummala [mailto:stummala@codeaurora.org]
> Sent: Tuesday, September 14, 2010 3:16 AM
> To: Bing Zhao
> Cc: Nicolas Pitre; linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball; Andrew Morton
> Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
> 
> Hi Bing, Chris,
> 
> On Tue, 2010-09-07 at 19:10 -0700, Bing Zhao wrote:
> > Hi Nicolas,
> >
> > > -----Original Message-----
> > > From: Nicolas Pitre [mailto:nico@fluxnic.net]
> > > Sent: Tuesday, September 07, 2010 6:29 PM
> > > To: Bing Zhao
> > > Cc: linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball; Andrew Morton
> > > Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
> > >
> > > On Tue, 7 Sep 2010, Bing Zhao wrote:
> > >
> > > > Thanks for the hint.
> > > >
> > > > The new patch skips reading CCCR, common CIS, and validation of
> > > > vendor/device IDs inside mmc_sdio_init_card() when powered_resume is
> > > > not zero.
> > >
> > > Why do you skip the reading of the CIS and IDs validation?  That's
> > > basically the main reason for still calling mmc_sdio_init_card().  And
> > > that only requires CMD 52 so that should be fine.
> >
> > While the system is suspended, the SDIO card could be in sleep mode (deep sleep or IEEE Power Save)
> as well. Reading CIS or any other CMD52 will fail if the card happens to be in sleep at this moment.
> If we skip re-initialization (including CCCR/CIS and IDs validation), mmc_sdio_init_card() returns
> success. Then the client driver's resume() handler will be called and the card can be woken up by
> client driver.
> 
> In one of your previous patches, "sdio: don't use CMD[357] as part of a
> powered SDIO resume", its mentioned that there is an issue with CMD7 in
> mmc_sdio_init_card() that is called during SDIO resume on Marvell 8686.
> 
> But in mmc_resume_host(), there is still a call to mmc_detect_change()
> which in turn calls mmc_sdio_detect(), thus sending CMD7 to the card.
> Does CMD7 to your card succeed after your client driver resume is
> called?

If CMD7 is sent _before_ client driver's resume handler is called, while 8686 card is in sleep mode, it will fail. If CMD7 is sent _after_ client driver's resume handler is called, it should succeed.

By the way, a patch "mmc: fix all hangs related to mmc/sd card insert/removal during suspend/resume" (4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e by Maxim Levitsky) has removed the call to mmc_detect_change() in mmc_resume_host().

Regards,

Bing

> 
> Thanks,
> Sahitya.
> 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
> 

