Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B3C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Feb 2021 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8837664D99
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Feb 2021 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBIOCQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Feb 2021 09:02:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21350 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231971AbhBIOCI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2021 09:02:08 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119DvDfb018685;
        Tue, 9 Feb 2021 15:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=9AVHdvUAIwUcnAMHaIh6YvIvWqn1oa337b0BjM9c3I4=;
 b=yf+GtKlpXz8+u9mRHOcSrR3DNUq65y3loOM8lVFg537GjfH5GOaqL+xYEJ7Q3r2KduPU
 rrqTtQotw5v2ILRv7H/l3Yq41f/G4H5l2NjTmZ0UgCsZA/1ffmEzeRjmz5Bhqu51cLYt
 ifvIZ3uzE9zOlCJSgzGJmrdEvJlyaMBflT7lTcYoS18rDFMiqaK0UEjKqQllW3xOds+W
 6XK1aLz2MWNyJ39DQiKUw0bqias1G2S4rK7wKsvte8guuqLVCQLy7KL5A5kYb5zdN4GF
 F/XMMGPgpNPnCT7/o5l+GMbau9Uukb87tHRFQNaiemZtBnEdyOq/UlyhhnpGYytSNWaS Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36hrf7918v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 15:01:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E2AC110002A;
        Tue,  9 Feb 2021 15:01:16 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node6.st.com [10.75.127.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B991E23BD43;
        Tue,  9 Feb 2021 15:01:16 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.121) by GPXDAG2NODE6.st.com
 (10.75.127.70) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 15:01:15 +0100
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        <ludovic.barre@foss.st.com>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-2-yann.gautier@foss.st.com>
 <CAPDyKFqdtK33HSW_AM0s9172V=cBM6wnKuHubXSOGCVqJ8nzFg@mail.gmail.com>
 <e31df871-ae1a-7c80-d741-0813f90532c7@foss.st.com>
 <1c1814dc-f87b-ef5c-24b4-b9a6ec570dbc@foss.st.com>
 <CAPDyKFq26Q3jwwJ71vp6s-+ux3jUnL6+m2FEzfi_gh5z8meqrw@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
Message-ID: <cc8a480c-77dc-f44b-ae98-309ab59c4e13@foss.st.com>
Date:   Tue, 9 Feb 2021 15:01:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq26Q3jwwJ71vp6s-+ux3jUnL6+m2FEzfi_gh5z8meqrw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To GPXDAG2NODE6.st.com
 (10.75.127.70)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/8/21 4:03 PM, Ulf Hansson wrote:
