Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8CC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BFA233FC
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbhAMOWQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:22:16 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41853 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbhAMOWQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 09:22:16 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10DEBu3l003195;
        Wed, 13 Jan 2021 15:21:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=X0MuUVG1nzIodFAT/Xpr7pm9K5Pm0TPf5ydlMJ1xAAk=;
 b=s0QDXl6nWpmsJeYvjL1lvta/Qe1pm4YowJfxokVG0xTJdvp675bxEvdsd5HbHpiciAZX
 G7ODzISfY0loo9Mwx9crnbQFL/DfGBuy86MK/VnMS7PpeYK6SVqmov/zbZJcwRH9Mhyx
 63aioAoDpfwE7HFv0zcQORrdiFMKIA9NuwtkiiD/SWVCZHXAAi/hr73jLnyAH8foT7hy
 CkmKveS7GMASCVgMCyPw+tKEr0bmkErpQSDXhVIQ5/i3djGYjEQEtmTfeVnIuUziHU96
 iMqP97hOaUUfP4RHxU5XWTGPf2unGqKfcrdNXfPCkZLR9whyEJFYUuM5hgNoDzoqKpXi Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35y5gx787r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 15:21:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2CDAC10002A;
        Wed, 13 Jan 2021 15:21:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E11525C0DF;
        Wed, 13 Jan 2021 15:21:29 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Jan
 2021 15:21:28 +0100
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
From:   Yann GAUTIER <yann.gautier@foss.st.com>
Message-ID: <f91fbdfc-453d-78a6-970a-5d6eecd443b2@foss.st.com>
Date:   Wed, 13 Jan 2021 15:21:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <77dd612b-23f0-1f77-797a-9cde512926e3@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_07:2021-01-13,2021-01-13 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/13/21 12:52 PM, Marek Vasut wrote:
> On 1/13/21 12:38 PM, Ulf Hansson wrote:
> [...]
>>>>>    static int mmci_of_parse(struct device_node *np, struct mmc_host 
>>>>> *mmc)
>>>>>    {
>>>>>           struct mmci_host *host = mmc_priv(mmc);
>>>>> @@ -1913,7 +1973,7 @@ static int mmci_of_parse(struct device_node 
>>>>> *np, struct mmc_host *mmc)
>>>>>           if (of_get_property(np, "st,neg-edge", NULL))
>>>>>                   host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
>>>>>           if (of_get_property(np, "st,use-ckin", NULL))
>>>>> -               host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
>>>>> +               mmci_probe_level_translator(mmc);
>>>>
>>>> I think you can make this change bit less invasive. Rather than having
>>>> to shuffle code around in ->probe(), I suggest you call
>>>> mmci_probe_level_translator() outside and after mmci_of_parse() has
>>>> been called.
>>>>
>>>> In this way, you can also provide mmci_probe_level_translator() with a
>>>> struct mmci_host *, rather than having to pick it up from
>>>> mmc_priv(mmc), if you see what I mean.
>>>>
>>>> Of course, this also means in mmci_probe_level_translator() you will
>>>> have to check if MCI_STM32_CLK_SELCKIN has been set, and if not then
>>>> do an early return.
>>>
>>> Testing the translator presence when checking whether its enabled in DT
>>> seems like the right place, but that's really just an implementation 
>>> detail.
>>>
>>> I am more interested in knowing whether adding
>>> mmci_probe_level_translator() is even acceptable in the first place. 
>>> Is it ?
>>
>> Honestly, I don't know.
>>
>> I think I need to defer that question to Linus Walleij. And of course,
>> it would be nice to get the opinion from Ludovic as well.
> 
> Good, that's what I was hoping for too.

Hi,

Ludovic is out of office this week.

The feature of detecting a level translator seems to be quite generic, 
and not dedicated to MMCI driver or the ST dedicated code, and with new 
st,* properties. It may be in generic mmc code. But I'll let Linus 
comment about that.

I also wonder if this HW detection should be done in kernel, or if it 
should be done in Bootloader. But it may be more complex, to add the 
st,use_ckin in kernel DT if bootloader detects this translator.


Regards,
Yann

> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

