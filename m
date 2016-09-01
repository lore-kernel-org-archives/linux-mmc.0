From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 2/3] sdhci-pci: enable SDIO interface on Intel
 Merrifield
Date: Thu, 1 Sep 2016 16:20:56 +0300
Message-ID: <775ffbb3-e2b4-6664-9b88-9e5dfcdf1daf@intel.com>
References: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1472463221-11948-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19103 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754318AbcIANZb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 09:25:31 -0400
In-Reply-To: <1472463221-11948-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 29/08/16 12:33, Andy Shevchenko wrote:
> Intel Merrifield is known to have an SDIO interface and on Intel Edison board a
> WiFi card is wired to it.
> 
> Enable the interface here to allow WiFi card enumeration.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 40f4fe8..d38d701 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -419,6 +419,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  /* Define Host controllers for Intel Merrifield platform */
>  #define INTEL_MRFLD_EMMC_0	0
>  #define INTEL_MRFLD_EMMC_1	1
> +#define INTEL_MRFLD_SDIO	3
>  
>  static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
> @@ -431,6 +432,10 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  					 MMC_CAP_8_BIT_DATA |
>  					 MMC_CAP_1_8V_DDR;
>  		break;
> +	case INTEL_MRFLD_SDIO:
> +		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
> +					 MMC_CAP_POWER_OFF_CARD;
> +		break;
>  	default:
>  		/* SD support is not ready yet */
>  		return -ENODEV;
> 

