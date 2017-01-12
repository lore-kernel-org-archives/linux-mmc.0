From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v5] mmc: sdhci-pci: Add support for HS200 tuning mode on
 AMD eMMC-4.5.1
Date: Thu, 12 Jan 2017 09:45:20 +0200
Message-ID: <f3e1a690-5118-9301-4fb9-3e10add5d79e@intel.com>
References: <8882eda8-6669-3061-4cce-b1b5dfda9c84@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19282 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdALHud (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Jan 2017 02:50:33 -0500
In-Reply-To: <8882eda8-6669-3061-4cce-b1b5dfda9c84@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

On 10/01/17 12:09, Shyam Sundar S K wrote:
> This patch adds support for HS200 tuning mode on AMD eMMC-4.5.1
> 
> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> Reviewed-by: Agrawal, Nitesh-kumar <Nitesh-kumar.Agrawal@amd.com>
> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>

There are just a few minor details left below.

> ---
> 
> Changes since v1: (https://patchwork.kernel.org/patch/9429071/)
>  * Reworked on review comments received which has the following:
>    -> Removed the amd_tuning_descriptor struct and amd_find_good_phase()
>       and handled the tuning changes in amd_execute_tuning().
>    -> Fix some alignment problems.
>    -> Defined macros for registers and bit fields used.
>    -> removed mdelay and used msleep
> 
> Changes since v2: (https://patchwork.kernel.org/patch/9469247/)
>  * Resubmitted the v1 patch by removing unused variables.
> 
> Changes since v3: (https://patchwork.kernel.org/patch/9469571/)
>  * Adding a changelog description and resubmitting the changes made in v2
> 
> Changes since v4: (https://patchwork.kernel.org/patch/9470185/)
>  * Changed the amd_execute_tuning logic as per Adrian suggestions and
>    addressed the comments received
> 
>  drivers/mmc/host/sdhci-pci-core.c | 103 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 1a72d32..b9899d0 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -866,11 +866,98 @@ enum amd_chipset_gen {
>  	AMD_CHIPSET_UNKNOWN,
>  };
> 
> +/* AMD registers */
> +#define AMD_SD_AUTO_PATTERN		0xB8
> +#define AMD_MSLEEP_DURATION		4
> +#define AMD_SD_MISC_CONTROL		0xD0
> +#define AMD_MAX_TUNE_VALUE		0x0B
> +#define AMD_AUTO_TUNE_SEL		0x10800
> +#define AMD_FIFO_PTR			0x30
> +#define AMD_BIT_MASK			0x1F
> +
> +static int amd_tuning_reset(struct sdhci_host *host)

Should return void

> +{
> +	unsigned int val;
> +
> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	val |= SDHCI_CTRL_PRESET_VAL_ENABLE | SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	val &= ~SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +
> +	return 0;
> +}
> +
> +static int amd_config_tuning_phase(struct sdhci_host *host, u8 phase)

Should return void and take pdev as a parameter i.e.

static void amd_config_tuning_phase(struct pci_dev *pdev, u8 phase)

> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	unsigned int val;
> +
> +	pci_read_config_dword(pdev, AMD_SD_AUTO_PATTERN, &val);
> +	val &= ~AMD_BIT_MASK;
> +	val |= (AMD_AUTO_TUNE_SEL | (phase << 1));
> +	pci_write_config_dword(pdev, AMD_SD_AUTO_PATTERN, val);
> +
> +	return 0;
> +}
> +
> +static int amd_enable_manual_tuning(struct sdhci_pci_slot *slot)

Should return void and take pdev as a parameter i.e.

static void amd_enable_manual_tuning(struct pci_dev *pdev)

> +{
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	unsigned int val;
> +
> +	pci_read_config_dword(pdev, AMD_SD_MISC_CONTROL, &val);
> +	val |= AMD_FIFO_PTR;
> +	pci_write_config_dword(pdev, AMD_SD_MISC_CONTROL, val);
> +
> +	return 0;
> +}
> +
> +static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);

Get pdev here and pass it to the functions that use it.

	struct pci_dev *pdev = slot->chip->pdev;

> +	u8 valid_win = 0;
> +	u8 valid_win_max = 0;
> +	u8 valid_win_end = 0;
> +	u8 ctrl, tune_around;
> +
> +	amd_tuning_reset(host);
> +
> +	for (tune_around = 0; tune_around < 12; tune_around++) {
> +		amd_config_tuning_phase(host, tune_around);
> +
> +		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> +			valid_win = 0;
> +			msleep(AMD_MSLEEP_DURATION);
> +			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> +			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
> +		} else if (++valid_win > valid_win_max) {
> +			valid_win_max = valid_win;
> +			valid_win_end = tune_around;
> +		}
> +	}
> +
> +	if (!valid_win_max) {
> +		dev_err(&slot->chip->pdev->dev, "no tuning point found\n");

Then this can be

		dev_err(&pdev->dev, "no tuning point found\n");


> +		return -EIO;
> +	}
> +
> +	amd_config_tuning_phase(host, valid_win_end - valid_win_max / 2);
> +
> +	amd_enable_manual_tuning(slot);
> +
> +	host->mmc->retune_period = 0;
> +
> +	return 0;
> +}
> +
>  static int amd_probe(struct sdhci_pci_chip *chip)
>  {
>  	struct pci_dev	*smbus_dev;
>  	enum amd_chipset_gen gen;
> -

Please don't remove this blank line.

>  	smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
>  			PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
>  	if (smbus_dev) {
> @@ -888,16 +975,24 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>  		}
>  	}
> 
> -	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
> +	if (gen == AMD_CHIPSET_BEFORE_ML || gen == AMD_CHIPSET_CZ)
>  		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
> -		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> -	}
> 
>  	return 0;
>  }
> 
> +static const struct sdhci_ops amd_sdhci_pci_ops = {
> +	.set_clock			= sdhci_set_clock,
> +	.enable_dma			= sdhci_pci_enable_dma,
> +	.set_bus_width			= sdhci_pci_set_bus_width,
> +	.reset				= sdhci_reset,
> +	.set_uhs_signaling		= sdhci_set_uhs_signaling,
> +	.platform_execute_tuning	= amd_execute_tuning,
> +};
> +
>  static const struct sdhci_pci_fixes sdhci_amd = {
>  	.probe		= amd_probe,
> +	.ops		= &amd_sdhci_pci_ops,
>  };
> 
>  static const struct pci_device_id pci_ids[] = {
> 

