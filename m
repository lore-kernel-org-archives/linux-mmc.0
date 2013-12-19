From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: don't return 1 for max_discard
Date: Thu, 19 Dec 2013 14:29:27 +0100
Message-ID: <CAPDyKFp1B6r+WyAO9PocL13LvzjsZDJ3HOUbXwJ+uTQ2Ayv-ug@mail.gmail.com>
References: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org>
	<52B22906.4010704@wwwdotorg.org>
	<52B2B5DF.1020702@intel.com>
	<52B2B8F7.1000905@mentor.com>
	<52B2BF95.302@intel.com>
	<CAPDyKFoiGzspgrtRwXruPqOODxbfKA4AAZHj_VF8H7rpwm7eTQ@mail.gmail.com>
	<52B2E67E.2000607@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:65493 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab3LSN32 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 08:29:28 -0500
Received: by mail-qc0-f176.google.com with SMTP id i8so883113qcq.35
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 05:29:27 -0800 (PST)
In-Reply-To: <52B2E67E.2000607@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Stephen Warren <swarren@wwwdotorg.org>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dongas86@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>

On 19 December 2013 13:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 19/12/13 12:26, Ulf Hansson wrote:
>> On 19 December 2013 10:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 19/12/13 11:14, Vladimir Zapolskiy wrote:
>>>> On 12/19/13 10:01, Adrian Hunter wrote:
>>>>> On 19/12/13 01:00, Stephen Warren wrote:
>>>>>> On 12/18/2013 03:27 PM, Stephen Warren wrote:
>>>>>>> From: Stephen Warren<swarren@nvidia.com>
>>>>>>>
>>>>>>> In mmc_do_calc_max_discard(), if only a single erase block can be
>>>>>>> discarded within the host controller's timeout, don't allow discard
>>>>>>> operations at all.
>>>>>>>
>>>>>>> Previously, the code allowed sector-at-a-time discard (rather than
>>>>>>> erase-block-at-a-time), which was chronically slow.
>>>>>>>
>>>>>>> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
>>>>>>> in qty == 1, which is immediately returned. This causes discard to
>>>>>>> operate a single sector at a time, which is chronically slow. With this
>>>>>>> patch in place, discard operates a single erase block at a time, which
>>>>>>> is reasonably fast.
>>>>>>
>>>>>> Alternatively, is the real fix a revert of e056a1b5b67b "mmc: queue: let
>>>>>> host controllers specify maximum discard timeout", followed by:
>>>>>>
>>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>>> index 050eb262485c..35c5b5d86c99 100644
>>>>>>> --- a/drivers/mmc/core/core.c
>>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>>> @@ -1950,7 +1950,6 @@ static int mmc_do_erase(struct mmc_card *card,
>>>>>>> unsigned int from,
>>>>>>>          cmd.opcode = MMC_ERASE;
>>>>>>>          cmd.arg = arg;
>>>>>>>          cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>>>>>> -       cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
>>>>>>>          err = mmc_wait_for_cmd(card->host,&cmd, 0);
>>>>>>>          if (err) {
>>>>>>>                  pr_err("mmc_erase: erase error %d, status %#x\n",
>>>>>>> @@ -1962,7 +1961,7 @@ static int mmc_do_erase(struct mmc_card *card,
>>>>>>> unsigned int from,
>>>>>>>          if (mmc_host_is_spi(card->host))
>>>>>>>                  goto out;
>>>>>>>
>>>>>>> -       timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
>>>>>>> +       timeout = jiffies + msecs_to_jiffies(mmc_erase_timeout(card,
>>>>>>> arg, qty));
>>>>>>>          do {
>>>>>>>                  memset(&cmd, 0, sizeof(struct mmc_command));
>>>>>>>                  cmd.opcode = MMC_SEND_STATUS;
>>>>>>
>>>>>> That certainly also seems to solve the problem on my board...
>>>>>
>>>>> But large erases will timeout when they should have been split into smaller
>>>>> chunks.
>>>>>
>>>>> A generic solution needs to be able to explain what happens when the host
>>>>> controller *does* timeout.
>>>>
>>>> Please correct me, but if Data Timeout Error is disabled, then this is not
>>>> an issue for most of the host controllers.
>>>
>>> That is a very good point.  My experience with SDHCI was that masking the
>>> "Data Timeout Error Status Enable" and "Data Timeout Error Signal Enable
>>> " bits did not disable the timeout i.e. the host controller would not
>>> deliver a TC interrupt if the erase exceeded the timeout.
>>>
>>> What happens on your board?
>>>
>>
>> I posted a response yesterday for "[PATCH] mmc: core: don't decrement
>> qty when calculating max_discard", related to this. Please have a
>> look.
>>
>> I think the interesting case to consider here is how we can handle
>> busy detection timeouts that is bigger than what the host hw can
>> support.
>>
>> Option 1)
>> Should we tell the host to disable the timeout in this case? That
>> potentially means hanging forever - if the card misbehaves. Like
>> omap_hsmmc does for erase commands. Maybe that is an okay limitation?
>
> sdhci anyway has a 10 second timer to catch unresponsive host controllers.
> I recently sent a patch to use the cmd_timeout_ms if it is bigger than 10
> seconds.
>
>         http://permalink.gmane.org/gmane.linux.kernel.mmc/23557
>

I see the reason behind your patch. Somehow, I don't like that host
drivers need to care about such things for specific commands.

The host driver should only tell it's maximum supported busy detection
timeout (max_discard_to) to the core layer, which should be needed
only of it supports MMC_CAP_WAIT_WHILE_BUSY.

Then the core layer should decide what to do depending on current
needed timeout.

BTW, do you know why sdhci haven't enabled MMC_CAP_WAIT_WHILE_BUSY. It
seems like it should be?

>>
>> Option 2)
>> Use a R1 response instead if R1B to prevent the host from doing busy
>> detection. Then rely on the CMD13 to poll for completion instead.
>> Obviously we can then stop polling after some selected timeout is the
>> card don't complete it's operations.
>
> It would be nice to avoid polling when the timeout can be supported. Also
> the polling should be periodic.

Agree!

>
>>
>> Would be very interesting to know what option you prefer!?
>
> At least 1 of the host controllers I have seen does not support disabling
> the timeout - so option 1) might not work in all cases.  Although it is the
> nicer option i.e. replace the hardware timeout with a software timeout.
>
> So I would probably allow both options to co-exist.

Thanks for input Adrian!

>
>>
>> Kind regards
>> Uffe
>>
>>
>
