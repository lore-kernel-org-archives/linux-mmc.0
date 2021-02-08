Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD8C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A5F64E7E
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 13:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBHNb7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:31:59 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38221 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhBHNb5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2021 08:31:57 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118DR22n002151;
        Mon, 8 Feb 2021 14:31:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : from : to
 : cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=si1So4VHV6RDEvv/5ou0Jpi+gztu6Xzw7DNL+Q9FjKQ=;
 b=VEV3jerIlpL7rZ9hxil7glHQHdomk1S9od4XSVIVEbHXgK2VuebMk1QjDNrW41RBVK4N
 pyshzoi6VEFuGryVPd05RMp0pncXwVBwfsgTES3x98wL/vURzT4E1nMF2xJq9OP2ag76
 S4Izi4yxTUSIpFDCDTIHPZWG6Sjwqkd4dyLKiQojXAg//Cd2FlFcu1bEOerZZ0Imh6iz
 QnhLxTvMCxpJYU+PQTvT6G6abRIcTtJyZPTtRKNoa+ZCQs/9kAhoockH2liM3oGZ2Hd5
 o09ZcFV/d8nTDRNa9dRgzSwENPYyTM3bQYW+3CrOjCyqaMhHfj6R+X10IvxXDZtjIO2s yQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36hr31a9yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 14:31:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 227E610002A;
        Mon,  8 Feb 2021 14:31:06 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node6.st.com [10.75.127.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1073F2AD2CE;
        Mon,  8 Feb 2021 14:31:06 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.121) by GPXDAG2NODE6.st.com
 (10.75.127.70) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 14:31:05 +0100
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
From:   Yann GAUTIER <yann.gautier@foss.st.com>
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
Message-ID: <fc4a9030-ba15-3236-7d81-52eb166a998a@foss.st.com>
Date:   Mon, 8 Feb 2021 14:31:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c1814dc-f87b-ef5c-24b4-b9a6ec570dbc@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To GPXDAG2NODE6.st.com
 (10.75.127.70)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_06:2021-02-08,2021-02-08 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/8/21 1:16 PM, Yann GAUTIER wrote:
> On 2/5/21 1:19 PM, Yann GAUTIER wrote:
>> On 2/5/21 10:53 AM, Ulf Hansson wrote:
>>> - trimmed cc-list
>>>
>>> On Thu, 4 Feb 2021 at 13:08, <yann.gautier@foss.st.com> wrote:
>>>>
>>>> From: Yann Gautier <yann.gautier@foss.st.com>
>>>>
>>>> To properly manage commands awaiting R1B responses, the capability
>>>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
>>>> manage busy detection.
>>>> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
>>>> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
>>>
>>> Would it be possible for you to share a little bit more about the
>>> problem? Like under what circumstances does things screw up?
>>>
>>> Is the issue only occurring when the cmd->busy_timeout becomes larger
>>> than host->max_busy_timeout. Or even in other cases?
>>>
>>>>
>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>> ---
>>>>   drivers/mmc/host/mmci.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>>> index 1bc674577ff9..bf6971fdd1a6 100644
>>>> --- a/drivers/mmc/host/mmci.c
>>>> +++ b/drivers/mmc/host/mmci.c
>>>> @@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
>>>>                  if (variant->busy_dpsm_flag)
>>>>                          mmci_write_datactrlreg(host,
>>>> host->variant->busy_dpsm_flag);
>>>> -               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>>>> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | 
>>>> MMC_CAP_NEED_RSP_BUSY;
>>>
>>> This isn't correct as the ux500 (and likely also other legacy
>>> variants) don't need this. I have tried it in the past and it works
>>> fine for ux500 without MMC_CAP_NEED_RSP_BUSY.
>>>
>>> The difference is rather that the busy detection for stm32 variants
>>> needs a corresponding HW busy timeout to be set (its
>>> variant->busy_timeout flag is set). Perhaps we can use that
>>> information instead?
>>>
>>> Note that, MMC_CAP_NEED_RSP_BUSY, means that cmd->busy_timeout will
>>> not be set by the core for erase commands, CMD5 and CMD6.
>>>
>>> By looking at the code in mmci_start_command(), it looks like we will
>>> default to a timeout of 10s, when cmd->busy_timeout isn't set. At
>>> least for some erase requests, that won't be sufficient. Would it be
>>> possible to disable the HW busy timeout in some way - and maybe use a
>>> software timeout instead? Maybe I already asked Ludovic about this?
>>> :-)
>>>
>>> BTW, did you check that the MMCIDATATIMER does get the correct value
>>> set for the timer in mmci_start_command() and if
>>> host->max_busy_timeout gets correctly set in
>>> mmci_set_max_busy_timeout()?
>>>
>>> [...]
>>>
>>> Kind regards
>>> Uffe
>>>
>>
>> Hi Ulf,
>>
>> Thanks for the hints.
>> I'll check all of that and get back with updated patches.
>>
>> As I tried to explain in the cover letter and in reply to Adrian, I saw
>> a freeze (BUSYD0) in test 37 during MMC_ERASE command  with 
>> SECURE_ERASE_ARG, when running this test just after test 36 (or any 
>> other write test). But maybe, as you said that's mostly a incorrect 
>> timeout issue.
>>
>> Regards,
>> Yann
> 
> Hi,
> 
> I made some extra tests, and the timeout value set in MMCIDATATIMER 
> correspond to the one computed:
> card->ext_csd.erase_group_def is set to 1 in mmc_init_card()
> In mmc_mmc_erase_timeout(), we have:
> erase_timeout = card->ext_csd.hc_erase_timeout; // 300ms * 0x07 (for the 
> eMMC card I have: THGBMDG5D1LBAIL
> erase_timeout *= card->ext_csd.sec_erase_mult; // 0xDC
> erase_timeout *= qty; // 32 (from = 0x1d0000, to = 0x20ffff)
> 
> This leads to a timeout of 14784000ms (~4 hours).
> The max_busy_timeout is 86767ms.
> 
> After those 4 hours, I get this message:
> mmc1: Card stuck being busy! __mmc_poll_for_busy
> 
> The second erase with MMC_ERASE_ARG finds an erase timeout of 67200ms, 
> and uses R1B command.
> But as the first erase failed, the DPSMACT is still enabled, the busy 
> timeout doesn't seem to happen. Something may be missing in the error path.
> 
> Anyway, I'll push an update of the second patch of the series, and just 
> drop this first one.
> 
> 
> Regards,
> Yann

I've discussed with Ludovic, and it is somewhat related to this patch set:
https://patchwork.kernel.org/project/linux-mmc/list/?series=186219&state=%2A&archive=both

The STM32 SDMMC IP needs a specific reset procedure when a data timeout 
occurs. If it is hardware, this is managed with the threaded IRQ. But if 
it is a SW polling (if R1B is replaced with R1), there is nothing in 
frameworks that could call this "unstuck" procedure for STM32 variant.
I don't know how this should be handled.


Regards,
Yann
