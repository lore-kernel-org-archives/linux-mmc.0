From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Fri, 21 Jan 2011 21:55:54 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101212148320.8580@xanadu.home>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009072119210.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
 <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com>
 <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009152222400.19366@xanadu.home>
 <AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F704307F4EA2865@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_v2JkPYnqO9yHuqokw5s8ag)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:35112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab1AVCzz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 21:55:55 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFE00J6LLFOI050@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 21 Jan 2011 21:55:00 -0500 (EST)
In-reply-to: <477F20668A386D41ADCC57781B1F704307F4EA2865@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_v2JkPYnqO9yHuqokw5s8ag)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Fri, 21 Jan 2011, Bing Zhao wrote:

> Hi Zhangfei,
> 
> > -----Original Message-----
> > From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
> > Sent: Friday, January 21, 2011 1:07 AM
> > To: Nicolas Pitre; Bing Zhao
> > Cc: Sahitya Tummala; linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball; Andrew Morton; Maxim
> > Levitsky
> > Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
> > 
> > On Wed, Sep 15, 2010 at 10:26 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > On Wed, 15 Sep 2010, Bing Zhao wrote:
> > >
> > >> If CMD7 is sent _before_ client driver's resume handler is called,
> > >> while 8686 card is in sleep mode, it will fail. If CMD7 is sent
> > >> _after_ client driver's resume handler is called, it should succeed.
> > >
> > > Maybe that's what we should do in the powered suspend case then.
> > >
> > >> By the way, a patch "mmc: fix all hangs related to mmc/sd card
> > >> insert/removal during suspend/resume"
> > >> (4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e by Maxim Levitsky) has
> > >> removed the call to mmc_detect_change() in mmc_resume_host().
> > >
> > > If a card is removed while the host is suspended, then this should be
> > > detected.
> > >
> > >
> > > Nicolas
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > 
> > Hi, Bing
> > 
> > Do you have any updated patch to skip mmc_sdio_init_card in resume back.
> > We need such patch in enable host sleep feature for mrvl8787.
> 
> I posted a patch that skips mmc_sdio_init_card() with MMC_PM_SKIP_RESUME_PROBE flag earlier:
> 
> [PATCH v1] sdio: add MMC_PM_SKIP_RESUME_PROBE to workaround powered resume
> http://marc.info/?l=linux-mmc&m=128294262424567&w=2
> 
> Nicolas commented that it's too hackish with this approach.
> http://marc.info/?l=linux-mmc&m=128294738230151&w=2
> 
> Other than that, I couldn't think of a better way to solve the issue here:
> 
> In mmc_sdio_init_card() CIS device/vendor IDs are read to check if the 
> card has been replaced or not when the system was suspended. But 
> reading these IDs will cause CMD52 timeout if the card is in sleep 
> state. The function driver can wake up the card by writing to certain 
> card specific register, so that the followed SDIO commands (CMD52, 
> CMD53, etc.) can go through. But the resume handler of the function 
> driver won't be invoked until the IDs get validated.

Please add the extra explanation above to the commit log so that 
the context is not lost.  And then

Acked-by: Nicolas Pitre <nico@fluxnic.net>

Then this could be revisited eventually when more devices are supported 
and a better abstraction to cover their needs could be created.


Nicolas

--Boundary_(ID_v2JkPYnqO9yHuqokw5s8ag)--
