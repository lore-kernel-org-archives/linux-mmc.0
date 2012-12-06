From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 3/3] mmc: sdio: print correct UHS mode during card detection
Date: Thu, 6 Dec 2012 11:41:59 +0100
Message-ID: <CAPDyKFqAkL+N3Zz2Lo7hj92QZoVJVn+UhbCSpqZLtSVG-eN3=Q@mail.gmail.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
	<1354620980-23764-4-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:61787 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab2LFKmB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 05:42:01 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so384002wib.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Dec 2012 02:42:00 -0800 (PST)
In-Reply-To: <1354620980-23764-4-git-send-email-subhashj@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 4 December 2012 12:36, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> When SDIO3.0 card is detected, incorrect bus speed mode
> is printed as part of card detection print in kernel logs.
>
> This change fixes it so that user won't be confused by
> looking at incorrect card detection message in logs.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
>  drivers/mmc/core/sdio.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 9565d38..3a64933 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -485,23 +485,27 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
>                         bus_speed = SDIO_SPEED_SDR104;
>                         timing = MMC_TIMING_UHS_SDR104;
>                         card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
> +                       card->sd_bus_speed = UHS_SDR104_BUS_SPEED;
>         } else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
>                    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50)) {
>                         bus_speed = SDIO_SPEED_DDR50;
>                         timing = MMC_TIMING_UHS_DDR50;
>                         card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> +                       card->sd_bus_speed = UHS_DDR50_BUS_SPEED;
>         } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>                     MMC_CAP_UHS_SDR50)) && (card->sw_caps.sd3_bus_mode &
>                     SD_MODE_UHS_SDR50)) {
>                         bus_speed = SDIO_SPEED_SDR50;
>                         timing = MMC_TIMING_UHS_SDR50;
>                         card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
> +                       card->sd_bus_speed = UHS_SDR50_BUS_SPEED;
>         } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>                     MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
>                    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
>                         bus_speed = SDIO_SPEED_SDR25;
>                         timing = MMC_TIMING_UHS_SDR25;
>                         card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> +                       card->sd_bus_speed = UHS_SDR25_BUS_SPEED;
>         } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>                     MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
>                     MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode &
> @@ -509,6 +513,7 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
>                         bus_speed = SDIO_SPEED_SDR12;
>                         timing = MMC_TIMING_UHS_SDR12;
>                         card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
> +                       card->sd_bus_speed = UHS_SDR12_BUS_SPEED;
>         }
>
>         err = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_SPEED, 0, &speed);
> --
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
