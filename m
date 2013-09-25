From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/3] mmc: dw_mmc-socfpga: Staticize dw_mci_socfpga_probe
Date: Wed, 25 Sep 2013 11:26:31 +0900
Message-ID: <524249D7.3000402@samsung.com>
References: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
 <1378968396-18604-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15211 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab3IYC0A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 22:26:00 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTN009LPTDVI8K0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Sep 2013 11:25:54 +0900 (KST)
In-reply-to: <1378968396-18604-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, tgih.jun@samsung.com, cjb@laptop.org, nico@fluxnic.net

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 09/12/2013 03:46 PM, Sachin Kamat wrote:
> 'dw_mci_socfpga_probe' is used only in this file. Make it static.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-socfpga.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
> index 5ce00b2..56c7fe2 100644
> --- a/drivers/mmc/host/dw_mmc-socfpga.c
> +++ b/drivers/mmc/host/dw_mmc-socfpga.c
> @@ -113,7 +113,7 @@ static const struct of_device_id dw_mci_socfpga_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_socfpga_match);
>  
> -int dw_mci_socfpga_probe(struct platform_device *pdev)
> +static int dw_mci_socfpga_probe(struct platform_device *pdev)
>  {
>  	const struct dw_mci_drv_data *drv_data;
>  	const struct of_device_id *match;
> 

