From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V2] mmc: sdhci: check 1.2v IO capability for SDHC host
Date: Tue, 19 Aug 2014 14:14:11 +0900
Message-ID: <53F2DD23.5080003@samsung.com>
References: <20140819030240.GA3201@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54244 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbaHSFOO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 01:14:14 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NAJ0017LFVO9M20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 19 Aug 2014 14:14:12 +0900 (KST)
In-reply-to: <20140819030240.GA3201@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>, ulf.hansson@linaro.org, chris@printf.org
Cc: linux-mmc@vger.kernel.org

Hi, Dong.

Doesn't it need to consider for HS400 mode?

Best Regards,
Jaehoon Chung

On 08/19/2014 12:02 PM, Chuanxiao Dong wrote:
> Right now enable 1.2v IO voltage for SDHC is by using vqmmc.
> Thus for the host which doesn't have vqmmc, or its vqmmc does
> not support 1.2v, directly use MMC_CAP2_HS200 may cause HS200
> failure.
> 
> So needs to check if vqmmc is able to support 1.2v. If it does
> not support, disable 1.2v IO for HS200.
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> Changelog V2: rebase this patch, and use IS_ERR to check vqmmc.
> 
>  drivers/mmc/host/sdhci.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4cc2ff9..a23738c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3009,8 +3009,13 @@ int sdhci_add_host(struct sdhci_host *host)
>  		/* SD3.0: SDR104 is supported so (for eMMC) the caps2
>  		 * field can be promoted to support HS200.
>  		 */
> -		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
> +		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)) {
>  			mmc->caps2 |= MMC_CAP2_HS200;
> +			if (IS_ERR(mmc->supply.vqmmc) ||
> +					!regulator_is_supported_voltage
> +					(mmc->supply.vqmmc, 1100000, 1300000))
> +				mmc->caps2 &= ~MMC_CAP2_HS200_1_2V_SDR;
> +		}
>  	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
>  		mmc->caps |= MMC_CAP_UHS_SDR50;
>  
> 

