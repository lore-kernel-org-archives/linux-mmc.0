From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Wed, 30 Mar 2016 20:40:31 +0900
Message-ID: <56FBBB2F.5030308@samsung.com>
References: <1459322696-29919-1-git-send-email-guodong.xu@linaro.org>
 <1459322696-29919-3-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51372 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbcC3Lkf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2016 07:40:35 -0400
In-reply-to: <1459322696-29919-3-git-send-email-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, shawn.lin@rock-chips.com, "robh+dt@kernel.org" <robh+dt@kernel.org>, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

modified Rob's mail address.

On 03/30/2016 04:24 PM, Guodong Xu wrote:
> mmc registers may in abnormal state if mmc is used in bootloader,
> eg. to support booting from eMMC. So we need reset mmc registers
> when kernel boots up, instead of assuming mmc is in clean state.

Do you mean mmc(card side) register or dwmmc host controller's register on host side?

According to dwmmc controller TMR, there are two reset signals. One is reset_n, other is rst_n.
It seems this patch is relevant to reset_n(For host). (rst_n is hardware reset for card.)

So could you clarify better? Then it's helpful to me for understanding..

It seems that it means "mmc" is card, mmc registers is host controller register, right?

> 
> With this patch, user can add a 'resets' property into dw_mmc dts
> node. When driver parse_dt and probe, it calls reset API to
> deassert the 'reset' of dw_mmc host controller. When probe error or
> remove, it calls reset API to assert it.
> 
> Please also refer to Documentation/devicetree/bindings/reset/reset.txt
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c  | 20 +++++++++++++++++++-
>  include/linux/mmc/dw_mmc.h |  6 ++++--
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 242f9a0..d0a4535 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2878,6 +2878,13 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	if (!pdata)
>  		return ERR_PTR(-ENOMEM);
>  
> +	/* find reset controller when exist */
> +	pdata->rstc = devm_reset_control_get_optional(dev, NULL);
> +	if (IS_ERR(pdata->rstc)) {
> +		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
>  	/* find out number of slots supported */
>  	of_property_read_u32(np, "num-slots", &pdata->num_slots);
>  
> @@ -2949,7 +2956,9 @@ int dw_mci_probe(struct dw_mci *host)
>  
>  	if (!host->pdata) {
>  		host->pdata = dw_mci_parse_dt(host);
> -		if (IS_ERR(host->pdata)) {
> +		if (PTR_ERR(host->pdata) == -EPROBE_DEFER) {
> +			return -EPROBE_DEFER;
> +		} else if (IS_ERR(host->pdata)) {
>  			dev_err(host->dev, "platform data not available\n");
>  			return -EINVAL;
>  		}
> @@ -3012,6 +3021,9 @@ int dw_mci_probe(struct dw_mci *host)
>  		}
>  	}
>  
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_deassert(host->pdata->rstc);
> +
>  	setup_timer(&host->cmd11_timer,
>  		    dw_mci_cmd11_timer, (unsigned long)host);
>  
> @@ -3164,6 +3176,9 @@ err_dmaunmap:
>  	if (host->use_dma && host->dma_ops->exit)
>  		host->dma_ops->exit(host);
>  
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);

location is correct?

> +
>  err_clk_ciu:
>  	if (!IS_ERR(host->ciu_clk))
>  		clk_disable_unprepare(host->ciu_clk);
> @@ -3196,6 +3211,9 @@ void dw_mci_remove(struct dw_mci *host)
>  	if (host->use_dma && host->dma_ops->exit)
>  		host->dma_ops->exit(host);
>  
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);
> +
>  	if (!IS_ERR(host->ciu_clk))
>  		clk_disable_unprepare(host->ciu_clk);
>  
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 7b41c6d..b95cd84 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -14,9 +14,10 @@
>  #ifndef LINUX_MMC_DW_MMC_H
>  #define LINUX_MMC_DW_MMC_H
>  
> -#include <linux/scatterlist.h>
> -#include <linux/mmc/core.h>
>  #include <linux/dmaengine.h>
> +#include <linux/mmc/core.h>
> +#include <linux/reset.h>
> +#include <linux/scatterlist.h>

Why did you touch other things?

>  
>  #define MAX_MCI_SLOTS	2
>  
> @@ -260,6 +261,7 @@ struct dw_mci_board {
>  	/* delay in mS before detecting cards after interrupt */
>  	u32 detect_delay_ms;
>  
> +	struct reset_control *rstc;
>  	struct dw_mci_dma_ops *dma_ops;
>  	struct dma_pdata *data;
>  };
> 

