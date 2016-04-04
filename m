From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: in mmc_hw_reset(), allow power cycle.
Date: Mon, 4 Apr 2016 14:39:12 +0200
Message-ID: <CAPDyKFq0o8ii27c8Qwh73EgANOfdEc-kXNdDDsjgVk_eU4y_TA@mail.gmail.com>
References: <1459531522-31874-1-git-send-email-gwendal@chromium.org>
	<1459551862-38853-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35243 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbcDDMjO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 08:39:14 -0400
Received: by mail-lf0-f41.google.com with SMTP id c126so49644309lfb.2
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 05:39:13 -0700 (PDT)
In-Reply-To: <1459551862-38853-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 2 April 2016 at 01:04, Gwendal Grignou <gwendal@chromium.org> wrote:
> When the eMMC device does not support/allow sending RST_n signal,
> try to do a brute force power cycle instead of returning EOPNOTSUPP.
> If power cycle is not supported by the hardware, mmc_init_card still
> send a CMD0, performing a Software Reset.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v3:
> - clock setting in already done in power_cycle.
> - clarify behavior when power cycle is not implemented. .
>  drivers/mmc/core/core.c |  5 +++--
>  drivers/mmc/core/mmc.c  | 24 +++++++++++-------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d8bbc78..d5bc2d8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2468,8 +2468,9 @@ int mmc_hw_reset(struct mmc_host *host)
>         ret = host->bus_ops->reset(host);
>         mmc_bus_put(host);
>
> -       if (ret != -EOPNOTSUPP)
> -               pr_warn("%s: tried to reset card\n", mmc_hostname(host));
> +       if (ret)
> +               pr_warn("%s: tried to reset card, got error %d\n",
> +                       mmc_hostname(host), ret);
>
>         return ret;
>  }
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 96cc7e2..92b7bea 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1988,19 +1988,17 @@ static int mmc_reset(struct mmc_host *host)
>  {
>         struct mmc_card *card = host->card;
>
> -       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
> -               return -EOPNOTSUPP;
> -
> -       if (!mmc_can_reset(card))
> -               return -EOPNOTSUPP;
> -
> -       mmc_set_clock(host, host->f_init);
> -
> -       host->ops->hw_reset(host);
> -
> -       /* Set initial state and call mmc_set_ios */
> -       mmc_set_initial_state(host);
> -
> +       if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
> +            mmc_can_reset(card)) {
> +               /* If the card accept RST_n signal, send it. */
> +               mmc_set_clock(host, host->f_init);
> +               host->ops->hw_reset(host);
> +               /* Set initial state and call mmc_set_ios */
> +               mmc_set_initial_state(host);
> +       } else {
> +               /* Do a brute force power cycle */
> +               mmc_power_cycle(host, card->ocr);
> +       }
>         return mmc_init_card(host, card->ocr, card);
>  }
>
> --
> 2.8.0.rc3.226.g39d4020
>

There are more two callers triggering the host->ops->hw_reset() to be
called, which also have special treatment of the error code
-EOPNOTSUPP. These are mmc_hw_reset() and mmc_blk_reset().

Please make sure to update their error handling accordingly. Otherwise
this looks okay to me.

Kind regards
Uffe
