Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B525C25B50
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Jan 2023 20:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjATU4S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Jan 2023 15:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATU4S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2023 15:56:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9A374C0F0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2023 12:56:15 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1152)
        id 44F7A20E0A25; Fri, 20 Jan 2023 12:56:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44F7A20E0A25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674248175;
        bh=tdBUFlnl2csHIrAEQPqT4w3XmcsckFER5XINmyt3anc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UW4pYAYeXA7qSeFQBZiKHGWtVfHwtit6wSZx+BXhaz8NtOJCoq8Y/LW6msR7YhKTG
         a13z5rj/9rnny8ghUJGqUgfS0/sm6P4kGb9NGZSXENFhftED2Uaw58c55BqnDBYgko
         DFew8awm31CLymXNo16K1qFRZ3OTFuG1lW3uVL7Y=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 41D0130705AF;
        Fri, 20 Jan 2023 12:56:15 -0800 (PST)
Date:   Fri, 20 Jan 2023 12:56:15 -0800 (PST)
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, code@tyhicks.com
Subject: Re: [PATCH] mmc: core: host: fix mmc retuning
In-Reply-To: <55cd9754-d8db-a132-65fc-8ac63245d147@linux.microsoft.com>
Message-ID: <acb7e3e0-f7c6-f510-d636-e45f443247c2@linux.microsoft.com>
References: <20221219225319.24637-1-shyamsaini@linux.microsoft.com> <14de0095-db93-cf5b-e843-1554a392b177@linux.microsoft.com> <e467c158-b298-53d1-4b12-7cbfe413af79@intel.com> <cacb9337-ed1b-6c5b-efa2-ae4086f9d7a9@linux.microsoft.com>
 <2612a51f-a103-5b6a-24f1-ae3511b66c74@intel.com> <1cdcea-afbb-c6b5-8aad-f1be9a9882e@linux.microsoft.com> <b522862e-953b-67ef-f786-9e34bea2cc9d@intel.com> <55cd9754-d8db-a132-65fc-8ac63245d147@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="656392-1669516463-1674248175=:26568"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656392-1669516463-1674248175=:26568
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Mon, 16 Jan 2023, Shyam Saini wrote:

