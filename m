From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7] mmc: clarify DDR timing mode between SD-UHS and eMMC
Date: Thu, 16 Jan 2014 11:50:42 +0100
Message-ID: <CAPDyKFpzxoMJYhWWsnnJdHRbHd3+efTyz5PMtoqDtBa2O3pkeg@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<001f01cf11fb$93d188c0$bb749a40$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:57485 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbaAPKuo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 05:50:44 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so2150057qcx.30
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 02:50:43 -0800 (PST)
In-Reply-To: <001f01cf11fb$93d188c0$bb749a40$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 January 2014 15:10, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This change distinguishes DDR timing mode of current
> mixed usage to clarify device type.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/debugfs.c |    3 +++
>  drivers/mmc/core/mmc.c     |    2 +-
>  include/linux/mmc/host.h   |    3 ++-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 54829c0..509229b 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>         case MMC_TIMING_UHS_DDR50:
>                 str = "sd uhs DDR50";
>                 break;
> +       case MMC_TIMING_MMC_DDR52:
> +               str = "mmc DDR52";
> +               break;
>         case MMC_TIMING_MMC_HS200:
>                 str = "mmc high-speed SDR200";
>                 break;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 98e9eb0..6d91ff7 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1261,7 +1261,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                                         goto err;
>                         }
>                         mmc_card_set_ddr_mode(card);
> -                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
> +                       mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>                         mmc_set_bus_width(card->host, bus_width);
>                 }
>         }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 99f5709..87b1f4f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -58,7 +58,8 @@ struct mmc_ios {
>  #define MMC_TIMING_UHS_SDR50   5
>  #define MMC_TIMING_UHS_SDR104  6
>  #define MMC_TIMING_UHS_DDR50   7
> -#define MMC_TIMING_MMC_HS200   8
> +#define MMC_TIMING_MMC_DDR52   8
> +#define MMC_TIMING_MMC_HS200   9
>
>  #define MMC_SDR_MODE           0
>  #define MMC_1_2V_DDR_MODE      1
> --
> 1.7.0.4
>
>
