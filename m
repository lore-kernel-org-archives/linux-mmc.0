From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Thu, 19 May 2011 14:24:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1105191413050.14430@xanadu.home>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
 <08119C91-F5AA-4E6A-99D4-CFB253B1AE7B@marvell.com>
 <BANLkTikVM7QbRJ2Lo2Ef3T9oGAmZ4SJzMQ@mail.gmail.com>
 <201105182238.45614.arnd@arndb.de>
 <BANLkTinGQLPD4LmjiSjtswqJ19xtvimjUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_EOlrhD0pLdU3+WCGbe/cPA)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:27256 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933758Ab1ESSYZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 14:24:25 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mr-mrz22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LLG00E7PGGOSO90@vl-mr-mrz22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 19 May 2011 14:24:25 -0400 (EDT)
In-reply-to: <BANLkTinGQLPD4LmjiSjtswqJ19xtvimjUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_EOlrhD0pLdU3+WCGbe/cPA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 19 May 2011, zhangfei gao wrote:

> On Wed, May 18, 2011 at 4:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 17 May 2011, zhangfei gao wrote:
> >> >> The code handle several register difference are located at
> >> >> arch/arm/mach-mmp/mmp2.c is for mmp2
> >> >> arch/arm/mach-mmp/pxa910.c is for pxa910 serious,
> >> >> arch/arm/mach-mmp/mmp3.c is for mmp3 serious, considering there may
> >> >> still registers changing.
> >> >>
> >> >> The board difference are directly put in board.c
> >> >> For example ttc_dkb do not use wp pin, so get_ro is provided.
> >> >
> >> > embedding the code in these chip files stops code sharing.  For example,
> >> > mmp3 has same controller as mmp2.
> >>
> >> If register are totally same, they can share.
> >> If there is minor difference with chip upgrading, they can put in
> >> different file.
> >
> > When we talked about similar problems in drivers during the Linaro Developer
> > Summit, the broad consensus was to move code from arch/arm into individual
> > device drivers, and I think this should be done for this driver too.
> >
> > My recommendation here would be to have no callbacks in the platform
> > data at all, but instead have the code for all variants in the
> > sdhci-pxa driver itself. You can still have a structure to describe
> > the differences using function pointers, but it's better if that is
> > part of the driver itself. In the platform data, provide a way
> > to identify the variant of the controller (e.g. using an enum)
> > and point to the base addresses as required.
> >
> >        Arnd
> >
> Hi, Arnd
> 
> Thanks for your suggestion.
> 
> To make sdhci-pxa easy to maintain, we still prefer put platform
> specific difference under platform code.

That's fine to split out platform differences.  However please put those 
differences, maybe in different files, but alongside the driver itself 
in drivers/mmc/host/sdhci-pxa-pxa910.c, sdhci-pxa-mmp2.c, etc. We don't 
want to see driver specific stuff hidden in arch/arm/mach-pxa/ or the 
like.

> More and more workaround comes when more and more platform need to
> support, making the driver bigger and bigger and not easy to maintain.
> Nobody remember what's the workaround purpose several years later.

You really really should spend more time documenting those workarounds 
in the source directly in that case.  Anyone not familiar with the 
issues should be able to understand why a given workaround is there, 
whether it is today or in several years.  And this is why we want driver 
stuff go in the driver directory where more people specifically 
interested in MMC/SD are looking.


Nicolas

--Boundary_(ID_EOlrhD0pLdU3+WCGbe/cPA)--
