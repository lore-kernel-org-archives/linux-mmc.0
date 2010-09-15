From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: MMC 4.4 DDR support
Date: Wed, 15 Sep 2010 15:02:05 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0315FAFD01@dbde02.ent.ti.com>
References: <1278658780-26397-1-git-send-email-hanumath.prasad@stericsson.com>
 <AANLkTikBdBhJeQ-t2+0echJfAxz529QZEYPJtyHUsROd@mail.gmail.com>
 <m3pqxbsibq.fsf@pullcord.laptop.org>
 <20100823204829.GB6510@console-pimps.org>
 <20100823142816.59b12253.akpm@linux-foundation.org>
 <4C739F55.8030301@nokia.com> <20100914112143.GA16039@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34690 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab0IOJdE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 05:33:04 -0400
In-Reply-To: <20100914112143.GA16039@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Linus Walleij <linus.ml.walleij@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "STEricsson_nomadik_linux@list.st.com" <STEricsson_nomadik_linux@list.st.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Kyungmin Park <kmpark@infradead.org>


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Chris Ball
> Sent: Tuesday, September 14, 2010 4:52 PM
> To: Adrian Hunter
> Cc: Andrew Morton; Matt Fleming; Linus Walleij; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org; STEricsson_nomadik_linux@list.st.com;
> Hanumath Prasad; Kyungmin Park
> Subject: Re: [PATCH] mmc: MMC 4.4 DDR support
> 
> Hi Hanumath, Linus,
> 
> On Tue, Aug 24, 2010 at 01:30:45PM +0300, Adrian Hunter wrote:
> > I am not able to test DDR mode but it look to me that the patch
> > should be changed.  Here is a fix:
> >
> > From: Adrian Hunter <adrian.hunter@nokia.com>
> > Date: Tue, 24 Aug 2010 13:20:26 +0300
> > Subject: [PATCH] mmc: Fix Dual Data Rate (DDR) support
> 
> Could someone please test Adrian's patch and report back?  I'd like
> to merge this, but not without testing.
> 
> https://patchwork.kernel.org/patch/177332/

[Ghorai] I was testing this patch (Adrian's) and top of patch[1] from Hanumath; Looks working fine as functionality. Checking throughput in my omap platform.
[1] http://lkml.org/lkml/2010/7/9/35
But there are few comments on this patch from others, I think. And is not applying cleanly in latest codebase. Also following #define is conflicting with Hanumath's patch.
File: include/linux/mmc/host.h
#define MMC_CAP_ERASE           (1 << 10)

> 
> Thanks,
> 
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
