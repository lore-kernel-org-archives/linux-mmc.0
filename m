From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: remove bogus MMC_SDHCI_IO_ACCESSORS
 select
Date: Fri, 2 Dec 2016 07:41:28 +0100
Message-ID: <20161202064128.a5ap4jgwl72v35af@rfolt0960.corp.atmel.com>
References: <1480565146-4857-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exsmtp02.microchip.com ([198.175.253.38]:53006 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbcLBGqw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2016 01:46:52 -0500
Content-Disposition: inline
In-Reply-To: <1480565146-4857-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Al Cooper <alcooperx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Dec 01, 2016 at 01:05:46PM +0900, Masahiro Yamada wrote:
> I see no override of read/write callbacks in sdhci-of-at91.c.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
> 
> BTW, this config may not be so useful in recent multi-platforms.
> Perhaps, is it better to remove this config entirely instead of
> the AT91 fix only.
> 
> 
>  drivers/mmc/host/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 39f6f96..8ac1640 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -135,7 +135,6 @@ config MMC_SDHCI_OF_AT91
>  	tristate "SDHCI OF support for the Atmel SDMMC controller"
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
> -	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the Atmel SDMMC driver
>  
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
