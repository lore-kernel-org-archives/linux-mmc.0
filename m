From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Mon, 19 Jan 2015 11:56:04 +0200
Message-ID: <54BCD4B4.1010703@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>	<54B51C55.9060500@intel.com>	<CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>	<54B52D53.8080106@intel.com>	<CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>	<54B53592.9070303@broadcom.com>	<CAPDyKFrs9SVt+8OSTHbkCFiY5ujdfXsqjg7E837CVZjEqz4EvA@mail.gmail.com>	<54B54187.7080008@broadcom.com>	<CAPDyKFqwQ+GPLv9T3fW3Y74hKhagKSOiXydvL9WoK8y3k0O6hQ@mail.gmail.com>	<54B63D94.2050602@intel.com>	<CAPDyKFosO9D6sQagk1nPRZ5aTMDhYu2P7Y5jzFUdA8gAcTNJog@mail.gmail.com>	<54B66015.1010507@intel.com>	<CAPDyKFrtByPeRvU-pSc62JjthRXQJyPkTR+PcNOSDeTPXwFEoA@mail.gmail.com>	<54B793B2.8090100@intel.com>	<CAPDyKFqAWR_L58=McCo0_GAUatm2373To8pduK+nV2cFZt8CnQ@mail.gmail.com>	<54B7C9A7.1090803@broadcom.com>	<54B
 7CBEB.9020404@broadcom.com>	<CAPDyKFp8gi=9O-2Cs9ewmYwqbvLLXsuTRKJZ-bDGavojPZSjCQ@mail.gmail.com>	<54B7D5EB.4050508@broadcom.com> <CAPDyKFrBX91htLFZB-ZUiL_T_x=e3A6KNb3LCq6P2GBFPZCsBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60224 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbbASJ5x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Jan 2015 04:57:53 -0500
In-Reply-To: <CAPDyKFrBX91htLFZB-ZUiL_T_x=e3A6KNb3LCq6P2GBFPZCsBQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arend van Spriel <arend@broadcom.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arindam Nath <arindam.nath@amd.com>

