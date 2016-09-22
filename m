From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/4] mmc: dw_mmc: fix misleading error print if failing
 to do DMA transfer
Date: Thu, 22 Sep 2016 13:26:45 +0900
Message-ID: <ffff9f80-1e81-2532-2b20-f857d867bdb0@samsung.com>
References: <1472789679-15121-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160902041953epcas1p2cba1b3343aa8c433159e4cad1074325c@epcas1p2.samsung.com>
 <1472789679-15121-3-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44068 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbcIVE0r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 00:26:47 -0400
In-reply-to: <1472789679-15121-3-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org

On 09/02/2016 01:14 PM, Shawn Lin wrote:
> The original log didn't figure out that we could still
> finish this transfer by PIO mode even if failing to use
> DMA. And it should be kept for debug level instead of
> error one.

Applied on my tree. Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index daa1c52..833b6ad 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1057,8 +1057,10 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>  	spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  
>  	if (host->dma_ops->start(host, sg_len)) {
> -		/* We can't do DMA */
> -		dev_err(host->dev, "%s: failed to start DMA.\n", __func__);
> +		/* We can't do DMA, try PIO for this one */
> +		dev_dbg(host->dev,
> +			"%s: fall back to PIO mode for current transfer\n",
> +			__func__);
>  		return -ENODEV;
>  	}
>  
> 

