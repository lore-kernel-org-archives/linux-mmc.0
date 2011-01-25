From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Mon, 24 Jan 2011 18:17:02 -0800
Message-ID: <477F20668A386D41ADCC57781B1F704307F4EA2BA9@SC-VEXCH1.marvell.com>
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
 <AANLkTikguM7rYuCXpom3dN4T4+9RG2=0OvV8cnL0Tz04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34311 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752966Ab1AYCR1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Jan 2011 21:17:27 -0500
In-Reply-To: <AANLkTikguM7rYuCXpom3dN4T4+9RG2=0OvV8cnL0Tz04@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, zhangfei gao <zhangfei.gao@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

Hi Ohad,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Saturday, January 22, 2011 2:01 PM
> To: zhangfei gao
> Cc: Nicolas Pitre; Bing Zhao; Sahitya Tummala; linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball;
> Andrew Morton; Maxim Levitsky
> Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
> 
> On Fri, Jan 21, 2011 at 11:07 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> > Do you have any updated patch to skip mmc_sdio_init_card in resume back.
> > We need such patch in enable host sleep feature for mrvl8787.
> 
> Is mrvl8787 a removable card ?

It can be either a removable or non-removable card, depending on what platform is used.

> 
> I'm asking because we already skip mmc_sdio_init_card() for
> powered-resumed nonremovable cards (check out commit 3cfc33a "mmc:
> sdio: don't reinitialize nonremovable powered-resumed cards").

Thanks for the info.

> 
> I'm not familiar with marvell's cards, but I do remember a thread
> mentioning they have dedicated reset GPIOs, and that may suggest they
> are nonremovables. If that's the case, simply setting
> MMC_CAP_NONREMOVABLE on the relevant slot should do the trick for you.

I think this approach works for Zhangfei on his embedded platform on which the 8787 card is non-removable.

Regards,

Bing
