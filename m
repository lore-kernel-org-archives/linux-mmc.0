From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 1/3] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date: Thu, 29 Mar 2018 15:25:50 +0300
Message-ID: <fbdc3592-cb50-9c0e-d5fd-0ab087f09a69@intel.com>
References: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com, yuxiang.wan@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

On 09/03/18 16:04, ernest.zhang wrote:
> When use eMMC as boot device, the eMMC signaling voltage is tied to 1.8v
> fixed output voltage, bios can set o2 sd host controller PCI configuration
> register 0x308 bit4 to 1 to let driver skip 3.3v signaling voltage and 
> direct use 1.8v singling voltage in eMMC initialize process.
> 
> Changes: Check PCIe register 0x308 bit 4 and skip eMMC 3.3v initialization
> process if it is set to 1.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>

Notwithstanding minor formatting comment below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 555970a..d465751 100644
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
> +				     mmc_hostname(host->mmc));

Indenting is a little odd i.e. checkpatch says

CHECK: Alignment should match open parenthesis
#58: FILE: drivers/mmc/host/sdhci-pci-o2micro.c:210:
+                               pr_info("%s: emmc 1.8v flag is set, force
1.8v signaling voltage\n",
+                                    mmc_hostname(host->mmc))

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
> 
