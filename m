From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: 70a3341a71 broke omap_hsmmc?
Date: Fri, 9 Oct 2009 03:38:11 +0530 (IST)
Message-ID: <46274.192.168.10.89.1255039691.squirrel@dbdmail.itg.ti.com>
References: <20091008092430.GA22561@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755903AbZJHWJ7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Oct 2009 18:09:59 -0400
In-Reply-To: <20091008092430.GA22561@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Matt Fleming <matt@console-pimps.org>, Ian Molton <ian@mnementh.co.uk>, "Roberto A. Foglietta" <roberto.foglietta@gmail.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Pierre Ossman <pierre@ossman.eu>, Philip Langdale <philipl@overt.org>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi,

A fix for this is pushed in Linux-omap.

Regards,
Madhu

commit fa7705edb1355a52cdca0adfcfe007923bfff7dc
Author: Roger Quadros <ext-roger.quadros@nokia.com>
Date:   Mon Oct 5 13:50:06 2009 -0700

    omap_hsmmc: Add missing probe handler hook to platform driver data

    The missing probe handler hook will never probe the driver. Add it =
back.
    Fixes broken MMC on OMAP.

    We use platform_driver_probe() API since omap_hsmmc is not a hot-pl=
uggable
    device.

    Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index 4487cc0..0aecaae 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2013,7 +2013,7 @@ static struct platform_driver omap_hsmmc_driver =3D=
 {
 static int __init omap_hsmmc_init(void)
 {
        /* Register the MMC driver */
-       return platform_driver_register(&omap_hsmmc_driver);
+       return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_pro=
be);
 }

 static void __exit omap_hsmmc_cleanup(void)



> Hello,
>
> commit 70a3341a711f27ae77714ae7dd360a4e7e2d5e7c changed registering o=
f
> omap_hsmmc_host from using platform_driver_probe to using
> platform_driver_register.  But omap_hsmmc_driver doesn't have a probe
> entry.  So I expect that the driver doesn't bind correctly.
>
> The fix is either convert back to platform_driver_probe or (add
> platform_driver_probe to omap_hsmmc_driver and move it to section
> .devinit.text).
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                              | Uwe Kleine-K=F6nig   =
         |
> Industrial Linux Solutions                    | http://www.pengutroni=
x.de/  |
>
>


