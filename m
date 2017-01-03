From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] mmc: sdhci-pci: Add support for HS200 tuning mode on
 AMD eMMC-4.5.1
Date: Tue, 3 Jan 2017 14:19:59 +0200
Message-ID: <0d3b2668-00ab-aa18-73da-b79cdec42900@intel.com>
References: <f2409173-92c9-406b-a90b-44537dc11e15@amd.com>
 <211ffd26-554d-9e94-6a57-c41814216cdf@intel.com>
 <7b4a85a3-d1c1-6c6a-3071-14e7958a9fef@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20532 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757302AbdACMZK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Jan 2017 07:25:10 -0500
In-Reply-To: <7b4a85a3-d1c1-6c6a-3071-14e7958a9fef@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

On 03/01/17 13:50, Shyam Sundar S K wrote:
> 
> 
> On 1/3/2017 3:42 PM, Adrian Hunter wrote:
>> On 12/12/16 11:03, Shyam Sundar S K wrote:
>>> This patch adds support for HS200 tuning mode on AMD eMMC-4.5.1
>>>
>>> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
>>> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>>> Reviewed-by: Agrawal, Nitesh-kumar <Nitesh-kumar.Agrawal@amd.com>
>>> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
>>> ---
>>>
>>> Changes since v1: (https://patchwork.kernel.org/patch/9429071/)
>>>  * Reworked on review comments received which has the following:
>>>    -> Removed the amd_tuning_descriptor struct and amd_find_good_phase()
>>>       and handled the tuning changes in amd_execute_tuning().
>>>    -> Fix some alignment problems.
>>>    -> Defined macros for registers and bit fields used.
>>>    -> removed mdelay and used msleep
>>>
>>>
>>> Changes since v2: (https://patchwork.kernel.org/patch/9469247/)
>>>  * Resubmitted the v1 patch by removing unused variables.
>>>
>>> Changes in v3: (https://patchwork.kernel.org/patch/9469571/)
>>>  * Adding a changelog description and resubmitting the changes made in v2
>>>
>>>  drivers/mmc/host/sdhci-pci-core.c | 152 +++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 149 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index 1d9e00a..c2a8da4 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -817,6 +817,140 @@ enum amd_chipset_gen {
>>>  	AMD_CHIPSET_UNKNOWN,
>>>  };
>>>
>>> +/* AMD registers */
>>> +#define AMD_SD_AUTO_PATTERN		(0xB8)
>>> +#define AMD_MSLEEP_DURATION		(4)
>>> +#define AMD_SD_MISC_CONTROL		(0xD0)
>>> +#define AMD_MAX_TUNE_VALUE		(0x0B)
>>> +#define AMD_AUTO_TUNE_SEL		(0x10800)
>>> +#define AMD_FIFO_PTR			(0x30)
>>> +#define AMD_BIT_MASK			(0x1F)
>>
>> The parentheses are not needed.  Please remove them.
> 
> I feel this is a good practice to keep within the brackets. If you still insist to remove it, I will resubmit the patch.

It is not common in the kernel.  Please remove.

>>
>>> +
>>> +static int amd_tuning_reset(struct sdhci_host *host)
>>> +{
>>> +	unsigned int val;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&host->lock, flags);
>>
>> sdhci makes too much use of the spin lock.  Please correct me if I am wrong
>> but I don't see how it is needed here, so remove the locking.
>>
>>> +
>>> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +	val |= SDHCI_CTRL_PRESET_VAL_ENABLE | SDHCI_CTRL_EXEC_TUNING;
>>> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
>>> +
>>> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +	val &= ~SDHCI_CTRL_EXEC_TUNING;
>>> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
>>> +
>>> +	spin_unlock_irqrestore(&host->lock, flags);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int amd_config_tuning_phase(struct sdhci_host *host, u8 phase)
>>> +{
>>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>> +	struct pci_dev *pdev = slot->chip->pdev;
>>> +	unsigned int val;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&host->lock, flags);
>>
>> Ditto wrt locking.
>>
>>> +
>>> +	pci_read_config_dword(pdev, AMD_SD_AUTO_PATTERN, &val);
>>> +	val &= ~AMD_BIT_MASK;
>>> +	val |= (AMD_AUTO_TUNE_SEL | (phase << 1));
>>> +	pci_write_config_dword(pdev, AMD_SD_AUTO_PATTERN, val);
>>> +
>>> +	spin_unlock_irqrestore(&host->lock, flags);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int amd_enable_manual_tuning(struct sdhci_pci_slot *slot)
>>> +{
>>> +	struct pci_dev *pdev = slot->chip->pdev;
>>> +	unsigned int val;
>>> +
>>> +	pci_read_config_dword(pdev, AMD_SD_MISC_CONTROL, &val);
>>> +	val |= AMD_FIFO_PTR;
>>> +	pci_write_config_dword(pdev, AMD_SD_MISC_CONTROL, val);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
>>> +{
>>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>> +	u8 ctrl, tune_around, valid_f = 0, valid_win_max = 0;
>>> +	u8 tune_low_max = 0, tune_low = 0, valid_win = 0, tune_res = 0;
>>> +	bool this_tune_ok = 0, last_tune_ok = 0;
>>
>> Use "false" instead of 0 for the bools.
>>
>>> +
>>> +	amd_tuning_reset(host);
>>> +
>>> +	/*********************************************************************/
>>> +	/* Enabling Software Tuning */
>>> +	/********************************************************************/
>>> +	/* 1. First switch the eMMC to HS200 Mode
>>> +	 * 2. Prepare the registers by using the sampling clock select
>>> +	 * 3. Send the CMD21 12 times with block length of 64 bytes
>>> +	 * 4. Everytime change the clk phase and check for CRC error
>>> +	 *	(CMD and DATA),if error, soft reset the CMD and DATA line
>>> +	 * 5. Calculate the window and set the clock phase.
>>> +	 */
>>
>> Do we really need this comment.  I think the code speaks for itself.
> 
> The algorithm details were added based on the feedback from you for the earlier submission which I made :-)
> 
> "Please consider adding some explanation of the tuning algorithm
> and defining some of the constants."
> 
> I am not really sure, why this needs to be removed now.

Did I, sorry.  But as we get the code into shape, what it is doing becomes
increasingly obvious and decreasingly in need of further explanation.

> 
>>
>> You could say something about whether you support tuning for SD cards,
>> or do you know this host controller is only used for eMMC?
>>
>>> +
>>> +	for (tune_around = 0; tune_around < 12; tune_around++) {
>>> +		amd_config_tuning_phase(host, tune_around);
>>> +
>>> +		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
>>> +			this_tune_ok = false;
>>> +			host->mmc->need_retune = 0;
>>
>> You should not need to change host->mmc->need_retune.  It will
>> be zero anyway.
>>
>>> +			msleep(AMD_MSLEEP_DURATION);
>>> +			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
>>> +			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
>>
>> Are you sure you don't have to wait for the reset to complete?
>>
>>> +		} else {
>>> +			this_tune_ok = true;
>>> +			valid_f += 1;
>>> +		}
>>> +
>>> +		/* find good phase */
>>> +		if ((!this_tune_ok && last_tune_ok) || (tune_around == 11)) {
>>> +			if (valid_win > valid_win_max) {
>>> +				valid_win_max = valid_win;
>>> +				tune_low_max = tune_low;
>>> +			}
>>> +		}
>>> +
>>> +		if (this_tune_ok && (!last_tune_ok))
>>> +			tune_low = tune_around;
>>> +		if (!this_tune_ok && last_tune_ok)
>>> +			valid_win = 0;
>>> +		else if (this_tune_ok)
>>> +			valid_win += 1;
>>> +
>>> +		last_tune_ok = this_tune_ok;
>>> +
>>> +		if (tune_around == 11) {
>>
>> So this code really belongs after the loop.  But really the logic
>> looks overly complicated.  If all you are doing is finding the centre
>> of the biggest valid window, then the logic should be more like this:
>>
> 
> Is it possible to take this patch as-is without affecting the current logic of amd_execute_tuning ?
> Can we take up the optimization of the logic in the next submission ?

So below is what you are trying to do?  I would much prefer to have code
that is understandable.

> 
>>
>> static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
>> {
>> 	struct sdhci_pci_slot *slot = sdhci_priv(host);
>> 	int valid_win = 0;
>> 	int valid_win_max = 0;
>> 	int valid_win_end = 0;
>>
>> 	amd_tuning_reset(host);
>>
>> 	for (tune_around = 0; tune_around < 12; tune_around++) {
>> 		amd_config_tuning_phase(host, tune_around);
>>
>> 		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
>> 			valid_win = 0;
>> 			msleep(AMD_MSLEEP_DURATION);
>> 			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
>> 			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
>> 		} else if (++valid_win > valid_win_max)
>> 			valid_win_max = valid_win;
>> 			valid_win_end = tune_around;
>> 		}
>> 	}
>>
>> 	if (!valid_win_max) {
>> 		dev_err(&slot->chip->pdev->dev,
>> 			"no tuning point found\n");
>> 		return -EIO;
>> 	}
>>
>> 	amd_config_tuning_phase(host, valid_win_end - valid_win_max / 2);
>>
>> 	amd_enable_manual_tuning(slot);
>>
>> 	host->mmc->retune_period = 0;
>>
>> 	return 0;
>> }
>>
>>> +			if ((valid_f + valid_win) > valid_win_max) {
>>> +				if (valid_f > valid_win)
>>> +					tune_res = ((valid_f - valid_win) >> 1);
>>> +				else
>>> +					tune_res = tune_low + ((valid_win +
>>> +								valid_f) >> 1);
>>> +			} else {
>>> +				tune_res = tune_low_max + (valid_win_max >> 1);
>>> +			}
>>> +
>>> +			if (tune_res > AMD_MAX_TUNE_VALUE)
>>> +				tune_res = AMD_MAX_TUNE_VALUE;
>>> +
>>> +			amd_config_tuning_phase(host, tune_res);
>>> +		}
>>> +	}
>>> +	host->mmc->retune_period = 0;
>>> +
>>> +	amd_enable_manual_tuning(slot);
>>> +	return 0;
>>> +}
>>> +
>>>  static int amd_probe(struct sdhci_pci_chip *chip)
>>>  {
>>>  	struct pci_dev	*smbus_dev;
>>> @@ -839,16 +973,17 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>>>  		}
>>>  	}
>>>
>>> -	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
>>> +	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ))
>>
>> Please remove the redundant ().
>>
>>>  		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
>>> -		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>>> -	}
>>>
>>>  	return 0;
>>>  }
>>>
>>> +static const struct sdhci_ops amd_sdhci_pci_ops;
>>
>> Please just put the definition of amd_sdhci_pci_ops here instead of the forward declaration.
>>
>>> +
>>>  static const struct sdhci_pci_fixes sdhci_amd = {
>>>  	.probe		= amd_probe,
>>> +	.ops		= &amd_sdhci_pci_ops,
>>>  };
>>>
>>>  static const struct pci_device_id pci_ids[] = {
>>> @@ -1469,6 +1604,17 @@ static const struct sdhci_ops sdhci_pci_ops = {
>>>  	.select_drive_strength	= sdhci_pci_select_drive_strength,
>>>  };
>>>
>>> +static const struct sdhci_ops amd_sdhci_pci_ops = {
>>> +	.set_clock			= sdhci_set_clock,
>>> +	.enable_dma			= sdhci_pci_enable_dma,
>>> +	.set_bus_width			= sdhci_pci_set_bus_width,
>>> +	.reset				= sdhci_reset,
>>> +	.set_uhs_signaling		= sdhci_set_uhs_signaling,
>>> +	.hw_reset			= sdhci_pci_hw_reset,
>>> +	.select_drive_strength		= sdhci_pci_select_drive_strength,
>>
>> You don't use select_drive_strength or hw_reset so you can leave those ones out.
>>
>>> +	.platform_execute_tuning	= amd_execute_tuning,
>>> +};
>>> +
>>>  /*****************************************************************************\
>>>   *                                                                           *
>>>   * Suspend/resume                                                            *
>>>
>>
> 
> If you are okay with above comments, for remaining comments I will resubmit the patch. Hopefully that will be having all the
> review comments incorporated :-) We would like to have this patch as early as possible to mainline.

If we act promptly there should be plenty of time to get this in the next
kernel release. i.e. v4.11

