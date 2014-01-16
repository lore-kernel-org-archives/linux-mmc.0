From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] mmc: rtsx: clarify DDR timing mode between SD-UHS and eMMC
Date: Thu, 16 Jan 2014 11:51:33 +0100
Message-ID: <CAPDyKFoGkf+zcdsJc+9gY5AHhypax7PMuWBNQGY44BCW+W7Gxg@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<002301cf11fb$cad390c0$607ab240$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:54448 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbaAPKve (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 05:51:34 -0500
Received: by mail-qa0-f41.google.com with SMTP id w8so1967578qac.28
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 02:51:33 -0800 (PST)
In-Reply-To: <002301cf11fb$cad390c0$607ab240$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <chris@printf.net>, Wei WANG <wei_wang@realsil.com.cn>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 January 2014 15:12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Added MMC_DDR52 as eMMC's DDR mode distinguished from SD-UHS.
>
> CC: Wei WANG <wei_wang@realsil.com.cn>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index c46feda..752f003 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -864,6 +864,7 @@ static int sd_set_timing(struct realtek_pci_sdmmc *host, unsigned char timing)
>                 rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_CTL, CLK_LOW_FREQ, 0);
>                 break;
>
> +       case MMC_TIMING_MMC_DDR52:
>         case MMC_TIMING_UHS_DDR50:
>                 rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG1,
>                                 0x0C | SD_ASYNC_FIFO_NOT_RST,
> @@ -944,6 +945,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 host->vpclk = true;
>                 host->double_clk = false;
>                 break;
> +       case MMC_TIMING_MMC_DDR52:
>         case MMC_TIMING_UHS_DDR50:
>         case MMC_TIMING_UHS_SDR25:
>                 host->ssc_depth = RTSX_SSC_DEPTH_1M;
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
