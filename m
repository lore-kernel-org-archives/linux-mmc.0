From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
Date: Mon, 11 Jun 2018 14:20:03 +0200
Message-ID: <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Evgeniy Didin <Evgeniy.Didin@synopsys.com>, Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Qing Xia <xiaqing17@hisilicon.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+ Shawn Lin, Evgeniy Didin, Doug Andersson

On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
> From: x00270170 <xiaqing17@hisilicon.com>
>
> Card write threshold control is supposed to be set since controller
> version 2.80a for data write in HS400 mode and data read in
> HS200/HS400/SDR104 mode. However the current code returns without
> configuring it in the case of data writing in HS400 mode.
> Meanwhile the patch fixes that the current code goes to
> 'disable' when doing data reading in HS400 mode.
>
> Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>

This looks good to me. However, it seems like Jaehoon has been busy,
no response yet.

I have looped in a few more people to see if they thinks this makes sense.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 29a1afa..3ee8f57 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1065,8 +1065,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>          * It's used when HS400 mode is enabled.
>          */
>         if (data->flags & MMC_DATA_WRITE &&
> -               !(host->timing != MMC_TIMING_MMC_HS400))
> -               return;
> +               host->timing != MMC_TIMING_MMC_HS400)
> +               goto disable;
>
>         if (data->flags & MMC_DATA_WRITE)
>                 enable = SDMMC_CARD_WR_THR_EN;
> @@ -1074,7 +1074,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>                 enable = SDMMC_CARD_RD_THR_EN;
>
>         if (host->timing != MMC_TIMING_MMC_HS200 &&
> -           host->timing != MMC_TIMING_UHS_SDR104)
> +           host->timing != MMC_TIMING_UHS_SDR104 &&
> +           host->timing != MMC_TIMING_MMC_HS400)
>                 goto disable;
>
>         blksz_depth = blksz / (1 << host->data_shift);
> --
> 2.8.1
>
