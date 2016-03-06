From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Sun, 6 Mar 2016 22:16:13 +0800
Message-ID: <56DC3BAD.8020107@rock-chips.com>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
 <1457254062-22677-2-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:35690 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcCFOQx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2016 09:16:53 -0500
In-Reply-To: <1457254062-22677-2-git-send-email-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jh80.chung@samsung.com, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>

On 2016/3/6 16:47, Guodong Xu wrote:
> mmc registers may in abnormal state if mmc is used in bootloader,
> eg. to support booting from eMMC. So we need reset mmc registers
> when kernel boots up, instead of assuming mmc is in clean state.
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

Really should V2 and add the changelog.

> ---
>   drivers/mmc/host/dw_mmc.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 242f9a0..281ea9c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2878,6 +2878,14 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>   	if (!pdata)
>   		return ERR_PTR(-ENOMEM);
>
> +	/* find reset controller when exist */
> +	pdata->rstc = devm_reset_control_get_optional(dev, NULL);
> +	if (IS_ERR(pdata->rstc)) {
> +		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
> +			return ERR_PTR(-EPROBE_DEFER);
> +		pdata->rstc = NULL;

maybe we can remove "pdata->rstc = NULL", and directly
use IS_ERR(..) for the following "if (host->pdata->rstc != NULL)"
statement


> +	}
> +
>   	/* find out number of slots supported */
>   	of_property_read_u32(np, "num-slots", &pdata->num_slots);
>
> @@ -2949,7 +2957,9 @@ int dw_mci_probe(struct dw_mci *host)
>
>   	if (!host->pdata) {
>   		host->pdata = dw_mci_parse_dt(host);
> -		if (IS_ERR(host->pdata)) {
> +		if (PTR_ERR(host->pdata) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

please fix the coding style here.

> +		else if (IS_ERR(host->pdata)) {
>   			dev_err(host->dev, "platform data not available\n");
>   			return -EINVAL;
>   		}
> @@ -3012,6 +3022,9 @@ int dw_mci_probe(struct dw_mci *host)
>   		}
>   	}
>
> +	if (host->pdata->rstc != NULL)
> +		reset_control_deassert(host->pdata->rstc);
> +

sorry, I can't follow your intention here. Shouldn't it be something
like "assert mmc -> may need delay -> deassert mmc". As your current
code, nothing happend right?

>   	setup_timer(&host->cmd11_timer,
>   		    dw_mci_cmd11_timer, (unsigned long)host);
>
> @@ -3164,6 +3177,9 @@ err_dmaunmap:
>   	if (host->use_dma && host->dma_ops->exit)
>   		host->dma_ops->exit(host);
>
> +	if (host->pdata->rstc != NULL)
> +		reset_control_assert(host->pdata->rstc);
> +
>   err_clk_ciu:
>   	if (!IS_ERR(host->ciu_clk))
>   		clk_disable_unprepare(host->ciu_clk);
> @@ -3196,11 +3212,15 @@ void dw_mci_remove(struct dw_mci *host)
>   	if (host->use_dma && host->dma_ops->exit)
>   		host->dma_ops->exit(host);
>
> +	if (host->pdata->rstc != NULL)
> +		reset_control_assert(host->pdata->rstc);
> +
>   	if (!IS_ERR(host->ciu_clk))
>   		clk_disable_unprepare(host->ciu_clk);
>
>   	if (!IS_ERR(host->biu_clk))
>   		clk_disable_unprepare(host->biu_clk);
> +
>   }

unnecessary new line here.

>   EXPORT_SYMBOL(dw_mci_remove);
>
>


-- 
Best Regards
Shawn Lin

