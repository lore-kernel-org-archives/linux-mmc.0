From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: use GPIO descriptors array API
Date: Wed, 23 Sep 2015 23:42:27 +0200
Message-ID: <CAPDyKFrYsiw7-gXu_FuBT+aBe6GVSp64jRzW8UphowwPsKo5RQ@mail.gmail.com>
References: <1442837694-2738-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36527 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbbIWVm2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 17:42:28 -0400
Received: by wicgb1 with SMTP id gb1so224760844wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2015 14:42:27 -0700 (PDT)
In-Reply-To: <1442837694-2738-1-git-send-email-javier@osg.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, NeilBrown <neil@brown.name>

On 21 September 2015 at 14:14, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The simple power sequence provider sets a value for multiple GPIOs in one
> go so it is better to use the API already provided by the GPIO descriptor
> API instead of open coding the same logic.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/core/pwrseq_simple.c | 45 ++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 0b14b83a53d6..d10538bb5e07 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -23,18 +23,21 @@ struct mmc_pwrseq_simple {
>         struct mmc_pwrseq pwrseq;
>         bool clk_enabled;
>         struct clk *ext_clk;
> -       int nr_gpios;
> -       struct gpio_desc *reset_gpios[0];
> +       struct gpio_descs *reset_gpios;
>  };
>
>  static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>                                               int value)
>  {
>         int i;
> +       struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
> +       int values[reset_gpios->ndescs];
>
> -       for (i = 0; i < pwrseq->nr_gpios; i++)
> -               if (!IS_ERR(pwrseq->reset_gpios[i]))
> -                       gpiod_set_value_cansleep(pwrseq->reset_gpios[i], value);
> +       for (i = 0; i < reset_gpios->ndescs; i++)
> +               values[i] = value;
> +
> +       gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
> +                                      values);
>  }
>
>  static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
> @@ -75,11 +78,8 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>  {
>         struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>                                         struct mmc_pwrseq_simple, pwrseq);
> -       int i;
>
> -       for (i = 0; i < pwrseq->nr_gpios; i++)
> -               if (!IS_ERR(pwrseq->reset_gpios[i]))
> -                       gpiod_put(pwrseq->reset_gpios[i]);
> +       gpiod_put_array(pwrseq->reset_gpios);
>
>         if (!IS_ERR(pwrseq->ext_clk))
>                 clk_put(pwrseq->ext_clk);
> @@ -98,14 +98,9 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>                                            struct device *dev)
>  {
>         struct mmc_pwrseq_simple *pwrseq;
> -       int i, nr_gpios, ret = 0;
> -
> -       nr_gpios = of_gpio_named_count(dev->of_node, "reset-gpios");
> -       if (nr_gpios < 0)
> -               nr_gpios = 0;
> +       int ret = 0;
>
> -       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple) + nr_gpios *
> -                        sizeof(struct gpio_desc *), GFP_KERNEL);
> +       pwrseq = kzalloc(sizeof(*pwrseq), GFP_KERNEL);
>         if (!pwrseq)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -116,22 +111,12 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>                 goto free;
>         }
>
> -       for (i = 0; i < nr_gpios; i++) {
> -               pwrseq->reset_gpios[i] = gpiod_get_index(dev, "reset", i,
> -                                                        GPIOD_OUT_HIGH);
> -               if (IS_ERR(pwrseq->reset_gpios[i]) &&
> -                   PTR_ERR(pwrseq->reset_gpios[i]) != -ENOENT &&
> -                   PTR_ERR(pwrseq->reset_gpios[i]) != -ENOSYS) {
> -                       ret = PTR_ERR(pwrseq->reset_gpios[i]);
> -
> -                       while (i--)
> -                               gpiod_put(pwrseq->reset_gpios[i]);
> -
> -                       goto clk_put;
> -               }
> +       pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(pwrseq->reset_gpios)) {
> +               ret = PTR_ERR(pwrseq->reset_gpios);
> +               goto clk_put;
>         }
>
> -       pwrseq->nr_gpios = nr_gpios;
>         pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>
>         return &pwrseq->pwrseq;
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
