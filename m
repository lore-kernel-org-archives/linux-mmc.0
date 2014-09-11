From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: make hw_reset power cycle SD-cards
Date: Thu, 11 Sep 2014 13:03:00 +0200
Message-ID: <CAPDyKFrNV1qoDkTMsRwSf=SihHBwGUhqP4yL3NNfwhnn9wf9Hg@mail.gmail.com>
References: <1410272508-4885-1-git-send-email-johanru@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:57356 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbaIKLDC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Sep 2014 07:03:02 -0400
Received: by mail-qc0-f171.google.com with SMTP id x3so20528804qcv.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2014 04:03:01 -0700 (PDT)
In-Reply-To: <1410272508-4885-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Johan Rudholm <johanru@axis.com>

On 9 September 2014 16:21, Johan Rudholm <johan.rudholm@axis.com> wrote:
> SD-cards cannot be reset, but they can be power cycled. Power cycling
> a buggy SD-card sometimes helps it get back on track.

Hi Johan,

This feature has been missing for too long - really great that you are
working on this!

>
> Signed-off-by: Johan Rudholm <johanru@axis.com>
> ---
>  drivers/mmc/core/core.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d03a080..9171aa9 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2250,19 +2250,25 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
>  {
>         struct mmc_card *card = host->card;
>
> -       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
> -               return -EOPNOTSUPP;
> -
>         if (!card)
>                 return -EINVAL;
>
> -       if (!mmc_can_reset(card))
> +       if (!mmc_card_sd(card) && !((host->caps & MMC_CAP_HW_RESET) &&
> +                                                       host->ops->hw_reset))
> +               return -EOPNOTSUPP;
> +
> +       if (!mmc_card_sd(card) && !mmc_can_reset(card))
>                 return -EOPNOTSUPP;
>
>         mmc_host_clk_hold(host);
>         mmc_set_clock(host, host->f_init);
>
> -       host->ops->hw_reset(host);
> +       if (mmc_card_sd(card))
> +               mmc_power_cycle(host, card->ocr);
> +       else
> +               host->ops->hw_reset(host);
> +
> +       pr_warning("%s: reset device\n", mmc_hostname(host));
>
>         /* If the reset has happened, then a status command will fail */
>         if (check) {
> --
> 1.7.2.5
>

Before we decide to go ahead an continue to hack on the current reset
code as your patch does, could you possibly consider to do some more
extensive rework this code?

Here are some of the ideas that I had in mind.

1) Invent a new bus_ops callback for reset. Or maybe we should re-use
the ->power_save|restore ones, since those already exist!?
2) Since those bus_ops are specific for sd/mmc/sdio we shall handle
those related parts in there.
3) Then let's mmc_do_hw_reset invoke the above bus_ops.
4) Remove the mmc_hw_reset_check() API. Currently only used by mmc_test.

What do you think?

Kind regards
Uffe