On 19/01/15 11:27, Ulf Hansson wrote:
> On 15 January 2015 at 15:59, Arend van Spriel <arend@broadcom.com> wrote:
>> On 01/15/15 15:46, Ulf Hansson wrote:
>>>
>>> On 15 January 2015 at 15:17, Arend van Spriel<arend@broadcom.com>  wrote:
>>>>
>>>> On 01/15/15 15:07, Arend van Spriel wrote:
>>>>>
>>>>>
>>>>> On 01/15/15 14:39, Ulf Hansson wrote:
>>>>>>
>>>>>>
>>>>>> On 15 January 2015 at 11:17, Adrian Hunter<adrian.hunter@intel.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 14/01/15 14:59, Ulf Hansson wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The value from the register is also just randomly selected, only
>>>>>>>>>> difference is that it's the HW that has randomly set it.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Presumably the value is chosen based on the maximum rate of
>>>>>>>>> temperature
>>>>>>>>> change and the corresponding effect that has on the signal.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Even if the above commit was merged, I don't think it was the
>>>>>>>>>> correct
>>>>>>>>>> way of dealing with re-tuning.
>>>>>>>>>>
>>>>>>>>>> First of all, re-tuning this is a mmc protocol specific thing
>>>>>>>>>> should
>>>>>>>>>> be managed from the mmc core, like the approach you have taken in
>>>>>>>>>> your
>>>>>>>>>> $subject patchset. Second I question whether the timer is useful at
>>>>>>>>>> all.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The SD Host Controller Specification does not document another way
>>>>>>>>> to do
>>>>>>>>> mode 1 re-tuning. The timer is it. Otherwise re-tuning is never
>>>>>>>>> done.
>>>>>>>>>
>>>>>>>>> In the patches I sent, the driver must call mmc_retune_needed() to
>>>>>>>>> set
>>>>>>>>> host->need_retune = 1 otherwise mmc_retune() does nothing.
>>>>>>>>>
>>>>>>>>> I would like to extend the model to include transparently re-tuning
>>>>>>>>> and
>>>>>>>>> re-trying when there is a CRC error, but that is a separate issue,
>>>>>>>>> not
>>>>>>>>> documented in the spec but recommended by others.
>>>>>>>>>
>>>>>>>>
>>>>>>>> That perfect and in line from what I heard as recommendations from
>>>>>>>> memory vendors as well.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> How would that work for SDIO? How do you know it is OK to retry SDIO
>>>>>>> operations?
>>>>>>
>>>>>>
>>>>>>
>>>>>> Retries or error handling, needs to be handled from SDIO func drivers
>>>>>> or upper level code. They certainly also need it for other errors,
>>>>>> which are not caused by the lack of a re-tune. I believe they exist
>>>>>> already.
>>>>>>
>>>>>> For mmc core point of view, we need to act on SDIO data transfers
>>>>>> errors and perform re-tuning for cases when it makes sense.
>>>>>>
>>>>>> More importantly, using a timer won't make SDIO data transfers error
>>>>>> free, since we can still end up needing a re-tune at any point.
>>>>>>
>>>>>> Still, you do have point for SDIO. Minimizing the number of errors for
>>>>>> SDIO could be important, due to that an SDIO func driver may not be
>>>>>> able to recover from data errors as smoothly as the mmc block layer
>>>>>> can. Thus, a timer could help to improve the situation, but I think it
>>>>>> only makes sense in the SDIO case.
>>>>>>
>>>>>> BTW, what's your experience around SDIO cards supporting SDR104. I
>>>>>> have never used such, have you?
>>>>>
>>>>>
>>>>>
>>>>> My primary focus in all this discussing is about SDIO cards. The main
>>>>> reason being that our 11ac wifi SDIO cards do support SDR104. So the
>>>>> brcmfmac driver support SDIO and has retry mechanisms in place. However,
>>>>> it may also end-up doing an abort under certain conditions.
>>>>>
>>>>> You also mentioned using runtime-pm, but how do you deal with func
>>>>> drivers not supporting runtime-pm. That is already an issue aka. bug
>>>>> right now. Our driver does not support runtime-pm (yet) and we have
>>>>> reported issues that host controller does runtime-pm basically killing
>>>>> communication between device and func driver.
>>>>
>>>>
>>>
>>> Runtime PM is implemented a bit differently between SDIO vs MMC/SD.
>>> Your are right.
>>>
>>> For MMC/SD the mmc block device handles pm_runtime_get|put() in
>>> principle per request basis and makes use of the
>>> pm_runtime_autosuspend feature. While in the SDIO case, it's entirely
>>> up the SDIO func driver to deal with pm_runtime_get|put().
>>>
>>> So it seems like we can use runtime PM for MMC/SD but not for SDIO. At
>>> least not using the SDIO func device.
>>>
>>>>
>>>> Could leave it to the function driver to call mmc_retune_needed().
>>>
>>>
>>> Hmm, the positive side from such approach would be that the SDIO func
>>> driver can decide when it's convenient to do a re-tune.
>>
>>
>> I would say "appropriate" instead of "convenient".
>>
>>> The negative side is that all SDIO func driver would need to care
>>> about this. I am not sure we want that.
>>
>>
>> The whole retry handling also seems deferred to the SDIO func driver and the
>> same for runtime-pm. As the "retune needed" question would pops up during
>> the retry handling it seems not a bad option.
> 
> Okay, your argument seems reasonable, let's got for this approach.

A re-tune is needed when there is a CRC error. That should be a low level
decision because it is needed no matter if it is a SDIO function driver or
eMMC block driver. There is a mechanism to hold-off re-tuning if it would
cause a problem. Otherwise re-tuning should be done immediately. Remember we
are already in an error condition, which must be rare to non-existent for
the device to perform reasonably.

The decision of the upper layers is when to retry.

My thought for the block driver was that it would indicate that it was ok to
transparently re-try if re-tuning was needed. Then the core would do the
re-try. A complication is the need to retry just once not get stuck
error->retry->error->retry->...

