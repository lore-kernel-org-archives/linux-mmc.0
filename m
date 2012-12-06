From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/3] mmc: sdio: fix resume failure
Date: Thu, 6 Dec 2012 11:33:24 +0100
Message-ID: <CAPDyKFowKZcUXr-4Qug_Awww6wPGXsAm-gMaKs7oOrTwN9RFVw@mail.gmail.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
	<1354620980-23764-2-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1354620980-23764-2-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 4 December 2012 12:36, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> If SDIO keep power flag (MMC_PM_KEEP_POWER) is not set, card would
> be reinitialized during resume but as we are not resetting
> (CMD52 reset) the SDIO card during this reinitialization, card may
> fail to respond back to subsequent commands (CMD5 etc...).
>
> This change resets the card before the reinitialization of card
> during resume.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
>  drivers/mmc/core/sdio.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 2273ce6..34ad4c8 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -937,10 +937,12 @@ static int mmc_sdio_resume(struct mmc_host *host)
>         mmc_claim_host(host);
>
>         /* No need to reinitialize powered-resumed nonremovable cards */
> -       if (mmc_card_is_removable(host) || !mmc_card_keep_power(host))
> +       if (mmc_card_is_removable(host) || !mmc_card_keep_power(host)) {
> +               sdio_reset(host);
> +               mmc_go_idle(host);

If the card has lost power, why is this needed? Could it be that the
host is not capable of cutting the power to card?

It might be more safe to do this but I would like to understand more,
before you get my ack on this patch.

>                 err = mmc_sdio_init_card(host, host->ocr, host->card,
>                                         mmc_card_keep_power(host));
> -       else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
> +       } else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
>                 /* We may have switched to 1-bit mode during suspend */
>                 err = sdio_enable_4bit_bus(host->card);
>                 if (err > 0) {
> --
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
