From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix err handle of dw_mci_probe
Date: Mon, 25 Jan 2016 13:58:32 +0900
Message-ID: <56A5AB78.5020706@samsung.com>
References: <1453448592-9897-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1453448592-9897-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi, Shawn.

On 01/22/2016 04:43 PM, Shawn Lin wrote:
> This patch add correct err handle if dw_mci_ctrl_reset
> failed while probing.

Thanks! I will applied this.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 065a8f5..ec19984 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3046,8 +3046,10 @@ int dw_mci_probe(struct dw_mci *host)
>  	}
>  
>  	/* Reset all blocks */
> -	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS))
> -		return -ENODEV;
> +	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
> +		ret = -ENODEV;
> +		goto err_clk_ciu;
> +	}
>  
>  	host->dma_ops = host->pdata->dma_ops;
>  	dw_mci_init_dma(host);
> 
