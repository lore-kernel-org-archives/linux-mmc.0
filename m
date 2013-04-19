From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Only execute tuning for SDR50 and SDR104
Date: Fri, 19 Apr 2013 12:16:37 +0200
Message-ID: <CAPDyKFp7N7FYUbHHcH_O6P-p5Ajd7ME+WZ4TCGqbGKKU=hpdEA@mail.gmail.com>
References: <1366199453-6135-1-git-send-email-fredrik.soderstedt@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:36496 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664Ab3DSKQi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Apr 2013 06:16:38 -0400
Received: by mail-vb0-f49.google.com with SMTP id 11so3402336vbf.8
        for <linux-mmc@vger.kernel.org>; Fri, 19 Apr 2013 03:16:37 -0700 (PDT)
In-Reply-To: <1366199453-6135-1-git-send-email-fredrik.soderstedt@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On 17 April 2013 13:50, Fredrik Soderstedt
<fredrik.soderstedt@stericsson.com> wrote:
> Only execute tuning for sd and sdio devices that are using
> SDR50 or SDR104.
>
> Make sure clock is hold during tuning for sdio devices.
>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
> ---
>  drivers/mmc/core/sd.c   |  9 +++++++--
>  drivers/mmc/core/sdio.c | 12 ++++++++++--
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 9e645e1..8373d22 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -646,8 +646,13 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>         if (err)
>                 goto out;
>
> -       /* SPI mode doesn't define CMD19 */
> -       if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning) {
> +       /*
> +        * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
> +        * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
> +        */
> +       if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
> +                       (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
> +                        card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
>                 mmc_host_clk_hold(card->host);
>                 err = card->host->ops->execute_tuning(card->host,
>                                                       MMC_SEND_TUNING_BLOCK);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 6889a82..444668c 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -563,10 +563,18 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
>         if (err)
>                 goto out;
>
> -       /* Initialize and start re-tuning timer */
> -       if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning)
> +       /*
> +        * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
> +        * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
> +        */
> +       if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
> +                       ((card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50) ||
> +                        (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104))) {
> +               mmc_host_clk_hold(card->host);
>                 err = card->host->ops->execute_tuning(card->host,
>                                                       MMC_SEND_TUNING_BLOCK);
> +               mmc_host_clk_release(card->host);
> +       }
>
>  out:
>
> --
> 1.8.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
