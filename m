From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: RE: [PATCH 3/7] mmc: sdhci: Do not BUG on invalid vdd
Date: Fri, 27 Nov 2015 05:08:08 +0000
Message-ID: <371b41d66a9240958bb337dc3937f9c9@bgmail103.nvidia.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
 <1448539250-18769-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11821 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbK0FIN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Nov 2015 00:08:13 -0500
In-Reply-To: <1448539250-18769-4-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>, Venu Byravarasu <vbyravarasu@nvidia.com>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Thursday, November 26, 2015 5:31 PM
> To: Ulf Hansson
> Cc: linux-mmc; Jaehoon Chung; Chaotian Jing; Wenkai Du
> Subject: [PATCH 3/7] mmc: sdhci: Do not BUG on invalid vdd
> 
> The driver may not be able to set the power correctly but that is not a reason
> to BUG().
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 2b17cc1246ca..5f8b0766428c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1299,7 +1299,10 @@ static void sdhci_set_power(struct sdhci_host
> *host, unsigned char mode,
>  			pwr = SDHCI_POWER_330;
>  			break;
>  		default:
> -			BUG();
> +			WARN(1, "%s: Invalid vdd %#x\n",
> +			     mmc_hostname(host->mmc), vdd);
> +			pwr = 0;

As pwr is initialized to 0 during declaration, don't see a need for above statement.
However agree with your point that BUG can be replaced with a warn message.

> +			break;
>  		}
>  	}
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
