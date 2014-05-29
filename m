From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v14 6/6] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x
Date: Thu, 29 May 2014 19:11:12 +0530
Message-ID: <538738F8.8000807@ti.com>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com> <1401352085-22781-7-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1401352085-22781-7-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 29 May 2014 01:58 PM, Andreas Fenkart wrote:
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

Acked-by: Balaji T K <balajitk@ti.com>

Hi Chris/Ulf,

Can you please queue this series for 3.16

Thanks and Regards,
Balaji T K

>
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 0233ba7..76bf087 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -57,3 +57,56 @@ Examples:
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
> +In suspend the fclk is off and the module is disfunctional. Even register reads
> +will fail. A small logic in the host will request fclk restore, when an
> +external event is detected. Once the clock is restored, the host detects the
> +event normally. Since am33xx doesn't have this line it never wakes from
> +suspend.
> +
> +The workaround is to reconfigure the dat1 line as a GPIO upon suspend. To make
> +this work, we need to set the named pinctrl states "default" and "idle".
> +Prepare idle to remux dat1 as a gpio, and default to remux it back as sdio
> +dat1. The MMC driver will then toggle between idle and default state during
> +runtime.
> +
> +In summary:
> +1. select matching 'compatible' section, see example below.
> +2. specify pinctrl states "default" and "idle", "sleep" is optional.
> +3. specify the gpio irq used for detecting sdio irq in suspend
> +
> +If configuration is incomplete, a warning message is emitted "falling back to
> +polling". Also check the "sdio irq mode" in /sys/kernel/debug/mmc0/regs. Mind
> +not every application needs SDIO irq, e.g. MMC cards.
> +
> +	mmc1: mmc@48060100 {
> +		compatible = "ti,am33xx-hsmmc";
> +		...
> +		pinctrl-names = "default", "idle", "sleep"
> +		pinctrl-0 = <&mmc1_pins>;
> +		pinctrl-1 = <&mmc1_idle>;
> +		pinctrl-2 = <&mmc1_sleep>;
> +		...
> +		interrupts-extended = <&intc 64 &gpio2 28 0>;
> +	};
> +
> +	mmc1_idle : pinmux_cirq_pin {
> +		pinctrl-single,pins = <
> +		        0x0f8 0x3f      /* GPIO2_28 */
> +		>;
> +	};
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 0febb17..35ac2e4 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1754,15 +1754,33 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>   	 * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
>   	 */
>   	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
> -		ret = -ENODEV;
> -		devm_free_irq(host->dev, host->wake_irq, host);
> -		goto err;
> +		struct pinctrl *p = devm_pinctrl_get(host->dev);
> +		if (!p) {
> +			ret = -ENODEV;
> +			goto err_free_irq;
> +		}
> +		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
> +			dev_info(host->dev, "missing default pinctrl state\n");
> +			devm_pinctrl_put(p);
> +			ret = -EINVAL;
> +			goto err_free_irq;
> +		}
> +
> +		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_IDLE))) {
> +			dev_info(host->dev, "missing idle pinctrl state\n");
> +			devm_pinctrl_put(p);
> +			ret = -EINVAL;
> +			goto err_free_irq;
> +		}
> +		devm_pinctrl_put(p);
>   	}
>
>   	OMAP_HSMMC_WRITE(host->base, HCTL,
>   			 OMAP_HSMMC_READ(host->base, HCTL) | IWE);
>   	return 0;
>
> +err_free_irq:
> +	devm_free_irq(host->dev, host->wake_irq, host);
>   err:
>   	dev_warn(host->dev, "no SDIO IRQ support, falling back to polling\n");
>   	host->wake_irq = 0;
>

