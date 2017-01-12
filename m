From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v2 1/2] mmc: sdio: Factor out retry init card helper function
Date: Thu, 12 Jan 2017 13:01:19 +0100
Message-ID: <CAPDyKFqiABSSOk6=04nFGn0K78Puqdj6GnycCbWKF_DUTDEQdg@mail.gmail.com>
References: <1483952180-85063-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35047 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdALMB1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 07:01:27 -0500
Received: by mail-wm0-f51.google.com with SMTP id r126so15500402wmr.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 04:01:21 -0800 (PST)
In-Reply-To: <1483952180-85063-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 9 January 2017 at 09:56, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Add new helper function, mmc_sdio_resend_if_cond, to be
> reused when trying to retry the init sequence.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
> Changes in v2:
> - rename the funtion to mmc_sdio_resend_if_cond
> - move the control of retries outside the helper function
>
>  drivers/mmc/core/sdio.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ecbc529..f417adc 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -541,6 +541,15 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
>         return err;
>  }
>
> +static void mmc_sdio_resend_if_cond(struct mmc_host *host,
> +                                   struct mmc_card *card)
> +{
> +       sdio_reset(host);
> +       mmc_go_idle(host);
> +       mmc_send_if_cond(host, host->ocr_avail);
> +       mmc_remove_card(card);
> +}
> +
>  /*
>   * Handle the detection and initialisation of a card.
>   *
> @@ -630,10 +639,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
>                                         ocr_card);
>                 if (err == -EAGAIN) {
> -                       sdio_reset(host);
> -                       mmc_go_idle(host);
> -                       mmc_send_if_cond(host, host->ocr_avail);
> -                       mmc_remove_card(card);
> +                       mmc_sdio_resend_if_cond(host, card);
>                         retries--;
>                         goto try_again;
>                 } else if (err) {
> --
> 1.9.1
>
>
