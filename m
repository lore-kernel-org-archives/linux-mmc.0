From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc-socfpga: Remove redundant of_match_ptr
Date: Wed, 25 Sep 2013 11:26:19 +0900
Message-ID: <524249CB.7050701@samsung.com>
References: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
 <1378968396-18604-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20250 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab3IYCZn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 22:25:43 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTN003TLTDUV380@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Sep 2013 11:25:41 +0900 (KST)
In-reply-to: <1378968396-18604-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, tgih.jun@samsung.com, cjb@laptop.org, nico@fluxnic.net

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 09/12/2013 03:46 PM, Sachin Kamat wrote:
> 'dw_mci_socfpga_match' is always compiled in.
> Hence of_match_ptr is not necessary.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-socfpga.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
> index 14b5961..5ce00b2 100644
> --- a/drivers/mmc/host/dw_mmc-socfpga.c
> +++ b/drivers/mmc/host/dw_mmc-socfpga.c
> @@ -128,7 +128,7 @@ static struct platform_driver dw_mci_socfpga_pltfm_driver = {
>  	.remove		= __exit_p(dw_mci_pltfm_remove),
>  	.driver		= {
>  		.name		= "dwmmc_socfpga",
> -		.of_match_table	= of_match_ptr(dw_mci_socfpga_match),
> +		.of_match_table	= dw_mci_socfpga_match,
>  		.pm		= &dw_mci_pltfm_pmops,
>  	},
>  };
> 

