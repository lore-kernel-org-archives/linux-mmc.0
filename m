Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF707C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 10:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A201223A55
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 10:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbhANKNz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 05:13:55 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbhANKNy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 05:13:54 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EAD3r7016690;
        Thu, 14 Jan 2021 11:13:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=sVesANlBEQEMySIkYMC5c1ewT46wm1qfoPp6x/8L7CY=;
 b=f897wr/crCD6+1OR/xizgszd1H6fYzJZeXOb2w6A6NurinHySN00zVN2muwlxutNitoe
 c3YQ4mfMgkpv4MjDTXQJdbUs57WtlNS1vYhWYtISM64kk5YPPKj7W7V8SOG/Uoo0Ntzp
 6ibP0JbEtRZi/X6wIK3zCvZOdgHWTPer0hl4YMNnr5MKXUtYR9CLglxa7vcEeAeOL0cz
 A/oKVUf27eluND42Y4S0iCyKDUEWCYh25LPheNbQth4NZZEwbquB5Q08megoexAPCU61
 2FC/Lj5iDZd3TjAd7rZcG5tr35tRj5lFWBOrxfgH01e5eD53yyzIlk3niVzJ+byryph3 RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35yp3y1n00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 11:13:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78FC910002A;
        Thu, 14 Jan 2021 11:13:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5D81322D214;
        Thu, 14 Jan 2021 11:13:07 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 11:13:06 +0100
Subject: Re: [Linux-stm32] [PATCH] [RFC] mmc: mmci: Add support for probing
 bus voltage level translator
To:     Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210105140718.122752-1-marex@denx.de>
 <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
 <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
 <CAPDyKFo5Sqxj31owrnmz1sTZqgW_PtZM2H=pDPBz+9hc0W0hHA@mail.gmail.com>
 <77dd612b-23f0-1f77-797a-9cde512926e3@denx.de>
 <f91fbdfc-453d-78a6-970a-5d6eecd443b2@foss.st.com>
 <ccef7ae4-8cd7-4434-9632-917a4fb92f53@denx.de>
From:   Yann GAUTIER <yann.gautier@foss.st.com>
Message-ID: <ad4a108e-81f1-daf5-9921-9884ed06d237@foss.st.com>
Date:   Thu, 14 Jan 2021 11:13:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ccef7ae4-8cd7-4434-9632-917a4fb92f53@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_03:2021-01-13,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/13/21 3:45 PM, Marek Vasut wrote:
> On 1/13/21 3:21 PM, Yann GAUTIER wrote:
>> On 1/13/21 12:52 PM, Marek Vasut wrote:
>>> On 1/13/21 12:38 PM, Ulf Hansson wrote:
>>> [...]
>>>>>>>    static int mmci_of_parse(struct device_node *np, struct 
>>>>>>> mmc_host *mmc)
>>>>>>>    {
>>>>>>>           struct mmci_host *host = mmc_priv(mmc);
>>>>>>> @@ -1913,7 +1973,7 @@ static int mmci_of_parse(struct device_node 
>>>>>>> *np, struct mmc_host *mmc)
>>>>>>>           if (of_get_property(np, "st,neg-edge", NULL))
>>>>>>>                   host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
>>>>>>>           if (of_get_property(np, "st,use-ckin", NULL))
>>>>>>> -               host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
>>>>>>> +               mmci_probe_level_translator(mmc);
>>>>>>
>>>>>> I think you can make this change bit less invasive. Rather than 
>>>>>> having
>>>>>> to shuffle code around in ->probe(), I suggest you call
>>>>>> mmci_probe_level_translator() outside and after mmci_of_parse() has
>>>>>> been called.
>>>>>>
>>>>>> In this way, you can also provide mmci_probe_level_translator() 
>>>>>> with a
>>>>>> struct mmci_host *, rather than having to pick it up from
>>>>>> mmc_priv(mmc), if you see what I mean.
>>>>>>
>>>>>> Of course, this also means in mmci_probe_level_translator() you will
>>>>>> have to check if MCI_STM32_CLK_SELCKIN has been set, and if not then
>>>>>> do an early return.
>>>>>
>>>>> Testing the translator presence when checking whether its enabled 
>>>>> in DT
>>>>> seems like the right place, but that's really just an 
>>>>> implementation detail.
>>>>>
>>>>> I am more interested in knowing whether adding
>>>>> mmci_probe_level_translator() is even acceptable in the first 
>>>>> place. Is it ?
>>>>
>>>> Honestly, I don't know.
>>>>
>>>> I think I need to defer that question to Linus Walleij. And of course,
>>>> it would be nice to get the opinion from Ludovic as well.
>>>
>>> Good, that's what I was hoping for too.
>>
>> Hi,
>>
>> Ludovic is out of office this week.
>>
>> The feature of detecting a level translator seems to be quite generic, 
>> and not dedicated to MMCI driver or the ST dedicated code, and with 
>> new st,* properties. It may be in generic mmc code. But I'll let Linus 
>> comment about that.
>>
>> I also wonder if this HW detection should be done in kernel, or if it 
>> should be done in Bootloader. But it may be more complex, to add the 
>> st,use_ckin in kernel DT if bootloader detects this translator.
> 
> Lets not attempt to hide inobvious functionality in bootloaders, the 
> kernel should be independent of bootloader where possible. And here it 
> is clearly and easily possible.

OK for this part, I understand it will be better not to hide this in 
bootloader.

There is still the previous point for which Linus may help.

Regards,
Yann
