From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add switch_voltage
Date: Mon, 04 May 2015 09:25:13 +0900
Message-ID: <5546BC69.4090708@samsung.com>
References: <1430444818-7740-1-git-send-email-zhangfei.gao@linaro.org>
 <1430444818-7740-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57575 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbEDAZQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 May 2015 20:25:16 -0400
In-reply-to: <1430444818-7740-3-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, "Jorge A. Ramirez-Ortiz" <jorge.ramirez-ortiz@linaro.org>, Dan Yuan <yuandan@hisilicon.com>

Hi, Zhangfei.

On 05/01/2015 10:46 AM, Zhangfei Gao wrote:
> switch_voltage is required on some platform since special register accessing
> 
> Signed-off-by: Jorge A. Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Dan Yuan <yuandan@hisilicon.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 6 ++++++
>  drivers/mmc/host/dw_mmc.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 69952b2..488a8af 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1236,11 +1236,17 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	struct dw_mci *host = slot->host;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
>  	u32 uhs;
>  	u32 v18 = SDMMC_UHS_18V << slot->id;
>  	int min_uv, max_uv;
>  	int ret;
>  
> +	if (drv_data && drv_data->switch_voltage) {
> +		ret = drv_data->switch_voltage(mmc, ios);
> +		return ret;

Just use "return drv_data->switch_voltage(mmc, ios);"

Best Regards,
Jaehoon Chung

> +	}
> +
>  	/*
>  	 * Program the voltage.  Note that some instances of dw_mmc may use
>  	 * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index f45ab91..c723617 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -287,5 +287,7 @@ struct dw_mci_drv_data {
>  	int		(*execute_tuning)(struct dw_mci_slot *slot);
>  	int		(*prepare_hs400_tuning)(struct dw_mci *host,
>  						struct mmc_ios *ios);
> +	int		(*switch_voltage)(struct mmc_host *mmc,
> +					  struct mmc_ios *ios);
>  };
>  #endif /* _DW_MMC_H_ */
> 

