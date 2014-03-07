From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 6/7] mmc: dw_mmc: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Fri, 07 Mar 2014 22:43:09 +0900
Message-ID: <5319CCED.3080309@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006501cf2a57$881b0ff0$98512fd0$%jun@samsung.com>
 <002e01cf3a09$832d3b50$8987b1f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25938 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbaCGNnK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Mar 2014 08:43:10 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2200DL1JFYN710@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Mar 2014 22:43:10 +0900 (KST)
In-reply-to: <002e01cf3a09$832d3b50$8987b1f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 03/07/2014 10:31 PM, Seungwon Jeon wrote:
> Replaced UHS_DDR50 with MMC_DDR52. And MMC_CAP_UHS_DDR50
> is removed because of non-implementation of UHS signaling.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    5 ++---
>  drivers/mmc/host/dw_mmc.c        |    2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 3423c5e..a67e784 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -187,7 +187,7 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  	unsigned long actual;
>  	u8 div = priv->ciu_div + 1;
>  
> -	if (ios->timing == MMC_TIMING_UHS_DDR50) {
> +	if (ios->timing == MMC_TIMING_MMC_DDR52) {
>  		mci_writel(host, CLKSEL, priv->ddr_timing);
>  		/* Should be double rate for DDR mode */
>  		if (ios->bus_width == MMC_BUS_WIDTH_8)
> @@ -386,8 +386,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
>  
>  /* Common capabilities of Exynos4/Exynos5 SoC */
>  static unsigned long exynos_dwmmc_caps[4] = {
> -	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
> -		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
> +	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
>  	MMC_CAP_CMD23,
>  	MMC_CAP_CMD23,
>  	MMC_CAP_CMD23,
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0c56faa..ab704d9 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -962,7 +962,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	regs = mci_readl(slot->host, UHS_REG);
>  
>  	/* DDR mode set */
> -	if (ios->timing == MMC_TIMING_UHS_DDR50)
> +	if (ios->timing == MMC_TIMING_MMC_DDR52)
>  		regs |= ((0x1 << slot->id) << 16);
>  	else
>  		regs &= ~((0x1 << slot->id) << 16);
> 

