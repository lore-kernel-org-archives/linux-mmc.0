From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2] mmc: core: Add option to prevent eMMC sleep command
Date: Mon, 19 Dec 2011 12:58:21 +0100
Message-ID: <4EEF26DD.2070307@stericsson.com>
References: <1323941761-24947-1-git-send-email-ulf.hansson@stericsson.com> <000601ccbb4d$dcefca00$96cf5e00$@org> <4EEF1C04.7030502@stericsson.com> <4EEF2479.7010602@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:45762 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752580Ab1LSL6q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 06:58:46 -0500
In-Reply-To: <4EEF2479.7010602@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, 'Lee Jones' <lee.jones@linaro.org>

Subhash Jadavani wrote:
>   On 12/19/2011 4:42 PM, Ulf Hansson wrote:
>> Subhash Jadavani wrote:
>>>> -----Original Message-----
>>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>>> owner@vger.kernel.org] On Behalf Of Ulf Hansson
>>>> Sent: Thursday, December 15, 2011 3:06 PM
>>>> To: linux-mmc@vger.kernel.org; Chris Ball
>>>> Cc: Per Forlin; Ulf Hansson; Johan Rudholm; Lee Jones
>>>> Subject: [PATCH V2] mmc: core: Add option to prevent eMMC sleep command
>>>>
>>>> Host may now use MMC_CAP2_NOSLEEP to disable the use of
>>>> eMMC sleep/awake command.
>>>>
>>>> This option can be used when you platform have a buggy
>>>> kernel crash dump software, which is supposed to store
>>>> the dump on the eMMC, but is not able to wake up the eMMC
>>>> from sleep state.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>>>> Reviewed-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
>>>> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>     - Added some motivation to why this patch is wanted in the
>>>>     commit message.
>>>>
>>>> ---
>>>>  drivers/mmc/core/core.c  |    6 ++++++
>>>>  include/linux/mmc/host.h |    1 +
>>>>  2 files changed, 7 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index a2aa860..5a1ce37 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -2246,6 +2246,9 @@ int mmc_card_awake(struct mmc_host *host)
>>>>  {
>>>>      int err = -ENOSYS;
>>>>
>>>> +    if (host->caps2 & MMC_CAP2_NOSLEEP)
>>>> +        return 0;
>>>> +
>>>>      mmc_bus_get(host);
>>>>
>>>>      if (host->bus_ops && !host->bus_dead && host->bus_ops->awake)
>>>> @@ -2261,6 +2264,9 @@ int mmc_card_sleep(struct mmc_host *host)
>>>>  {
>>>>      int err = -ENOSYS;
>>>>
>>>> +    if (host->caps2 & MMC_CAP2_NOSLEEP)
>>>> +        return 0;
>>>> +
>>>>      mmc_bus_get(host);
>>>>
>>>>      if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep)
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index 9a03d03..d07fb27 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -242,6 +242,7 @@ struct mmc_host {
>>>>  #define MMC_CAP2_CACHE_CTRL    (1 << 1)    /* Allow cache control */
>>>>  #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)    /* Notify poweroff
>>>> supported */
>>>>  #define MMC_CAP2_NO_MULTI_READ    (1 << 3)    /* Multiblock reads
>>>> don't work */
>>>> +#define MMC_CAP2_NOSLEEP    (1 << 4)    /* Don't allow sleep command
>>> Can we rename this CAP to something like "MMC_CAP2_NO_MMC_SLEEP_CMD" 
>>> to make
>>> it more specific?
>>>
>> The "cap" actually disables the execution of the mmc_card_awake|sleep 
>> functions which is not (e)MMC specific functions.
>>
>> I could change to someting like with *SLEEP_CMD but without *MMC* if 
>> that sounds better?
> Yes, it sounds good.

OK, fixed in v3 patch. May I add your Ack as well?

Br
Ulf Hansson