>
>
> On Fri, 13 Jan 2023, Adrian Hunter wrote:
>
>> On 7/01/23 02:30, Shyam Saini wrote:
>>>
>>>
>>> On Wed, 4 Jan 2023, Adrian Hunter wrote:
>>>
>>>> On 3/01/23 22:59, Shyam Saini wrote:
>>>>>
>>>>> Hi Adrian,
>>>>>
>>>>> Thank you for response.
>>>>>
>>>>>> On 20/12/22 01:41, Shyam Saini wrote:
>>>>>>> As per the JEDEC spec, tuning(command CMD21) is not allowed in
>>>>>>> RPMB partition.
>>>>>>>
>>>>>>> To avoid retuning while switching to RPMB, hold_retune variable was
>>>>>>> introduced
>>>>>>
>>>>>> No, mmc_retune_pause() is used:
>>>>>>
>>>>>> /*
>>>>>> * Pause re-tuning for a small set of operations.  The pause begins after the
>>>>>> * next command and after first doing re-tuning.
>>>>>> */
>>>>>> void mmc_retune_pause(struct mmc_host *host)
>>>>>> {
>>>>>>     if (!host->retune_paused) {
>>>>>>         host->retune_paused = 1;
>>>>>>         mmc_retune_needed(host);
>>>>>>         mmc_retune_hold(host);
>>>>>>     }
>>>>>> }
>>>>>>
>>>>>>>            but it is not taken into account while making the tuning
>>>>>>> decision. As a consequence of this, mmc driver aborts while switching to
>>>>>>> RPMB partition:
>>>>>>>  mmc0: mmc_hs400_to_hs200 failed, error -84
>>>>>>
>>>>>> Do you normally re-tune at all?  It could just be that re-tuning
>>>>>> doesn't work.
>>>>>>
>>>>>
>>>>> Yes, we are able to retune.
>>>>>
>>>>> In fact this bug occurs when we iteratively switch to RPMB partition.
>>>>>
>>>>> May be related to this, we also observed that in __mmc_blk_ioctl_cmd
>>>>> function in line 487[1] part_index is assigned target_part variable and
>>>>> on the next line EXT_CSD_PART_CONFIG_ACC_RPMB OR'ed to the target_part
>>>>> variable.
>>>>>
>>>>> In mmc_blk_part_switch_pre function line 831 [2], part_type variable is
>>>>> compared to EXT_CSD_PART_CONFIG_ACC_RPMB without taking into account that
>>>>> the part_index variable is also OR'ed and its not separated before
>>>>> the comparision.
>>>>>
>>>>> Same thing happens in mmc_blk_part_switch_post function.
>>>>>
>>>>> Is it expected to be this way?, please let me know.
>>>>
>>>> According to the spec, there can only be 1 RPMB partition,
>>>> so the comment and code are not very meaningful.
>>>>
>>>> AFAICT rpmb->part_index is set to EXT_CSD_PART_CONFIG_ACC_RPMB
>>>> anyway, originally by mmc_decode_ext_csd():
>>>>
>>>>         /*
>>>>          * RPMB regions are defined in multiples of 128K.
>>>>          */
>>>>         card->ext_csd.raw_rpmb_size_mult = ext_csd[EXT_CSD_RPMB_MULT];
>>>>         if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host)) {
>>>>             mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
>>>>                 EXT_CSD_PART_CONFIG_ACC_RPMB,
>>>>                 "rpmb", 0, false,
>>>>                 MMC_BLK_DATA_AREA_RPMB);
>>>>         }
>>>>
>>>> So the OR has no effect.
>>>
>>> Thank you for the insight.
>>>
>>>>
>>>> As for "mmc_hs400_to_hs200 failed, error -84", I suggest enabling
>>>> some dynamic debug messages to determine what command is getting
>>>> an error and what the I/O state (as per mmc_set_ios()) is.
>>>>
>>>
>>> As per your suggestion I enabled dynamic debug messages and added few more statements just to check current partition. It seems like it fails after the CMD6 is started in the retuning code path.
>>>
>>> The partition seems to be non-RPMB when this happens.
>>>
>>> Snipet from the dmesg logs:
>>>
>>> [   92.573713] mmc_request_done: mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
>>> [   92.573715] mmc_request_done: mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>> [   92.573718] mmc_request_done: mmc0:     512 bytes transferred: 0
>>> [   92.573727] mmc_mrq_pr_debug: mmc0: starting CMD13 arg 00010000 flags 00000195
>>> [   92.573740] sdhci_irq: mmc0: sdhci: IRQ status 0x00000001
>>> [   92.573747] mmc_request_done: mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
>>> [   92.573754] =====>>>>>>>>>>>  part_type is Non RPMB <<<<<<==============
>>
>> eMMC partition is RPMB and about to switch to the main partition.
>>
>
  yes, Thank you. I overlooked it initially
