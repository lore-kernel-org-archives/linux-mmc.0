From: Marc Reilly <marc@cpdesign.com.au>
Subject: Re: [PATCH 1/5] mmc: sdhci-esdhc-imx: add support for write protect
	on custom GPIO
Date: Fri, 11 Feb 2011 09:24:38 +1100
Message-ID: <201102110924.38338.marc@cpdesign.com.au>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
	<1297365291-1038-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1297365291-1038-2-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, Eric =?iso-8859-1?q?B=E9nard?= <eric@eukrea.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

First three patches work well on my vpr200 board (mx35). 
One comment inline...

I ran some tests of insert/remove card with the card locked and unlocked, and 
trying to append a file. It behaved as expected, thus:

Tested-by: Marc Reilly <marc@cpdesign.com.au> 


> +static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
> +{
> +	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
> +
> +	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
> +		return gpio_get_value(boarddata->wp_gpio);
> +	else
> +		return -ENOSYS;
> +}
> +

..snip..

> @@ -116,9 +139,20 @@ static int esdhc_pltfm_init(struct sdhci_host *host,
> struct sdhci_pltfm_data *pd if (cpu_is_mx35() || cpu_is_mx51())
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> 
> -	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
> -	if (cpu_is_mx25() || cpu_is_mx35())
> +	if (cpu_is_mx25() || cpu_is_mx35()) {
> +		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
>  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
> +		/* write_protect can't be routed to controller, use gpio */
> +		sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
> +	}
> +
> +	if (boarddata) {

Perhaps (boarddata && gpio_is_valid(boarddata->wp_gpio) as above?

For example what if someone sets up the boarddata for a card detect, but not 
write protect.

> +		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
> +		if (err) {
> +			dev_warn(mmc_dev(host->mmc), "can't get wp_pin!\n");
> +			boarddata->wp_gpio = err;
> +		}
> +	}
> 
>  	return 0;
>  }

Cheers,
Marc