> On Mon, 8 Feb 2021 at 13:16, Yann GAUTIER <yann.gautier@foss.st.com> wrote:
>>
>> On 2/5/21 1:19 PM, Yann GAUTIER wrote:
>>> On 2/5/21 10:53 AM, Ulf Hansson wrote:
>>>> - trimmed cc-list
>>>>
>>>> On Thu, 4 Feb 2021 at 13:08, <yann.gautier@foss.st.com> wrote:
>>>>>
>>>>> From: Yann Gautier <yann.gautier@foss.st.com>
>>>>>
>>>>> To properly manage commands awaiting R1B responses, the capability
>>>>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
>>>>> manage busy detection.
>>>>> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
>>>>> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
>>>>
>>>> Would it be possible for you to share a little bit more about the
>>>> problem? Like under what circumstances does things screw up?
>>>>
>>>> Is the issue only occurring when the cmd->busy_timeout becomes larger
>>>> than host->max_busy_timeout. Or even in other cases?
>>>>
>>>>>
>>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>>> ---
>>>>>    drivers/mmc/host/mmci.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>>>> index 1bc674577ff9..bf6971fdd1a6 100644
>>>>> --- a/drivers/mmc/host/mmci.c
>>>>> +++ b/drivers/mmc/host/mmci.c
>>>>> @@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
>>>>>                   if (variant->busy_dpsm_flag)
>>>>>                           mmci_write_datactrlreg(host,
>>>>>
>>>>> host->variant->busy_dpsm_flag);
>>>>> -               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>>>>> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
>>>>> MMC_CAP_NEED_RSP_BUSY;
>>>>
>>>> This isn't correct as the ux500 (and likely also other legacy
>>>> variants) don't need this. I have tried it in the past and it works
>>>> fine for ux500 without MMC_CAP_NEED_RSP_BUSY.
>>>>
>>>> The difference is rather that the busy detection for stm32 variants
>>>> needs a corresponding HW busy timeout to be set (its
>>>> variant->busy_timeout flag is set). Perhaps we can use that
>>>> information instead?
>>>>
>>>> Note that, MMC_CAP_NEED_RSP_BUSY, means that cmd->busy_timeout will
>>>> not be set by the core for erase commands, CMD5 and CMD6.
>>>>
>>>> By looking at the code in mmci_start_command(), it looks like we will
>>>> default to a timeout of 10s, when cmd->busy_timeout isn't set. At
>>>> least for some erase requests, that won't be sufficient. Would it be
>>>> possible to disable the HW busy timeout in some way - and maybe use a
>>>> software timeout instead? Maybe I already asked Ludovic about this?
>>>> :-)
>>>>
>>>> BTW, did you check that the MMCIDATATIMER does get the correct value
>>>> set for the timer in mmci_start_command() and if
>>>> host->max_busy_timeout gets correctly set in
>>>> mmci_set_max_busy_timeout()?
>>>>
>>>> [...]
>>>>
>>>> Kind regards
>>>> Uffe
>>>>
>>>
>>> Hi Ulf,
>>>
>>> Thanks for the hints.
>>> I'll check all of that and get back with updated patches.
>>>
>>> As I tried to explain in the cover letter and in reply to Adrian, I saw
>>> a freeze (BUSYD0) in test 37 during MMC_ERASE command  with
>>> SECURE_ERASE_ARG, when running this test just after test 36 (or any
>>> other write test). But maybe, as you said that's mostly a incorrect
>>> timeout issue.
>>>
>>> Regards,
>>> Yann
>>
>> Hi,
>>
>> I made some extra tests, and the timeout value set in MMCIDATATIMER
>> correspond to the one computed:
>> card->ext_csd.erase_group_def is set to 1 in mmc_init_card()
>> In mmc_mmc_erase_timeout(), we have:
>> erase_timeout = card->ext_csd.hc_erase_timeout; // 300ms * 0x07 (for the
>> eMMC card I have: THGBMDG5D1LBAIL
>> erase_timeout *= card->ext_csd.sec_erase_mult; // 0xDC
>> erase_timeout *= qty; // 32 (from = 0x1d0000, to = 0x20ffff)
>>
>> This leads to a timeout of 14784000ms (~4 hours).
>> The max_busy_timeout is 86767ms.
>>
>> After those 4 hours, I get this message:
>> mmc1: Card stuck being busy! __mmc_poll_for_busy
> 
> Okay, I see.
> 
> This means that we end up polling for busy in __mmc_poll_for_busy().
> However, not by using CMD13 but rather with the ->card_busy() ops (as
> mmci has this callback set).
> 
> Could it be that the ->card_busy() callback isn't working correctly
> for the stm32 variant?
> 
> What happens if you temporarily drop the assignment of the
> ->card_busy() callback, thus force the mmc core to poll with CMD13
> instead? Would this work?
> 

Hi Ulf,

When ->card_busy() is stubbed for MMC_ERASE command, CMD13 is running in 
loop, for ~66 seconds.
The card status is just 0xe00 here, no errors, just prog state, as 
awaited for CMD38, and READY_FOR_DATA bit not set.
And after those 66 seconds, the status changes to 0x900.
But busyd0 is still set to 1, during the CMD13 and after.
The test continues, with a CMD25, still with busyd0 and DPSM so the IP 
is stuck, and the STOP command is sent (mrq->stop in mmc_mrq_pr_debug).
And here nothing more happens, wait_for_completion() from 
mmc_wait_for_req_done().

>>
>> The second erase with MMC_ERASE_ARG finds an erase timeout of 67200ms,
>> and uses R1B command.
>> But as the first erase failed, the DPSMACT is still enabled, the busy
>> timeout doesn't seem to happen. Something may be missing in the error path.
> 
> Assuming the eMMC card completed the first erase operation
> successfully, then yes, the second erase should work.
> 
> However, what if the eMMC actually failed with the first erase? How can we know?

In the case where ->card_busy() is used:
As busyd0 is still 1 in the STATUS register, we cannot know if the 
command really finished. And as the DPSM is stuck, we cannot send other 
read command to check what is on the card.

As I said in another thread:
"I've discussed with Ludovic, and it is somewhat related to this patch set:
https://patchwork.kernel.org/project/linux-mmc/list/?series=186219&state=%2A&archive=both

The STM32 SDMMC IP needs a specific reset procedure when a data timeout 
occurs. If it is hardware, this is managed with the threaded IRQ. But if 
it is a SW polling (if R1B is replaced with R1), there is nothing in 
frameworks that could call this "unstuck" procedure for STM32 variant.
I don't know how this should be handled."

Are there other things I should check?

The main issue here is that we cannot use R1B if timeout > 
mmc->max_busy_timeout, and SW polling won't be able to call our reset 
procedure in case of trouble.

The second patch in the series, changing the MMC_ERASE argument from 
MMC_SECURE_ERASE_ARG to the argument chosen in the framework will then 
compute a timeout lower than mmc->max_busy_timeout, and the test will pass.
But this does not explain why STM32 SDMMC IP doesn't react well to this 
secure argument after it has executed a write test.


Thanks,
Yann

> 
>>
>> Anyway, I'll push an update of the second patch of the series, and just
>> drop this first one.
>>
>>
>> Regards,
>> Yann
> 
> Kind regards
> Uffe
> 

