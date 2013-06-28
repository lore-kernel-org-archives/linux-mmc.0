From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use for OMAP5 as well
Date: Fri, 28 Jun 2013 21:27:20 +0530
Message-ID: <51CDB260.8080108@ti.com>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50717 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab3F1P5Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Jun 2013 11:57:25 -0400
In-Reply-To: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: a-bindra@ti.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, balbi@ti.com, nm@ti.com

On Friday 28 June 2013 06:04 PM, a-bindra@ti.com wrote:
> From: Amarinder Bindra <a-bindra@ti.com>
>
> OMAP's hs_mmc driver is also used for OMAP5 MMC controller operation.
> Considering that the device tree entries are already there for this,
> allow the driver to be built when only OMAP5 is enabled.
> This allows MMC root filesystems to be available in "OMAP5 only"
> configurations.
>
> Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>

Looks good to me,
Acked-by: Balaji T K <balajitk@ti.com>

> ---
>   drivers/mmc/host/Kconfig |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 009dabd..6722e21 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -254,11 +254,11 @@ config MMC_OMAP
>
>   config MMC_OMAP_HS
>   	tristate "TI OMAP High Speed Multimedia Card Interface support"
> -	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
> +	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
>   	help
>   	  This selects the TI OMAP High Speed Multimedia card Interface.
> -	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
> -	  Multimedia Card slot, say Y or M here.
> +	  If you have an OMAP2430 or OMAP3 board or OMAP4 board or OMAP5
> +	  board with a Multimedia Card slot, say Y or M here.
>
>   	  If unsure, say N.
>
>

