From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add missing codes for runtime resume
Date: Fri, 25 Nov 2016 11:37:24 +0900
Message-ID: <994098ad-ae2c-7e35-8300-d4937cd77881@samsung.com>
References: <CGME20161123093310epcas5p2dddadfc26d93d80161d16ee4c1509f35@epcas5p2.samsung.com>
 <1479893632-1742-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59982 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbcKYCh0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 21:37:26 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH6013GIFACGN50@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Nov 2016 11:37:24 +0900 (KST)
In-reply-to: <1479893632-1742-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

Hi Joonyoung,

On 11/23/2016 06:33 PM, Joonyoung Shim wrote:
> The commit 64997de4fd17 ("mmc: dw_mmc: remove system PM callback") is
> missing to call dw_mci_ctrl_reset(). This adds to call
> dw_mci_ctrl_reset() and to handle error of clocks.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

Applied on my dwmmc repository. Thanks!

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d426fa41bcce..25e21a20ee04 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3303,6 +3303,17 @@ int dw_mci_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
> +		clk_disable_unprepare(host->ciu_clk);
> +
> +		if (host->cur_slot &&
> +		    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
> +		     !mmc_card_is_removable(host->cur_slot->mmc)))
> +			clk_disable_unprepare(host->biu_clk);
> +
> +		return -ENODEV;
> +	}
> +
>  	if (host->use_dma && host->dma_ops->init)
>  		host->dma_ops->init(host);
>  
> 

