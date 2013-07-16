From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
Date: Mon, 15 Jul 2013 22:04:52 -0700
Message-ID: <20130716050452.GA10380@teo>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
 <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
 <1373303919.8183.164@snotra>
 <20130712183503.GA24689@teo>
 <99E897753B6F7048BD8CCDB4661D02E13A7CC3@039-SN2MPN1-021.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53209 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab3GPFE5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2013 01:04:57 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so267482pdj.15
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2013 22:04:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E13A7CC3@039-SN2MPN1-021.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun-B42677 <B42677@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>, Wrobel Heinz-R39252 <r39252@freescale.com>

On Tue, Jul 16, 2013 at 03:11:47AM +0000, Zhang Haijun-B42677 wrote:
> Hi, Anton
> 
> You mean get voltage support from DTS?
> Or get voltage both from DTS and host capacity register?

The logic might be that you first check device-tree, if it specifies
voltage ranges, assume that DTS knows better, otherwise read capabilities
from the register.

Anton

> Thanks.
> 
> Regards
> Haijun.
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Anton Vorontsov
> > Sent: Saturday, July 13, 2013 2:35 AM
> > To: Wood Scott-B07421
> > Cc: Zhang Haijun-B42677; linux-mmc@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; cjb@laptop.org; Fleming Andy-AFLEMING; Wrobel
> > Heinz-R39252
> > Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS
> > board
> > 
> > On Mon, Jul 08, 2013 at 12:18:39PM -0500, Scott Wood wrote:
> > > On 07/08/2013 02:16:04 AM, Haijun Zhang wrote:
> > > >On T4240QDS board controllers has an unusable ADMA engine, so use
> > > >SDMA instead.
> > > >Also 3.0v is support on T4240QDS board even if the capacity detailed
> > > >only 1.8v support. Without this quirk SD card will declare voltage
> > > >not support and
> > > >
> > > >Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > >
> > > ...and what?
> > >
> > > Why is this board-specific?  Isn't the controller part of the SoC, not
> > > part of the board?  If it really is board-specific, could you be more
> > > detailed about why (ideally with an erratum number), and check the
> > > toplevel board compatible (or get the information from platform
> > > code) rather than modify the device tree?
> > 
> > Yup, and if anything, I would recommend to reuse voltage-ranges property,
> > it is already implemented for mmc spi driver,
> > 
> > drivers/mmc/host/of_mmc_spi.c
> > Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
> > 
> > Thanks,
> > 
> > Anton
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> 
