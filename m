From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD
 host
Date: Wed, 16 May 2018 11:07:16 +0300
Message-ID: <b3e93d89-8f95-be29-32d9-2bc8f6d83f62@intel.com>
References: <20180420163950.11756-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420163950.11756-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 20/04/18 19:39, ernest.zhang wrote:
> Add MSI interrupt support if the SD host device can support MSI interrupt.
> 
> Changes in V5:

The change log goes below the --- line or in a separate cover email.

> 	1. Because pci_enable_msi is marked as deprecated and should not be
> 	used in new code, use pci_alloc_irq_vectors instead.
> 	2. Remove unneeded CONFIG_PCI_MSI macro check
> 
> Changes in V4:
> 	Enable MSI interrupt if the MSI capability bit is set in
> 	capability register.
> 
> Changes in V3:
> 	None. This patch is add in V4.
> 
> Changes in V2:
> 	None. This patch is add in V4.
> 
> Changes in V1:
> 	None. This patch is add in V4.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 96adaae..374c783 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -358,11 +358,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
> +	struct mmc_host *mmc;
>  	u32 reg;
>  	int ret;
>  
>  	chip = slot->chip;
>  	host = slot->host;
> +	mmc = host->mmc;
>  	switch (chip->pdev->device) {
>  	case PCI_DEVICE_ID_O2_SDS0:
>  	case PCI_DEVICE_ID_O2_SEABIRD0:
> @@ -373,6 +375,28 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +		if (pci_find_capability(chip->pdev, PCI_CAP_ID_MSI)) {
> +			ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
> +						    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +			if (ret == 1) {
> +				ret = pci_irq_vector(chip->pdev, 0);
> +				if (ret >= 0) {
> +					host->irq = ret;
> +					pr_info("%s: use MSI irq, irq=%d\n",
> +						mmc_hostname(mmc), host->irq);
> +				} else {
> +					pr_err("%s: failed to get device irq, err=%d\n",
> +					       mmc_hostname(mmc), ret);
> +				}
> +			} else {
> +				pr_err("%s: enable PCI MSI failed, err=%d\n",
> +				       mmc_hostname(mmc), ret);
> +			}
> +		} else {
> +			pr_info("%s: unsupport msi, use INTx irq\n",
> +				mmc_hostname(mmc));
> +		}

There seem to be more prints here than you really need.  Please reduce them
and make this a separate function.

> +
>  		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
>  			ret = pci_read_config_dword(chip->pdev,
>  						    O2_SD_MISC_SETTING, &reg);
> @@ -380,11 +404,11 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  				return -EIO;
>  			if (reg & (1 << 4)) {
>  				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
> -					mmc_hostname(host->mmc));
> +					mmc_hostname(mmc));

The change from using 'host->mmc' to using local variable 'mmc' needs to be
a separate patch.

>  				host->flags &= ~SDHCI_SIGNALING_330;
>  				host->flags |= SDHCI_SIGNALING_180;
> -				host->mmc->caps2 |= MMC_CAP2_NO_SD;
> -				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +				mmc->caps2 |= MMC_CAP2_NO_SD;
> +				mmc->caps2 |= MMC_CAP2_NO_SDIO;

Ditto

>  			}
>  		}
>  
> 
