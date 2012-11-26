From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card
 detection on Dove
Date: Mon, 26 Nov 2012 14:53:07 +0800
Message-ID: <20121126065304.GA27305@S2100-06.ap.freescale.net>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
 <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:13174
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752134Ab2KZG0r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 01:26:47 -0500
Content-Disposition: inline
In-Reply-To: <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thu, Nov 22, 2012 at 11:55:51PM +0000, Russell King wrote:
> This commit taken from Rabeeh's Cubox kernel and re-worked for DT;
> Sebastian Hasselbrath is believed to be the original author.
> 
> Some Cuboxes require a GPIO for card detection; this implements the
> optional GPIO support for card detection.  This GPIO is logic 0 for
> card inserted.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-dove.c |   73 +++++++++++++++++++++++++++++++++++++---
>  1 files changed, 67 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> index 4af64f3..e621448 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -19,20 +19,30 @@
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> -#include <linux/err.h>
> -#include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
>  #include <linux/mmc/host.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #include "sdhci-pltfm.h"
>  
>  struct sdhci_dove_priv {
>  	struct clk *clk;
> +	int gpio_cd;
>  };
>  
> +static irqreturn_t sdhci_dove_carddetect_irq(int irq, void *data)
> +{
> +	struct sdhci_host *host = data;
> +
> +	tasklet_schedule(&host->card_tasklet);
> +	return IRQ_HANDLED;
> +}
> +
>  static u16 sdhci_dove_readw(struct sdhci_host *host, int reg)
>  {
>  	u16 ret;
> @@ -50,16 +60,25 @@ static u16 sdhci_dove_readw(struct sdhci_host *host, int reg)
>  
>  static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_dove_priv *priv = pltfm_host->priv;
>  	u32 ret;
>  
> +	ret = readl(host->ioaddr + reg);
> +
>  	switch (reg) {
>  	case SDHCI_CAPABILITIES:
> -		ret = readl(host->ioaddr + reg);
>  		/* Mask the support for 3.0V */
>  		ret &= ~SDHCI_CAN_VDD_300;
>  		break;
> -	default:
> -		ret = readl(host->ioaddr + reg);
> +	case SDHCI_PRESENT_STATE:
> +		if (gpio_is_valid(priv->gpio_cd)) {
> +			if (gpio_get_value(priv->gpio_cd) == 0)
> +				ret |= SDHCI_CARD_PRESENT;
> +			else
> +				ret &= ~SDHCI_CARD_PRESENT;
> +		}
> +		break;
>  	}
>  	return ret;
>  }
> @@ -94,6 +113,23 @@ static int __devinit sdhci_dove_probe(struct platform_device *pdev)
>  
>  	priv->clk = devm_clk_get(&pdev->dev, NULL);
>  
> +	if (pdev->dev.of_node) {
> +		priv->gpio_cd = of_get_named_gpio(pdev->dev.of_node,
> +						  "cd-gpios", 0);
> +	} else {
> +		priv->gpio_cd = -EINVAL;
> +	}
> +
> +	if (gpio_is_valid(priv->gpio_cd)) {
> +		ret = gpio_request(priv->gpio_cd, "sdhci-cd");
> +		if (ret) {
> +			dev_err(&pdev->dev, "card detect gpio request failed: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		gpio_direction_input(priv->gpio_cd);
> +	}
> +
>  	host = sdhci_pltfm_init(pdev, &sdhci_dove_pdata);
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
> @@ -112,13 +148,33 @@ static int __devinit sdhci_dove_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_sdhci_add;
>  
> +	/*
> +	 * We must request the IRQ after sdhci_add_host(), as the tasklet only
> +	 * gets setup in sdhci_add_host() and we oops.
> +	 */
> +	if (gpio_is_valid(priv->gpio_cd)) {
> +		ret = request_irq(gpio_to_irq(priv->gpio_cd),
> +				  sdhci_dove_carddetect_irq,
> +				  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +				  mmc_hostname(host->mmc), host);
> +		if (ret) {
> +			dev_err(&pdev->dev, "card detect irq request failed: %d\n",
> +				ret);
> +			goto err_request_irq;
> +		}
> +	}
> +
>  	return 0;
>  
> +err_request_irq:
> +	sdhci_remove_host(host, 0);
>  err_sdhci_add:
>  	if (!IS_ERR(priv->clk))
>  		clk_disable_unprepare(priv->clk);
>  	sdhci_pltfm_free(pdev);
>  err_sdhci_pltfm_init:
> +	if (gpio_is_valid(priv->gpio_cd))
> +		gpio_free(priv->gpio_cd);
>  	return ret;
>  }
>  
> @@ -130,6 +186,11 @@ static int __devexit sdhci_dove_remove(struct platform_device *pdev)
>  
>  	sdhci_pltfm_unregister(pdev);
>  
> +	if (gpio_is_valid(priv->gpio_cd)) {
> +		free_irq(gpio_to_irq(priv->gpio_cd), host);
> +		gpio_free(priv->gpio_cd);
> +	}
> +

You can probably use devm_gpio_request() and devm_request_irq() to save
these cleanups like what patch #1 is doing?

Shawn

>  	if (!IS_ERR(priv->clk))
>  		clk_disable_unprepare(priv->clk);
>  
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

