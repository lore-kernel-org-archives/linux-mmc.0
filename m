From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add missing codes for runtime resume
Date: Fri, 25 Nov 2016 11:37:22 +0900
Message-ID: <4478096a-4d57-f739-d746-17c506548981@samsung.com>
References: <CGME20161123094435epcas1p358457576f3e08aa57b19012efc8c7ad1@epcas1p3.samsung.com>
 <1479893632-1742-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38461 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbcKYCh2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 21:37:28 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH601K6XFAAKA60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Nov 2016 11:37:22 +0900 (KST)
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

