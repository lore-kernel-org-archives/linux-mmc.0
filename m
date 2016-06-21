From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 3/3] mmc: dw_mmc: prevent to set the wrong value
Date: Tue, 21 Jun 2016 16:13:27 +0800
Message-ID: <ab1a9cae-b841-4ec2-8382-7f355b352382@rock-chips.com>
References: <1466487339-13211-1-git-send-email-jh80.chung@samsung.com>
 <1466487339-13211-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:44172 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcFUI0Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 04:26:25 -0400
In-Reply-To: <1466487339-13211-3-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

On 2016/6/21 13:35, Jaehoon Chung wrote:
> If there ins no vqmmc, voltage should not be changed.
> Then it nees to maintain the previous status for USH_REG register.
> To use the standard spec, it should be returned error when voltage
> can't switch.
>
> Note:
> Dwmmc controller will not make any exception case.(like exynos.)
> If card isn't working well after appling this patch, it needs to check
> the regulator side.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog V2:
> 	-Fix the typo
>
>  drivers/mmc/host/dw_mmc.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ec3f0a8..56c48fb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1404,33 +1404,37 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	struct dw_mci *host = slot->host;
>  	const struct dw_mci_drv_data *drv_data = host->drv_data;
> -	u32 uhs;
> +	u32 uhs = 0;
>  	u32 v18 = SDMMC_UHS_18V << slot->id;
>  	int ret;
>
>  	if (drv_data && drv_data->switch_voltage)
>  		return drv_data->switch_voltage(mmc, ios);
>
> -	/*
> -	 * Program the voltage.  Note that some instances of dw_mmc may use
> -	 * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
> -	 * does no harm but you need to set the regulator directly.  Try both.
> -	 */
> +	if (IS_ERR(mmc->supply.vqmmc)) {
> +		dev_dbg(&mmc->class_dev,
> +			"vqmmc not available.(Skip the switching voltage)\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = mmc_regulator_set_vqmmc(mmc, ios);
> +	if (ret) {
> +		dev_err(&mmc->class_dev,
> +				 "Regulator set error %d - %s V\n",
> +				 ret, uhs & v18 ? "1.8" : "3.3");
> +		return ret;
> +	}
> +
>  	uhs = mci_readl(host, UHS_REG);
> -	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)

uhs is still zero now, so maybe we can remove this switch branch and
only need a simple checking like this:

if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
	uhs |= v18;

otherwise, it looks good to me.

> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_330:
>  		uhs &= ~v18;
> -	else
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_180:
>  		uhs |= v18;
> -
> -	if (!IS_ERR(mmc->supply.vqmmc)) {
> -		ret = mmc_regulator_set_vqmmc(mmc, ios);
> -
> -		if (ret) {
> -			dev_dbg(&mmc->class_dev,
> -					 "Regulator set error %d - %s V\n",
> -					 ret, uhs & v18 ? "1.8" : "3.3");
> -			return ret;
> -		}
> +		break;
> +	default:
> +		uhs &= ~v18;
>  	}
>  	mci_writel(host, UHS_REG, uhs);
>
>


-- 
Best Regards
Shawn Lin

