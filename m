Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DB7C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE9E2313C
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbhAMOqC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:46:02 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:58090 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhAMOqC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 09:46:02 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DG9GF3d3mz1qw9v;
        Wed, 13 Jan 2021 15:45:09 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DG9GF194Mz1tYWc;
        Wed, 13 Jan 2021 15:45:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Qs4kinPvzBp8; Wed, 13 Jan 2021 15:45:08 +0100 (CET)
X-Auth-Info: e0i2lK6b5VfpekyATUmk8KQgP9D45XgI+JpoatpQhBE=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 13 Jan 2021 15:45:07 +0100 (CET)
Subject: Re: [Linux-stm32] [PATCH] [RFC] mmc: mmci: Add support for probing
 bus voltage level translator
To:     Yann GAUTIER <yann.gautier@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
References: <20210105140718.122752-1-marex@denx.de>
 <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
 <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
 <CAPDyKFo5Sqxj31owrnmz1sTZqgW_PtZM2H=pDPBz+9hc0W0hHA@mail.gmail.com>
 <77dd612b-23f0-1f77-797a-9cde512926e3@denx.de>
 <f91fbdfc-453d-78a6-970a-5d6eecd443b2@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <ccef7ae4-8cd7-4434-9632-917a4fb92f53@denx.de>
Date:   Wed, 13 Jan 2021 15:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f91fbdfc-453d-78a6-970a-5d6eecd443b2@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/13/21 3:21 PM, Yann GAUTIER wrote:
> On 1/13/21 12:52 PM, Marek Vasut wrote:
>> On 1/13/21 12:38 PM, Ulf Hansson wrote:
>> [...]
>>>>>>    static int mmci_of_parse(struct device_node *np, struct 
>>>>>> mmc_host *mmc)
>>>>>>    {
>>>>>>           struct mmci_host *host = mmc_priv(mmc);
>>>>>> @@ -1913,7 +1973,7 @@ static int mmci_of_parse(struct device_node 
>>>>>> *np, struct mmc_host *mmc)
>>>>>>           if (of_get_property(np, "st,neg-edge", NULL))
>>>>>>                   host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
>>>>>>           if (of_get_property(np, "st,use-ckin", NULL))
>>>>>> -               host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
>>>>>> +               mmci_probe_level_translator(mmc);
>>>>>
>>>>> I think you can make this change bit less invasive. Rather than having
>>>>> to shuffle code around in ->probe(), I suggest you call
>>>>> mmci_probe_level_translator() outside and after mmci_of_parse() has
>>>>> been called.
>>>>>
>>>>> In this way, you can also provide mmci_probe_level_translator() with a
>>>>> struct mmci_host *, rather than having to pick it up from
>>>>> mmc_priv(mmc), if you see what I mean.
>>>>>
>>>>> Of course, this also means in mmci_probe_level_translator() you will
>>>>> have to check if MCI_STM32_CLK_SELCKIN has been set, and if not then
>>>>> do an early return.
>>>>
>>>> Testing the translator presence when checking whether its enabled in DT
>>>> seems like the right place, but that's really just an implementation 
>>>> detail.
>>>>
>>>> I am more interested in knowing whether adding
>>>> mmci_probe_level_translator() is even acceptable in the first place. 
>>>> Is it ?
>>>
>>> Honestly, I don't know.
>>>
>>> I think I need to defer that question to Linus Walleij. And of course,
>>> it would be nice to get the opinion from Ludovic as well.
>>
>> Good, that's what I was hoping for too.
> 
> Hi,
> 
> Ludovic is out of office this week.
> 
> The feature of detecting a level translator seems to be quite generic, 
> and not dedicated to MMCI driver or the ST dedicated code, and with new 
> st,* properties. It may be in generic mmc code. But I'll let Linus 
> comment about that.
> 
> I also wonder if this HW detection should be done in kernel, or if it 
> should be done in Bootloader. But it may be more complex, to add the 
> st,use_ckin in kernel DT if bootloader detects this translator.

Lets not attempt to hide inobvious functionality in bootloaders, the 
kernel should be independent of bootloader where possible. And here it 
is clearly and easily possible.
