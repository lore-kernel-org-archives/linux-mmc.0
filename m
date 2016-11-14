From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: Add support for HS200 tuning mode on
 AMD, eMMC-4.5.1
Date: Mon, 14 Nov 2016 15:37:54 +0200
Message-ID: <74277e4d-98ee-fc9b-2363-26e207170806@intel.com>
References: <49d59018-a294-9cea-b92c-f74935314dc8@amd.com>
 <5fed9224-f843-fbd4-6ae6-fd0708bc6c98@intel.com>
 <dbebff7a-d144-9dc5-6e59-3a39274ee21d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39404 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbcKNNmw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Nov 2016 08:42:52 -0500
In-Reply-To: <dbebff7a-d144-9dc5-6e59-3a39274ee21d@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>

On 14/11/16 08:38, Shyam Sundar S K wrote:
> 
> 
> On 11/11/2016 6:11 PM, Adrian Hunter wrote:
>> On 10/11/16 14:51, Shyam Sundar S K wrote:
>>> This patch adds support for HS200 tuning mode on AMD eMMC-4.5.1
>>>
>>> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
>>> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>>> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
>>> ---
>>>  drivers/mmc/host/sdhci-pci-core.c | 178 +++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 177 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index 782c8d2..9576f82 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -817,6 +817,171 @@ enum amd_chipset_gen {
>>>  	AMD_CHIPSET_UNKNOWN,
>>>  };
>>>
>>> +static const struct sdhci_ops amd_sdhci_pci_ops;
>>> +
>>> +struct amd_tuning_descriptor {
>>> +	u8 tune_around;
>>> +	bool this_tune_ok;
>>> +	bool last_tune_ok;
>>> +	u8 valid_front;
>>> +	u8 valid_window_max;
>>> +	u8 tune_low_max;
>>> +	u8 tune_low;
>>> +	u8 valid_window;
>>> +	u8 tune_result;
>>> +};
>>> +
>>> +static int amd_tuning_reset(struct sdhci_host *host)
>>> +{
>>> +	unsigned int val;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&host->lock, flags);
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
>>> +
>>> +	pci_read_config_dword(pdev, 0xb8, &val);
>>> +	val &= ~0x1f;
>>> +	val |= (0x10800 | (phase << 1));
>>> +	pci_write_config_dword(pdev, 0xb8, val);
>>> +
>>> +	spin_unlock_irqrestore(&host->lock, flags);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int amd_find_good_phase(struct sdhci_host *host)
>>> +{
>>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>> +	struct pci_dev *pdev = slot->chip->pdev;
>>> +	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
>>> +
>>> +	unsigned int val;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&host->lock, flags);
>>> +
>>> +	if (td->this_tune_ok)
>>> +		td->valid_front += 1;
>>> +	if ((!td->this_tune_ok && td->last_tune_ok) ||
>>> +	    (td->tune_around == 11)) {
>>> +		if (td->valid_window > td->valid_window_max) {
>>> +			td->valid_window_max = td->valid_window;
>>> +			td->tune_low_max = td->tune_low;
>>> +		}
>>> +	}
>>> +	if (td->this_tune_ok && (!td->last_tune_ok))
>>> +		td->tune_low = td->tune_around;
>>> +	if (!td->this_tune_ok && td->last_tune_ok)
>>> +		td->valid_window = 0;
>>> +	else if (td->this_tune_ok)
>>> +		td->valid_window += 1;
>>> +
>>> +	td->last_tune_ok = td->this_tune_ok;
>>> +
>>> +	if (td->tune_around == 11) {
>>> +		if ((td->valid_front + td->valid_window) >
>>> +						td->valid_window_max) {
>>> +			if (td->valid_front > td->valid_window)
>>> +				td->tune_result = ((td->valid_front -
>>> +						td->valid_window) >> 1);
>>> +			else
>>> +				td->tune_result = td->tune_low +
>>> +				((td->valid_window + td->valid_front) >> 1);
>>> +		} else {
>>> +			td->tune_result = td->tune_low_max +
>>> +					(td->valid_window_max >> 1);
>>> +		}
>>> +
>>> +		if (td->tune_result > 0x0b)
>>> +			td->tune_result = 0x0b;
>>> +
>>> +		pci_read_config_dword(pdev, 0xb8, &val);
>>> +		val &= ~0x1f;
>>> +		val |= (0x10800 | (td->tune_result << 1));
>>> +		pci_write_config_dword(pdev, 0xb8, val);
>>> +	}
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
>>> +	pci_read_config_dword(pdev, 0xd0, &val);
>>> +	val &= 0xffffffcf;
>>> +	val |= 0x30;
>>> +	pci_write_config_dword(pdev, 0xd0, val);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
>>> +{
>>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>> +	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
>>> +	u8 ctrl;
>>> +
>>> +	amd_tuning_reset(host);
>>> +	memset(td, 0, sizeof(struct amd_tuning_descriptor));
>>
>> I didn't notice last time that you are always clearing all the values in the
>> tuning descriptor, so it doesn't need to be kept between calls to
>> amd_execute_tuning().  So it should be a local variable that you pass to the
>> functions that need it.  Then you don't need the patch I sent at all.
>>
>> Does that make sense?
>>
> 
> Hi Adrian,
> 
> Thanks for pointing this out. Your patch will help, so will remove the memset()
> and redo the submission. Is this OK ?

Sure

