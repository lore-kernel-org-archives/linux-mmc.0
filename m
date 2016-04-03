From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: add the function for controlling SMU
Date: Mon, 04 Apr 2016 08:46:24 +0900
Message-ID: <5701AB50.9000105@samsung.com>
References: <1459403598-5256-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50965 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbcDCXq0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Apr 2016 19:46:26 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O5301C0F0PCC7B0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Apr 2016 08:46:24 +0900 (KST)
In-reply-to: <1459403598-5256-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

Hi,

Picked this patch on my repository.

Best Regards,
Jaehoon Chung

On 03/31/2016 02:53 PM, Jaehoon Chung wrote:
> Some of Exynos has the Security management Unit(SMU).
> This patch adds the function for controlling SMU.
> 
> In future, if exynos needs to control SMU, it can be implemented
> in "config_smu" function, not "init" function.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 8790f2a..0e989eb 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -91,10 +91,14 @@ static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
>  		return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL)) + 1;
>  }
>  
> -static int dw_mci_exynos_priv_init(struct dw_mci *host)
> +static void dw_mci_exynos_config_smu(struct dw_mci *host)
>  {
>  	struct dw_mci_exynos_priv_data *priv = host->priv;
>  
> +	/*
> +	 * If Exynos is provided the Security management,
> +	 * set for non-ecryption mode at this time.
> +	 */
>  	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU ||
>  		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
>  		mci_writel(host, MPSBEGIN0, 0);
> @@ -104,6 +108,13 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>  			   SDMMC_MPSCTRL_VALID |
>  			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
>  	}
> +}
> +
> +static int dw_mci_exynos_priv_init(struct dw_mci *host)
> +{
> +	struct dw_mci_exynos_priv_data *priv = host->priv;
> +
> +	dw_mci_exynos_config_smu(host);
>  
>  	if (priv->ctrl_type >= DW_MCI_TYPE_EXYNOS5420) {
>  		priv->saved_strobe_ctrl = mci_readl(host, HS400_DLINE_CTRL);
> @@ -169,7 +180,7 @@ static int dw_mci_exynos_resume(struct device *dev)
>  {
>  	struct dw_mci *host = dev_get_drvdata(dev);
>  
> -	dw_mci_exynos_priv_init(host);
> +	dw_mci_exynos_config_smu(host);
>  	return dw_mci_resume(host);
>  }
>  
> 

