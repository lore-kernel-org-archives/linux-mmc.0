From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] ARM: at91: add atmel-mci support for chips and boards
 which can use it
Date: Mon, 21 May 2012 12:17:13 +0200
Message-ID: <4FBA1629.7020702@atmel.com>
References: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com> <1337183519-25459-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:15913 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757245Ab2EUKRP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 06:17:15 -0400
In-Reply-To: <1337183519-25459-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com

On 05/16/2012 05:51 PM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
> use it instead of at91_mci driver.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/at91rm9200_devices.c  |   99 ++++++++++++++++++
>  arch/arm/mach-at91/at91sam9261_devices.c |   67 ++++++++++++
>  arch/arm/mach-at91/at91sam9263.c         |    2 +
>  arch/arm/mach-at91/at91sam9263_devices.c |  164 ++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/at91sam9rl_devices.c  |   70 +++++++++++++
>  arch/arm/mach-at91/board-foxg20.c        |   16 +++-
>  arch/arm/mach-at91/board-rm9200ek.c      |   14 +++
>  arch/arm/mach-at91/board-sam9-l9260.c    |   16 +++-
>  arch/arm/mach-at91/board-sam9260ek.c     |   16 +++-
>  arch/arm/mach-at91/board-sam9261ek.c     |   14 +++
>  arch/arm/mach-at91/board-sam9263ek.c     |   14 +++
>  arch/arm/mach-at91/board-sam9rlek.c      |   14 +++
>  arch/arm/mach-at91/board-usb-a926x.c     |    2 +-
>  13 files changed, 504 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> index 05774e5..2c13783 100644
> --- a/arch/arm/mach-at91/at91rm9200_devices.c
> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> @@ -374,6 +374,105 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  
>  
>  /* --------------------------------------------------------------------
> + *  MMC / SD
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static u64 mmc_dmamask = DMA_BIT_MASK(32);
> +static struct mci_platform_data mmc_data;
> +
> +static struct resource mmc_resources[] = {
> +	[0] = {
> +		.start	= AT91RM9200_BASE_MCI,
> +		.end	= AT91RM9200_BASE_MCI + SZ_16K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= AT91RM9200_ID_MCI,
> +		.end	= AT91RM9200_ID_MCI,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device at91rm9200_mmc_device = {
> +	.name		= "atmel_mci",
> +	.id		= -1,
> +	.dev		= {
> +				.dma_mask		= &mmc_dmamask,
> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> +				.platform_data		= &mmc_data,
> +	},
> +	.resource	= mmc_resources,
> +	.num_resources	= ARRAY_SIZE(mmc_resources),
> +};
> +
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
> +{
> +	unsigned int i;
> +	unsigned int slot_count = 0;
> +
> +	if (!data)
> +		return;
> +
> +	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
> +
> +		if (!data->slot[i].bus_width)
> +			continue;
> +
> +		/* input/irq */
> +		if (gpio_is_valid(data->slot[i].detect_pin)) {
> +			at91_set_gpio_input(data->slot[i].detect_pin, 1);
> +			at91_set_deglitch(data->slot[i].detect_pin, 1);
> +		}
> +		if (gpio_is_valid(data->slot[i].wp_pin))
> +			at91_set_gpio_input(data->slot[i].wp_pin, 1);
> +
> +		switch (i) {
> +		case 0:                                 /* slot A */
> +			/* CMD */
> +			at91_set_A_periph(AT91_PIN_PA28, 1);
> +			/* DAT0, maybe DAT1..DAT3 */
> +			at91_set_A_periph(AT91_PIN_PA29, 1);
> +			if (data->slot[i].bus_width == 4) {
> +				at91_set_B_periph(AT91_PIN_PB3, 1);
> +				at91_set_B_periph(AT91_PIN_PB4, 1);
> +				at91_set_B_periph(AT91_PIN_PB5, 1);
> +			}
> +			slot_count++;
> +			break;
> +		case 1:					/* slot B */
> +			/* CMD */
> +			at91_set_B_periph(AT91_PIN_PA8, 1);
> +			/* DAT0, maybe DAT1..DAT3 */
> +			at91_set_B_periph(AT91_PIN_PA9, 1);
> +			if (data->slot[i].bus_width == 4) {
> +				at91_set_B_periph(AT91_PIN_PA10, 1);
> +				at91_set_B_periph(AT91_PIN_PA11, 1);
> +				at91_set_B_periph(AT91_PIN_PA12, 1);
> +			}
> +			slot_count++;
> +			break;
> +		default:
> +			printk(KERN_ERR
> +			       "AT91: SD/MMC slot %d not available\n", i);
> +			break;
> +		}
> +		if (slot_count) {
> +			/* CLK */
> +			at91_set_A_periph(AT91_PIN_PA27, 0);
> +
> +			mmc_data = *data;
> +			platform_device_register(&at91rm9200_mmc_device);
> +		}
> +	}
> +
> +}
> +#else
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
> +#endif
> +
> +
> +/* --------------------------------------------------------------------
>   *  NAND / SmartMedia
>   * -------------------------------------------------------------------- */
>  
> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> index 4db961a..0817854 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -202,7 +202,74 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
>  void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  #endif
>  
> +/* --------------------------------------------------------------------
> + *  MMC / SD Slot for Atmel MCI Driver
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static u64 mmc_dmamask = DMA_BIT_MASK(32);
> +static struct mci_platform_data mmc_data;
> +
> +static struct resource mmc_resources[] = {
> +	[0] = {
> +		.start	= AT91SAM9261_BASE_MCI,
> +		.end	= AT91SAM9261_BASE_MCI + SZ_16K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= AT91SAM9261_ID_MCI,
> +		.end	= AT91SAM9261_ID_MCI,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device at91sam9261_mmc_device = {
> +	.name		= "atmel_mci",
> +	.id		= -1,
> +	.dev		= {
> +				.dma_mask		= &mmc_dmamask,
> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> +				.platform_data		= &mmc_data,
> +	},
> +	.resource	= mmc_resources,
> +	.num_resources	= ARRAY_SIZE(mmc_resources),
> +};
> +
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
> +{
> +	if (!data)
> +		return;
>  
> +	if (data->slot[0].bus_width) {
> +		/* input/irq */
> +		if (gpio_is_valid(data->slot[0].detect_pin)) {
> +			at91_set_gpio_input(data->slot[0].detect_pin, 1);
> +			at91_set_deglitch(data->slot[0].detect_pin, 1);
> +		}
> +		if (gpio_is_valid(data->slot[0].wp_pin))
> +			at91_set_gpio_input(data->slot[0].wp_pin, 1);
> +
> +		/* CLK */
> +		at91_set_B_periph(AT91_PIN_PA2, 0);
> +
> +		/* CMD */
> +		at91_set_B_periph(AT91_PIN_PA1, 1);
> +
> +		/* DAT0, maybe DAT1..DAT3 */
> +		at91_set_B_periph(AT91_PIN_PA0, 1);
> +		if (data->slot[0].bus_width == 4) {
> +			at91_set_B_periph(AT91_PIN_PA4, 1);
> +			at91_set_B_periph(AT91_PIN_PA5, 1);
> +			at91_set_B_periph(AT91_PIN_PA6, 1);
> +		}
> +
> +		mmc_data = *data;
> +		platform_device_register(&at91sam9261_mmc_device);
> +	}
> +}
> +#else
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
> +#endif
>  /* --------------------------------------------------------------------
>   *  NAND / SmartMedia
>   * -------------------------------------------------------------------- */
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index ef301be..053e47a 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -189,6 +189,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
>  	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
>  	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.0", &mmc0_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.1", &mmc1_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
>  	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index fe99206..617fbfc 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -354,6 +354,170 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  #endif
>  
>  /* --------------------------------------------------------------------
> + *  MMC / SD
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static u64 mmc_dmamask = DMA_BIT_MASK(32);
> +static struct mci_platform_data mmc0_data, mmc1_data;
> +
> +static struct resource mmc0_resources[] = {
> +	[0] = {
> +		.start	= AT91SAM9263_BASE_MCI0,
> +		.end	= AT91SAM9263_BASE_MCI0 + SZ_16K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= AT91SAM9263_ID_MCI0,
> +		.end	= AT91SAM9263_ID_MCI0,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device at91sam9263_mmc0_device = {
> +	.name		= "atmel_mci",
> +	.id		= 0,
> +	.dev		= {
> +				.dma_mask		= &mmc_dmamask,
> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> +				.platform_data		= &mmc0_data,
> +	},
> +	.resource	= mmc0_resources,
> +	.num_resources	= ARRAY_SIZE(mmc0_resources),
> +};
> +
> +static struct resource mmc1_resources[] = {
> +	[0] = {
> +		.start	= AT91SAM9263_BASE_MCI1,
> +		.end	= AT91SAM9263_BASE_MCI1 + SZ_16K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= AT91SAM9263_ID_MCI1,
> +		.end	= AT91SAM9263_ID_MCI1,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device at91sam9263_mmc1_device = {
> +	.name		= "atmel_mci",
> +	.id		= 1,
> +	.dev		= {
> +				.dma_mask		= &mmc_dmamask,
> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> +				.platform_data		= &mmc1_data,
> +	},
> +	.resource	= mmc1_resources,
> +	.num_resources	= ARRAY_SIZE(mmc1_resources),
> +};
> +
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
> +{
> +	unsigned int i;
> +	unsigned int slot_count = 0;
> +
> +	if (!data)
> +		return;
> +
> +	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
> +
> +		if (!data->slot[i].bus_width)
> +			continue;
> +
> +		/* input/irq */
> +		if (gpio_is_valid(data->slot[i].detect_pin)) {
> +			at91_set_gpio_input(data->slot[i].detect_pin,
> +					1);
> +			at91_set_deglitch(data->slot[i].detect_pin,
> +					1);
> +		}
> +		if (gpio_is_valid(data->slot[i].wp_pin))
> +			at91_set_gpio_input(data->slot[i].wp_pin, 1);
> +
> +		if (mmc_id == 0) {				/* MCI0 */
> +			switch (i) {
> +			case 0:					/* slot A */
> +				/* CMD */
> +				at91_set_A_periph(AT91_PIN_PA1, 1);
> +				/* DAT0, maybe DAT1..DAT3 */
> +				at91_set_A_periph(AT91_PIN_PA0, 1);
> +				if (data->slot[i].bus_width == 4) {
> +					at91_set_A_periph(AT91_PIN_PA3, 1);
> +					at91_set_A_periph(AT91_PIN_PA4, 1);
> +					at91_set_A_periph(AT91_PIN_PA5, 1);
> +				}
> +				slot_count++;
> +				break;
> +			case 1:					/* slot B */
> +				/* CMD */
> +				at91_set_A_periph(AT91_PIN_PA16, 1);
> +				/* DAT0, maybe DAT1..DAT3 */
> +				at91_set_A_periph(AT91_PIN_PA17, 1);
> +				if (data->slot[i].bus_width == 4) {
> +					at91_set_A_periph(AT91_PIN_PA18, 1);
> +					at91_set_A_periph(AT91_PIN_PA19, 1);
> +					at91_set_A_periph(AT91_PIN_PA20, 1);
> +				}
> +				slot_count++;
> +				break;
> +			default:
> +				printk(KERN_ERR
> +				       "AT91: SD/MMC slot %d not available\n", i);
> +				break;
> +			}
> +			if (slot_count) {
> +				/* CLK */
> +				at91_set_A_periph(AT91_PIN_PA12, 0);
> +
> +				mmc0_data = *data;
> +				platform_device_register(&at91sam9263_mmc0_device);
> +			}
> +		} else if (mmc_id == 1) {			/* MCI1 */
> +			switch (i) {
> +			case 0:					/* slot A */
> +				/* CMD */
> +				at91_set_A_periph(AT91_PIN_PA7, 1);
> +				/* DAT0, maybe DAT1..DAT3 */
> +				at91_set_A_periph(AT91_PIN_PA8, 1);
> +				if (data->slot[i].bus_width == 4) {
> +					at91_set_A_periph(AT91_PIN_PA9, 1);
> +					at91_set_A_periph(AT91_PIN_PA10, 1);
> +					at91_set_A_periph(AT91_PIN_PA11, 1);
> +				}
> +				slot_count++;
> +				break;
> +			case 1:					/* slot B */
> +				/* CMD */
> +				at91_set_A_periph(AT91_PIN_PA21, 1);
> +				/* DAT0, maybe DAT1..DAT3 */
> +				at91_set_A_periph(AT91_PIN_PA22, 1);
> +				if (data->slot[i].bus_width == 4) {
> +					at91_set_A_periph(AT91_PIN_PA23, 1);
> +					at91_set_A_periph(AT91_PIN_PA24, 1);
> +					at91_set_A_periph(AT91_PIN_PA25, 1);
> +				}
> +				slot_count++;
> +				break;
> +			default:
> +				printk(KERN_ERR
> +				       "AT91: SD/MMC slot %d not available\n", i);
> +				break;
> +			}
> +			if (slot_count) {
> +				/* CLK */
> +				at91_set_A_periph(AT91_PIN_PA6, 0);
> +
> +				mmc1_data = *data;
> +				platform_device_register(&at91sam9263_mmc1_device);
> +			}
> +		}
> +	}
> +}
> +#else
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
> +#endif
> +
> +/* --------------------------------------------------------------------
>   *  Compact Flash (PCMCIA or IDE)
>   * -------------------------------------------------------------------- */
>  
> diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
> index fe4ae22..83c5845 100644
> --- a/arch/arm/mach-at91/at91sam9rl_devices.c
> +++ b/arch/arm/mach-at91/at91sam9rl_devices.c
> @@ -228,6 +228,76 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  
>  
>  /* --------------------------------------------------------------------
> + *  MMC / SD
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static u64 mmc_dmamask = DMA_BIT_MASK(32);
> +static struct mci_platform_data mmc_data;
> +
> +static struct resource mmc_resources[] = {
> +	[0] = {
> +		.start	= AT91SAM9RL_BASE_MCI,
> +		.end	= AT91SAM9RL_BASE_MCI + SZ_16K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= AT91SAM9RL_ID_MCI,
> +		.end	= AT91SAM9RL_ID_MCI,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device at91sam9rl_mmc_device = {
> +	.name		= "atmel_mci",
> +	.id		= -1,
> +	.dev		= {
> +				.dma_mask		= &mmc_dmamask,
> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> +				.platform_data		= &mmc_data,
> +	},
> +	.resource	= mmc_resources,
> +	.num_resources	= ARRAY_SIZE(mmc_resources),
> +};
> +
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
> +{
> +	if (!data)
> +		return;
> +
> +	if (data->slot[0].bus_width) {
> +		/* input/irq */
> +		if (gpio_is_valid(data->slot[0].detect_pin)) {
> +			at91_set_gpio_input(data->slot[0].detect_pin, 1);
> +			at91_set_deglitch(data->slot[0].detect_pin, 1);
> +		}
> +		if (gpio_is_valid(data->slot[0].wp_pin))
> +			at91_set_gpio_input(data->slot[0].wp_pin, 1);
> +
> +		/* CLK */
> +		at91_set_A_periph(AT91_PIN_PA2, 0);
> +
> +		/* CMD */
> +		at91_set_A_periph(AT91_PIN_PA1, 1);
> +
> +		/* DAT0, maybe DAT1..DAT3 */
> +		at91_set_A_periph(AT91_PIN_PA0, 1);
> +		if (data->slot[0].bus_width == 4) {
> +			at91_set_A_periph(AT91_PIN_PA3, 1);
> +			at91_set_A_periph(AT91_PIN_PA4, 1);
> +			at91_set_A_periph(AT91_PIN_PA5, 1);
> +		}
> +
> +		mmc_data = *data;
> +		platform_device_register(&at91sam9rl_mmc_device);
> +	}
> +}
> +#else
> +void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
> +#endif
> +
> +
> +/* --------------------------------------------------------------------
>   *  NAND / SmartMedia
>   * -------------------------------------------------------------------- */
>  
> diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
> index caf017f..6cda303 100644
> --- a/arch/arm/mach-at91/board-foxg20.c
> +++ b/arch/arm/mach-at91/board-foxg20.c
> @@ -123,7 +123,7 @@ static struct at91_udc_data __initdata foxg20_udc_data = {
>   * SPI devices.
>   */
>  static struct spi_board_info foxg20_spi_devices[] = {
> -#if !defined(CONFIG_MMC_AT91)
> +#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
>  	{
>  		.modalias	= "mtd_dataflash",
>  		.chip_select	= 1,
> @@ -146,6 +146,7 @@ static struct macb_platform_data __initdata foxg20_macb_data = {
>   * MCI (SD/MMC)
>   * det_pin, wp_pin and vcc_pin are not connected
>   */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  static struct at91_mmc_data __initdata foxg20_mmc_data = {
>  	.slot_b		= 1,
>  	.wire4		= 1,
> @@ -153,6 +154,15 @@ static struct at91_mmc_data __initdata foxg20_mmc_data = {
>  	.wp_pin		= -EINVAL,
>  	.vcc_pin	= -EINVAL,
>  };
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata foxg20_mci0_data = {
> +	.slot[1] = {
> +		.bus_width	= 4,
> +		.detect_pin	= -EINVAL,
> +		.wp_pin		= -EINVAL,
> +	},
> +};
> +#endif
>  
>  
>  /*
> @@ -251,7 +261,11 @@ static void __init foxg20_board_init(void)
>  	/* Ethernet */
>  	at91_add_device_eth(&foxg20_macb_data);
>  	/* MMC */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  	at91_add_device_mmc(0, &foxg20_mmc_data);
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(0, &foxg20_mci0_data);
> +#endif
>  	/* I2C */
>  	at91_add_device_i2c(foxg20_i2c_devices, ARRAY_SIZE(foxg20_i2c_devices));
>  	/* LEDs */
> diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
> index b2e4fe2..7177aac 100644
> --- a/arch/arm/mach-at91/board-rm9200ek.c
> +++ b/arch/arm/mach-at91/board-rm9200ek.c
> @@ -83,6 +83,7 @@ static struct at91_udc_data __initdata ek_udc_data = {
>  };
>  
>  #ifndef CONFIG_MTD_AT91_DATAFLASH_CARD
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.det_pin	= AT91_PIN_PB27,
>  	.slot_b		= 0,
> @@ -90,6 +91,15 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.wp_pin		= AT91_PIN_PA17,
>  	.vcc_pin	= -EINVAL,
>  };
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata ek_mci0_data = {
> +	.slot[0] = {
> +		.bus_width	= 4,
> +		.detect_pin	= AT91_PIN_PB27,
> +		.wp_pin		= AT91_PIN_PA17,
> +	}
> +};
> +#endif
>  #endif
>  
>  static struct spi_board_info ek_spi_devices[] = {
> @@ -180,7 +190,11 @@ static void __init ek_board_init(void)
>  #else
>  	/* MMC */
>  	at91_set_gpio_output(AT91_PIN_PB22, 1);	/* this MMC card slot can optionally use SPI signaling (CS3). */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  	at91_add_device_mmc(0, &ek_mmc_data);
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(0, &ek_mci0_data);
> +#endif
>  #endif
>  	/* NOR Flash */
>  	platform_device_register(&ek_flash);
> diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
> index e8b116b..4a5786b 100644
> --- a/arch/arm/mach-at91/board-sam9-l9260.c
> +++ b/arch/arm/mach-at91/board-sam9-l9260.c
> @@ -89,7 +89,7 @@ static struct at91_udc_data __initdata ek_udc_data = {
>   * SPI devices.
>   */
>  static struct spi_board_info ek_spi_devices[] = {
> -#if !defined(CONFIG_MMC_AT91)
> +#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
>  	{	/* DataFlash chip */
>  		.modalias	= "mtd_dataflash",
>  		.chip_select	= 1,
> @@ -174,6 +174,7 @@ static void __init ek_add_device_nand(void)
>  /*
>   * MCI (SD/MMC)
>   */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.slot_b		= 1,
>  	.wire4		= 1,
> @@ -181,6 +182,15 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.wp_pin		= AT91_PIN_PC4,
>  	.vcc_pin	= -EINVAL,
>  };
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata mci0_data = {
> +	.slot[1] = {
> +		.bus_width	= 4,
> +		.detect_pin	= AT91_PIN_PC8,
> +		.wp_pin		= AT91_PIN_PC4,
> +	},
> +};
> +#endif
>  
>  static void __init ek_board_init(void)
>  {
> @@ -197,7 +207,11 @@ static void __init ek_board_init(void)
>  	/* Ethernet */
>  	at91_add_device_eth(&ek_macb_data);
>  	/* MMC */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  	at91_add_device_mmc(0, &ek_mmc_data);
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(0, &ek_mci0_data);
> +#endif
>  	/* I2C */
>  	at91_add_device_i2c(NULL, 0);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
> index d5aec55..b6ce2df 100644
> --- a/arch/arm/mach-at91/board-sam9260ek.c
> +++ b/arch/arm/mach-at91/board-sam9260ek.c
> @@ -121,7 +121,7 @@ static void __init at73c213_set_clk(struct at73c213_board_info *info) {}
>   * SPI devices.
>   */
>  static struct spi_board_info ek_spi_devices[] = {
> -#if !defined(CONFIG_MMC_AT91)
> +#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
>  	{	/* DataFlash chip */
>  		.modalias	= "mtd_dataflash",
>  		.chip_select	= 1,
> @@ -224,6 +224,7 @@ static void __init ek_add_device_nand(void)
>  /*
>   * MCI (SD/MMC)
>   */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.slot_b		= 1,
>  	.wire4		= 1,
> @@ -231,6 +232,15 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.wp_pin		= -EINVAL,
>  	.vcc_pin	= -EINVAL,
>  };
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata mci0_data = {
> +	.slot[1] = {
> +		.bus_width	= 4,
> +		.detect_pin	= -EINVAL,
> +		.wp_pin		= -EINVAL,
> +	},
> +};
> +#endif
>  
>  
>  /*
> @@ -332,7 +342,11 @@ static void __init ek_board_init(void)
>  	/* Ethernet */
>  	at91_add_device_eth(&ek_macb_data);
>  	/* MMC */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  	at91_add_device_mmc(0, &ek_mmc_data);
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(0, &ek_mci0_data);
> +#endif
>  	/* I2C */
>  	at91_add_device_i2c(ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
>  	/* SSC (to AT73C213) */
> diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
> index 065fed3..797dd7c 100644
> --- a/arch/arm/mach-at91/board-sam9261ek.c
> +++ b/arch/arm/mach-at91/board-sam9261ek.c
> @@ -344,6 +344,7 @@ static struct spi_board_info ek_spi_devices[] = {
>  #else /* CONFIG_SPI_ATMEL_* */
>  /* spi0 and mmc/sd share the same PIO pins: cannot be used at the same time */
>  
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  /*
>   * MCI (SD/MMC)
>   * det_pin, wp_pin and vcc_pin are not connected
> @@ -354,6 +355,15 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.wp_pin		= -EINVAL,
>  	.vcc_pin	= -EINVAL,
>  };
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata mci0_data = {
> +	.slot[0] = {
> +		.bus_width      = 4,
> +		.detect_pin     = -EINVAL,
> +		.wp_pin         = -EINVAL,
> +	},
> +};
> +#endif
>  
>  #endif /* CONFIG_SPI_ATMEL_* */
>  
> @@ -601,7 +611,11 @@ static void __init ek_board_init(void)
>  	at91_add_device_ssc(AT91SAM9261_ID_SSC1, ATMEL_SSC_TX);
>  #else
>  	/* MMC */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  	at91_add_device_mmc(0, &ek_mmc_data);
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(0, &mci0_data);
> +#endif
>  #endif
>  	/* LCD Controller */
>  	at91_add_device_lcdc(&ek_lcdc_data);
> diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
> index 2ffe50f..8080d02 100644
> --- a/arch/arm/mach-at91/board-sam9263ek.c
> +++ b/arch/arm/mach-at91/board-sam9263ek.c
> @@ -149,12 +149,22 @@ static struct spi_board_info ek_spi_devices[] = {
>  /*
>   * MCI (SD/MMC)
>   */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.wire4		= 1,
>  	.det_pin	= AT91_PIN_PE18,
>  	.wp_pin		= AT91_PIN_PE19,
>  	.vcc_pin	= -EINVAL,
>  };
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata mci1_data = {
> +	.slot[0] = {
> +		.bus_width	= 4,
> +		.detect_pin	= AT91_PIN_PE18,
> +		.wp_pin		= AT91_PIN_PE19,
> +	},
> +};
> +#endif
>  
>  
>  /*
> @@ -423,7 +433,11 @@ static void __init ek_board_init(void)
>  	/* Touchscreen */
>  	ek_add_device_ts();
>  	/* MMC */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  	at91_add_device_mmc(1, &ek_mmc_data);
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(1, &mci1_data);
> +#endif
>  	/* Ethernet */
>  	at91_add_device_eth(&ek_macb_data);
>  	/* NAND */
> diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
> index b109ce2..bb06521 100644
> --- a/arch/arm/mach-at91/board-sam9rlek.c
> +++ b/arch/arm/mach-at91/board-sam9rlek.c
> @@ -64,12 +64,22 @@ static struct usba_platform_data __initdata ek_usba_udc_data = {
>  /*
>   * MCI (SD/MMC)
>   */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  static struct at91_mmc_data __initdata ek_mmc_data = {
>  	.wire4		= 1,
>  	.det_pin	= AT91_PIN_PA15,
>  	.wp_pin		= -EINVAL,
>  	.vcc_pin	= -EINVAL,
>  };
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata mci0_data = {
> +	.slot[0] = {
> +		.bus_width	= 4,
> +		.detect_pin	= AT91_PIN_PA15,
> +		.wp_pin		= -EINVAL,
> +	},
> +};
> +#endif
>  
>  
>  /*
> @@ -306,7 +316,11 @@ static void __init ek_board_init(void)
>  	/* SPI */
>  	at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
>  	/* MMC */
> +#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
>  	at91_add_device_mmc(0, &ek_mmc_data);
> +#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(0, &mci0_data);
> +#endif
>  	/* LCD Controller */
>  	at91_add_device_lcdc(&ek_lcdc_data);
>  	/* AC97 */
> diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
> index b7483a3..879e34e 100644
> --- a/arch/arm/mach-at91/board-usb-a926x.c
> +++ b/arch/arm/mach-at91/board-usb-a926x.c
> @@ -114,7 +114,7 @@ static struct mmc_spi_platform_data at91_mmc_spi_pdata = {
>   * SPI devices.
>   */
>  static struct spi_board_info usb_a9263_spi_devices[] = {
> -#if !defined(CONFIG_MMC_AT91)
> +#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
>  	{	/* DataFlash chip */
>  		.modalias	= "mtd_dataflash",
>  		.chip_select	= 0,


-- 
Nicolas Ferre
