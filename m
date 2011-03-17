From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: fix suspend/resume operation
Date: Thu, 17 Mar 2011 14:22:46 -0400
Message-ID: <m362rhppxl.fsf@pullcord.laptop.org>
References: <4D81F151.3090300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46200 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968Ab1CQSZk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2011 14:25:40 -0400
In-Reply-To: <4D81F151.3090300@samsung.com> (Jaehoon Chung's message of "Thu,
	17 Mar 2011 20:32:33 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Thu, Mar 17 2011, Jaehoon Chung wrote:
> This patch is applied about re-init processing when suspend/resume.
>
> When card is resuming, some register is reset.
> If card is removable, maybe controller should be rescan for card.
> But if assume card is non-removable, need to restore the old value at registers.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |   22 ++++++++++++++++++++--
>  include/linux/mmc/dw_mmc.h |    1 +
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 299c1d6..892bfe3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1633,8 +1633,9 @@ static int dw_mci_probe(struct platform_device *pdev)
>  	 */
>  	fifo_size = mci_readl(host, FIFOTH);
>  	fifo_size = (fifo_size >> 16) & 0x7ff;
> -	mci_writel(host, FIFOTH, ((0x2 << 28) | ((fifo_size/2 - 1) << 16) |
> -				  ((fifo_size/2) << 0)));
> +	host->fifoth_val = ((0x2 << 28) | ((fifo_size/2 - 1) << 16) |
> +			((fifo_size/2) << 0));
> +	mci_writel(host, FIFOTH, host->fifoth_val);
>  
>  	/* disable clock to CIU */
>  	mci_writel(host, CLKENA, 0);
> @@ -1766,6 +1767,23 @@ static int dw_mci_resume(struct platform_device *pdev)
>  	int i, ret;
>  	struct dw_mci *host = platform_get_drvdata(pdev);
>  
> +	if (host->dma_ops->init)
> +		host->dma_ops->init(host);
> +
> +	if (!mci_wait_reset(&pdev->dev, host)) {
> +		ret = -ENODEV;
> +		return ret;
> +	}
> +
> +	/* Restore the old value at FIFOTH register */
> +	mci_writel(host, FIFOTH, host->fifoth_val);
> +
> +	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> +		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> +		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> +	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> +
>  	for (i = 0; i < host->num_slots; i++) {
>  		struct dw_mci_slot *slot = host->slot[i];
>  		if (!slot)
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 3f22c20..5b2b414 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -140,6 +140,7 @@ struct dw_mci {
>  	u32			bus_hz;
>  	u32			current_speed;
>  	u32			num_slots;
> +	u32			fifoth_val;
>  	struct platform_device	*pdev;
>  	struct dw_mci_board	*pdata;
>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
>

Thanks, will merge for .39 with Will's ACK.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
