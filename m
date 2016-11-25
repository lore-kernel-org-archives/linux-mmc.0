From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: add missing codes for runtime resume
Date: Fri, 25 Nov 2016 12:49:54 +0900
Message-ID: <96aa5cfb-02c1-4639-7a71-b97d126ac027@samsung.com>
References: <CGME20161125034631epcas1p31fe5114a49893a671bbcaaa300d53e6f@epcas1p3.samsung.com>
 <1480045635-32042-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55254 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbcKYDt4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 22:49:56 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH601FF7IN6C080@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Nov 2016 12:49:54 +0900 (KST)
In-reply-to: <1480045635-32042-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

On 11/25/2016 12:47 PM, Joonyoung Shim wrote:
> The commit 64997de4fd17 ("mmc: dw_mmc: remove system PM callback") is
> missing to call dw_mci_ctrl_reset(). This adds to call
> dw_mci_ctrl_reset() and to handle error of clocks.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

Applied on my repository, instead of v1. Thanks for noticing.
If someone find the issue, let me know before PR to Ulf. 

Best Regards,
Jaehoon Chung

> ---
> v2: fix error handling of biu_clk.
> 
>  drivers/mmc/host/dw_mmc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d426fa41bcce..5b50b2cdb008 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3301,7 +3301,13 @@ int dw_mci_runtime_resume(struct device *dev)
>  
>  	ret = clk_prepare_enable(host->ciu_clk);
>  	if (ret)
> -		return ret;
> +		goto err;
> +
> +	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
> +		clk_disable_unprepare(host->ciu_clk);
> +		ret = -ENODEV;
> +		goto err;
> +	}
>  
>  	if (host->use_dma && host->dma_ops->init)
>  		host->dma_ops->init(host);
> @@ -3336,6 +3342,14 @@ int dw_mci_runtime_resume(struct device *dev)
>  	/* Now that slots are all setup, we can enable card detect */
>  	dw_mci_enable_cd(host);
>  
> +	return 0;
> +
> +err:
> +	if (host->cur_slot &&
> +	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
> +	     !mmc_card_is_removable(host->cur_slot->mmc)))
> +		clk_disable_unprepare(host->biu_clk);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(dw_mci_runtime_resume);
> 

