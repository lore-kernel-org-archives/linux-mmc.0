From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] mmc: mmci: switch the driver to using gpio descriptors
Date: Wed, 16 Apr 2014 15:30:01 +0900
Message-ID: <CAAVeFu+At6pfq=Pwxd+y29RJWff_dh0V+KBu2HoC1TEMD00i+Q@mail.gmail.com>
References: <1397550786-8146-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:36702 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaDPGaW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Apr 2014 02:30:22 -0400
Received: by mail-ve0-f173.google.com with SMTP id oy12so10166535veb.18
        for <linux-mmc@vger.kernel.org>; Tue, 15 Apr 2014 23:30:21 -0700 (PDT)
In-Reply-To: <1397550786-8146-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Apr 15, 2014 at 5:33 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The next step in modernization of GPIO is to let drivers handle
> descriptors rather than integer numbers representing GPIO pins,
> akin to how clocks or regulators are already handled today.
>
> This patch makes the MMCI driver use GPIO descriptos in the

s/descriptos/descriptors

> core code with fallback code using the platform data if that
> is not possible. After all platforms with MMCI have been
> migrated to use descriptors, the platform data entries for
> GPIO pins can be removed.
>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Russell,Ulf: there is no hurry to do these changes (only used
> for my very corner-case MMCI PL181 experiments) but it's the
> desired direction to use descriptors for GPIOs going forward.
> I can rebase this on top of Ulf's patch stack any time, no
> problem.
> ---
>  drivers/mmc/host/mmci.c | 76 ++++++++++++++++++++++++-------------------------
>  drivers/mmc/host/mmci.h |  4 +--
>  2 files changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 771c60ab4a32..f84e39a5d592 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -26,7 +26,7 @@
>  #include <linux/amba/bus.h>
>  #include <linux/clk.h>
>  #include <linux/scatterlist.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of_gpio.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/dmaengine.h>
> @@ -1330,10 +1330,10 @@ static int mmci_get_ro(struct mmc_host *mmc)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
>
> -       if (host->gpio_wp == -ENOSYS)
> +       if (IS_ERR(host->gpio_wp))
>                 return -ENOSYS;
>
> -       return gpio_get_value_cansleep(host->gpio_wp);
> +       return gpiod_get_value_cansleep(host->gpio_wp);
>  }
>
>  static int mmci_get_cd(struct mmc_host *mmc)
> @@ -1342,13 +1342,13 @@ static int mmci_get_cd(struct mmc_host *mmc)
>         struct mmci_platform_data *plat = host->plat;
>         unsigned int status;
>
> -       if (host->gpio_cd == -ENOSYS) {
> +       if (IS_ERR(host->gpio_cd)) {
>                 if (!plat->status)
>                         return 1; /* Assume always present */
>
>                 status = plat->status(mmc_dev(host->mmc));
>         } else
> -               status = !!gpio_get_value_cansleep(host->gpio_cd)
> +               status = !!gpiod_get_value_cansleep(host->gpio_cd)

I think you don't even need that "!!" anymore since gpiolib now clamps
the returned values.

>                         ^ plat->cd_invert;
>
>         /*
> @@ -1412,13 +1412,10 @@ static struct mmc_host_ops mmci_ops = {
>
>  #ifdef CONFIG_OF
>  static void mmci_dt_populate_generic_pdata(struct device_node *np,
> -                                       struct mmci_platform_data *pdata)
> +                                          struct mmci_platform_data *pdata)
>  {
>         int bus_width = 0;
>
> -       pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
> -       pdata->gpio_cd = of_get_named_gpio(np, "cd-gpios", 0);
> -
>         if (of_get_property(np, "cd-inverted", NULL))
>                 pdata->cd_invert = true;
>         else
> @@ -1494,9 +1491,20 @@ static int mmci_probe(struct amba_device *dev,
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
>
> -       host->gpio_wp = -ENOSYS;
> -       host->gpio_cd = -ENOSYS;
> +       host->gpio_wp = ERR_PTR(-ENOSYS);
> +       host->gpio_cd = ERR_PTR(-ENOSYS);
>         host->gpio_cd_irq = -1;
> +       /*
> +        * TODO: when we finally get rid of all platform data for all
> +        * platforms deploying the MMCI block, we can delete the
> +        * gpio_to_desc() calls.
> +        */
> +       host->gpio_wp = gpiod_get(&dev->dev, "wp");
> +       if (IS_ERR(host->gpio_wp) && gpio_is_valid(plat->gpio_wp))
> +               host->gpio_wp = gpio_to_desc(plat->gpio_wp);

I think you will probably want to also call gpio_request() before
gpio_to_desc, or you may end up using a non-requested GPIO.

> +       host->gpio_cd = gpiod_get(&dev->dev, "cd");
> +       if (IS_ERR(host->gpio_cd) && gpio_is_valid(plat->gpio_wp))
> +               host->gpio_cd = gpio_to_desc(plat->gpio_cd);

Same here.

Nice patch anyway. Once the fallback integer GPIO code can be removed,
this will result in more removed lines than added ones, which is what
I like about these gpiod conversion patches! :)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
