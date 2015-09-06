From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Date: Sun, 6 Sep 2015 16:41:10 -0700
Message-ID: <20150906234110.GA2228@roeck-us.net>
References: <1441274111-18049-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42071 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbbIFXlR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Sep 2015 19:41:17 -0400
Content-Disposition: inline
In-Reply-To: <1441274111-18049-1-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: ulf.hansson@linaro.org, tony@atomide.com, broonie@kernel.org, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com

On Thu, Sep 03, 2015 at 03:25:11PM +0530, Kishon Vijay Abraham I wrote:
> PBIAS regulator is required for MMC module in OMAP2, OMAP3, OMAP4,
> OMAP5 and DRA7 SoCs. Enable it here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/configs/multi_v7_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 5fd8df6..f497c96 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -403,6 +403,7 @@ CONFIG_REGULATOR_MAX8973=y
>  CONFIG_REGULATOR_MAX77686=y
>  CONFIG_REGULATOR_MAX77693=m
>  CONFIG_REGULATOR_PALMAS=y
> +CONFIG_REGULATOR_PBIAS=y
>  CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
>  CONFIG_REGULATOR_TPS51632=y
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
