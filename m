From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: Add support for HS200 tuning mode on
 AMD eMMC-4.5.1
Date: Wed, 16 Nov 2016 14:01:05 +0200
Message-ID: <9edba1b9-638d-c8a3-ad3f-43b4635eeb8e@intel.com>
References: <13d2d300-de73-cdc8-3d3a-1fdc2cfcd205@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:18287 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbcKPMGD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Nov 2016 07:06:03 -0500
In-Reply-To: <13d2d300-de73-cdc8-3d3a-1fdc2cfcd205@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

On 15/11/16 08:57, Shyam Sundar S K wrote:
> This patch adds support for HS200 tuning mode on AMD eMMC-4.5.1
> 
> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 177 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 176 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 782c8d2..1a31bdf 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -817,6 +817,170 @@ enum amd_chipset_gen {
>  	AMD_CHIPSET_UNKNOWN,
>  };
> 
> +static const struct sdhci_ops amd_sdhci_pci_ops;

You shouldn't need this.  Just put amd_sdhci_pci_ops in the right place.

> +
> +struct amd_tuning_descriptor {
> +	u8 tune_around;
> +	bool this_tune_ok;
> +	bool last_tune_ok;
> +	u8 valid_front;
> +	u8 valid_window_max;
> +	u8 tune_low_max;
> +	u8 tune_low;
> +	u8 valid_window;
> +	u8 tune_result;
> +};
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
> +	pci_read_config_dword(pdev, 0xb8, &val);
> +	val &= ~0x1f;
> +	val |= (0x10800 | (phase << 1));
> +	pci_write_config_dword(pdev, 0xb8, val);

It wouldn't hurt to #define registers and bit fields.

> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int amd_find_good_phase(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
> +
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (td->this_tune_ok)
> +		td->valid_front += 1;

So now valid_front is never reset ?

> +	if ((!td->this_tune_ok && td->last_tune_ok) ||
> +	    (td->tune_around == 11)) {
> +		if (td->valid_window > td->valid_window_max) {
> +			td->valid_window_max = td->valid_window;
> +			td->tune_low_max = td->tune_low;
> +		}
> +	}
> +	if (td->this_tune_ok && (!td->last_tune_ok))
> +		td->tune_low = td->tune_around;
> +	if (!td->this_tune_ok && td->last_tune_ok)
> +		td->valid_window = 0;
> +	else if (td->this_tune_ok)
> +		td->valid_window += 1;
> +
> +	td->last_tune_ok = td->this_tune_ok;
> +
> +	if (td->tune_around == 11) {
> +		if ((td->valid_front + td->valid_window) >
> +						td->valid_window_max) {
> +			if (td->valid_front > td->valid_window)
> +				td->tune_result = ((td->valid_front -
> +						td->valid_window) >> 1);
> +			else
> +				td->tune_result = td->tune_low +
> +				((td->valid_window + td->valid_front) >> 1);
> +		} else {
> +			td->tune_result = td->tune_low_max +
> +					(td->valid_window_max >> 1);
> +		}

So tune_result doesn't need to be in amd_tuning_descriptor.

It is not at all obvious why you need to retain amd_tuning_descriptor
between calls to amd_execute_tuning.  Please explain.

> +
> +		if (td->tune_result > 0x0b)
> +			td->tune_result = 0x0b;
> +
> +		pci_read_config_dword(pdev, 0xb8, &val);
> +		val &= ~0x1f;
> +		val |= (0x10800 | (td->tune_result << 1));
> +		pci_write_config_dword(pdev, 0xb8, val);
> +	}
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
> +	pci_read_config_dword(pdev, 0xd0, &val);
> +	val &= 0xffffffcf;

No need to set the bits to 0 if you are then going to OR them with 1.
i.e. (val & 0xffffffcf) | 0x30 == val | 0x30

> +	val |= 0x30;
> +	pci_write_config_dword(pdev, 0xd0, val);
> +
> +	return 0;
> +}
> +
> +static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
> +	u8 ctrl;
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
> +	for (td->tune_around = 0; td->tune_around < 12; td->tune_around++) {

tune_around does not need to be in amd_tuning_descriptor

> +		amd_config_tuning_phase(host, td->tune_around);
> +
> +		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> +			td->this_tune_ok = false;
> +			host->mmc->need_retune = 0;
> +			mdelay(4);

Use msleep not mdelay

> +			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> +			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
> +		} else {
> +			td->this_tune_ok = true;

this_tune_ok does not need to be in amd_tuning_descriptor

> +		}
> +
> +		amd_find_good_phase(host);

Pass tune_around and this_tune_ok to amd_find_good_phase

> +	}
> +
> +	host->mmc->retune_period = 0;
> +
> +	amd_enable_manual_tuning(slot);
> +	return 0;
> +}
> +
>  static int amd_probe(struct sdhci_pci_chip *chip)
>  {
>  	struct pci_dev	*smbus_dev;
> @@ -841,7 +1005,6 @@ static int amd_probe(struct sdhci_pci_chip *chip)
> 
>  	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
>  		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
> -		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>  	}
> 
>  	return 0;
> @@ -849,6 +1012,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
> 

Put amd_sdhci_pci_ops here.

>  static const struct sdhci_pci_fixes sdhci_amd = {
>  	.probe		= amd_probe,
> +	.ops		= &amd_sdhci_pci_ops,

Need to define the private size i.e.

	.priv_size	= sizeof(struct amd_tuning_descriptor),

>  };
> 
>  static const struct pci_device_id pci_ids[] = {
> @@ -1469,6 +1633,17 @@ static const struct sdhci_ops sdhci_pci_ops = {
>  	.select_drive_strength	= sdhci_pci_select_drive_strength,
>  };
> 
> +static const struct sdhci_ops amd_sdhci_pci_ops = {
> +	.set_clock	= sdhci_set_clock,
> +	.enable_dma	= sdhci_pci_enable_dma,
> +	.set_bus_width	= sdhci_pci_set_bus_width,
> +	.reset		= sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.hw_reset		= sdhci_pci_hw_reset,
> +	.select_drive_strength	= sdhci_pci_select_drive_strength,
> +	.platform_execute_tuning = amd_execute_tuning,
> +};

Please try to line up the '='

> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Suspend/resume                                                            *
> 

