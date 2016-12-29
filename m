From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC RESEND PATCH 1/2] mmc: sdio: Factor out retry init card
 helper function
Date: Thu, 29 Dec 2016 16:08:49 +0100
Message-ID: <CAPDyKFp7=TzhgcQ3=es_D=gfo+ot1AMX3eZfdkGwUJYX9RGB+w@mail.gmail.com>
References: <1481689038-128781-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f182.google.com ([209.85.210.182]:36632 "EHLO
        mail-wj0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbcL2PI7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2016 10:08:59 -0500
Received: by mail-wj0-f182.google.com with SMTP id c11so155028884wjx.3
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2016 07:08:51 -0800 (PST)
In-Reply-To: <1481689038-128781-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 14 December 2016 at 05:17, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Add new helper function, mmc_sdio_retry_init_card, to be
> reused when trying to retry the init sequence.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/core/sdio.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ecbc529..47f824b 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -541,6 +541,18 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
>         return err;
>  }
>
> +static void mmc_sdio_retry_init_card(struct mmc_host *host,

I suggest renaming this function to mmc_sdio_resend_if_cond() and...

> +                                    struct mmc_card *card,
> +                                    int *retries)

... remove retries, as I think retries is better handled outside of
this function. Looking at patch 2 also confirms this is a good idea.

> +{
> +       sdio_reset(host);
> +       mmc_go_idle(host);
> +       mmc_send_if_cond(host, host->ocr_avail);
> +       mmc_remove_card(card);
> +       (*retries)--;
> +
> +}
> +
>  /*
>   * Handle the detection and initialisation of a card.
>   *
> @@ -630,11 +642,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
>                                         ocr_card);
>                 if (err == -EAGAIN) {
> -                       sdio_reset(host);
> -                       mmc_go_idle(host);
> -                       mmc_send_if_cond(host, host->ocr_avail);
> -                       mmc_remove_card(card);
> -                       retries--;
> +                       mmc_sdio_retry_init_card(host, card, &retries);
>                         goto try_again;
>                 } else if (err) {
>                         ocr &= ~R4_18V_PRESENT;
> --
> 1.9.1
>

Kind regards
Uffe
