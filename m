From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
Date: Mon, 30 Aug 2010 20:11:02 +0400
Message-ID: <20100830161102.GA20413@oksana.dev.rtsoft.ru>
References: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
 <20100830132914.GA32266@oksana.dev.rtsoft.ru>
 <AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57357 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab0H3QLG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 12:11:06 -0400
Received: by ewy23 with SMTP id 23so3298598ewy.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 09:11:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Esben Haabendal <esbenhaabendal@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, linux-mmc@vger.kernel.org

> of_mmc_spi: add card detect irq support
> 
> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

> ---
>  .../powerpc/dts-bindings/mmc-spi-slot.txt          |    9 ++++++-
>  drivers/mmc/host/of_mmc_spi.c                      |   26 ++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
> index c39ac28..89a0084 100644
> --- a/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
> +++ b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
> @@ -7,8 +7,13 @@ Required properties:
>  - voltage-ranges : two cells are required, first cell specifies minimum
>    slot voltage (mV), second cell specifies maximum slot voltage (mV).
>    Several ranges could be specified.
> -- gpios : (optional) may specify GPIOs in this order: Card-Detect GPIO,
> +
> +Optional properties:
> +- gpios : may specify GPIOs in this order: Card-Detect GPIO,
>    Write-Protect GPIO.
> +- interrupts : the interrupt of a card detect interrupt.
> +- interrupt-parent : the phandle for the interrupt controller that
> +  services interrupts for this device.
>  
>  Example:
>  
> @@ -20,4 +25,6 @@ Example:
>  			 &qe_pio_d 15 0>;
>  		voltage-ranges = <3300 3300>;
>  		spi-max-frequency = <50000000>;
> +		interrupts = <42>;
> +		interrupt-parent = <&PIC>;
>  	};
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 1247e5d..5530def 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -34,6 +34,7 @@ enum {
>  struct of_mmc_spi {
>  	int gpios[NUM_GPIOS];
>  	bool alow_gpios[NUM_GPIOS];
> +	int detect_irq;
>  	struct mmc_spi_platform_data pdata;
>  };
>  
> @@ -61,6 +62,22 @@ static int of_mmc_spi_get_ro(struct device *dev)
>  	return of_mmc_spi_read_gpio(dev, WP_GPIO);
>  }
>  
> +static int of_mmc_spi_init(struct device *dev,
> +			   irqreturn_t (*irqhandler)(int, void *), void *mmc)
> +{
> +	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
> +
> +	return request_threaded_irq(oms->detect_irq, NULL, irqhandler, 0,
> +				    dev_name(dev), mmc);
> +}
> +
> +static void of_mmc_spi_exit(struct device *dev, void *mmc)
> +{
> +	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
> +
> +	free_irq(oms->detect_irq, mmc);
> +}
> +
>  struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -121,8 +138,13 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  	if (gpio_is_valid(oms->gpios[WP_GPIO]))
>  		oms->pdata.get_ro = of_mmc_spi_get_ro;
>  
> -	/* We don't support interrupts yet, let's poll. */
> -	oms->pdata.caps |= MMC_CAP_NEEDS_POLL;
> +	oms->detect_irq = irq_of_parse_and_map(np, 0);
> +	if (oms->detect_irq != NO_IRQ) {
> +		oms->pdata.init = of_mmc_spi_init;
> +		oms->pdata.exit = of_mmc_spi_exit;
> +	} else {
> +		oms->pdata.caps |= MMC_CAP_NEEDS_POLL;
> +	}
>  
>  	dev->platform_data = &oms->pdata;
>  	return dev->platform_data;
> -- 
> 1.7.1.1


-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
