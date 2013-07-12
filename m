From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
Date: Fri, 12 Jul 2013 11:35:03 -0700
Message-ID: <20130712183503.GA24689@teo>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
 <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
 <1373303919.8183.164@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38802 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965108Ab3GLSfG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jul 2013 14:35:06 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so9233757pbb.36
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jul 2013 11:35:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373303919.8183.164@snotra>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, AFLEMING@freescale.com, r39252@freescale.com

On Mon, Jul 08, 2013 at 12:18:39PM -0500, Scott Wood wrote:
> On 07/08/2013 02:16:04 AM, Haijun Zhang wrote:
> >On T4240QDS board controllers has an unusable ADMA engine, so use
> >SDMA instead.
> >Also 3.0v is support on T4240QDS board even if the capacity
> >detailed only 1.8v
> >support. Without this quirk SD card will declare voltage not
> >support and
> >
> >Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> 
> ...and what?
> 
> Why is this board-specific?  Isn't the controller part of the SoC,
> not part of the board?  If it really is board-specific, could you be
> more detailed about why (ideally with an erratum number), and check
> the toplevel board compatible (or get the information from platform
> code) rather than modify the device tree?

Yup, and if anything, I would recommend to reuse voltage-ranges property,
it is already implemented for mmc spi driver,

drivers/mmc/host/of_mmc_spi.c
Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt

Thanks,

Anton
