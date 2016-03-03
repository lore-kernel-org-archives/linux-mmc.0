From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mci_parse_dt()
Date: Thu, 3 Mar 2016 10:00:20 +0800
Message-ID: <56D79AB4.7050809@rock-chips.com>
References: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org>
 <1456968818-22140-2-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:41403 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbcCCCAn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2016 21:00:43 -0500
In-Reply-To: <1456968818-22140-2-git-send-email-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jh80.chung@samsung.com, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>

Hi Guodong,

On 2016/3/3 9:33, Guodong Xu wrote:
> With this, user can add a 'resets' property into dw_mmc dts
> node, and when driver probe and parse_dt, it will call
> reset APIs to reset dw_mmc host controller.
>
> Please also refer to Documentation/devicetree/bindings/reset/reset.txt

I have no hard objection for this patch, but I'd rather not add it
unless we actually need it. Could you elaborate more about any futher
actions you will take if it's applied(i.e: deal with some unrecoverable
broken case)?  If we just reset the controller while probing, actually I
can't find any problems without it based on tons of my reboot test.


>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   drivers/mmc/host/dw_mmc.c  | 7 +++++++
>   include/linux/mmc/dw_mmc.h | 6 ++++--
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 242f9a0..d3a7376 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2878,6 +2878,13 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>   	if (!pdata)
>   		return ERR_PTR(-ENOMEM);
>
> +	/* find reset controller when exist */
> +	pdata->rstc = devm_reset_control_get_optional(dev, NULL);
> +	if (IS_ERR(pdata->rstc))
> +		pdata->rstc = NULL;
> +	else
> +		reset_control_deassert(pdata->rstc);
> +

if the PTR_ERR(pdata->rstc) is -EPROBE_DEFER, should we defer probing
the driver?

>   	/* find out number of slots supported */
>   	of_property_read_u32(np, "num-slots", &pdata->num_slots);
>
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 7b41c6d..b95cd84 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -14,9 +14,10 @@
>   #ifndef LINUX_MMC_DW_MMC_H
>   #define LINUX_MMC_DW_MMC_H
>
> -#include <linux/scatterlist.h>
> -#include <linux/mmc/core.h>
>   #include <linux/dmaengine.h>
> +#include <linux/mmc/core.h>
> +#include <linux/reset.h>
> +#include <linux/scatterlist.h>
>
>   #define MAX_MCI_SLOTS	2
>
> @@ -260,6 +261,7 @@ struct dw_mci_board {
>   	/* delay in mS before detecting cards after interrupt */
>   	u32 detect_delay_ms;
>
> +	struct reset_control *rstc;
>   	struct dw_mci_dma_ops *dma_ops;
>   	struct dma_pdata *data;
>   };
>


-- 
Best Regards
Shawn Lin