>
>>> [   92.573758] mmc_mrq_pr_debug: mmc0: starting CMD6 arg 03b30001 flags 0000049d
>>> [   92.573768] sdhci_irq: mmc0: sdhci: IRQ status 0x00000001
>>> [   92.573867] sdhci_irq: mmc0: sdhci: IRQ status 0x00000002
>>> [   92.573872] mmc_request_done: mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
>>> [   92.573882] mmc_mrq_pr_debug: mmc0: starting CMD13 arg 00010000 flags 00000195
>>> [   92.573892] sdhci_irq: mmc0: sdhci: IRQ status 0x00000001
>>> [   92.573900] mmc_request_done: mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
>>
>> eMMC partition is the main partition, needing to switch to
>> RPMB.
>>
>>> [   92.574246] =====>>>>>>>>>>>  part_type is RPMB
>>> [   92.574251] mmc_mrq_pr_debug: mmc0: starting CMD6 arg 03b30301 flags 0000049d
>>> [   92.574253] ============>>>>>>>>>>>>>>> just before mmc_hs400_to_hs200
>>> [   92.574256] mmc_set_ios: mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 10
>>> [   92.574262] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>>> [   92.574272] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>>> [   92.574300] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>>> [   92.574307] mmc_mrq_pr_debug: mmc0: starting CMD6 arg 03b90101 flags 0000049d
>>> [   92.574321] sdhci_irq: mmc0: sdhci: IRQ status 0x00000001
>>> [   92.574326] sdhci_irq: mmc0: sdhci: IRQ status 0x00000002
>>> [   92.574331] mmc_request_done: mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
>>> [   92.574343] mmc_set_ios: mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 8
>>> [   92.574349] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>>> [   92.574360] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>>> [   92.574367] mmc_mrq_pr_debug: mmc0: starting CMD13 arg 00010000 flags 00000195
>>> [   92.574378] sdhci_irq: mmc0: sdhci: IRQ status 0x00000001
>>
>> The commands above are done when the eMMC partition is the main
>> partition.
>>
>>>
>>>
>>> full logs are available here [1]
>>>
>>>
>>> If we look at complete logs [1] it seems there isn't any tuning related error initially,
>>> but it occurs after few iterations of accessing RPMB partition.
>>>
>>> [1] https://pastebin.ubuntu.com/p/9ZzYd4gfhj/plain/
>>
>> It would be easier for me if you just attach logs
>> especially when they are so small.

sure.

>> [   92.574246] =====>>>>>>>>>>>  part_type is RPMB
>>
>> eMMC partition is the main partition
>>
>> [   92.574251] mmc_mrq_pr_debug: mmc0: starting CMD6 arg 03b30301 flags 0000049d
>>
>> CMD6 is being processed by mmc core, but it has not been
>> issued to the card.  The commands below are issued to the
>> eMMC main partition.
>>
>> [   92.574253] ============>>>>>>>>>>>>>>> just before mmc_hs400_to_hs200
>> [   92.574256] mmc_set_ios: mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 10
>> [   92.574262] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>> [   92.574272] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>> [   92.574300] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>>
>> Frequency has dropped to 52 MHz
>>
>> [   92.574307] mmc_mrq_pr_debug: mmc0: starting CMD6 arg 03b90101 flags 0000049d
>> [   92.574321] sdhci_irq: mmc0: sdhci: IRQ status 0x00000001
>> [   92.574326] sdhci_irq: mmc0: sdhci: IRQ status 0x00000002
>> [   92.574331] mmc_request_done: mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
>>
>> Successful switch from HS400 to DDR52 mode
>>
>> [   92.574343] mmc_set_ios: mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 8 timing 8
>> [   92.574349] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>> [   92.574360] esdhc_of_set_clock: sdhci-esdhc 2150000.esdhc: desired SD clock: 52000000, actual: 50000000
>> [   92.574367] mmc_mrq_pr_debug: mmc0: starting CMD13 arg 00010000 flags 00000195
>> [   92.574378] sdhci_irq: mmc0: sdhci: IRQ status 0x00000001
>> [   92.574385] mmc_request_done: mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
>>
>> CMD13 has been done successfully which checks it is still working.
>>
>> Now attempting bus width switch from DDR to SDR:
>>
>> [   92.574394] mmc_mrq_pr_debug: mmc0: starting CMD6 arg 03b70201 flags 0000049d
>>
>> All the errors in the log are coming from this switch command,
>> which is issued when the eMMC partition is the main partition.
>>
>> [   92.574407] sdhci_irq: mmc0: sdhci: IRQ status 0x000a0001
>> [   92.574415] sdhci_irq: mmc0: sdhci: IRQ status 0x00000002
>> [   92.574431] mmc_wait_for_req_done: mmc0: req failed (CMD6): -84, retrying...
>>
>> Probably some settings are not configured correctly for
>> DDR52 mode at this point.
>>
Do you have any suggestions for me to check any related 
settings/properties, please let me know.

