From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
Date: Thu, 15 Jan 2015 17:04:44 +0000
Message-ID: <20150115170444.GM16217@leverpostej>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
 <1421240530-7971-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:34991 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbAORFI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jan 2015 12:05:08 -0500
Content-Disposition: inline
In-Reply-To: <1421240530-7971-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Hi,

On Wed, Jan 14, 2015 at 01:02:10PM +0000, Ulf Hansson wrote:
> The need for a reset GPIO has several times been pointed out from
> earlier posted patchsets. Especially some WLAN chips which are
> attached to an SDIO interface may use a GPIO reset.
> 
> In this first version, one reset pin is supported. We may want to
> extend the support to cover more pins, but let's leave that as a future
> change. The added DT binding for the reset GPIO can easily be extended
> to manage several pins.
> 
> The reset GPIO is asserted at initialization and prior we start the
> power up procedure. It will then be de-asserted right after the power
> has been provided to the external chip/card, from the ->post_power_on()
> callback.

This needs to be specified a little more explicitly in the binding
document below, as it forms part of the contract of the binding.

> 
> Note, the reset GPIO is optional. Thus we don't return an error even if
> we can't find a GPIO pin for the consumer.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Adopted to the changed names of the pwrseq callbacks.
> 
> ---
>  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt  |  5 +++
>  drivers/mmc/core/pwrseq_simple.c                   | 38 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> index e1b7f9c..6fe0cd6 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> @@ -11,8 +11,13 @@ for several SOC designs.
>  Required properties:
>  - compatible : contains "mmc,pwrseq-simple".
>  
> +Optional properties:
> +- reset-gpios : contains a list of GPIO specifiers, though currently only one
> +		specifier is supported.

The support is a Linux issue. If the binding is meant to describe a
list, mention that, and what the expected semantics are.

Is it that difficult to have the driver iterate over the list now?

Thanks,
Mark.

> +
>  Example:
>  
>  	sdhci0_pwrseq {
>  		compatible = "mmc,pwrseq-simple";
> +		reset-gpios = <&gpio1 12 0>;
>  	}
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 7f87bc1..42d9836 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <linux/mmc/host.h>
>  
> @@ -18,31 +19,68 @@
>  
>  struct mmc_pwrseq_simple {
>  	struct mmc_pwrseq pwrseq;
> +	struct gpio_desc *reset_gpio;
>  };
>  
> +static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
> +{
> +	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
> +					struct mmc_pwrseq_simple, pwrseq);
> +
> +	if (!IS_ERR(pwrseq->reset_gpio))
> +		gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
> +}
> +
> +static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
> +{
> +	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
> +					struct mmc_pwrseq_simple, pwrseq);
> +
> +	if (!IS_ERR(pwrseq->reset_gpio))
> +		gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
> +}
> +
>  static void mmc_pwrseq_simple_free(struct mmc_host *host)
>  {
>  	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>  					struct mmc_pwrseq_simple, pwrseq);
>  
> +	if (!IS_ERR(pwrseq->reset_gpio))
> +		gpiod_put(pwrseq->reset_gpio);
> +
>  	kfree(&pwrseq);
>  	host->pwrseq = NULL;
>  }
>  
>  static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> +	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
> +	.post_power_on = mmc_pwrseq_simple_post_power_on,
> +	.power_off = mmc_pwrseq_simple_pre_power_on,
>  	.free = mmc_pwrseq_simple_free,
>  };
>  
>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>  {
>  	struct mmc_pwrseq_simple *pwrseq;
> +	int ret = 0;
>  
>  	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>  	if (!pwrseq)
>  		return -ENOMEM;
>  
> +	pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
> +	if (IS_ERR(pwrseq->reset_gpio) &&
> +		PTR_ERR(pwrseq->reset_gpio) != -ENOENT &&
> +		PTR_ERR(pwrseq->reset_gpio) != -ENOSYS) {
> +		ret = PTR_ERR(pwrseq->reset_gpio);
> +		goto free;
> +	}
> +
>  	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>  	host->pwrseq = &pwrseq->pwrseq;
>  
>  	return 0;
> +free:
> +	kfree(&pwrseq);
> +	return ret;
>  }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
