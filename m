From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 1/3] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date: Tue, 10 Jul 2018 15:23:12 +0300
Message-ID: <0c2398b7-184b-e464-0613-c5b5609a7094@intel.com>
References: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com, chevron.li@bayhubtech.com, shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

On 26/06/18 18:46, ernest.zhang wrote:
> When use eMMC as boot device, the eMMC signaling voltage is tied to 1.8v
> fixed output voltage, bios can set o2 sd host controller PCI configuration
> register 0x308 bit4 to 1 to let driver skip 3.3v signaling voltage and
> direct use 1.8v singling voltage in eMMC initialize process.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
> Changes in V6:
> 	1.Move change log to correct place.
> 	2.Change HS200 mode clock frequency from 208MHz to 200MHz to meet
> 	Specification.

That 2nd change should be a separate patch.

> 
> Changes in V5:
> 	Modify code format to pass checkpatch.pl check and add a summary
> 	of what has changed in each version.
> 
> Changes in V4:
> 	Skip SDIO and SD initalization when register 0x308 bit 4 is set,
> 	and modify some typo.
> 
> Changes in V3:
> 	Rebase the patch on the mmc tree 'next' branch.
> 
> Changes in V2:
> 	Modify code format, and delete unused code path.
> 
> Changes in V1:
> 	Check PCIe register 0x308 bit 4 and skip eMMC 3.3v initialization
> 	process if it is set to 1.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 555970a..94cf3cd 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -3,6 +3,7 @@
>   *
>   * Authors: Peter Guo <peter.guo@bayhubtech.com>
>   *          Adam Lee <adam.lee@canonical.com>
> + *          Ernest Zhang <ernest.zhang@bayhubtech.com>
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -39,6 +40,7 @@
>  #define O2_SD_MISC_CTRL4	0xFC
>  #define O2_SD_TUNING_CTRL	0x300
>  #define O2_SD_PLL_SETTING	0x304
> +#define O2_SD_MISC_SETTING	0x308
>  #define O2_SD_CLK_SETTING	0x328
>  #define O2_SD_CAP_REG2		0x330
>  #define O2_SD_CAP_REG0		0x334
> @@ -184,6 +186,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
>  	u32 reg;
> +	int ret;
>  
>  	chip = slot->chip;
>  	host = slot->host;
> @@ -197,6 +200,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
> +			ret = pci_read_config_dword(chip->pdev,
> +						    O2_SD_MISC_SETTING, &reg);
> +			if (ret)
> +				return -EIO;
> +			if (reg & (1 << 4)) {
> +				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
> +					mmc_hostname(host->mmc));
> +				host->flags &= ~SDHCI_SIGNALING_330;
> +				host->flags |= SDHCI_SIGNALING_180;
> +				host->mmc->caps2 |= MMC_CAP2_NO_SD;
> +				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +			}
> +		}
> +
>  		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>  			break;
>  		/* set dll watch dog timer */
> @@ -293,7 +311,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  
>  			/* Check Whether subId is 0x11 or 0x12 */
>  			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
> -				scratch_32 = 0x2c280000;
> +				scratch_32 = 0x25100000;
>  
>  				/* Set Base Clock to 208MZ */

Need to change the comment too i.e. 208MZ -> 200 MHz

>  				o2_pci_set_baseclk(chip, scratch_32);
> @@ -388,7 +406,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  					       O2_SD_PLL_SETTING, scratch_32);
>  		} else {
>  			scratch_32 &= 0x0000FFFF;
> -			scratch_32 |= 0x2c280000;
> +			scratch_32 |= 0x25100000;
>  
>  			pci_write_config_dword(chip->pdev,
>  					       O2_SD_PLL_SETTING, scratch_32);
> 
