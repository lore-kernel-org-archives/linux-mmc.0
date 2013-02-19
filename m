From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4 00/13] mmc: core and driver DT and related development
Date: Tue, 19 Feb 2013 22:57:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302192253140.22058@axis700.grange>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <87k3q5ahl8.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60533 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933545Ab3BSV5V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 16:57:21 -0500
In-Reply-To: <87k3q5ahl8.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>

Hi Chris

On Mon, 18 Feb 2013, Chris Ball wrote:

> Hi Guennadi,
> 
> On Fri, Feb 15 2013, Guennadi Liakhovetski wrote:
> > This is v4 of a patch-series, extending mmc subsystem device-tree usage 
> > and adding more advanced DT capabilities to sh_mmcif and sh_mobile_sdhi / 
> > tmio_mmc drivers. Changes since v3 are described in respective patches. 
> > Thanks to all who commented on v3.
> >
> > Guennadi Liakhovetski (13):
> >   mmc: sdhi, tmio: only check flags in tmio-mmc driver proper
> >   mmc: detailed definition of CD and WP MMC line polarities in DT
> >   mmc: provide a standard MMC device-tree binding parser centrally
> >   mmc: (cosmetic) remove "extern" from function declarations
> >   mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
> >   mmc: tmio-mmc: define device-tree bindings
> >   mmc: tmio-mmc: parse device-tree bindings
> >   mmc: sh_mobile_sdhi: remove unused .pdata field
> >   mmc: sh_mobile_sdhi: use managed resource allocations
> >   mmc: tmio: remove unused and deprecated symbols
> >   mmc: tmio: add support for the VccQ regulator
> >   mmc: add DT bindings for more MMC capability flags
> >   mmc: tmio: add barriers to IO operations
> 
> Thanks!  Pushed to mmc-next, will think about merging for 3.9.

Thanks! Please, push all of them (taking into account v5 of #03/13), but 
hold back on #13, it'll need some more work.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
