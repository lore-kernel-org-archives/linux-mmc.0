From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 3/4] mmc: core: Break out start_signal_voltage_switch
Date: Tue, 8 Jan 2013 15:06:36 +0100
Message-ID: <CAPDyKFp7nd4cYBEFs01Hqu=Td2tmbo5tm_O6XUmO6OduaFdvWg@mail.gmail.com>
References: <1357571428-19466-1-git-send-email-johan.rudholm@stericsson.com>
	<1357571428-19466-4-git-send-email-johan.rudholm@stericsson.com>
	<CAPDyKFp9D0c8vOqzEDdwU9XWdBg1-FYe3KNb52_Y=Bu4Q7OrPg@mail.gmail.com>
	<CADz5_gLvU7ZPwTqiD3MJXoAKhCC05O2rdejstiUjpr-hvzOFWA@mail.gmail.com>
	<CAPDyKFp2Xx5VokaZHDJgjoKKozkQ_DYRm69d_c4Qd8umhNZ9hw@mail.gmail.com>
	<CA+20K0Aj73irSXibLzMB4bDcFuox7jCBCpgr7fR-kd4=umCgSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:52624 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab3AHOM0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 09:12:26 -0500
Received: by mail-la0-f41.google.com with SMTP id em20so498337lab.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 06:12:25 -0800 (PST)
In-Reply-To: <CA+20K0Aj73irSXibLzMB4bDcFuox7jCBCpgr7fR-kd4=umCgSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Kevin Liu <keyuan.liu@gmail.com>, Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 8 January 2013 11:23, Johan Rudholm <jrudholm@gmail.com> wrote:
> Hi Kevin and Ulf,
>
> 2013/1/8 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 8 January 2013 01:56, Kevin Liu <keyuan.liu@gmail.com> wrote:
>>> 2013/1/8 Ulf Hansson <ulf.hansson@linaro.org>:
>>>> On 7 January 2013 16:10, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
>>>>> Allow callers to access the start_signal_voltage_switch host_ops
>>>>> member without going through any cmd11 logic. This is mostly a
>>>>> preparation for the following signal voltage switch patch.
>>>>>
>>>>> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
>>>>> ---
>>>>>  drivers/mmc/core/core.c |   31 +++++++++++++++++++------------
>>>>>  drivers/mmc/core/core.h |    4 ++--
>>>>>  drivers/mmc/core/mmc.c  |    8 ++++----
>>>>>  drivers/mmc/core/sd.c   |    2 +-
>>>>>  drivers/mmc/core/sdio.c |    3 +--
>>>>>  5 files changed, 27 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 285f064..90f8e11 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -1219,7 +1219,22 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>>>>>         return ocr;
>>>>>  }
>>>>>
>>>>> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11)
>>>>> +int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>>>>> +{
>>>>> +       int err = 0;
>>>>> +
>>>>> +       host->ios.signal_voltage = signal_voltage;
>>>>> +       if (host->ops->start_signal_voltage_switch) {
>>>>> +               mmc_host_clk_hold(host);
>>>>> +               err = host->ops->start_signal_voltage_switch(host, &host->ios);
>>>>
>>>> Would it not make sense to restore the host->ios.signal_voltage value
>>>> if this goes wrong?
>>>>
>>>
>>> Why need to transfer ios to the voltage switch function which only
>>> need the voltage value.
>>> Why not just transfer the voltage value to the voltage switch
>>> function? If return ok then set host->ios.signal_voltage =
>>> signal_voltage otherwise do nothing.
>>> I did this in my previous patch.
>>
>> I like the idea!
>>
>> Although, if the "host->ops->start_signal_voltage_switch" function
>> pointer is missing, we should fall back to set the new voltage value
>> anyway I think.
>
> How about we keep the definition of start_signal_voltage_switch for
> now and maybe send it as a separate patch later? This change is not
> really functionally related to this patch series.

Make sense to me. Please go ahead!

>
> I agree that reseting the value of ios.signal_voltage to the original
> value on failure is good, as Kevin initially suggested. I'll take care
> of this in the next version!
>
> Kind regards, Johan

Kind regards
Ulf Hansson
