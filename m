From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3] mmc: dw_mmc: Add MSHC compatible for Exynos4412
Date: Tue, 19 Feb 2013 19:19:15 +0900
Message-ID: <000501ce0e8a$91ef7c30$b5ce7490$%jun@samsung.com>
References: <1361210793-5710-1-git-send-email-tobetter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59960 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616Ab3BSKTR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 05:19:17 -0500
In-reply-to: <1361210793-5710-1-git-send-email-tobetter@gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dongjin Kim' <tobetter@gmail.com>, "'unlisted-recipients:'"@samsung.com, "'no To-header on input'"@samsung.com
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Will Newton' <will.newton@imgtec.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, February 19, 2013, Dongjin Kim wrote:
> This patch adds the compatible string for MSHC controller of Exynos4412, and
> share the controller specific properties with Exynos5250 since they have same
> features. Its driver data name is changed to exynos_drv_data instead SoC
> specific name.

It's not actually same.
Exynos4412 doesn't have forward compatibilities for Exynos5250.
I agree that functionality of exynos_drv_data is common.
These functions have been implemented for existing Exynos*.
But in case of caps, it can't applied completely.
I'm concerning about this.

Thanks,
Seungwon Jeon
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 4d50da6..38cd03c 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -199,8 +199,8 @@ static int dw_mci_exynos_setup_bus(struct dw_mci *host,
>  	return 0;
>  }
> 
> -/* Exynos5250 controller specific capabilities */
> -static unsigned long exynos5250_dwmmc_caps[4] = {
> +/* Exynos4412/Exynos5250 controller specific capabilities */
> +static unsigned long exynos_dwmmc_caps[4] = {
>  	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
>  		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
>  	MMC_CAP_CMD23,
> @@ -208,8 +208,8 @@ static unsigned long exynos5250_dwmmc_caps[4] = {
>  	MMC_CAP_CMD23,
>  };
> 
> -static const struct dw_mci_drv_data exynos5250_drv_data = {
> -	.caps			= exynos5250_dwmmc_caps,
> +static const struct dw_mci_drv_data exynos_drv_data = {
> +	.caps			= exynos_dwmmc_caps,
>  	.init			= dw_mci_exynos_priv_init,
>  	.setup_clock		= dw_mci_exynos_setup_clock,
>  	.prepare_command	= dw_mci_exynos_prepare_command,
> @@ -219,8 +219,10 @@ static const struct dw_mci_drv_data exynos5250_drv_data = {
>  };
> 
>  static const struct of_device_id dw_mci_exynos_match[] = {
> +	{ .compatible = "samsung,exynos4412-dw-mshc",
> +			.data = &exynos_drv_data, },
>  	{ .compatible = "samsung,exynos5250-dw-mshc",
> -			.data = &exynos5250_drv_data, },
> +			.data = &exynos_drv_data, },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

