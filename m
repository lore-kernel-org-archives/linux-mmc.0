From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v2] mmc: sdhci: also set driver type for MMC_DDR52
Date: Mon, 17 Aug 2015 19:49:54 +0800
Message-ID: <20150817194954.691729d7@xhacker>
References: <1439812041-6596-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:65436 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755314AbbHQLxd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 07:53:33 -0400
In-Reply-To: <1439812041-6596-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 17 Aug 2015 19:47:21 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> commit bb8175a8aa42 ("mmc: sdhci: clarify DDR timing mode between
> SD-UHS and eMMC") added MMC_DDR52 as eMMC's DDR mode to be
> distinguished from SD-UHS, but it missed setting driver type for
> MMC_DDR52 timing mode. This patches adds the missing driver type
> setting.

This patch fixes unstable emmc read/write on marvell BG2Q DMP board.

> 
> Fixes: bb8175a8aa42 ("mmc: sdhci: clarify DDR timing mode ...")
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1dbe932..32f2a07 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1559,7 +1559,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
>  				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
>  				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
> -				 (ios->timing == MMC_TIMING_UHS_DDR50))) {
> +				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
> +				 (ios->timing == MMC_TIMING_MMC_DDR52))) {

I'm not sure whether MMC_HS400 need such fix or not.

>  			u16 preset;
>  
>  			sdhci_enable_preset_value(host, true);

