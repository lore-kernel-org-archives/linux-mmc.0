From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of
 of_match_ptr()
Date: Wed, 13 Mar 2013 13:32:28 +0900
Message-ID: <5140015C.3010309@samsung.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
 <1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16307 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab3CMEc0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 00:32:26 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJL00I5F0M1XXM0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Mar 2013 13:32:25 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MJL00EHC0LXD9G1@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Mar 2013 13:32:21 +0900 (KST)
In-reply-to: <1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, patches@linaro.org, tgih.jun@samsung.com

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 02/18/2013 05:53 PM, Sachin Kamat wrote:
> 'dw_mci_exynos_match' is always compiled in. Hence of_match_ptr
> is not required.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 5a09c77..517a603 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -230,7 +230,7 @@ static struct platform_driver dw_mci_exynos_pltfm_driver = {
>  	.remove		= __exit_p(dw_mci_pltfm_remove),
>  	.driver		= {
>  		.name		= "dwmmc_exynos",
> -		.of_match_table	= of_match_ptr(dw_mci_exynos_match),
> +		.of_match_table	= dw_mci_exynos_match,
>  		.pm		= &dw_mci_pltfm_pmops,
>  	},
>  };
> 

