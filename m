From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] mmc: dw-mmc: check the host->bus_hz before calling
Date: Tue, 19 Feb 2013 19:18:59 +0900
Message-ID: <000401ce0e8a$88892c90$999b85b0$%jun@samsung.com>
References: <5121FE73.5010206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59920 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758052Ab3BSKTC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 05:19:02 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIG001RKPYI1A01@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 19 Feb 2013 19:19:00 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MIG00E5YPZOYF60@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 19 Feb 2013 19:19:00 +0900 (KST)
In-reply-to: <5121FE73.5010206@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>

On Monday, February 18, 2013, Jaehoon Chung wrote:
> Check whether host->bus_hz is zero or not. before calling drv_data->setup_clock.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 60063cc..c59078c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2203,6 +2203,13 @@ int dw_mci_probe(struct dw_mci *host)
>  	else
>  		host->bus_hz = clk_get_rate(host->ciu_clk);
> 
> +	if (!host->bus_hz) {
> +		dev_err(host->dev,
> +			"Platform data must supply bus speed\n");
> +		ret = -ENODEV;
> +		goto err_clk_ciu;
> +	}
> +
>  	if (drv_data && drv_data->setup_clock) {
>  		ret = drv_data->setup_clock(host);
>  		if (ret) {
> @@ -2212,13 +2219,6 @@ int dw_mci_probe(struct dw_mci *host)
>  		}
>  	}
> 
> -	if (!host->bus_hz) {
> -		dev_err(host->dev,
> -			"Platform data must supply bus speed\n");
> -		ret = -ENODEV;
> -		goto err_clk_ciu;
> -	}
> -
Currently checking 'host->bus_hz' is following 'setup_clock'
If specific implementation for 'setup_clock' is present, bus_hz may be updated.
When considering multiple platforms,  it looks like proper.
Could you check the patch for more?
[PATCH v5 9/9] mmc: dw_mmc: add support for exynos specific implementation of dw-mshc

Thanks,
Seungwon Jeon

>  	host->quirks = host->pdata->quirks;
> 
>  	spin_lock_init(&host->lock);
> --
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

