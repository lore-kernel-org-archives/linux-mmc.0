From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/5] OMAP HSMMC: Adding a flag to determine the card
 detect type
Date: Mon, 17 May 2010 19:56:21 -0700
Message-ID: <20100518025621.GH5818@atomide.com>
References: <22510.10.24.255.17.1273947712.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55845 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0ERC4b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 May 2010 22:56:31 -0400
Content-Disposition: inline
In-Reply-To: <22510.10.24.255.17.1273947712.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, santosh.shilimkar@ti.com

* kishore kadiyala <kishore.kadiyala@ti.com> [100515 11:16]:
> Adding a flag to determine the card detect type which can be
> either GPIO or NON-GPIO.MMC1 Controller of OMAP4 have NON-GPIO
> interrupt line from twl6030 for card detect.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c          |    2 ++
>  arch/arm/mach-omap2/board-3430sdp.c          |    3 +++
>  arch/arm/mach-omap2/board-cm-t35.c           |    3 +++
>  arch/arm/mach-omap2/board-devkit8000.c       |    2 ++
>  arch/arm/mach-omap2/board-igep0020.c         |    3 +++
>  arch/arm/mach-omap2/board-ldp.c              |    2 ++
>  arch/arm/mach-omap2/board-omap3beagle.c      |    2 ++
>  arch/arm/mach-omap2/board-omap3evm.c         |    2 ++
>  arch/arm/mach-omap2/board-omap3pandora.c     |    4 ++++
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 ++
>  arch/arm/mach-omap2/board-overo.c            |    3 +++
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +++
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +++
>  arch/arm/mach-omap2/hsmmc.h                  |    1 +
>  arch/arm/plat-omap/include/plat/mmc.h        |    4 ++++
>  15 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index a11a575..c7dec0e 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -37,6 +37,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/usb.h>
>  #include <plat/gpmc-smc91x.h>
> +#include <plat/mmc.h>
> 
>  #include "hsmmc.h"
> 
> @@ -196,6 +197,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
>  		.mmc		= 1,
>  		.wires		= 4,
>  		.gpio_cd	= -EINVAL,
> +		.cd_type	= GPIO,
>  		.gpio_wp	= -EINVAL,
>  		.ext_clock	= 1,
>  	},

To me it seems it would be simpler to just set a flag for the non-gpio
boards instead of patching all of them for gpio. Also, let's see
what we can do with the generic features flag we have now.

Regards,

Tony
