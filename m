From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v10 5/5] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x
Date: Fri, 2 May 2014 20:00:58 +0530
Message-ID: <5363AC22.9030208@ti.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com> <1398670860-30695-6-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36346 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbaEBObK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 May 2014 10:31:10 -0400
In-Reply-To: <1398670860-30695-6-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 28 April 2014 01:11 PM, Andreas Fenkart wrote:
> The am335x can't detect pending cirq in PM runtime suspend.
> This patch reconfigures dat1 as a GPIO before going to suspend.
> SDIO interrupts are detected with the GPIO, the GPIO will only wake
> the module from suspend, SDIO irq detection will still happen through the
> IP block.
>
> Idea of remuxing the pins by Tony Lindgren. Code contributions from
> Tony Lindgren and Balaji T K <balajitk@ti.com>
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks Andreas for the patch series.
Few comments ...

>
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index ce80561..4767cd1 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -56,3 +56,54 @@ Examples:
>   			&edma 25>;
>   		dma-names = "tx", "rx";
>   	};
> +
> +[workaround for missing swakeup on am33xx]
> +
> +This SOC is missing the swakeup line, it will not detect SDIO irq
> +while in suspend.
> +
> +                             ------
> +                             | PRCM |
> +                              ------
> +                               ^ |
> +                       swakeup | | fclk
> +                               | v
> +       ------                -------               -----
> +      | card | -- CIRQ -->  | hsmmc | -- IRQ -->  | CPU |
> +       ------                -------               -----
> +
> +In suspend the fclk is off and the module is disfunctional. Even
> +register reads will fail. A small logic in the host will request
> +fclk restore, when an external event is detected. Once the clock
> +is restored, the host detects the event normally. Since am33xx
> +doesn't have this line it never wakes from suspend.
> +
> +The workaround is to reconfigure the dat1 line as a GPIO upon
> +suspend. To make this work, we need to set 1) the named pinctrl
> +states "default", "idle" and "gpio_dat1", 2) the gpio detecting
> +sdio irq in suspend and 3) the compatibe section, see example below.
> +The MMC driver will then toggle between gpio_dat1 and default during
> +the runtime. If configuration is incomplete, a warning message is
> +emitted "falling back to polling". Mind not every application
> +needs SDIO irq, e.g. MMC cards Affected chips are am335x,
> +probably others
> +
> +
> +	mmc1: mmc@48060100 {
> +		compatible = "ti,am33xx-hsmmc";
> +		...
> +		interrupts-extended = <&intc 64 &gpio2 28 0>;
> +		...
> +		pinctrl-names = "default", "idle", "sleep", "gpio_dat1"
> +		pinctrl-0 = <&mmc1_pins>;
> +		pinctrl-1 = <&mmc1_idle>;
> +		pinctrl-2 = <&mmc1_sleep>;
> +		pinctrl-3 = <&mmc1_cirq_pin>;
> +		...
> +	};
> +
> +	mmc1_cirq_pin: pinmux_cirq_pin {
> +		pinctrl-single,pins = <
> +		        0x0f8 0x3f      /* GPIO2_28 */
> +		>;
> +	};
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 9cc0d21..8661e1f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -213,7 +213,10 @@ struct omap_hsmmc_host {
>   #define AUTO_CMD23		(1 << 0)        /* Auto CMD23 support */
>   #define HSMMC_SDIO_IRQ_ENABLED	(1 << 1)        /* SDIO irq enabled */
>   #define HSMMC_WAKE_IRQ_ENABLED	(1 << 2)
> +#define HSMMC_SWAKEUP_QUIRK	(1 << 3)
>   	struct omap_hsmmc_next	next_data;
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*gpio_pinmux;
>   	struct	omap_mmc_platform_data	*pdata;
>   };
>
> @@ -1744,8 +1747,28 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>   	 * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
>   	 */
>   	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
> -		ret = -ENODEV;
> -		goto err;
> +		if (IS_ERR(host->dev->pins->default_state)) {
> +			dev_info(host->dev, "missing default pinctrl state\n");
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		host->pinctrl = devm_pinctrl_get(host->dev);
> +		if (IS_ERR(host->pinctrl)) {
> +			dev_warn(host->dev, "no pinctrl handle\n");
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +
> +		host->gpio_pinmux = pinctrl_lookup_state(host->pinctrl,
> +							 "gpio_dat1");
> +		if (IS_ERR(host->gpio_pinmux)) {
> +			dev_info(host->dev, "missing \"gpio_dat1\" pinctrl state\n");
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +
> +		host->flags |= HSMMC_SWAKEUP_QUIRK;
>   	}
>
>   	devres_remove_group(host->dev, NULL);
> @@ -2438,7 +2461,10 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
>   			goto abort;
>   		}
>
> -		pinctrl_pm_select_idle_state(dev);
> +		if (host->flags & HSMMC_SWAKEUP_QUIRK)
> +			pinctrl_select_state(host->pinctrl, host->gpio_pinmux);

Why not combine "gpio_dat1" state and "idle", update documentation to have
gpio remuxed in idle state for SoCs with swakeup quirk,
Since I don't see any use case where both idle/gpio_pinmux are getting used.

> +		else
> +			pinctrl_pm_select_idle_state(dev);
>
>   		WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
>   		enable_irq(host->wake_irq);
>

