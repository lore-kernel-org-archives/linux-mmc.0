From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH] mmc: sdhci: fix caps2 for HS200
Date: Tue, 11 Jun 2013 17:09:17 +0200
Message-ID: <DC90B37F-FB8C-4A1E-AACF-82CE5D53B95C@nvidia.com>
References: <1370959760-27215-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:6839 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab3FKPJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 11:09:24 -0400
In-Reply-To: <1370959760-27215-1-git-send-email-peppe.cavallaro@st.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>


On Jun 11, 2013, at 3:09 PM, Giuseppe CAVALLARO <peppe.cavallaro@st.com> wrote:

> Although the HC supports HS200 (eMMC) the caps2 are always zero; this means that
> no way to use the super speed mode (when init the card).
> 
> If the HC support SDR104, for SD3.0, so it also supports HS200 for eMMC and
> this patch just sets the MMC_CAP2_HS200 in the host caps2 field.
> 
> Reported-by: Youssef Triki <youssef.triki@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
> drivers/mmc/host/sdhci.c |    8 ++++++--
> 1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ea429c..5626f5f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2962,9 +2962,13 @@ int sdhci_add_host(struct sdhci_host *host)
> 		mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
> 
> 	/* SDR104 supports also implies SDR50 support */
> -	if (caps[1] & SDHCI_SUPPORT_SDR104)
> +	if (caps[1] & SDHCI_SUPPORT_SDR104) {
> 		mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
> -	else if (caps[1] & SDHCI_SUPPORT_SDR50)
> +		/* SD3.0: SDR104 is supported so from eMMC caps2
> +		 * can be promoted to support HS200.
> +		 */
> +		mmc->caps2 |= MMC_CAP2_HS200;
> +	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
> 		mmc->caps |= MMC_CAP_UHS_SDR50;
> 
> 	if (caps[1] & SDHCI_SUPPORT_DDR50)
> -- 
> 1.7.4.4


further down in the code could you  change the  comment from
        /* Does the host need tuning for HS200? */
        if (mmc->caps2 & MMC_CAP2_HS200)
                host->flags |= SDHCI_HS200_NEEDS_TUNING;


to

        /* Does the host need tuning for SDR104/HS200? */
        if (mmc->caps2 & MMC_CAP2_HS200)
                host->flags |= SDHCI_HS200_NEEDS_TUNING;

Since SDR104 and HS200 are effectively the same thing should we delete the defines for HS200 and use SDR104 ?
or
if we want SDR104 to be separate from HS200 create defines for that.  Like SDHCI_SDR104_NEEDS_TUNING 




> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

