Return-Path: <SRS0=Vjr6=5R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA43C43331
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A839220737
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 19:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbgDAT7z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:59:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57344 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbgDAT7y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2020 15:59:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48sxqn17jPz1rmgX;
        Wed,  1 Apr 2020 21:59:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48sxqm55ZKz1r0cc;
        Wed,  1 Apr 2020 21:59:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ARRSFarqvGyk; Wed,  1 Apr 2020 21:59:47 +0200 (CEST)
X-Auth-Info: 4zaLNIcWZJ0OWFfwvO7Y1We/SkNclQpUKNMfR0QzUbg=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  1 Apr 2020 21:59:47 +0200 (CEST)
Subject: Re: [PATCH] mmc: mmci: Only call .post_sig_volt_switch if voltage
 switch happened
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
References: <20200331155254.100952-1-marex@denx.de>
 <CAPDyKFrypbDEuDaGWySjC6j_qKbXpVHoubhh8e9jS24JSzBg3Q@mail.gmail.com>
 <7a7c0180-0a11-17b2-7815-b18b1ca11120@denx.de>
 <CAPDyKFoEFe=fru0=HCTzG2CikGA72hFWK0y6iL_EN6BDK3Vtkw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <29a4a198-db29-447a-fa64-68de9430cd07@denx.de>
Date:   Wed, 1 Apr 2020 21:59:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoEFe=fru0=HCTzG2CikGA72hFWK0y6iL_EN6BDK3Vtkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/1/20 10:16 AM, Ulf Hansson wrote:
> On Tue, 31 Mar 2020 at 23:01, Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/31/20 8:53 PM, Ulf Hansson wrote:
>>> On Tue, 31 Mar 2020 at 17:53, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Call the post voltage switch handler only if the voltage switch actually
>>>> happened. It is well possible that the regulator is already set correctly
>>>> and no voltage switch happened, so there is no need to take any further
>>>> action.
>>>>
>>>> This fixes a real issue on STM32MP1 where, if the eMMC is supplied with
>>>> VccQ=1.8 V, the post voltage switch code will spin indefinitelly waiting
>>>> for the voltage switch to complete, even though no voltage switch really
>>>> happened.
>>>
>>> Whether this is a common problem or not, I think in a first step we
>>> should manage this in the common mmc_regulator_set_vqmmc().
>>
>> I can pass in a variable which would be set if a voltage switch actually
>> happened in mmc_regulator_set_vqmmc() OR I can return a code > 0 from
>> there. Which one do you prefer?
> 
> Return a code > 0.
> 
>>
>> Then I guess we can add something like
>>
>> if (regulator_get_voltage(...vqmmc) is already in voltage range)
>>  return 1;
>>
>> ...
>>
>> and the MMCI driver would do something like
>>
>> if (mmc_regulator_set_vqmmc(...) > 0)
>>  host->ops->post_sig_volt_switch(...);
>>
>> That looks OK I guess ?
>>
>>> Then on top of that, convert mmci into using the mmc_regulator_set_vqmmc() API.
>>>
>>> Can please try this approach instead?
>> Sure. Does the above look sane ?
> 
> Yes, great!

The resulting patch doesn't really look all that great, but I sent out a
small series.
