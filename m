From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
Date: Sun, 23 Jan 2011 00:01:19 +0200
Message-ID: <AANLkTikguM7rYuCXpom3dN4T4+9RG2=0OvV8cnL0Tz04@mail.gmail.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home> <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home> <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009072119210.19366@xanadu.home> <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
 <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com> <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009152222400.19366@xanadu.home> <AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55657 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1AVWBk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 17:01:40 -0500
Received: by iwn9 with SMTP id 9so2829168iwn.19
        for <linux-mmc@vger.kernel.org>; Sat, 22 Jan 2011 14:01:39 -0800 (PST)
In-Reply-To: <AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Bing Zhao <bzhao@marvell.com>, Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On Fri, Jan 21, 2011 at 11:07 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> Do you have any updated patch to skip mmc_sdio_init_card in resume back.
> We need such patch in enable host sleep feature for mrvl8787.

Is mrvl8787 a removable card ?

I'm asking because we already skip mmc_sdio_init_card() for
powered-resumed nonremovable cards (check out commit 3cfc33a "mmc:
sdio: don't reinitialize nonremovable powered-resumed cards").

I'm not familiar with marvell's cards, but I do remember a thread
mentioning they have dedicated reset GPIOs, and that may suggest they
are nonremovables. If that's the case, simply setting
MMC_CAP_NONREMOVABLE on the relevant slot should do the trick for you.
