From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: Revert the sdr_timing assignment
Date: Tue, 22 Oct 2013 19:12:24 +0900
Message-ID: <52664F88.50605@samsung.com>
References: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48342 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab3JVKMY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 06:12:24 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV20023AF0NEUC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Oct 2013 19:12:23 +0900 (KST)
In-reply-to: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, thomas.ab@samsung.com, grundler@chromium.org
Cc: dianders@chromium.org, sonnyrao@chromium.org, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Reported-by: Grant Grundler <grundler@chromium.org>

On 10/22/2013 06:11 PM, Yuvaraj Kumar C D wrote:
> commit 4ad602c9df1e3b04979c260b5612141b4b892257 was wrongly assigning
> ddr_timing value to sdr_timing.This patch fix's this by reverting
> the sdr_timing assignment statement to the earlier location.
> 
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index d42e664..3423c5e 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -251,12 +251,13 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>  	if (ret)
>  		return ret;
>  
> +	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
> +
>  	ret = of_property_read_u32_array(np,
>  			"samsung,dw-mshc-ddr-timing", timing, 2);
>  	if (ret)
>  		return ret;
>  
> -	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
>  	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
>  	host->priv = priv;
>  	return 0;
> 

