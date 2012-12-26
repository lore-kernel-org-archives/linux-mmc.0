From: "Shen, Jackey" <Jackey.Shen@amd.com>
Subject: RE: [PATCH v1 3/3] mmc: sdio: print correct UHS mode during card
 detection
Date: Wed, 26 Dec 2012 04:59:05 +0000
Message-ID: <0C8FBB70FF40A94D98BE847F9C171A9803416BB9@SCYBEXDAG04.amd.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
	<1354620980-23764-4-git-send-email-subhashj@codeaurora.org>
 <CAPDyKFqAkL+N3Zz2Lo7hj92QZoVJVn+UhbCSpqZLtSVG-eN3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:9019 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753100Ab2LZE7O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Dec 2012 23:59:14 -0500
In-Reply-To: <CAPDyKFqAkL+N3Zz2Lo7hj92QZoVJVn+UhbCSpqZLtSVG-eN3=Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

Hi,

Tested-by: Jackey Shen <Jackey.Shen@amd.com>

Thanks,
Jackey

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Ulf Hansson
Sent: Thursday, December 06, 2012 6:42 PM
To: Subhash Jadavani
Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] mmc: sdio: print correct UHS mode during card detection

On 4 December 2012 12:36, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> When SDIO3.0 card is detected, incorrect bus speed mode is printed as 
> part of card detection print in kernel logs.
>
> This change fixes it so that user won't be confused by looking at 
> incorrect card detection message in logs.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
>  drivers/mmc/core/sdio.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c index 
> 9565d38..3a64933 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -485,23 +485,27 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
>                         bus_speed = SDIO_SPEED_SDR104;
>                         timing = MMC_TIMING_UHS_SDR104;
>                         card->sw_caps.uhs_max_dtr = 
> UHS_SDR104_MAX_DTR;
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
>                     MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode 
> & @@ -509,6 +513,7 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
>                         bus_speed = SDIO_SPEED_SDR12;
>                         timing = MMC_TIMING_UHS_SDR12;
>                         card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
> +                       card->sd_bus_speed = UHS_SDR12_BUS_SPEED;
>         }
>
>         err = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_SPEED, 0, 
> &speed);
> --
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
> member of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


