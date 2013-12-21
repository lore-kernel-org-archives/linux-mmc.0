From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 6/7] ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in
 omap2plus_defconfig
Date: Fri, 20 Dec 2013 16:33:19 -0800
Message-ID: <20131221003318.GF26054@atomide.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1387560955-6547-7-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15716 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751035Ab3LUAdW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Dec 2013 19:33:22 -0500
Content-Disposition: inline
In-Reply-To: <1387560955-6547-7-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

* Balaji T K <balajitk@ti.com> [131220 09:37]:
> Enable REGULATOR_PBIAS needed for SD card on most OMAPs.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>

I can queue this one once the pieces are merged.

Tony

>  arch/arm/configs/omap2plus_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index bfa80a1..f67baa9 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -169,6 +169,7 @@ CONFIG_DRA752_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_OMAP_WATCHDOG=y
>  CONFIG_TWL4030_WATCHDOG=y
> +CONFIG_MFD_SYSCON=y
>  CONFIG_MFD_PALMAS=y
>  CONFIG_MFD_TPS65217=y
>  CONFIG_MFD_TPS65910=y
> @@ -180,6 +181,7 @@ CONFIG_REGULATOR_TPS6507X=y
>  CONFIG_REGULATOR_TPS65217=y
>  CONFIG_REGULATOR_TPS65910=y
>  CONFIG_REGULATOR_TWL4030=y
> +CONFIG_REGULATOR_PBIAS=y
>  CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_MODE_HELPERS=y
> -- 
> 1.7.5.4
> 
