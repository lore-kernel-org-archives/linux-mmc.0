Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E89C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1349233F8
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAMLyU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbhAMLyT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:54:19 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40917C061575
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:53:24 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DG5R31QNXz1s8vN;
        Wed, 13 Jan 2021 12:52:31 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DG5R30ctsz1tSQB;
        Wed, 13 Jan 2021 12:52:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id WdqOKE_5sjir; Wed, 13 Jan 2021 12:52:29 +0100 (CET)
X-Auth-Info: +dZY/g2E08KBBiW1kSe0TgijeYyITzju1CFoH6PC2Bc=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 13 Jan 2021 12:52:29 +0100 (CET)
Subject: Re: [PATCH] [RFC] mmc: mmci: Add support for probing bus voltage
 level translator
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210105140718.122752-1-marex@denx.de>
 <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
 <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
 <CAPDyKFo5Sqxj31owrnmz1sTZqgW_PtZM2H=pDPBz+9hc0W0hHA@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <77dd612b-23f0-1f77-797a-9cde512926e3@denx.de>
Date:   Wed, 13 Jan 2021 12:52:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo5Sqxj31owrnmz1sTZqgW_PtZM2H=pDPBz+9hc0W0hHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/13/21 12:38 PM, Ulf Hansson wrote:
[...]
>>>>    static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
>>>>    {
>>>>           struct mmci_host *host = mmc_priv(mmc);
>>>> @@ -1913,7 +1973,7 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
>>>>           if (of_get_property(np, "st,neg-edge", NULL))
>>>>                   host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
>>>>           if (of_get_property(np, "st,use-ckin", NULL))
>>>> -               host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
>>>> +               mmci_probe_level_translator(mmc);
>>>
>>> I think you can make this change bit less invasive. Rather than having
>>> to shuffle code around in ->probe(), I suggest you call
>>> mmci_probe_level_translator() outside and after mmci_of_parse() has
>>> been called.
>>>
>>> In this way, you can also provide mmci_probe_level_translator() with a
>>> struct mmci_host *, rather than having to pick it up from
>>> mmc_priv(mmc), if you see what I mean.
>>>
>>> Of course, this also means in mmci_probe_level_translator() you will
>>> have to check if MCI_STM32_CLK_SELCKIN has been set, and if not then
>>> do an early return.
>>
>> Testing the translator presence when checking whether its enabled in DT
>> seems like the right place, but that's really just an implementation detail.
>>
>> I am more interested in knowing whether adding
>> mmci_probe_level_translator() is even acceptable in the first place. Is it ?
> 
> Honestly, I don't know.
> 
> I think I need to defer that question to Linus Walleij. And of course,
> it would be nice to get the opinion from Ludovic as well.

Good, that's what I was hoping for too.
