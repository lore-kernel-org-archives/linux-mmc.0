From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 08/10] mmc: card: Use R1 response for the stop cmd at
 recovery path
Date: Tue, 28 Jan 2014 17:11:53 +0100
Message-ID: <CAPDyKFqqKtQoFVV3QBtPsVYkdyXyQu93a5r_gtQLe-eR7G37zQ@mail.gmail.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
	<1390402824-9850-9-git-send-email-ulf.hansson@linaro.org>
	<52E0EA70.9010308@intel.com>
	<CAPDyKFpB4CUqzLsDE1NyGuWX4nMLRL7HwtPpcKp82vP1VGhJmg@mail.gmail.com>
	<52E1274D.3050200@intel.com>
	<CAPDyKFommygDb23S_OsN8-JZ2HoyzJeB0F-WmPGB5fOrBO3tHg@mail.gmail.com>
	<52E637A1.8060602@intel.com>
	<CAPDyKFonnZViAD4so9py11nFAES=L6j=8X8vNuJV7_1PzLSksA@mail.gmail.com>
	<52E7C297.7080105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:64420 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbaA1QLy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 11:11:54 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so745555qae.27
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2014 08:11:53 -0800 (PST)
In-Reply-To: <52E7C297.7080105@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On 28 January 2014 15:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 28/01/14 14:39, Ulf Hansson wrote:
>> On 27 January 2014 11:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 23/01/14 16:59, Ulf Hansson wrote:
>>>> On 23 January 2014 15:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 23/01/14 15:21, Ulf Hansson wrote:
>>>>>> On 23 January 2014 11:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>> On 22/01/14 17:00, Ulf Hansson wrote:
>>>>>>>> Hosts supporting MMC_CAP_WAIT_WHILE_BUSY shall not be waiting for busy
>>>>>>>> detection completion in the recovery path, which were the case when
>>>>>>>> using R1B response.
>>>>>>>>
>>>>>>>> Start using R1 as response instead to align behavior, no matter if
>>>>>>>> MMC_CAP_WAIT_WHILE_BUSY is supported or not.
>>>>>>>
>>>>>>> This does not make sense to me.  If you are sending a STOP command you
>>>>>>> should use the correct response type.  R1B should be OK here because the
>>>>>>> card should release the busy signal in any case except failure.
>>>>>>
>>>>>> For those hosts not supporting MMC_CAP_WAIT_WHILE_BUSY a R1B is
>>>>>> assumed to be treated same as an R1, which means there are no busy
>>>>>> detection handled in the host.
>>>>>
>>>>> That is not entirely true.  For hosts that do not set
>>>>> MMC_CAP_WAIT_WHILE_BUSY we don't know if they wait or not.  I imagine most
>>>>> do because it is more efficient, but the kernel has always been programmed
>>>>> to poll the status anyway so you can't tell from the code.
>>>>
>>>> You are right, we can't know - unless we dive in into each host driver
>>>> and check.
>>>>
>>>> Surely there could be more than omap_hsmmc and sdhci that support
>>>> this. Still I think we need to conclude on how to go forward with
>>>> MMC_CAP_WAIT_WHILE_BUSY, since at the moment it seems a bit of a mess.
>>>> Obviously we need to be careful to not break anything.
>>>>
>>>>>
>>>>> MMC_CAP_WAIT_WHILE_BUSY was one of my inventions I am afraid.  If I recall
>>>>> correctly it was mainly due to the SLEEP command because you can't poll in
>>>>> that case and you don't want to delay the system from sleeping - if you are
>>>>> certain that the controller has waited for busy to de-assert (i.e.
>>>>> MMC_CAP_WAIT_WHILE_BUSY) then you can exit immediately.
>>>>
>>>> I think MMC_CAP_WAIT_WHILE_BUSY was a needed feature, now we only have
>>>> to make it more mature. :-)
>>>>
>>>>>
>>>>>>
>>>>>> mmc_blk_cmd_recovery() is the only caller of the send_stop() function.
>>>>>> Additionally it does not care about to handle busy detection with
>>>>>> CDM13 polling.
>>>>>>
>>>>>> Now, since most hosts don't support MMC_CAP_WAIT_WHILE_BUSY which
>>>>>> means there no busy detection done, I wanted to align to this
>>>>>> behaviour - no matter if the host can do HW busy detection or not.
>>>>>>
>>>>>> I am not saying this is how it must be done, just trying to provide
>>>>>> you with some more reasons to why I wanted to change.
>>>>>>
>>>>>> If we instead decide keep the R1B for send_stop(), we should implement
>>>>>> CMD 13 polling to meet the same behaviour for hosts not supporting
>>>>>> MMC_CAP_WAIT_WHILE_BUSY. In this scenario, we need to set a select a
>>>>>> busy timeout, do you have any suggestion of what would be a reasonable
>>>>>> value for it?
>>>>>
>>>>> It is hard to tell if waiting is ever going to help more than hinder, so I
>>>>> would not change this.
>>>>
>>>> Fair enough, but certainly we should implement a CMD13 polling
>>>> mechanism - to align behaviour.
>>>
>>> Recovery probably isn't possible.  The block driver heroically has a go
>>> at it.  For some people it much more important to fail fast than to
>>> recover.  Consequently, unless you has a specific use-case, I wouldn't
>>> add anything that would slow down that path.
>>
>> I agree that it's hard to tell what's the best approach. :-) Though I
>> still think we can do a bit better than what we do today, and I really
>> don't like that we don't have an aligned behaviour - between hosts
>> supporting and not supporting MMC_CAP_WAIT_WHILE_BUSY for this
>> particular case.
>>
>> I understand that you want to prevent us from breaking something. But
>> currently, if we consider all hosts, either it all works like a charm,
>> or some are broken, because the behaviour is different.
>>
>> In this case, I don't see the benefit of using hw busy detection at
>> all, since the performance to gain is not relevant. We could then
>> convert to R1 instead of R1B and for all cases do polling with CMD13
>> for a small period of let's say 200 ms.
>>
>> Would that be acceptable for you?
>
> How about R1 for the read case, R1B for write and poll only if
> !MMC_CAP_WAIT_WHILE_BUSY.
>
> I notice send_stop() has no timeout - perhaps fish out the data timeout and
> use that for both R1B and polling.