>> I don't remember if I asked this already, which driver is it?


This is Freescale eSDHC controller driver.


>
>>
>> [   92.574444] sdhci_irq: mmc0: sdhci: IRQ status 0x000a0001
>> [   92.574449] sdhci_irq: mmc0: sdhci: IRQ status 0x00000002
>> [   92.574465] mmc_wait_for_req_done: mmc0: req failed (CMD6): -84, retrying...
>> [   92.574479] sdhci_irq: mmc0: sdhci: IRQ status 0x000a0001
>> [   92.574484] sdhci_irq: mmc0: sdhci: IRQ status 0x00000002
>> [   92.574500] mmc_wait_for_req_done: mmc0: req failed (CMD6): -84, retrying...
>> [   92.574513] sdhci_irq: mmc0: sdhci: IRQ status 0x000a0001
>> [   92.574517] sdhci_irq: mmc0: sdhci: IRQ status 0x00000002
>> [   92.574527] mmc_request_done: mmc0: req done (CMD6): -84: 00000000 00000000 00000000 00000000
>> [   92.574536] mmc0: mmc_hs400_to_hs200 failed, error -84
>> [   92.579677] mmc_wait_for_req_done: mmc0: req failed (CMD6): -84, retrying...
>>
>>>
>>>
>>> Best Regards,
>>> Shyam
>>>
>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/core/block.c?h=next#n487
>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/core/block.c?h=next#n831
>>>>>
>>>>>>>
>>>>>>> To fix this, take hold_retune variable into account while making retune
>>>>>>> decision in mmc_retune() function.
>>>>>>>
>>>>>>> Fixes: 57da0c042f4a ("mmc: block: Pause re-tuning while switched to the RPMB partition")
>>>>>>> Reported-by: Judy Wang <wangjudy@linux.microsoft.com>
>>>>>>> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
>>>>>>> ---
>>>>>>>  drivers/mmc/core/host.c | 3 +++
>>>>>>>  1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>>>>> index b89dca1f15e9..342c1f5c256b 100644
>>>>>>> --- a/drivers/mmc/core/host.c
>>>>>>> +++ b/drivers/mmc/core/host.c
>>>>>>> @@ -181,6 +181,9 @@ int mmc_retune(struct mmc_host *host)
>>>>>>>      bool return_to_hs400 = false;
>>>>>>>      int err;
>>>>>>>
>>>>>>> +    if (host->hold_retune >= 1)
>>>>>>> +        return 0;
>>>>>>
>>>>>> No, hold_retune is set *before* the command *after* which
>>>>>> tuning is not permitted.
>>>>>>
>>>>>>> +
>>>>>>>      if (host->retune_now)
>>>>>>>          host->retune_now = 0;
>>>>>>>      else
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>
>>>>>> On 20/12/22 01:41, Shyam Saini wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> Cc'ing Tyler
>>>>>>>
>>>>>>> Please note that I am not 100 % sure about the fix.
>>>>>>> This issue is reproducible without this patch and the patch at least fix the issue without
>>>>>>> any regressions on our side.
>>>>>>>
>>>>>>> We observed that hold_retune is always greater or equal to 1 in mmc_retune() function,
>>>>>>>
>>>>>>> so it may always avoid  re-tuning when it is actually needed and there may
>>>>>>>
>>>>>>> be a better fix for the issue.
>>>>>>>
>>>>>>> Please let me know your any feedback or comments.
>>>>>>>
>>>>>>> Best Regards,
>>>>>>> Shyam
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>
>>
--656392-1669516463-1674248175=:26568--
