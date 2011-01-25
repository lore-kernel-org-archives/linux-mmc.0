From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
Date: Tue, 25 Jan 2011 09:24:56 +0200
Message-ID: <AANLkTi=Kd59Y0kFd=41cB7gUNRYjfcYe-n5ysfkQdvsk@mail.gmail.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home> <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home> <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009072119210.19366@xanadu.home> <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
 <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com> <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009152222400.19366@xanadu.home> <AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com>
 <AANLkTikguM7rYuCXpom3dN4T4+9RG2=0OvV8cnL0Tz04@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F704307F4EA2BA9@SC-VEXCH1.marvell.com>
 <AANLkTimZJbO1FNGKUG2JhJZOVeM-95cc5NuvAN+oC+Vx@mail.gmail.com> <AANLkTimp4a3BSGePPBwJP3zF2vbgF0hOmRHk2uZoeUF5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47990 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab1AYHZR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2011 02:25:17 -0500
Received: by ywe10 with SMTP id 10so1207322ywe.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2011 23:25:17 -0800 (PST)
In-Reply-To: <AANLkTimp4a3BSGePPBwJP3zF2vbgF0hOmRHk2uZoeUF5@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Bing Zhao <bzhao@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Jun Nie <njun@marvell.com>

On Tue, Jan 25, 2011 at 9:11 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> One thing we can do is letting drivers register a wake-up function
> within the SDIO core, just before suspending. Then, upon resume, if
> such a wake-up function was registered, SDIO core would invoke it just
> before it tries to read the CIS.

I guess that would be non-trivial, since at that point the driver is
not resumed yet, and you might need its facilities to receive some
wake-up ACK from the chip before continuing.