That could work! I will give it go and send a new v2 patch.

>
>>
>>>
>>>>
>>>> Are you then also indirectly suggesting that not specficing
>>>> "cmd.busy_timeout" should be interpreted by the host as "use whatever
>>>> timeout you want"?
>>>
>>> That is how it is now.  The problem with trying to so something better is
>>> that sometimes the timeout really is undefined.
>>
>> That makes sense!
>>
>>>
>>>>
>>>> Do note, there are another scenario, which also don't specify a busy
>>>> timeout, which is when we have used an open ended WRITE transmission
>>>> and using CMD12 to finalize it.
>>>> But, in this scenario we do polling with CMD13, also without a
>>>> timeout. So at least the behaviour are aligned here, but still no
>>>> timeout specified.
>>>
>>> I don't think that is right.  The data timeout applies in that case too.
>>
>> No it shouldn't. The data timeout applies only to the ongoing data
>> transfer. In other words, if the card stops sending/receiving data in
>> the middle of the transfer.
>
> I couldn't find anything in the JEDEC spec. but the SD spec. says:
>
>         There are two types of busies in a multiple block write operation.
>         (1) Write busy at block gap (without CMD12) is maximum 250ms
>         (2) Write busy after CMD12 is maximum 250ms (500ms for SDXC)

The SD spec mentions NAC for read and NWR for writes, similar bus
timings exists for the eMMC spec.

For the SD spec, it seems a bit more clear on what a host could expect
as a maximum busy timeout. According to what you also found above.

Maybe it is a really good option of re-using the data timeout as the
busy timeout, as you suggested above.

Still, the eMMC spec is not so clear. From the "Data Write" chapter
you will find the following statement:

"Some Devices may require long and unpredictable times to write a
block of data.". :-)

Kind regards
Uffe

>
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Kind regards
>>>>>> Ulf Hansson
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>>> ---
>>>>>>>>  drivers/mmc/card/block.c |    2 +-
>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>>>>> index 87cd2b0..74169fa 100644
>>>>>>>> --- a/drivers/mmc/card/block.c
>>>>>>>> +++ b/drivers/mmc/card/block.c
>>>>>>>> @@ -728,7 +728,7 @@ static int send_stop(struct mmc_card *card, u32 *status)
>>>>>>>>       int err;
>>>>>>>>
>>>>>>>>       cmd.opcode = MMC_STOP_TRANSMISSION;
>>>>>>>> -     cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>>>>>>> +     cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>>>>>>>>       err = mmc_wait_for_cmd(card->host, &cmd, 5);
>>>>>>>>       if (err == 0)
>>>>>>>>               *status = cmd.resp[0];
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
