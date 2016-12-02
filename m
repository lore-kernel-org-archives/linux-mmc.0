From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: remove bogus MMC_SDHCI_IO_ACCESSORS
 select
Date: Fri, 2 Dec 2016 16:03:37 +0200
Message-ID: <0fe5583e-f1d3-242f-a510-e3ea3b3b5481@intel.com>
References: <1480565146-4857-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480565146-4857-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Al Cooper <alcooperx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 01/12/16 06:05, Masahiro Yamada wrote:
> I see no override of read/write callbacks in sdhci-of-at91.c.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
> 
