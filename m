From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix card read threshold for PIO mode
Date: Fri, 21 Nov 2014 19:30:50 +0900
Message-ID: <546F145A.9050900@samsung.com>
References: <1416551950-8277-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25495 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbaKUKaw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 05:30:52 -0500
In-reply-to: <1416551950-8277-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org

Hi, Shawn.

On 11/21/2014 03:39 PM, Shawn Guo wrote:
> Commit f1d2736c8156 ("mmc: dw_mmc: control card read threshold")
> introduces a regression for use case where PIO mode is used, i.e.
> CONFIG_MMC_DW_IDMAC is not disabled.  It stops kernel from booting
> like below.
> 
> dw_mmc 9408000.dwmmc: fifo-depth property not found, using value of FIFOTH register as default
> dw_mmc 9408000.dwmmc: Using PIO mode.
> dw_mmc 9408000.dwmmc: Version ID is 210a
> dw_mmc 9408000.dwmmc: DW MMC controller at irq 72, 32 bit host data width, 32 deep fifo
> dw_mmc 9408000.dwmmc: 1 slots initialized
> ...
> Waiting for root device /dev/mmcblk0p2...
> mmc_host mmc0: Bus speed (slot 0) = 52000000Hz (slot req 50000000Hz, actual 26000000HZ div = 1)
> mmc0: new high speed SDHC card at address b368
> mmcblk0: mmc0:b368 AF UD 3.84 GiB

Stopping at here? I didn't know what's difference before applied your patch.
Clearing Card-read threshold value at every time would be caused that stop kernel?
Just wonder it.

> 
> Rather than clearing read threshold bits, the best thing that function
> dw_mci_ctrl_rd_thld() should do is leaving the bits untouched, in case
> that card read threshold setup is not needed.
> 
> The patch fixes the regression by changing dw_mci_ctrl_rd_thld() a bit
> to do nothing in case card read threshold bits setup is not needed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Fixes: f1d2736c8156 ("mmc: dw_mmc: control card read threshold")
> Cc: <stable@vger.kernel.org> # 3.13+
> ---
>  drivers/mmc/host/dw_mmc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 69f0cc68d5b2..52c04ba69970 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -628,13 +628,13 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>  
>  	if (host->timing != MMC_TIMING_MMC_HS200 &&
>  	    host->timing != MMC_TIMING_UHS_SDR104)
> -		goto disable;
> +		return;
>  
>  	blksz_depth = blksz / (1 << host->data_shift);
>  	fifo_depth = host->fifo_depth;
>  
>  	if (blksz_depth > fifo_depth)
> -		goto disable;
> +		return;
>  
>  	/*
>  	 * If (blksz_depth) >= (fifo_depth >> 1), should be 'thld_size <= blksz'
> @@ -644,9 +644,6 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>  	thld_size = blksz;
>  	mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(thld_size, 1));
>  	return;

Then "return" could be also removed.

Best Regards,
Jaehoon Chung

> -
> -disable:
> -	mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(0, 0));
>  }
>  
>  static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
> 

