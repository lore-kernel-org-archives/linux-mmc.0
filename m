From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/6] mmc: split the tmio driver into several modules
Date: Tue, 22 Mar 2011 14:31:31 +0900
Message-ID: <20110322053127.GG27346@verge.net.au>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
 <AANLkTi=EBDnRtjqN3eckpt32p-tG8VkcsktLartOEgBp@mail.gmail.com>
 <Pine.LNX.4.64.1103211226110.21013@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34981 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1CVFbj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 01:31:39 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103211226110.21013@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Mar 21, 2011 at 12:38:10PM +0100, Guennadi Liakhovetski wrote:
> Hi Chris, Ian
> 
> AFAICS there are currently still a few tmio patch-series outstanding:
> 
> From: Guennadi Liakhovetski <g.liakhovetski <at> gmx.de>
> Subject: [PATCH 0/2] tmio_mmc: improve DMA reliability
> 	http://thread.gmane.org/gmane.linux.kernel.mmc/6485
> 
> From: Simon Horman <horms <at> verge.net.au>
> Subject: [PATCH 0/4] [rfc v3] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
> 	http://thread.gmane.org/gmane.linux.kernel.mmc/6664

IMHO, Patch 1-3 are ready and can either be merged through the MMC
or one of Paul's trees. Although I should note that patches
2 and 3 include changes to arch/arm/boot/compressed/mmcif-sh7372.c and
arch/sh/boot/romimage/mmcif-sh7724.c.

Please wait on 4, which depends on 1-3, and I would like to do
one more round of testing. In any case it'll most likely need to go
through RMK's tree.

> From: Guennadi Liakhovetski <g.liakhovetski <at> gmx.de>
> Subject: [PATCH 0/6] mmc: split the tmio driver into several modules
> 	http://thread.gmane.org/gmane.linux.ports.sh.devel/10304
> 
> From: Guennadi Liakhovetski <g.liakhovetski <at> gmx.de>
> Subject: [PATCH 0/4 v2] mmc: tmio: don't access nonexisting registers
> 	http://thread.gmane.org/gmane.linux.ports.sh.devel/10311
> 
> From: Guennadi Liakhovetski <g.liakhovetski <at> gmx.de>
> Subject: [PATCH/RFC 0/2 v2] mmc: tmio: power management and clock gating
> 	http://thread.gmane.org/gmane.linux.kernel.mmc/6627
> 
> Of those the first patchset shouldn't have any issues.
> 
> I haven't followed discussions regarding the second patchset from Simon - 
> is it going to be applied as is, or is a new revision required?

I do not currently have any plans to revise patches 1-3.

> If it is going to be applied, shall I rebase my remaining patches on top 
> of it or would you prefer Simon to rebase his patches (I think, he has 
> only one patch, touching tmio: [PATCH 1/4])?

1-3 include MMC changes but only patch 1 includes TMIO changes.

I am happy for either my patches to go in first or for me to re-base them
on top of yours. I'm also happy for you to re-base my patches (1 or 1-3)
and include them in a patchset if that works for you.

> As for the rest of the 
> patches, IIRC, the only remaining issue, that I'll be fixing today is 
> Magnus' wish to allocate the bounce buffer dynamically. Although, I could 
> imagine doing that incrementally, because the #ifdef, that Magnus would 
> like to get rid of is already now in the code, it is not introduced by 
> these my patches. But I can redo my patches too, no problem.
> 
> What would be the preferred approach?
> 
> Thanks
> Guennadi
> 
> On Tue, 15 Mar 2011, Ian Molton wrote:
> 
> > Sounds like a good idea... Its possible that I could implement DMA on
> > the toshiba stuff too, can your code handle this?
> > 
> > (I havent had time to read this yet)
> > 
> > -- 
> > Ian Molton
> > Linux, Automotive, and other hacking:
> > http://www.mnementh.co.uk/
> > 
> > 
> > 
> > On 11 March 2011 07:51, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > > Hi all
> > >
> > > The tmio_mmc SD/SDIO driver is serving very different hardware
> > > configurations: on the one hand multi-function style chips from Toshiba,
> > > Compaq, on the other hand SDHI units in ARM- and SuperH-based sh-mobile
> > > SoCs. Apart from the different native APIs: MFD for the former and
> > > platform-device in the latter, sh-mobile implementations also have a
> > > number of features, exclusive to them, which, if implemented in the common
> > > driver, clutter it needlessly and make its maintenance more difficult.
> > > This patch series simplifies the situation by splitting the driver up into
> > > 3 modules: the core, consisting of the main part and, on sh-mobile, of the
> > > DMA part; the mfd glue; and the platform glue. This way also (imaginary)
> > > sh-mobile systems with additional tmio mfd chips on them can be supported.
> > >
> > > Thanks
> > > Guennadi
> > > ---
> > > Guennadi Liakhovetski, Ph.D.
> > > Freelance Open-Source Software Developer
> > > http://www.open-technology.de/
> > >
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
