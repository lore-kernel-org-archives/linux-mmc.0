From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Date: Wed, 23 Oct 2019 14:14:58 +0200
Message-ID: <20191023121458.GB11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-11-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kukjin Kim <kgene@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Bart
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> These can be build completely independently, so split
> the two Kconfig symbols.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug        | 6 +++---
>  arch/arm/Makefile             | 1 -
>  arch/arm/plat-samsung/Kconfig | 2 +-
>  drivers/mmc/host/Kconfig      | 2 +-
>  drivers/pwm/Kconfig           | 2 +-
>  drivers/spi/Kconfig           | 2 +-
>  drivers/tty/serial/Kconfig    | 2 +-
>  sound/soc/samsung/Kconfig     | 2 +-
>  8 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9c4f2d6deb06..4c4e97ae4fcb 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -998,7 +998,7 @@ choice
>  		  via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
>  
>  	config DEBUG_S3C_UART0
> -		depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +		depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS

How are you going to select DEBUG_S5PV210_UART now?

Best regards,
Krzysztof


>  		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>  		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>  		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> @@ -1010,7 +1010,7 @@ choice
>  		  by the boot-loader before use.
>  
>  	config DEBUG_S3C_UART1
> -		depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +		depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>  		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>  		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>  		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> @@ -1022,7 +1022,7 @@ choice
>  		  by the boot-loader before use.
>  
>  	config DEBUG_S3C_UART2
> -		depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +		depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>  		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>  		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>  		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index f492d7c338fe..a1bc15cda751 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -235,7 +235,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
>  # by CONFIG_* macro name.
>  plat-$(CONFIG_ARCH_OMAP)	+= omap
>  plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
> -plat-$(CONFIG_ARCH_S5PV210)	+= samsung
>  plat-$(CONFIG_PLAT_ORION)	+= orion
>  plat-$(CONFIG_PLAT_PXA)		+= pxa
>  plat-$(CONFIG_PLAT_S3C24XX)	+= samsung
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 740bdb23f38a..1530946cc672 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -4,7 +4,7 @@
>  
>  config PLAT_SAMSUNG
>  	bool
> -	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
> +	depends on PLAT_S3C24XX || ARCH_S3C64XX
>  	default y
>  	select GENERIC_IRQ_CHIP
>  	select NO_IOPORT_MAP
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 400a581c918c..16a0e5430b44 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -275,7 +275,7 @@ config MMC_SDHCI_TEGRA
>  
>  config MMC_SDHCI_S3C
>  	tristate "SDHCI support on Samsung S3C SoC"
> -	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_EXYNOS)
> +	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS)
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  often referrered to as the HSMMC block in some of the Samsung S3C
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index e3a2518503ed..8eb738cac0c7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -394,7 +394,7 @@ config PWM_ROCKCHIP
>  
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
> -	depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>  	help
>  	  Generic PWM framework driver for Samsung.
>  
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 6f7fdcbb9151..355391ee643d 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -625,7 +625,7 @@ config SPI_S3C24XX_FIQ
>  
>  config SPI_S3C64XX
>  	tristate "Samsung S3C64XX series type SPI"
> -	depends on (PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST)
> +	depends on (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST)
>  	help
>  	  SPI driver for Samsung S3C64XX and newer SoCs.
>  
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4789b5d62f63..17f01cf3009c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -237,7 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
>  
>  config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
> -	depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>  	select SERIAL_CORE
>  	help
>  	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index 638983123d8f..7a0035dd9995 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig SND_SOC_SAMSUNG
>  	tristate "ASoC support for Samsung"
> -	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
> +	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>  	depends on COMMON_CLK
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	---help---
> -- 
> 2.20.0
> 
