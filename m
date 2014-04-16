From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: switch the driver to using gpio descriptors
Date: Wed, 16 Apr 2014 09:31:12 +0200
Message-ID: <CAPDyKFq8TGsHQixYJwtPGkr0HS8r1-B0LZWsO9DKYH+gTq_Dgg@mail.gmail.com>
References: <1397550786-8146-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:60845 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaDPHbO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Apr 2014 03:31:14 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so11504247qcx.24
        for <linux-mmc@vger.kernel.org>; Wed, 16 Apr 2014 00:31:13 -0700 (PDT)
In-Reply-To: <1397550786-8146-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Alexandre Courbot <gnurou@gmail.com>

On 15 April 2014 10:33, Linus Walleij <linus.walleij@linaro.org> wrote:
> The next step in modernization of GPIO is to let drivers handle
> descriptors rather than integer numbers representing GPIO pins,
> akin to how clocks or regulators are already handled today.
>
> This patch makes the MMCI driver use GPIO descriptos in the
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

If you rebase it on top of my patch stack - I can resend the pull
request I sent a few days ago and include this one!?

Kind regards
Ulf Hansson

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
> +       host->gpio_cd = gpiod_get(&dev->dev, "cd");
> +       if (IS_ERR(host->gpio_cd) && gpio_is_valid(plat->gpio_wp))
> +               host->gpio_cd = gpio_to_desc(plat->gpio_cd);
>
>         host->hw_designer = amba_manf(dev);
>         host->hw_revision = amba_rev(dev);
> @@ -1616,17 +1624,13 @@ static int mmci_probe(struct amba_device *dev,
>         writel(0, host->base + MMCIMASK1);
>         writel(0xfff, host->base + MMCICLEAR);
>
> -       if (plat->gpio_cd == -EPROBE_DEFER) {
> +       if (PTR_ERR(host->gpio_cd) == -EPROBE_DEFER) {
>                 ret = -EPROBE_DEFER;
>                 goto err_gpio_cd;
>         }
> -       if (gpio_is_valid(plat->gpio_cd)) {
> -               ret = gpio_request(plat->gpio_cd, DRIVER_NAME " (cd)");
> -               if (ret == 0)
> -                       ret = gpio_direction_input(plat->gpio_cd);
> -               if (ret == 0)
> -                       host->gpio_cd = plat->gpio_cd;
> -               else if (ret != -ENOSYS)
> +       if (!IS_ERR(host->gpio_cd)) {
> +               ret = gpiod_direction_input(host->gpio_cd);
> +               if (ret < 0 && ret != -ENOSYS)
>                         goto err_gpio_cd;
>
>                 /*
> @@ -1636,28 +1640,24 @@ static int mmci_probe(struct amba_device *dev,
>                  * for the inverted case) so we request triggers on both
>                  * edges.
>                  */
> -               ret = request_any_context_irq(gpio_to_irq(plat->gpio_cd),
> +               ret = request_any_context_irq(gpiod_to_irq(host->gpio_cd),
>                                 mmci_cd_irq,
>                                 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>                                 DRIVER_NAME " (cd)", host);
>                 if (ret >= 0)
> -                       host->gpio_cd_irq = gpio_to_irq(plat->gpio_cd);
> +                       host->gpio_cd_irq = gpiod_to_irq(host->gpio_cd);
>         }
> -       if (plat->gpio_wp == -EPROBE_DEFER) {
> +       if (PTR_ERR(host->gpio_wp) == -EPROBE_DEFER) {
>                 ret = -EPROBE_DEFER;
>                 goto err_gpio_wp;
>         }
> -       if (gpio_is_valid(plat->gpio_wp)) {
> -               ret = gpio_request(plat->gpio_wp, DRIVER_NAME " (wp)");
> -               if (ret == 0)
> -                       ret = gpio_direction_input(plat->gpio_wp);
> -               if (ret == 0)
> -                       host->gpio_wp = plat->gpio_wp;
> -               else if (ret != -ENOSYS)
> +       if (!IS_ERR(host->gpio_wp)) {
> +               ret = gpiod_direction_input(host->gpio_wp);
> +               if (ret < 0 && ret != -ENOSYS)
>                         goto err_gpio_wp;
>         }
>
> -       if ((host->plat->status || host->gpio_cd != -ENOSYS)
> +       if ((host->plat->status || !IS_ERR(host->gpio_cd))
>             && host->gpio_cd_irq < 0)
>                 mmc->caps |= MMC_CAP_NEEDS_POLL;
>
> @@ -1696,13 +1696,13 @@ static int mmci_probe(struct amba_device *dev,
>   irq0_free:
>         free_irq(dev->irq[0], host);
>   unmap:
> -       if (host->gpio_wp != -ENOSYS)
> -               gpio_free(host->gpio_wp);
> +       if (!IS_ERR(host->gpio_wp))
> +               gpiod_put(host->gpio_wp);
>   err_gpio_wp:
>         if (host->gpio_cd_irq >= 0)
>                 free_irq(host->gpio_cd_irq, host);
> -       if (host->gpio_cd != -ENOSYS)
> -               gpio_free(host->gpio_cd);
> +       if (!IS_ERR(host->gpio_cd))
> +               gpiod_put(host->gpio_cd);
>   err_gpio_cd:
>         iounmap(host->base);
>   clk_disable:
> @@ -1741,12 +1741,12 @@ static int mmci_remove(struct amba_device *dev)
>                 if (!host->singleirq)
>                         free_irq(dev->irq[1], host);
>
> -               if (host->gpio_wp != -ENOSYS)
> -                       gpio_free(host->gpio_wp);
> +               if (!IS_ERR(host->gpio_wp))
> +                       gpiod_put(host->gpio_wp);
>                 if (host->gpio_cd_irq >= 0)
>                         free_irq(host->gpio_cd_irq, host);
> -               if (host->gpio_cd != -ENOSYS)
> -                       gpio_free(host->gpio_cd);
> +               if (!IS_ERR(host->gpio_cd))
> +                       gpiod_put(host->gpio_cd);
>
>                 iounmap(host->base);
>                 clk_disable_unprepare(host->clk);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 58b1b8896bf2..b1c1de28201f 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -176,8 +176,8 @@ struct mmci_host {
>         struct mmc_data         *data;
>         struct mmc_host         *mmc;
>         struct clk              *clk;
> -       int                     gpio_cd;
> -       int                     gpio_wp;
> +       struct gpio_desc        *gpio_cd;
> +       struct gpio_desc        *gpio_wp;
>         int                     gpio_cd_irq;
>         bool                    singleirq;
>
> --
> 1.9.0
>
