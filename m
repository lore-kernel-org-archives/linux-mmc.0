From: "Shen, Jackey" <Jackey.Shen@amd.com>
Subject: RE: [PATCH (v2)] mmc: sdhci: fix caps2 for HS200
Date: Tue, 18 Jun 2013 02:32:50 +0000
Message-ID: <0C8FBB70FF40A94D98BE847F9C171A9803A6FE72@SCYBEXDAG04.amd.com>
References: <DC90B37F-FB8C-4A1E-AACF-82CE5D53B95C@nvidia.com>
 <1371017798-4144-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:47134
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751453Ab3FRCdF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Jun 2013 22:33:05 -0400
In-Reply-To: <1371017798-4144-1-git-send-email-peppe.cavallaro@st.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, Philip Rakity <prakity@nvidia.com>

On Wed, Jun 12, 2013 at 2:16 PM, Giuseppe CAVALLARO <peppe.cavallaro@st.com> wrote:

> Although the HC supports HS200 (eMMC) the caps2 are always zero; this means that
> no way to use the super speed mode (when init the card).
> 
> If the HC support SDR104, for SD3.0, so it also supports HS200 for eMMC and
> this patch just sets the MMC_CAP2_HS200 in the host caps2 field.

Capabilities register defined in "SD Host Controller Standard Specification Version 3.00"
doesn't indicate it support HS200(eMMC). Which specification do you refer to?

> 
> v2: Since SDR104 and HS200 are effectively the same thing the patch deletes
> the defines for HS200 and use SDR104.

Why do you think they are the same thing?
SDR104: 1.8V signaling, Frequency up to 208 MHz, up to 104MB/sec 
HS200: 1.8/1.2V IO voltage, Frequency 0-200MHz, up to 200MB/sec, bus width 4-bit/8-bit

> 
> Reported-by: Youssef Triki <youssef.triki@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Philip Rakity <prakity@nvidia.com>
> ---
>  drivers/mmc/host/sdhci.c  |   14 +++++++++-----
>  include/linux/mmc/sdhci.h |    2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ea429c..b8bb3b3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1846,7 +1846,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	 */
>  	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
>  	    (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
> -	     host->flags & SDHCI_HS200_NEEDS_TUNING))
> +	     host->flags & SDHCI_SDR104_NEEDS_TUNING))
>  		requires_tuning_nonuhs = true;
> 
>  	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
> @@ -2962,9 +2962,13 @@ int sdhci_add_host(struct sdhci_host *host)
>  		mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
> 
>  	/* SDR104 supports also implies SDR50 support */
> -	if (caps[1] & SDHCI_SUPPORT_SDR104)
> +	if (caps[1] & SDHCI_SUPPORT_SDR104) {
>  		mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
> -	else if (caps[1] & SDHCI_SUPPORT_SDR50)
> +		/* SD3.0: SDR104 is supported so (for eMMC) the caps2
> +		 * field can be promoted to support HS200.
> +		 */
> +		mmc->caps2 |= MMC_CAP2_HS200;
> +	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
>  		mmc->caps |= MMC_CAP_UHS_SDR50;
> 
>  	if (caps[1] & SDHCI_SUPPORT_DDR50)
> @@ -2974,9 +2978,9 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (caps[1] & SDHCI_USE_SDR50_TUNING)
>  		host->flags |= SDHCI_SDR50_NEEDS_TUNING;
> 
> -	/* Does the host need tuning for HS200? */
> +	/* Does the host need tuning for SDR104 / HS200? */
>  	if (mmc->caps2 & MMC_CAP2_HS200)
> -		host->flags |= SDHCI_HS200_NEEDS_TUNING;
> +		host->flags |= SDHCI_SDR104_NEEDS_TUNING;
> 
>  	/* Driver Type(s) (A, C, D) supported by the host */
>  	if (caps[1] & SDHCI_DRIVER_TYPE_A)
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index b838ffc..0b1d7f4 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -126,7 +126,7 @@ struct sdhci_host {
>  #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
>  #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
>  #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
> -#define SDHCI_HS200_NEEDS_TUNING (1<<10)	/* HS200 needs tuning */
> +#define SDHCI_SDR104_NEEDS_TUNING (1<<10)	/* SDR104/HS200 needs tuning */
>  #define SDHCI_USING_RETUNING_TIMER (1<<11)	/* Host is using a retuning timer for the card */
> 
>  	unsigned int version;	/* SDHCI spec. version */
> --
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


