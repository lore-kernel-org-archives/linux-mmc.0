From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 3/3] sdhci-pci: enable SD card interface on Merrifield
Date: Thu, 1 Sep 2016 16:21:13 +0300
Message-ID: <51fff9ce-d6d8-22e3-adff-50241f418d72@intel.com>
References: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1472463221-11948-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5242 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754318AbcIANZs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 09:25:48 -0400
In-Reply-To: <1472463221-11948-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 29/08/16 12:33, Andy Shevchenko wrote:
> Intel Merrifield provides an interface to an external SD card.
> Enable it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index d38d701..3833c5f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -419,6 +419,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  /* Define Host controllers for Intel Merrifield platform */
>  #define INTEL_MRFLD_EMMC_0	0
>  #define INTEL_MRFLD_EMMC_1	1
> +#define INTEL_MRFLD_SD		2
>  #define INTEL_MRFLD_SDIO	3
>  
>  static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
> @@ -432,12 +433,14 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  					 MMC_CAP_8_BIT_DATA |
>  					 MMC_CAP_1_8V_DDR;
>  		break;
> +	case INTEL_MRFLD_SD:
> +		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +		break;
>  	case INTEL_MRFLD_SDIO:
>  		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
>  					 MMC_CAP_POWER_OFF_CARD;
>  		break;
>  	default:
> -		/* SD support is not ready yet */
>  		return -ENODEV;
>  	}
>  	return 0;
> 

