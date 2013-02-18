From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Make dw_mci_exynos_probe static
Date: Mon, 18 Feb 2013 18:41:34 +0900
Message-ID: <5121F74E.5050903@samsung.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13864 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab3BRJlq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 04:41:46 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIE009B7TL5TKD0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 18:41:29 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MIE00G92TL5BV20@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 18:41:29 +0900 (KST)
In-reply-to: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, patches@linaro.org, tgih.jun@samsung.com

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 02/18/2013 05:53 PM, Sachin Kamat wrote:
> Silences the following sparse warning:
> drivers/mmc/host/dw_mmc-exynos.c:218:5: warning:
> symbol 'dw_mci_exynos_probe' was not declared. Should it be static?
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 72fd0f2..5a09c77 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -215,7 +215,7 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
>  
> -int dw_mci_exynos_probe(struct platform_device *pdev)
> +static int dw_mci_exynos_probe(struct platform_device *pdev)
>  {
>  	const struct dw_mci_drv_data *drv_data;
>  	const struct of_device_id *match;
> 

