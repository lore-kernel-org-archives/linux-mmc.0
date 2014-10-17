From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Reset DMA before enabling IDMAC
Date: Fri, 17 Oct 2014 17:26:39 +0900
Message-ID: <5440D2BF.8070702@samsung.com>
References: <1413478686-6857-1-git-send-email-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23143 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbaJQI0m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Oct 2014 04:26:42 -0400
In-reply-to: <1413478686-6857-1-git-send-email-sonnyrao@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sonny Rao <sonnyrao@chromium.org>, Alim Akhtar <alim.akhtar@gmail.com>, linux-mmc@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, dianders@chromium.org, eddie.cai@rock-chips.com, addy.ke@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi, Sonny.

On 10/17/2014 01:58 AM, Sonny Rao wrote:
> We've already got a reset of DMA after it's done.  Add one before we
> start DMA too.  This fixes a data corruption on Rockchip SoCs which
> will get bad data when doing a DMA transfer after doing a PIO transfer.
> 
> We tested this on an Exynos 5800 with HS200 and didn't notice any
> difference in sequential read throughput.

Didn't affect the write throughput?
I tested this on exynos3/4 with DDR50 and HS200.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 69f0cc6..ca67f69 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -83,6 +83,7 @@ struct idmac_desc {
>  #endif /* CONFIG_MMC_DW_IDMAC */
>  
>  static bool dw_mci_reset(struct dw_mci *host);
> +static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>  
>  #if defined(CONFIG_DEBUG_FS)
>  static int dw_mci_req_show(struct seq_file *s, void *v)
> @@ -448,6 +449,10 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>  
>  	dw_mci_translate_sglist(host, host->data, sg_len);
>  
> +	/* Make sure to reset DMA in case we did PIO before this */
> +	dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET);
> +	dw_mci_idmac_reset(host);
> +
>  	/* Select IDMAC interface */
>  	temp = mci_readl(host, CTRL);
>  	temp |= SDMMC_CTRL_USE_IDMAC;
> 

