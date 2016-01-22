From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci: Add get_cd sdhci host operation
Date: Fri, 22 Jan 2016 13:07:45 +0100
Message-ID: <CAPDyKFoFGNGMJXtD7bTGWuO2FrDazDcZJ9KMHt_G38zxkn07Zg@mail.gmail.com>
References: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
	<1453455902-3987-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34201 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbcAVMHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2016 07:07:46 -0500
Received: by mail-yk0-f177.google.com with SMTP id a85so83568036ykb.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2016 04:07:46 -0800 (PST)
In-Reply-To: <1453455902-3987-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Lakshmi Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Russell King <linux@arm.linux.org.uk>

On 22 January 2016 at 10:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
> In the future sdhci will be a library.  When that happens
> a callback will be needed to allow drivers easily to override
> the standard way of determining whether a card is present.

There's already a ->get_cd() callback in the struct mmc_host_ops.

By turning sdhci into a library, each sdhci variant should decide
whether they want to use a default "sdhci_get_cd()" version, rely on
slot-gpio or implement their own.

I don't understand why we need a specific sdhci callback to deal with
this, it doesn't make sense to me.

> That is needed because functions like sdhci_request() also
> check the card presence.

Why does sdhci do that? Is that because some variants needs it or
because of all?

Reading a state of a GPIO pin before every request doesn't come
without a cost in performance. My point is, it should only be done
when *really* needed.
Again, by having sdhci to become a library each variant should decide
what's needed for them.

>
> The get_cd callback is being added now to facilitate
> a bug fix, for which subsequent patches are provided.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v4.4+
> ---
>  drivers/mmc/host/sdhci.c | 6 +++++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d622435d1bcc..535236084b27 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1612,7 +1612,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>  static int sdhci_do_get_cd(struct sdhci_host *host)
>  {
> -       int gpio_cd = mmc_gpio_get_cd(host->mmc);
> +       int gpio_cd;
>
>         if (host->flags & SDHCI_DEVICE_DEAD)
>                 return 0;
> @@ -1621,10 +1621,14 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
>         if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>                 return 1;
>
> +       if (host->ops->get_cd)
> +               return host->ops->get_cd(host);
> +
>         /*
>          * Try slot gpio detect, if defined it take precedence
>          * over build in controller functionality
>          */
> +       gpio_cd = mmc_gpio_get_cd(host->mmc);
>         if (!IS_ERR_VALUE(gpio_cd))
>                 return !!gpio_cd;
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7654ae5d2b4e..a6c2cd8ef0b2 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -552,6 +552,7 @@ struct sdhci_ops {
>                                          struct mmc_card *card,
>                                          unsigned int max_dtr, int host_drv,
>                                          int card_drv, int *drv_type);
> +       int     (*get_cd)(struct sdhci_host *host);
>  };
>
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> --
> 1.9.1
>

Can you please try to fix this without adding a new callback!? I know,
it requires some more efforts but for sure it's doable.

Kind regards
Uffe
