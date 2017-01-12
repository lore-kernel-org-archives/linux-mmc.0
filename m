From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v2 2/2] mmc: sdio: don't use rocr to check if the card
 could support UHS mode
Date: Thu, 12 Jan 2017 13:01:28 +0100
Message-ID: <CAPDyKFro4cOCeVaGjBN9J-mbHFf4YPDf=xwJ0jvqCjxR_0zXmg@mail.gmail.com>
References: <1483952180-85063-1-git-send-email-shawn.lin@rock-chips.com> <1483952180-85063-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35143 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdALMBf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 07:01:35 -0500
Received: by mail-wm0-f44.google.com with SMTP id r126so15504748wmr.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 04:01:30 -0800 (PST)
In-Reply-To: <1483952180-85063-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 9 January 2017 at 09:56, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Per SDIO Simplified Specification V3, section 3.1.2, A host that
> supports UHS-I sets S18R to 1 in the argument of CMD5 to request a
> change of the signal voltage to 1.8V. If the card supports UHS-I and
> the current signal voltage is 3.3V, S18A is set to 1 in the R4 response.
> If the signal voltage is already 1.8V, the card sets S18A to 0 so that
> host maintains the current signal voltage. UHS-I is supported in SD mode
> and S18A is always 0 in SPI mode.
>
> For the current code, if the signaling voltage is fixed 1.8v, so
> the card will set S18A to 0 for rocr and thus we would clear the
> R4_18V_PRESENT from ocr, which make core won't try to use uhs mode.
>
> To fix it, we expect sdio_read_cccr would fail if the uhs mode won't
> work at all. Note that it's interesting that some sdio cards still
> response S18A even the voltage is fixed to 1.8v and the CMD11 will
> also accepted and finish enabling UHS mode successfully. I guess this
> is why folks didn't notice this problem. Anyway, fix it.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next, with minor modification to a comment in the
code - see below!

Kind regards
Uffe

>
> ---
>
> Changes in v2:
> - use the new helper function and improve the retry
> - fix a typo
>
>  drivers/mmc/core/sdio.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index f417adc..3af09da 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -633,7 +633,11 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>          * to switch to 1.8V signaling level.  No 1.8v signalling if
>          * UHS mode is not enabled to maintain compatibility and some
>          * systems that claim 1.8v signalling in fact do not support
> -        * it.
> +        * it. Per SDIO spec v3, section 3.1.2, if the voltage is already
> +        * 1.8v, the card sets S18A to 0 in the R4 response. So it will
> +        * fails to check rocr & R4_18V_PRESENT,  but we still need to
> +        * try to init uhs card. sdio_read_cccr will take over this task
> +        * to make sure which speed mode should work.
>          */
>         if (!powered_resume && (rocr & ocr & R4_18V_PRESENT)) {
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
> @@ -645,9 +649,6 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>                 } else if (err) {
>                         ocr &= ~R4_18V_PRESENT;
>                 }
> -               err = 0;
> -       } else {
> -               ocr &= ~R4_18V_PRESENT;
>         }
>
>         /*
> @@ -704,11 +705,23 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>         }
>
>         /*
> -        * Read the common registers.
> +        * Read the common registers. Note that we should try to
> +        * validate whether UHS would work or not.
>          */
>         err = sdio_read_cccr(card, ocr);
> -       if (err)
> -               goto remove;
> +       if (err) {
> +               mmc_sdio_resend_if_cond(host, card);
> +               if (ocr & R4_18V_PRESENT) {
> +                       /*
> +                        * Not retry it but just retring the sequence
> +                        * w/o R4_18V_PRESENT.

I am amending the change and rephrasing this to:

"Retry init sequence, but without R4_18V_PRESENT."

> +                        */
> +                       retries = 0;
> +                       goto try_again;
> +               } else {
> +                       goto remove;
> +               }
> +       }
>
>         /*
>          * Read the common CIS tuples.
> --
> 1.9.1
>
>
