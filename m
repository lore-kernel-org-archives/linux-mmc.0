From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add a new compatible string for
 exynos5420
Date: Thu, 20 Jun 2013 21:50:51 +0900
Message-ID: <51C2FAAB.1050708@samsung.com>
References: <1369389873-15018-1-git-send-email-yuvaraj.cd@samsung.com>
 <1369389873-15018-2-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57887 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757841Ab3FTMux (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jun 2013 08:50:53 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOO000Z5ZONWB90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 20 Jun 2013 21:50:52 +0900 (KST)
In-reply-to: <1369389873-15018-2-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, thomas.ab@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 05/24/2013 07:04 PM, Yuvaraj Kumar C D wrote:
> The Exynos5420 has a DWMMC controller which is different from prior
> versions.This patch adds a new compatible string for Exynos5420.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index f013e7e..f883b17 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -41,6 +41,7 @@ enum dw_mci_exynos_type {
>  	DW_MCI_TYPE_EXYNOS4210,
>  	DW_MCI_TYPE_EXYNOS4412,
>  	DW_MCI_TYPE_EXYNOS5250,
> +	DW_MCI_TYPE_EXYNOS5420,
>  };
>  
>  /* Exynos implementation specific driver private data */
> @@ -64,6 +65,9 @@ static struct dw_mci_exynos_compatible {
>  	}, {
>  		.compatible	= "samsung,exynos5250-dw-mshc",
>  		.ctrl_type	= DW_MCI_TYPE_EXYNOS5250,
> +	}, {
> +		.compatible	= "samsung,exynos5420-dw-mshc",
> +		.ctrl_type	= DW_MCI_TYPE_EXYNOS5420,
>  	},
>  };
>  
> @@ -92,7 +96,8 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
>  {
>  	struct dw_mci_exynos_priv_data *priv = host->priv;
>  
> -	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
> +	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250 ||
> +		priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420)
>  		host->bus_hz /= (priv->ciu_div + 1);
>  	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
>  		host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
> @@ -175,6 +180,8 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>  			.data = &exynos_drv_data, },
>  	{ .compatible = "samsung,exynos5250-dw-mshc",
>  			.data = &exynos_drv_data, },
> +	{ .compatible = "samsung,exynos5420-dw-mshc",
> +			.data = &exynos_drv_data, },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
> 

