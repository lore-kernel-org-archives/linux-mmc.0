From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Remove redundant of_match_ptr
Date: Sun, 06 Oct 2013 17:26:01 +0900
Message-ID: <52511E99.8050108@samsung.com>
References: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
 <1380517173-10537-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15228 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3JFIZ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Oct 2013 04:25:59 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU8005C4NEEULB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sun, 06 Oct 2013 17:25:57 +0900 (KST)
In-reply-to: <1380517173-10537-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 09/30/2013 01:59 PM, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 5c49656..2553bfb 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -123,7 +123,7 @@ static struct platform_driver dw_mci_pltfm_driver = {
>  	.remove		= dw_mci_pltfm_remove,
>  	.driver		= {
>  		.name		= "dw_mmc",
> -		.of_match_table	= of_match_ptr(dw_mci_pltfm_match),
> +		.of_match_table	= dw_mci_pltfm_match,
>  		.pm		= &dw_mci_pltfm_pmops,
>  	},
>  };
> 

