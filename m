From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 08/10] mmc: card: Use R1 response for the stop cmd at
 recovery path
Date: Mon, 27 Jan 2014 12:40:33 +0200
Message-ID: <52E637A1.8060602@intel.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org> <1390402824-9850-9-git-send-email-ulf.hansson@linaro.org> <52E0EA70.9010308@intel.com> <CAPDyKFpB4CUqzLsDE1NyGuWX4nMLRL7HwtPpcKp82vP1VGhJmg@mail.gmail.com> <52E1274D.3050200@intel.com> <CAPDyKFommygDb23S_OsN8-JZ2HoyzJeB0F-WmPGB5fOrBO3tHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2605 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbaA0Kiu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Jan 2014 05:38:50 -0500
In-Reply-To: <CAPDyKFommygDb23S_OsN8-JZ2HoyzJeB0F-WmPGB5fOrBO3tHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On 23/01/14 16:59, Ulf Hansson wrote:
> On 23 January 2014 15:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 23/01/14 15:21, Ulf Hansson wrote:
>>> On 23 January 2014 11:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 22/01/14 17:00, Ulf Hansson wrote:
>>>>> Hosts supporting MMC_CAP_WAIT_WHILE_BUSY shall not be waiting for busy
>>>>> detection completion in the recovery path, which were the case when
>>>>> using R1B response.
>>>>>
>>>>> Start using R1 as response instead to align behavior, no matter if
>>>>> MMC_CAP_WAIT_WHILE_BUSY is supported or not.
>>>>
>>>> This does not make sense to me.  If you are sending a STOP command you
>>>> should use the correct response type.  R1B should be OK here because the
>>>> card should release the busy signal in any case except failure.
>>>
>>> For those hosts not supporting MMC_CAP_WAIT_WHILE_BUSY a R1B is
>>> assumed to be treated same as an R1, which means there are no busy
>>> detection handled in the host.
>>
>> That is not entirely true.  For hosts that do not set
>> MMC_CAP_WAIT_WHILE_BUSY we don't know if they wait or not.  I imagine most
>> do because it is more efficient, but the kernel has always been programmed
>> to poll the status anyway so you can't tell from the code.
> 
> You are right, we can't know - unless we dive in into each host driver
> and check.
> 
> Surely there could be more than omap_hsmmc and sdhci that support
> this. Still I think we need to conclude on how to go forward with
> MMC_CAP_WAIT_WHILE_BUSY, since at the moment it seems a bit of a mess.
> Obviously we need to be careful to not break anything.
> 
>>
>> MMC_CAP_WAIT_WHILE_BUSY was one of my inventions I am afraid.  If I recall
>> correctly it was mainly due to the SLEEP command because you can't poll in
>> that case and you don't want to delay the system from sleeping - if you are
>> certain that the controller has waited for busy to de-assert (i.e.
>> MMC_CAP_WAIT_WHILE_BUSY) then you can exit immediately.
> 
> I think MMC_CAP_WAIT_WHILE_BUSY was a needed feature, now we only have
> to make it more mature. :-)
> 
>>
>>>
>>> mmc_blk_cmd_recovery() is the only caller of the send_stop() function.
>>> Additionally it does not care about to handle busy detection with
>>> CDM13 polling.
>>>
>>> Now, since most hosts don't support MMC_CAP_WAIT_WHILE_BUSY which
>>> means there no busy detection done, I wanted to align to this
>>> behaviour - no matter if the host can do HW busy detection or not.
>>>
>>> I am not saying this is how it must be done, just trying to provide
>>> you with some more reasons to why I wanted to change.
>>>
>>> If we instead decide keep the R1B for send_stop(), we should implement
>>> CMD 13 polling to meet the same behaviour for hosts not supporting
>>> MMC_CAP_WAIT_WHILE_BUSY. In this scenario, we need to set a select a
>>> busy timeout, do you have any suggestion of what would be a reasonable
>>> value for it?
>>
>> It is hard to tell if waiting is ever going to help more than hinder, so I
>> would not change this.
> 
> Fair enough, but certainly we should implement a CMD13 polling
> mechanism - to align behaviour.

Recovery probably isn't possible.  The block driver heroically has a go
at it.  For some people it much more important to fail fast than to
recover.  Consequently, unless you has a specific use-case, I wouldn't
add anything that would slow down that path.

> 
> Are you then also indirectly suggesting that not specficing
> "cmd.busy_timeout" should be interpreted by the host as "use whatever
> timeout you want"?

That is how it is now.  The problem with trying to so something better is
that sometimes the timeout really is undefined.

> 
> Do note, there are another scenario, which also don't specify a busy
> timeout, which is when we have used an open ended WRITE transmission
> and using CMD12 to finalize it.
> But, in this scenario we do polling with CMD13, also without a
> timeout. So at least the behaviour are aligned here, but still no
> timeout specified.

I don't think that is right.  The data timeout applies in that case too.

> 
>>
>>>
>>> Kind regards
>>> Ulf Hansson
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> ---
>>>>>  drivers/mmc/card/block.c |    2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>> index 87cd2b0..74169fa 100644
>>>>> --- a/drivers/mmc/card/block.c
>>>>> +++ b/drivers/mmc/card/block.c
>>>>> @@ -728,7 +728,7 @@ static int send_stop(struct mmc_card *card, u32 *status)
>>>>>       int err;
>>>>>
>>>>>       cmd.opcode = MMC_STOP_TRANSMISSION;
>>>>> -     cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>>>> +     cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>>>>>       err = mmc_wait_for_cmd(card->host, &cmd, 5);
>>>>>       if (err == 0)
>>>>>               *status = cmd.resp[0];
>>>>>
>>>>
>>>
>>>
>>
> 
> 

