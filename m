From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci: Add support for HS200 tuning mode on
 AMD, eMMC-4.5.1
Date: Mon, 12 Dec 2016 09:17:07 +0200
Message-ID: <3dced9c9-2cd7-d80a-6744-c6adb0f54d9c@intel.com>
References: <e699ed9f-4711-cfe8-1153-998ae0fcc9eb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:33276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbcLLHWN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Dec 2016 02:22:13 -0500
In-Reply-To: <e699ed9f-4711-cfe8-1153-998ae0fcc9eb@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

On 11/12/16 04:41, Shyam Sundar S K wrote:
> This patch adds support for HS200 tuning mode on AMD eMMC-4.5.1
> 
> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> Reviewed-by: Agrawal, Nitesh-kumar <Nitesh-kumar.Agrawal@amd.com>
> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> ---

Patches should come with an explanation of what changed since the last
submission.  You can put that here, after the "---" line or in a covering
email.  For example, look at the "Changes since v1" here:

	https://marc.info/?l=linux-mmc&m=148035476707192&w=2


>  drivers/mmc/host/sdhci-pci-core.c | 152 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 149 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 1d9e00a..c2a8da4 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -817,6 +817,140 @@ enum amd_chipset_gen {
>  	AMD_CHIPSET_UNKNOWN,
>  };
> 
> +/* AMD registers */
> +#define AMD_SD_AUTO_PATTERN		(0xB8)
> +#define AMD_MSLEEP_DURATION		(4)
> +#define AMD_SD_MISC_CONTROL		(0xD0)
> +#define AMD_MAX_TUNE_VALUE		(0x0B)
> +#define AMD_AUTO_TUNE_SEL		(0x10800)
> +#define AMD_FIFO_PTR			(0x30)
> +#define AMD_BIT_MASK			(0x1F)
> +
> +static int amd_tuning_reset(struct sdhci_host *host)
> +{
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	val |= SDHCI_CTRL_PRESET_VAL_ENABLE | SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	val &= ~SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int amd_config_tuning_phase(struct sdhci_host *host, u8 phase)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	pci_read_config_dword(pdev, AMD_SD_AUTO_PATTERN, &val);
> +	val &= ~AMD_BIT_MASK;
> +	val |= (AMD_AUTO_TUNE_SEL | (phase << 1));
> +	pci_write_config_dword(pdev, AMD_SD_AUTO_PATTERN, val);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int amd_enable_manual_tuning(struct sdhci_pci_slot *slot)
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
> +	u8 ctrl, tune_around, valid_f = 0, valid_win_max = 0;
> +	u8 tune_low_max = 0, tune_low = 0, valid_win = 0, tune_res = 0;
> +	bool this_tune_ok = 0, last_tune_ok = 0;
> +
> +	amd_tuning_reset(host);
> +
> +	/*********************************************************************/
> +	/* Enabling Software Tuning */
> +	/********************************************************************/
> +	/* 1. First switch the eMMC to HS200 Mode
> +	 * 2. Prepare the registers by using the sampling clock select
> +	 * 3. Send the CMD21 12 times with block length of 64 bytes
> +	 * 4. Everytime change the clk phase and check for CRC error
> +	 *	(CMD and DATA),if error, soft reset the CMD and DATA line
> +	 * 5. Calculate the window and set the clock phase.
> +	 */
> +
> +	for (tune_around = 0; tune_around < 12; tune_around++) {
> +		amd_config_tuning_phase(host, tune_around);
> +
> +		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> +			this_tune_ok = false;
> +			host->mmc->need_retune = 0;
> +			msleep(AMD_MSLEEP_DURATION);
> +			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> +			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
> +		} else {
> +			this_tune_ok = true;
> +			valid_f += 1;
> +		}
> +
> +		/* find good phase */
> +		if ((!this_tune_ok && last_tune_ok) || (tune_around == 11)) {
> +			if (valid_win > valid_win_max) {
> +				valid_win_max = valid_win;
> +				tune_low_max = tune_low;
> +			}
> +		}
> +
> +		if (this_tune_ok && (!last_tune_ok))
> +			tune_low = tune_around;
> +		if (!this_tune_ok && last_tune_ok)
> +			valid_win = 0;
> +		else if (this_tune_ok)
> +			valid_win += 1;
> +
> +		last_tune_ok = this_tune_ok;
> +
> +		if (tune_around == 11) {
> +			if ((valid_f + valid_win) > valid_win_max) {
> +				if (valid_f > valid_win)
> +					tune_res = ((valid_f - valid_win) >> 1);
> +				else
> +					tune_res = tune_low + ((valid_win +
> +								valid_f) >> 1);
> +			} else {
> +				tune_res = tune_low_max + (valid_win_max >> 1);
> +			}
> +
> +			if (tune_res > AMD_MAX_TUNE_VALUE)
> +				tune_res = AMD_MAX_TUNE_VALUE;
> +
> +			amd_config_tuning_phase(host, tune_res);
> +		}
> +	}
> +	host->mmc->retune_period = 0;
> +
> +	amd_enable_manual_tuning(slot);
> +	return 0;
> +}
> +
>  static int amd_probe(struct sdhci_pci_chip *chip)
>  {
>  	struct pci_dev	*smbus_dev;
> @@ -839,16 +973,17 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>  		}
>  	}
> 
> -	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
> +	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ))
>  		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
> -		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> -	}
> 
>  	return 0;
>  }
> 
> +static const struct sdhci_ops amd_sdhci_pci_ops;
> +
>  static const struct sdhci_pci_fixes sdhci_amd = {
>  	.probe		= amd_probe,
> +	.ops		= &amd_sdhci_pci_ops,
>  };
> 
>  static const struct pci_device_id pci_ids[] = {
> @@ -1469,6 +1604,17 @@ static const struct sdhci_ops sdhci_pci_ops = {
>  	.select_drive_strength	= sdhci_pci_select_drive_strength,
>  };
> 
> +static const struct sdhci_ops amd_sdhci_pci_ops = {
> +	.set_clock			= sdhci_set_clock,
> +	.enable_dma			= sdhci_pci_enable_dma,
> +	.set_bus_width			= sdhci_pci_set_bus_width,
> +	.reset				= sdhci_reset,
> +	.set_uhs_signaling		= sdhci_set_uhs_signaling,
> +	.hw_reset			= sdhci_pci_hw_reset,
> +	.select_drive_strength		= sdhci_pci_select_drive_strength,
> +	.platform_execute_tuning	= amd_execute_tuning,
> +};
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Suspend/resume                                                            *
> 

