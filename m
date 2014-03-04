From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: exynos: Staticize dw_mci_exynos_pmops
Date: Tue, 04 Mar 2014 20:44:49 +0900
Message-ID: <5315BCB1.5020000@samsung.com>
References: <1393909405-2760-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20732 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756661AbaCDLoZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Mar 2014 06:44:25 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1W00JJ7TXZ3180@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Mar 2014 20:44:23 +0900 (KST)
In-reply-to: <1393909405-2760-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, tgih.jun@samsung.com, chris@printf.net

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 03/04/2014 02:03 PM, Sachin Kamat wrote:
> 'dw_mci_exynos_pmops' is local to this file.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 3423c5ed50c7..12f0929f12a9 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -426,7 +426,7 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
>  	return dw_mci_pltfm_register(pdev, drv_data);
>  }
>  
> -const struct dev_pm_ops dw_mci_exynos_pmops = {
> +static const struct dev_pm_ops dw_mci_exynos_pmops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
>  	.resume_noirq = dw_mci_exynos_resume_noirq,
>  	.thaw_noirq = dw_mci_exynos_resume_noirq,
> 

