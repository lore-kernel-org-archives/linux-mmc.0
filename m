From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V2] mmc: core: Remove MMC_CAP2_HC_ERASE_SZ
Date: Fri, 16 Jun 2017 09:01:34 +0800
Message-ID: <94b0bc5f-8679-e368-08fe-5249970ef4ed@rock-chips.com>
References: <1497270250-11353-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:36244 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdFPBBl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 21:01:41 -0400
In-Reply-To: <1497270250-11353-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 2017/6/12 20:24, Ulf Hansson wrote:
> The MMC_CAP2_HC_ERASE_SZ is used only by a few mmc host drivers. Its intent
> is to enable eMMC's high-capacity erase size, as to improve the behaviour
> of the erase operations.
> 
> We should strive to avoid software configuration options that aren't
> necessary, but instead deploy common behaviours. For these reasons, let's
> remove the capability bit for MMC_CAP2_HC_ERASE_SZ and make it the default
> behaviour.
> 
> Note that this change doesn't affect eMMCs supporting trim/discard, because
> these commands operates on sectors and takes precedence over erase
> commands.
> 

A quick test shows it's good to make it default behaviour, so

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Make the behaviour from MMC_CAP2_HC_ERASE_SZ the default.
> 	- Update changelog to reflect the change.
> 
> ---
>   drivers/mmc/core/mmc.c            | 8 ++------
>   drivers/mmc/host/sdhci-acpi.c     | 1 -
>   drivers/mmc/host/sdhci-brcmstb.c  | 3 ---
>   drivers/mmc/host/sdhci-pci-core.c | 4 +---
>   include/linux/mmc/host.h          | 1 -
>   5 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e504b66..4ffea14 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1651,12 +1651,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   		mmc_set_erase_size(card);
>   	}
>   
> -	/*
> -	 * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
> -	 * bit.  This bit will be lost every time after a reset or power off.
> -	 */
> -	if (card->ext_csd.partition_setting_completed ||
> -	    (card->ext_csd.rev >= 3 && (host->caps2 & MMC_CAP2_HC_ERASE_SZ))) {
> +	/* Enable ERASE_GRP_DEF. This bit is lost after a reset or power off. */
> +	if (card->ext_csd.rev >= 3) {
>   		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>   				 EXT_CSD_ERASE_GROUP_DEF, 1,
>   				 card->ext_csd.generic_cmd6_time);
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 89d9a8c..cf66a3d 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -274,7 +274,6 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>   	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
>   		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
>   		   MMC_CAP_CMD_DURING_TFR | MMC_CAP_WAIT_WHILE_BUSY,
> -	.caps2   = MMC_CAP2_HC_ERASE_SZ,
>   	.flags   = SDHCI_ACPI_RUNTIME_PM,
>   	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 242c5dc..e2f6383 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -89,9 +89,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   		goto err_clk;
>   	}
>   
> -	/* Enable MMC_CAP2_HC_ERASE_SZ for better max discard calculations */
> -	host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
> -
>   	sdhci_get_of_property(pdev);
>   	mmc_of_parse(host->mmc);
>   
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 8fa84a0..227a5cb 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -347,8 +347,7 @@ static inline void sdhci_pci_remove_own_cd(struct sdhci_pci_slot *slot)
>   static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
>   {
>   	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE;
> -	slot->host->mmc->caps2 |= MMC_CAP2_BOOTPART_NOACC |
> -				  MMC_CAP2_HC_ERASE_SZ;
> +	slot->host->mmc->caps2 |= MMC_CAP2_BOOTPART_NOACC;
>   	return 0;
>   }
>   
> @@ -587,7 +586,6 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>   				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
>   				 MMC_CAP_CMD_DURING_TFR |
>   				 MMC_CAP_WAIT_WHILE_BUSY;
> -	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
>   	slot->hw_reset = sdhci_pci_int_hw_reset;
>   	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BSW_EMMC)
>   		slot->host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 9209f95..c81380a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -287,7 +287,6 @@ struct mmc_host {
>   #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
>   #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
>   				 MMC_CAP2_HS200_1_2V_SDR)
> -#define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
>   #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
>   #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
>   #define MMC_CAP2_PACKED_RD	(1 << 12)	/* Allow packed read */
> 

