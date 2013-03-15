From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] ARM: at91/avr32/atmel-mci: fix DMA-channel leak on
 module unload
Date: Fri, 15 Mar 2013 11:56:06 +0100
Message-ID: <46568.1708221838$1363345027@news.gmane.org>
References: <1363191119-4948-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1363191119-4948-1-git-send-email-jhovold@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <jhovold@gmail.com>
Cc: linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 13, 2013 at 05:11:59PM +0100, Johan Hovold wrote:
> Fix regression introduced by commit 796211b7953 ("mmc: atmel-mci: add
> pdc support and runtime capabilities detection") which removed the need
> for CONFIG_MMC_ATMELMCI_DMA but kept the Kconfig-entry as well as the
> compile guards around dma_release_channel() in remove(). Consequently,
> DMA is always enabled (if supported), but the DMA-channel is not
> released on module unload unless the DMA-config option is selected.
> 
> Remove the no longer used CONFIG_MMC_ATMELMCI_DMA option completely.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Hi Johan,

Good point so

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>  arch/arm/configs/at91sam9g45_defconfig |  1 -
>  arch/avr32/configs/favr-32_defconfig   |  1 -
>  arch/avr32/configs/merisc_defconfig    |  1 -
>  drivers/mmc/host/Kconfig               | 10 ----------
>  drivers/mmc/host/atmel-mci.c           |  2 --
>  5 files changed, 15 deletions(-)
> 
> diff --git a/arch/arm/configs/at91sam9g45_defconfig b/arch/arm/configs/at91sam9g45_defconfig
> index 606d48f..8aab786 100644
> --- a/arch/arm/configs/at91sam9g45_defconfig
> +++ b/arch/arm/configs/at91sam9g45_defconfig
> @@ -173,7 +173,6 @@ CONFIG_MMC=y
>  # CONFIG_MMC_BLOCK_BOUNCE is not set
>  CONFIG_SDIO_UART=m
>  CONFIG_MMC_ATMELMCI=y
> -CONFIG_MMC_ATMELMCI_DMA=y
>  CONFIG_LEDS_ATMEL_PWM=y
>  CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_TRIGGER_TIMER=y
> diff --git a/arch/avr32/configs/favr-32_defconfig b/arch/avr32/configs/favr-32_defconfig
> index 0421498..9791820 100644
> --- a/arch/avr32/configs/favr-32_defconfig
> +++ b/arch/avr32/configs/favr-32_defconfig
> @@ -122,7 +122,6 @@ CONFIG_USB_G_SERIAL=m
>  CONFIG_USB_CDC_COMPOSITE=m
>  CONFIG_MMC=y
>  CONFIG_MMC_ATMELMCI=y
> -CONFIG_MMC_ATMELMCI_DMA=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_ATMEL_PWM=m
> diff --git a/arch/avr32/configs/merisc_defconfig b/arch/avr32/configs/merisc_defconfig
> index 3befab9..65de443 100644
> --- a/arch/avr32/configs/merisc_defconfig
> +++ b/arch/avr32/configs/merisc_defconfig
> @@ -102,7 +102,6 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_LOGO=y
>  CONFIG_MMC=y
>  CONFIG_MMC_ATMELMCI=y
> -CONFIG_MMC_ATMELMCI_DMA=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_ATMEL_PWM=y
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8d13c65..009dabd 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -292,16 +292,6 @@ config MMC_ATMELMCI
>  
>  	  If unsure, say N.
>  
> -config MMC_ATMELMCI_DMA
> -	bool "Atmel MCI DMA support"
> -	depends on MMC_ATMELMCI && (AVR32 || ARCH_AT91SAM9G45) && DMA_ENGINE
> -	help
> -	  Say Y here to have the Atmel MCI driver use a DMA engine to
> -	  do data transfers and thus increase the throughput and
> -	  reduce the CPU utilization.
> -
> -	  If unsure, say N.
> -
>  config MMC_MSM
>  	tristate "Qualcomm SDCC Controller Support"
>  	depends on MMC && ARCH_MSM
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 722af1d..10f8b73 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2487,10 +2487,8 @@ static int __exit atmci_remove(struct platform_device *pdev)
>  	atmci_readl(host, ATMCI_SR);
>  	clk_disable(host->mck);
>  
> -#ifdef CONFIG_MMC_ATMELMCI_DMA
>  	if (host->dma.chan)
>  		dma_release_channel(host->dma.chan);
> -#endif
>  
>  	free_irq(platform_get_irq(pdev, 0), host);
>  	iounmap(host->regs);
> -- 
> 1.8.1.5
> 
