From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH RFC] mmc: slot-gpio: Convert to gpiod_* API
Date: Sun, 23 Feb 2014 23:10:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1402232258370.19145@axis700.grange>
References: <1393171552-8808-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62744 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaBWWKZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Feb 2014 17:10:25 -0500
In-Reply-To: <1393171552-8808-1-git-send-email-shc_work@mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-mmc@vger.kernel.org

Hi Alexander,

Sorry, this isn't going to be a complete review, just a couple of 
comments.

On Sun, 23 Feb 2014, Alexander Shiyan wrote:

> This is a RFC patch only, please do not apply it.
> 
> This introduce a conversion slot-gpio to gpiod-* API.
> Usage of gpiod-* API allows us to remove all pieces of storage
> GPIOs in the driver's platform_data in the future.
> Patch saves calls to existing functions that allows us to convert
> all drivers to use new interface, one by one.
> Ready for comments and suggestions.
> ---
>  drivers/mmc/core/slot-gpio.c  | 221 ++++++++++++++++++++++++++----------------
>  include/linux/mmc/slot-gpio.h |  10 +-
>  2 files changed, 148 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 46596b71..6fc0483 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -14,17 +14,14 @@
>  #include <linux/jiffies.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
> -#include <linux/module.h>
> -#include <linux/slab.h>
>  
>  struct mmc_gpio {
> -	int ro_gpio;
> -	int cd_gpio;
> -	char *ro_label;
> -	char cd_label[0];
> +	struct gpio_desc *ro_gpio;
> +	struct gpio_desc *cd_gpio;
> +	char *cd_label;

First question: has this patch been run-time tested? I don't see the above 
cd_label being assigned anywhere.

>  };
>  
> -static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
> +static irqreturn_t mmc_gpio_cd_irq(int irq, void *dev_id)
>  {
>  	/* Schedule a card detection after a debounce timeout */
>  	struct mmc_host *host = dev_id;
> @@ -37,34 +34,26 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static int mmc_gpio_alloc(struct mmc_host *host)
> +static int mmc_gpiod_alloc(struct mmc_host *host)
>  {
>  	size_t len = strlen(dev_name(host->parent)) + 4;
> -	struct mmc_gpio *ctx;
> -
> -	mutex_lock(&host->slot.lock);

Why do you decide to remove mutex locking? This is an unrelated change.

> +	struct mmc_gpio *ctx = host->slot.handler_priv;
>  
> -	ctx = host->slot.handler_priv;
>  	if (!ctx) {
>  		/*
>  		 * devm_kzalloc() can be called after device_initialize(), even
>  		 * before device_add(), i.e., between mmc_alloc_host() and
>  		 * mmc_add_host()
>  		 */
> -		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + 2 * len,
> +		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + len,
>  				   GFP_KERNEL);
>  		if (ctx) {
> -			ctx->ro_label = ctx->cd_label + len;
> -			snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
> -			snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
> -			ctx->cd_gpio = -EINVAL;
> -			ctx->ro_gpio = -EINVAL;
> +			snprintf(ctx->cd_label, len, "%s cd",
> +				 dev_name(host->parent));
>  			host->slot.handler_priv = ctx;
>  		}
>  	}
>  
> -	mutex_unlock(&host->slot.lock);
> -
>  	return ctx ? 0 : -ENOMEM;
>  }
>  
> @@ -72,10 +61,10 @@ int mmc_gpio_get_ro(struct mmc_host *host)
>  {
>  	struct mmc_gpio *ctx = host->slot.handler_priv;
>  
> -	if (!ctx || !gpio_is_valid(ctx->ro_gpio))
> +	if (!ctx || IS_ERR_OR_NULL(ctx->ro_gpio))
>  		return -ENOSYS;
>  
> -	return !gpio_get_value_cansleep(ctx->ro_gpio) ^
> +	return !gpiod_get_value_cansleep(ctx->ro_gpio) ^
>  		!!(host->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
>  }
>  EXPORT_SYMBOL(mmc_gpio_get_ro);
> @@ -84,18 +73,17 @@ int mmc_gpio_get_cd(struct mmc_host *host)
>  {
>  	struct mmc_gpio *ctx = host->slot.handler_priv;
>  
> -	if (!ctx || !gpio_is_valid(ctx->cd_gpio))
> +	if (!ctx || IS_ERR_OR_NULL(ctx->cd_gpio))
>  		return -ENOSYS;
>  
> -	return !gpio_get_value_cansleep(ctx->cd_gpio) ^
> +	return !gpiod_get_value_cansleep(ctx->cd_gpio) ^
>  		!!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
>  }
>  EXPORT_SYMBOL(mmc_gpio_get_cd);
>  
>  /**
> - * mmc_gpio_request_ro - request a gpio for write-protection
> + * mmc_gpiod_request_ro - request a gpio for write-protection
>   * @host: mmc host
> - * @gpio: gpio number requested
>   *
>   * As devm_* managed functions are used in mmc_gpio_request_ro(), client
>   * drivers do not need to explicitly call mmc_gpio_free_ro() for freeing up,
> @@ -106,35 +94,45 @@ EXPORT_SYMBOL(mmc_gpio_get_cd);
>   *
>   * Returns zero on success, else an error.
>   */
> -int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
> +int mmc_gpiod_request_ro(struct mmc_host *host)
>  {
> -	struct mmc_gpio *ctx;
> +	struct mmc_gpio *ctx = host->slot.handler_priv;
>  	int ret;
>  
> -	if (!gpio_is_valid(gpio))
> -		return -EINVAL;
> -
> -	ret = mmc_gpio_alloc(host);
> -	if (ret < 0)
> +	ret = mmc_gpiod_alloc(host);
> +	if (ret)
>  		return ret;
>  
> -	ctx = host->slot.handler_priv;
> +	ctx->ro_gpio = devm_gpiod_get(&host->class_dev, "wp");
> +	if (IS_ERR(ctx->ro_gpio))
> +		return PTR_ERR(ctx->ro_gpio);
> +
> +	return gpiod_direction_input(ctx->ro_gpio);
> +}
> +EXPORT_SYMBOL(mmc_gpiod_request_ro);
> +
> +int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
> +{
> +	struct mmc_gpio *ctx = host->slot.handler_priv;
> +	int ret;
> +
> +	ret = mmc_gpiod_alloc(host);
> +	if (ret)
> +		return ret;
>  
> -	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
> -				    ctx->ro_label);
> -	if (ret < 0)
> +	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_IN, "wp");
> +	if (ret)

