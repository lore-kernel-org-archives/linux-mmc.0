From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC RESEND PATCH 2/2] mmc: sdio: don't use rocr to check if the
 card could support UHS mode
Date: Thu, 29 Dec 2016 16:31:00 +0100
Message-ID: <CAPDyKFqJRCt-krcmJDh1YGtnZOpyLP3d2CMi-ufuX+vwayG33g@mail.gmail.com>
References: <1481689038-128781-1-git-send-email-shawn.lin@rock-chips.com> <1481689038-128781-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f176.google.com ([209.85.210.176]:32803 "EHLO
        mail-wj0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbcL2PbD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2016 10:31:03 -0500
Received: by mail-wj0-f176.google.com with SMTP id tq7so123367999wjb.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2016 07:31:02 -0800 (PST)
In-Reply-To: <1481689038-128781-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 14 December 2016 at 05:17, Shawn Lin <shawn.lin@rock-chips.com> wrote:
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
>
> ---
>
>  drivers/mmc/core/sdio.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 47f824b..1d736e4 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -636,7 +636,11 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
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
> @@ -647,9 +651,6 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>                 } else if (err) {
>                         ocr &= ~R4_18V_PRESENT;
>                 }
> -               err = 0;
> -       } else {
> -               ocr &= ~R4_18V_PRESENT;
>         }
>
>         /*
> @@ -706,11 +707,18 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>         }
>
>         /*
> -        * Read the common registers.
> +        * Read the common registers. Note that we should try to
> +        * validate whether ush would work or not.

ush? I guess "UHS" is what you want?

>          */
> +       retries = 1;



>         err = sdio_read_cccr(card, ocr);
> -       if (err)
> -               goto remove;
> +       if (err) {
> +               mmc_sdio_retry_init_card(host, card, &retries);
> +               if (ocr & R4_18V_PRESENT)
> +                       goto try_again;

Re-trying like this, would potentially cause us looping forever.

Do you really need to retry in this case? If so, there need to be a
limit for how many times.

> +               else
> +                       goto remove;
> +       }
>
>         /*
>          * Read the common CIS tuples.
> --
> 1.9.1
>

Kind regards
Uffe
