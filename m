From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] sdhci: Advertise 2.0v supply on SDIO host controller
Date: Thu, 11 Jan 2018 15:55:57 +0200
Message-ID: <923ab23d-0573-d278-a6b0-9a27673e9613@intel.com>
References: <20180111135158.19366-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28924 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932720AbeAKN4a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Jan 2018 08:56:30 -0500
In-Reply-To: <20180111135158.19366-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 11/01/18 15:51, Andy Shevchenko wrote:
> On Intel Edison the Broadcom Wi-Fi card, which is connected to SDIO,
> requires 2.0v, while the host, according to Intel Merrifield TRM,
> supports 1.8v supply only.
> 
> The card announces itself as
> 
>   mmc2: new ultra high speed DDR50 SDIO card at address 0001
> 
> Introduce a custom OCR mask for SDIO host controller on Intel Merrifield
> and add a special case to sdhci_set_power_noreg() to override 2.0v supply
> by enforcing 1.8v power choice.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> - address Ulf's comment
>  drivers/mmc/host/sdhci-pci-core.c | 2 ++
>  drivers/mmc/host/sdhci.c          | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 3e4f04fd5175..bcfb5dc0d85e 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -778,6 +778,8 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  		break;
>  	case INTEL_MRFLD_SDIO:
> +		/* Advertise 2.0v for compatibility with the SDIO card's OCR */
> +		slot->host->ocr_mask = MMC_VDD_20_21 | MMC_VDD_165_195;
>  		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
>  					 MMC_CAP_POWER_OFF_CARD;
>  		break;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9290a3439d5..80b1a59bc3c5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1434,6 +1434,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  	if (mode != MMC_POWER_OFF) {
>  		switch (1 << vdd) {
>  		case MMC_VDD_165_195:
> +		/*
> +		 * Without a regulator, SDHCI does not support 2.0v
> +		 * so we only get here if the driver deliberately
> +		 * added the 2.0v range to ocr_avail. Map it to 1.8v
> +		 * for the purpose of turning on the power.
> +		 */
> +		case MMC_VDD_20_21:
>  			pwr = SDHCI_POWER_180;
>  			break;
>  		case MMC_VDD_29_30:
> 