I consider the choice of "if (ret)" vs. "if (ret < 0)" mostly a matter of 
taste / style and I prefer to keep this uniform across sources. If you 
really think this is important, please, submit a separate patch.

>  		return ret;

Wouldn't this change break platforms, that already have MMC GPIOs with the 
old style label? Why do you have to change this?

Thanks
Guennadi

>  
> -	ctx->ro_gpio = gpio;
> +	ctx->ro_gpio = gpio_to_desc(gpio);
>  
> -	return 0;
> +	return IS_ERR(ctx->ro_gpio) ? PTR_ERR(ctx->ro_gpio) : 0;
>  }
>  EXPORT_SYMBOL(mmc_gpio_request_ro);
>  
>  /**
> - * mmc_gpio_request_cd - request a gpio for card-detection
> + * mmc_gpiod_request_cd - request a gpio for card-detection
>   * @host: mmc host
> - * @gpio: gpio number requested
>   * @debounce: debounce time in microseconds
>   *
>   * As devm_* managed functions are used in mmc_gpio_request_cd(), client
> @@ -150,60 +148,98 @@ EXPORT_SYMBOL(mmc_gpio_request_ro);
>   *
>   * Returns zero on success, else an error.
>   */
> -int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
> -			unsigned int debounce)
> +int mmc_gpiod_request_cd(struct mmc_host *host, unsigned int debounce)
>  {
> -	struct mmc_gpio *ctx;
> -	int irq = gpio_to_irq(gpio);
> +	struct mmc_gpio *ctx = host->slot.handler_priv;
>  	int ret;
>  
> -	ret = mmc_gpio_alloc(host);
> -	if (ret < 0)
> +	ret = mmc_gpiod_alloc(host);
> +	if (ret)
>  		return ret;
>  
> -	ctx = host->slot.handler_priv;
> +	ctx->cd_gpio = devm_gpiod_get(&host->class_dev, "cd");
> +	if (IS_ERR(ctx->cd_gpio))
> +		return PTR_ERR(ctx->cd_gpio);
>  
> -	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
> -				    ctx->cd_label);
> -	if (ret < 0)
> -		/*
> -		 * don't bother freeing memory. It might still get used by other
> -		 * slot functions, in any case it will be freed, when the device
> -		 * is destroyed.
> -		 */
> +	ret = gpiod_direction_input(ctx->cd_gpio);
> +	if (ret)
>  		return ret;
>  
>  	if (debounce) {
> -		ret = gpio_set_debounce(gpio, debounce);
> -		if (ret < 0)
> +		ret = gpiod_set_debounce(ctx->cd_gpio, debounce);
> +		if (ret)
>  			return ret;
>  	}
>  
>  	/*
> -	 * Even if gpio_to_irq() returns a valid IRQ number, the platform might
> +	 * Even if gpiod_to_irq() returns a valid IRQ number, the platform might
>  	 * still prefer to poll, e.g., because that IRQ number is already used
>  	 * by another unit and cannot be shared.
>  	 */
> -	if (irq >= 0 && host->caps & MMC_CAP_NEEDS_POLL)
> -		irq = -EINVAL;
> -
> -	if (irq >= 0) {
> -		ret = devm_request_threaded_irq(&host->class_dev, irq,
> -			NULL, mmc_gpio_cd_irqt,
> +	if (!(host->caps & MMC_CAP_NEEDS_POLL)) {
> +		host->slot.cd_irq = gpiod_to_irq(ctx->cd_gpio);
> +		ret = devm_request_threaded_irq(&host->class_dev,
> +			host->slot.cd_irq, NULL, mmc_gpio_cd_irq,
>  			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  			ctx->cd_label, host);
> -		if (ret < 0)
> -			irq = ret;
> +		if (ret)
> +			host->slot.cd_irq = ret;
> +	} else {
> +		host->slot.cd_irq = -EINVAL;
>  	}
>  
> -	host->slot.cd_irq = irq;
> -
> -	if (irq < 0)
> +	if (host->slot.cd_irq < 0)
>  		host->caps |= MMC_CAP_NEEDS_POLL;
>  
> -	ctx->cd_gpio = gpio;
> +	return ret;
> +}
> +EXPORT_SYMBOL(mmc_gpiod_request_cd);
> +
> +int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
> +			unsigned int debounce)
> +{
> +	struct mmc_gpio *ctx = host->slot.handler_priv;
> +	int ret;
> +
> +	ret = mmc_gpiod_alloc(host);
> +	if (ret)
> +		return ret;
>  
> -	return 0;
> +	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_IN, "cd");
> +	if (ret)
> +		return ret;
> +
> +	ctx->cd_gpio = gpio_to_desc(gpio);
> +	if (IS_ERR(ctx->cd_gpio))
> +		return PTR_ERR(ctx->cd_gpio);
> +
> +	if (debounce) {
> +		ret = gpiod_set_debounce(ctx->cd_gpio, debounce);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Even if gpiod_to_irq() returns a valid IRQ number, the platform might
> +	 * still prefer to poll, e.g., because that IRQ number is already used
> +	 * by another unit and cannot be shared.
> +	 */
> +	if (!(host->caps & MMC_CAP_NEEDS_POLL)) {
> +		host->slot.cd_irq = gpiod_to_irq(ctx->cd_gpio);
> +		ret = devm_request_threaded_irq(&host->class_dev,
> +			host->slot.cd_irq, NULL, mmc_gpio_cd_irq,
> +			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			ctx->cd_label, host);
> +		if (ret)
> +			host->slot.cd_irq = ret;
> +	} else {
> +		host->slot.cd_irq = -EINVAL;
> +	}
> +
> +	if (host->slot.cd_irq < 0)
> +		host->caps |= MMC_CAP_NEEDS_POLL;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(mmc_gpio_request_cd);
>  
> @@ -214,18 +250,41 @@ EXPORT_SYMBOL(mmc_gpio_request_cd);
>   * It's provided only for cases that client drivers need to manually free
>   * up the write-protection gpio requested by mmc_gpio_request_ro().
>   */
> +void mmc_gpiod_free(struct mmc_host *host)
> +{
> +	struct mmc_gpio *ctx = host->slot.handler_priv;
> +
> +	if (!ctx)
> +		return;
> +
> +	if (!IS_ERR_OR_NULL(ctx->ro_gpio))
> +		devm_gpiod_put(&host->class_dev, ctx->ro_gpio);
> +
> +	if (!IS_ERR_OR_NULL(ctx->cd_gpio)) {
> +		if (host->slot.cd_irq >= 0) {
> +			devm_free_irq(&host->class_dev, host->slot.cd_irq, host);
> +			host->slot.cd_irq = -EINVAL;
> +		}
> +
> +		devm_gpiod_put(&host->class_dev, ctx->cd_gpio);
> +	}
> +
> +	devm_kfree(&host->class_dev, ctx);
> +
> +	ctx = NULL;
> +}
> +EXPORT_SYMBOL(mmc_gpiod_free);
> +
>  void mmc_gpio_free_ro(struct mmc_host *host)
>  {
>  	struct mmc_gpio *ctx = host->slot.handler_priv;
> -	int gpio;
>  
> -	if (!ctx || !gpio_is_valid(ctx->ro_gpio))
> +	if (!ctx || IS_ERR_OR_NULL(ctx->ro_gpio))
>  		return;
>  
> -	gpio = ctx->ro_gpio;
> -	ctx->ro_gpio = -EINVAL;
> +	devm_gpiod_put(&host->class_dev, ctx->ro_gpio);
>  
> -	devm_gpio_free(&host->class_dev, gpio);
> +	ctx->ro_gpio = NULL;
>  }
>  EXPORT_SYMBOL(mmc_gpio_free_ro);
>  
> @@ -239,9 +298,8 @@ EXPORT_SYMBOL(mmc_gpio_free_ro);
>  void mmc_gpio_free_cd(struct mmc_host *host)
>  {
>  	struct mmc_gpio *ctx = host->slot.handler_priv;
> -	int gpio;
>  
> -	if (!ctx || !gpio_is_valid(ctx->cd_gpio))
> +	if (!ctx || IS_ERR_OR_NULL(ctx->cd_gpio))
>  		return;
>  
>  	if (host->slot.cd_irq >= 0) {
> @@ -249,9 +307,8 @@ void mmc_gpio_free_cd(struct mmc_host *host)
>  		host->slot.cd_irq = -EINVAL;
>  	}
>  
> -	gpio = ctx->cd_gpio;
> -	ctx->cd_gpio = -EINVAL;
> +	devm_gpiod_put(&host->class_dev, ctx->cd_gpio);
>  
> -	devm_gpio_free(&host->class_dev, gpio);
> +	ctx->cd_gpio = NULL;
>  }
>  EXPORT_SYMBOL(mmc_gpio_free_cd);
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index b0c73e4..a31ed96 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -14,10 +14,18 @@
>  struct mmc_host;
>  
>  int mmc_gpio_get_ro(struct mmc_host *host);
> +#define mmc_gpiod_get_ro(host)	mmc_gpio_get_ro(host)
> +int mmc_gpiod_request_ro(struct mmc_host *host);
> +
> +int mmc_gpio_get_cd(struct mmc_host *host);
> +#define mmc_gpiod_get_cd(host)	mmc_gpio_get_cd(host)
> +int mmc_gpiod_request_cd(struct mmc_host *host, unsigned int debounce);
> +
> +void mmc_gpiod_free(struct mmc_host *host);
> +
>  int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio);
>  void mmc_gpio_free_ro(struct mmc_host *host);
>  
> -int mmc_gpio_get_cd(struct mmc_host *host);
>  int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
>  			unsigned int debounce);
>  void mmc_gpio_free_cd(struct mmc_host *host);
> -- 
> 1.8.3.2

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
