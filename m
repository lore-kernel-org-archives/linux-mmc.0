From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
Date: Wed, 06 May 2015 09:36:55 +0900
Message-ID: <55496227.9000904@samsung.com>
References: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38044 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbbEFAhA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 20:37:00 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NNW005CSKDMM210@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 May 2015 09:36:58 +0900 (KST)
In-reply-to: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi, Zhangfei.

If you want to check it, use the "broken-cd" and "non-removable" properties into dt-file.
Did you use them?

Best Regards,
Jaehoon Chung

On 05/05/2015 05:54 PM, Zhangfei Gao wrote:
> When non-removable is used for emmc,  MMC_CAP_NONREMOVABLE should
> also be checked, otherwise detection fail since present=0
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 488a8af..5d327e4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1308,7 +1308,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  	int gpio_cd = mmc_gpio_get_cd(mmc);
>  
>  	/* Use platform get_cd function, else try onboard card detect */
> -	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> +	if ((brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) ||
> +	    (mmc->caps & MMC_CAP_NONREMOVABLE))
>  		present = 1;
>  	else if (!IS_ERR_VALUE(gpio_cd))
>  		present = gpio_cd;
> 

