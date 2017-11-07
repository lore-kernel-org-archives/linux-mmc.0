From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Add support for ACPI HID of AMD
 Controller with HS400
Date: Tue, 7 Nov 2017 11:24:56 +0200
Message-ID: <f67d8250-4455-d797-f9f6-1d27024b33ae@intel.com>
References: <1507803468-26313-1-git-send-email-Nehal-bakulchandra.Shah@amd.com>
 <83dfe4d0-8084-e1b5-0d87-ff42c3e5ca4c@amd.com>
 <c53c41c5-3d17-e6c4-5219-9d16c7a7f4b9@intel.com>
 <95f094fa-0121-f848-d210-05614b91429e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16403 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932873AbdKGJZK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Nov 2017 04:25:10 -0500
In-Reply-To: <95f094fa-0121-f848-d210-05614b91429e@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shah, Nehal-bakulchandra" <Nehal-Bakulchandra.shah@amd.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, sandeep.singh@amd.com, Nitesh-kumar.Agrawal@amd.com

On 03/11/17 11:23, Shah, Nehal-bakulchandra wrote:
> Hi Adrian 
> 
> On 10/19/2017 3:32 PM, Adrian Hunter wrote:
>> On 12/10/17 13:32, Shah, Nehal-bakulchandra wrote:
>>> From: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>>>
>>> This patch supports HS400 for AMD upcoming emmc 5.0 controller.The
>>> HS400 and HS200 mode requires hardware work around also. This patch
>>> adds the quirks for the same.
>>>
>>> Signed-off-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>>
>> This is V2 of this patch.  In future, please put the version number in the
>> subject and describe the changes since the previous version in a cover email
>> or after the "---" below.
>>
>>> ---
>>>  drivers/mmc/core/mmc.c        |  6 +--
>>>  drivers/mmc/host/sdhci-acpi.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci.c      |  3 +-
>>>  drivers/mmc/host/sdhci.h      |  5 +++
>>>  include/linux/mmc/host.h      |  6 +++
>>>  5 files changed, 105 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 4ffea14..7bf3736 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1164,7 +1164,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>>>  
>>>  	/* Set host controller to HS timing */
>>>  	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>>> -
>>> +	host->ios.transition = HS200_TO_HS_TO_HS400;
>>>  	/* Reduce frequency to HS frequency */
>>>  	max_dtr = card->ext_csd.hs_max_dtr;
>>>  	mmc_set_clock(host, max_dtr);
>>> @@ -1196,7 +1196,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>>>  			 mmc_hostname(host), err);
>>>  		return err;
>>>  	}
>>> -
>>> +	host->ios.transition = SWITCHING_TO_HS400;
>>>  	/* Set host controller to HS400 timing and frequency */
>>>  	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>>>  	mmc_set_bus_speed(card);
>>> @@ -1204,7 +1204,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>>>  	err = mmc_switch_status(card);
>>>  	if (err)
>>>  		goto out_err;
>>> -
>>> +	host->ios.transition = SWITCHED_TO_HS400;
>>>  	return 0;
>>>  
>>>  out_err:
>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>> index ac678e9..a3456be 100644
>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>> @@ -89,6 +89,47 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
>>>  	return c->slot && (c->slot->flags & flag);
>>>  }
>>>  
>>> + /*AMD Driver Strength function*/
>>
>> This comment is redundant - please omit it.
>>
>>> +
>>> +static int amd_select_drive_strength(struct mmc_card *card,
>>> +				     unsigned int max_dtr, int host_drv,
>>> +				     int card_drv, int *drv_type)
>>> +{
>>> +	return MMC_SET_DRIVER_TYPE_A;
>>> +}
>>> +
>>> +static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
>>> +{
>>> +	/*AMD Platform requires dll setting*/
>>> +	sdhci_writel(host, 0x40003210, SDHCI_AMD_REST_DLL_REGISTER);
>>> +	usleep_range(10, 20);
>>> +	sdhci_writel(host, 0x40033210, SDHCI_AMD_REST_DLL_REGISTER);
>>> +}
>>> +
>>> +/*
>>> + * For AMD Platform it is required to disable the tuning
>>> + * bit first controller to bring to HS Mode from HS200
>>> + * mode, later enable to tune to HS400 mode.
>>> + */
>>> +
>>
>> Why can't you hook ->set_ios() e.g.
>>
>> 	host->mmc_host_ops.set_ios = amd_set_ios;
>>
>> static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> {
>> 	sdhci_set_ios(mmc, ios);
>>
>> 	if (ios->timing == MMC_TIMING_MMC_HS400) {
>> 		sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
>> 		sdhci_acpi_amd_hs400_dll(host);
>> 	}
>> }
>>
>>
>>> +static void sdhci_amd_set_hs400_transition(struct sdhci_host *host)
>>> +{
>>> +	switch (host->mmc->ios.transition) {
>>> +	case HS200_TO_HS_TO_HS400:
>>> +		sdhci_writew(host, 0x9, SDHCI_HOST_CONTROL2);
>>
>> Maybe better to just change the bits in SDHCI_HOST_CONTROL2 that you need
>> and leave the other bits alone.
>>
>> We know when we do tuning whether it is for HS400, so maybe you could hook
>> ->execute_tuning() for this e.g.
>>
>> 	host->mmc_host_ops.execute_tuning = amd_execute_tuning;
>>
>> static int amd_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> {
>> 	bool hs400_tuning = host->flags & SDHCI_HS400_TUNING;
>> 	int err;
>>
>> 	err = sdhci_execute_tuning(mmc, opcode);
>> 	if (err)
>> 		return err;
>>
>> 	/* Disable tuning during switch to HS400 */
>> 	if (hs400_tuning)
>> 		sdhci_writew(host, 0x9, SDHCI_HOST_CONTROL2);
>> }
>>
>>> +		break;
>>> +
>>> +	case SWITCHING_TO_HS400:
>>
>> This case is always ios->timing == MMC_TIMING_MMC_HS400 so you don't need
>> the ios.transition for this
>>
>>> +		sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
>>
>> Maybe better to just change the bits in SDHCI_HOST_CONTROL2 that you need
>> and leave the other bits alone.
>>
>>> +		sdhci_acpi_amd_hs400_dll(host);
>>> +		break;
>>> +
>>> +	case SWITCHED_TO_HS400:
>>> +	default:
>>> +		break;
>>> +	}
>>> +}
>>> +
> Liked your suggestions and tried but doesn't work.Because The changes are required in transition phase i.e in case of switching to HS400 just after "mmc_set_timing(card->host, MMC_TIMING_MMC_HS)" call so these changes are intermediate as we have issue with the IP. Now Hooking with execute_tuning makes the functionality non working as execute_tuning gets called before. So is there any better way to handle intermediate transition? Can you please suggest. So instead of using execute_tuning hook up can be done in set_ios however still it requires the transition cases. Something like this

But what about below:

> 
> static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> {
>         struct sdhci_host *host = mmc_priv(mmc);

	unsigned old_timing = host->timing;

>         sdhci_set_ios(mmc, ios);
> 
> 
>        switch (host->mmc->ios.transition) {
>        case HS200_TO_HS_TO_HS400:

	if (old_timing == MMC_TIMING_MMC_HS200 &&
	    ios->timing == MMC_TIMING_SD_HS)

If you want to know if this is the HS400 case, you could record whether the
SDHCI_HS400_TUNING flag was set during tuning.

>        {
>            printk(KERN_ERR "Sandeep transition HS200 to HS to HS400 \n");
>            sdhci_writew(host, 0x9, SDHCI_HOST_CONTROL2);
>        }
>        break;
> 
>        case SWITCHING_TO_HS400:

	if (old_timing != MMC_TIMING_MMC_HS400 &&
	    ios->timing == MMC_TIMING_MMC_HS400)

>        {
> 
>         printk(KERN_ERR "Sandeep transition Switching to HS400 \n");
>                sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
> 
>                sdhci_acpi_amd_hs400_dll(host);
>        }
>        break;
> 
>        case SWITCHED_TO_HS400:
>        default:
>        break;
>        }
> 
> }
