From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: core: Power cycle card on voltage switch fail
Date: Wed, 26 Sep 2012 10:54:32 +0200
Message-ID: <CA+20K0BUZ2xL3hW5oKzzYG8R3Z1oetZikkYRZ5AeG1LtyCCxgA@mail.gmail.com>
References: <1348556654-2119-1-git-send-email-johan.rudholm@stericsson.com>
	<CAPDyKFqr9COJ0oGQE_G99zscFXpRztQ3nN8o3_Vn-sQOxegB5Q@mail.gmail.com>
	<6903B09F-6665-4E4F-9398-2BC93E2BE061@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46851 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab2IZIyc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 04:54:32 -0400
Received: by ieak13 with SMTP id k13so810090iea.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Sep 2012 01:54:32 -0700 (PDT)
In-Reply-To: <6903B09F-6665-4E4F-9398-2BC93E2BE061@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Philip,

2012/9/25 Philip Rakity <prakity@marvell.com>:
>
>
> On Sep 25, 2012, at 12:30 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> Hi Johan,
>>
>> An overall comment; would it be possible to include this patch as a
>> piece of patch 1/2 "mmc: core: Proper signal voltage switch".
>> They seems like quite tight connected.
>>
>> Anyway, some comment below.
>>
>> On 25 September 2012 09:04, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
>>> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
>>> ---
>>> drivers/mmc/core/core.c |    2 +-
>>> drivers/mmc/core/core.h |    1 +
>>> drivers/mmc/core/sd.c   |    8 ++++++--
>>> 3 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index dae6744..fb03bd9 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1348,7 +1348,7 @@ static void mmc_poweroff_notify(struct mmc_host *host)
>>>  * If a host does all the power sequencing itself, ignore the
>>>  * initial MMC_POWER_UP stage.
>>>  */
>>> -static void mmc_power_up(struct mmc_host *host)
>>> +void mmc_power_up(struct mmc_host *host)
>>> {
>>>        int bit;
>>>
>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>>> index 3bdafbc..5a5170d 100644
>>> --- a/drivers/mmc/core/core.h
>>> +++ b/drivers/mmc/core/core.h
>>> @@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
>>> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>> void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
>>> void mmc_power_off(struct mmc_host *host);
>>> +void mmc_power_up(struct mmc_host *host);
>>>
>>> static inline void mmc_delay(unsigned int ms)
>>> {
>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>> index 74972c2..9a165451 100644
>>> --- a/drivers/mmc/core/sd.c
>>> +++ b/drivers/mmc/core/sd.c
>>> @@ -720,6 +720,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>>>         * state.  We wait 1ms to give cards time to
>>>         * respond.
>>>         */
>>> +try_again:
>>>        mmc_go_idle(host);
>>>
>>>        /*
>>> @@ -748,7 +749,6 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>>>        if (max_current > 150)
>>>                ocr |= SD_OCR_XPC;
>>>
>>> -try_again:
>>>        err = mmc_send_app_op_cond(host, ocr, rocr);
>>>        if (err)
>>>                return err;
>>> @@ -761,7 +761,11 @@ try_again:
>>>           ((*rocr & 0x41000000) == 0x41000000)) {
>>>                err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
>>>                if (err) {
>>> -                       ocr &= ~SD_OCR_S18R;
>>> +                       /* Power cycle card */
>>> +                       pr_warning("%s: Signal voltage switch failed, "
>>> +                               "power cycling card\n", mmc_hostname(host));
>>> +                       mmc_power_off(host);
>>> +                       mmc_power_up(host);
>>
>> This mean you will retry forever even if the card is not capable of
>> 1.8V. I doubt this really what you want?
>>
>>>                        goto try_again;
>>>                }
>>>        }
>>> --
>>> 1.7.10
>>>
>
>
>  I did a patch for this problem in sdhci.c when voltage switch failed.  It turned off and then
> turned on the regulator.  The patch worked on the UHS cards I was testing.  The fix
> has been pulled upstream.

We looked at this code for inspiration actually :) However, wouldn't
it be a good idea to include this functionality in the protocol layer
since it's a part of the SD spec?

The work on the SDIO patch required some more restructuring in the
code, so I'll drop this patch series now and push a new series in the
form of an RFC.

Kind regards, Johan
