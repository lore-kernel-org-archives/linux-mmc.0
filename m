From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq: simplify alloc/free hooks
Date: Thu, 5 Mar 2015 15:55:34 +0100
Message-ID: <CAPDyKFq+rvRQdjJN=M1rK+Ynj58Gw-o21kZP2bYeHj3Z-Phs8A@mail.gmail.com>
References: <1423715771-20498-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44950 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbbCEOzf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 09:55:35 -0500
Received: by qcxn11 with SMTP id n11so15274253qcx.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 06:55:34 -0800 (PST)
In-Reply-To: <1423715771-20498-1-git-send-email-acourbot@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Chris Ball <chris@printf.net>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On 12 February 2015 at 05:36, Alexandre Courbot <acourbot@nvidia.com> wrote:
> The alloc() and free() hooks required each pwrseq implementation to set
> host->pwrseq themselves. This is error-prone and could be done at a
> higher level if alloc() was changed to return a pointer to a struct
> mmc_pwrseq instead of an error code.
>
> This patch performs this change and moves the burden of maintaining
> host->pwrseq from the power sequence hooks to the pwrseq code.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Applied, thanks!

Kind regards
Uffe

> ---
> It occured to me that after this change, none of the alloc()
> implementations ever uses the host parameter. I have kept it in case
> it could be useful for other purposes, but can remove it in a v2 if
> this is deemed better by the MMC maintainers.
>
>  drivers/mmc/core/pwrseq.c        | 16 ++++++++++++----
>  drivers/mmc/core/pwrseq.h        |  6 ++++--
>  drivers/mmc/core/pwrseq_emmc.c   | 11 +++++------
>  drivers/mmc/core/pwrseq_simple.c | 11 +++++------
>  4 files changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index 862356123d78..ab2129781161 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -19,7 +19,7 @@
>
>  struct mmc_pwrseq_match {
>         const char *compatible;
> -       int (*alloc)(struct mmc_host *host, struct device *dev);
> +       struct mmc_pwrseq *(*alloc)(struct mmc_host *host, struct device *dev);
>  };
>
>  static struct mmc_pwrseq_match pwrseq_match[] = {
> @@ -52,6 +52,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>         struct platform_device *pdev;
>         struct device_node *np;
>         struct mmc_pwrseq_match *match;
> +       struct mmc_pwrseq *pwrseq;
>         int ret = 0;
>
>         np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
> @@ -70,9 +71,14 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>                 goto err;
>         }
>
> -       ret = match->alloc(host, &pdev->dev);
> -       if (!ret)
> -               dev_info(host->parent, "allocated mmc-pwrseq\n");
> +       pwrseq = match->alloc(host, &pdev->dev);
> +       if (IS_ERR(pwrseq)) {
> +               ret = PTR_ERR(host->pwrseq);
> +               goto err;
> +       }
> +
> +       host->pwrseq = pwrseq;
> +       dev_info(host->parent, "allocated mmc-pwrseq\n");
>
>  err:
>         of_node_put(np);
> @@ -109,4 +115,6 @@ void mmc_pwrseq_free(struct mmc_host *host)
>
>         if (pwrseq && pwrseq->ops && pwrseq->ops->free)
>                 pwrseq->ops->free(host);
> +
> +       host->pwrseq = NULL;
>  }
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index aba3409e8d6e..096da48c6a7e 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -27,8 +27,10 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host);
>  void mmc_pwrseq_power_off(struct mmc_host *host);
>  void mmc_pwrseq_free(struct mmc_host *host);
>
> -int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev);
> -int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev);
> +struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
> +                                          struct device *dev);
> +struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
> +                                        struct device *dev);
>
>  #else
>
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index a2d545904fbf..9d6d2fb21796 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -49,7 +49,6 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *host)
>         unregister_restart_handler(&pwrseq->reset_nb);
>         gpiod_put(pwrseq->reset_gpio);
>         kfree(pwrseq);
> -       host->pwrseq = NULL;
>  }
>
>  static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
> @@ -67,14 +66,15 @@ static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
>         return NOTIFY_DONE;
>  }
>
> -int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev)
> +struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
> +                                        struct device *dev)
>  {
>         struct mmc_pwrseq_emmc *pwrseq;
>         int ret = 0;
>
>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_emmc), GFP_KERNEL);
>         if (!pwrseq)
> -               return -ENOMEM;
> +               return ERR_PTR(-ENOMEM);
>
>         pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_LOW);
>         if (IS_ERR(pwrseq->reset_gpio)) {
> @@ -92,10 +92,9 @@ int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev)
>         register_restart_handler(&pwrseq->reset_nb);
>
>         pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
> -       host->pwrseq = &pwrseq->pwrseq;
>
> -       return 0;
> +       return &pwrseq->pwrseq;
>  free:
>         kfree(pwrseq);
> -       return ret;
> +       return ERR_PTR(ret);
>  }
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index e9f1d8d84613..5c0667af8dd6 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -85,7 +85,6 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>                 clk_put(pwrseq->ext_clk);
>
>         kfree(pwrseq);
> -       host->pwrseq = NULL;
>  }
>
>  static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> @@ -95,7 +94,8 @@ static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>         .free = mmc_pwrseq_simple_free,
>  };
>
> -int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
> +struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
> +                                          struct device *dev)
>  {
>         struct mmc_pwrseq_simple *pwrseq;
>         int i, nr_gpios, ret = 0;
> @@ -107,7 +107,7 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple) + nr_gpios *
>                          sizeof(struct gpio_desc *), GFP_KERNEL);
>         if (!pwrseq)
> -               return -ENOMEM;
> +               return ERR_PTR(-ENOMEM);
>
>         pwrseq->ext_clk = clk_get(dev, "ext_clock");
>         if (IS_ERR(pwrseq->ext_clk) &&
> @@ -133,13 +133,12 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>
>         pwrseq->nr_gpios = nr_gpios;
>         pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
> -       host->pwrseq = &pwrseq->pwrseq;
>
> -       return 0;
> +       return &pwrseq->pwrseq;
>  clk_put:
>         if (!IS_ERR(pwrseq->ext_clk))
>                 clk_put(pwrseq->ext_clk);
>  free:
>         kfree(pwrseq);
> -       return ret;
> +       return ERR_PTR(ret);
>  }
> --
> 2.3.0
>
