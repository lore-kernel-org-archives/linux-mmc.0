Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E1C3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 11:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DE120724
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 11:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDTL6k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:58:40 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58240 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgDTL6j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 07:58:39 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 495QFn46Vnz1qsjf;
        Mon, 20 Apr 2020 13:58:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 495QFm3N2qz1qtwV;
        Mon, 20 Apr 2020 13:58:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id S6ujsEzZ06o3; Mon, 20 Apr 2020 13:58:34 +0200 (CEST)
X-Auth-Info: 6ZJTbsWqyJl7sbVBt/0oWoYQgpCoYVtXW+ihheJuOrY=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 20 Apr 2020 13:58:34 +0200 (CEST)
Subject: Re: [PATCH V2 1/3] mmc: Prepare all code for
 mmc_regulator_set_vqmmc() returning > 0
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
References: <20200416163649.336967-1-marex@denx.de>
 <CAPDyKFqztJDfTrc+1q9mdyf0f2s=gE91J3eM92rzmm+FJNBW9A@mail.gmail.com>
 <11a78052-6320-2986-42b0-3f5536b8c061@denx.de>
 <CAPDyKFpQXaQ+rOX7f+zLfG2Q6fX3FsDk8d+uBtxAcLNkKPhAxQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <40498fad-0eb7-026c-a410-f9958f695d53@denx.de>
Date:   Mon, 20 Apr 2020 13:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpQXaQ+rOX7f+zLfG2Q6fX3FsDk8d+uBtxAcLNkKPhAxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/20/20 10:18 AM, Ulf Hansson wrote:
> On Fri, 17 Apr 2020 at 17:33, Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/17/20 11:30 AM, Ulf Hansson wrote:
>>> On Thu, 16 Apr 2020 at 18:36, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Patch all drivers which use mmc_regulator_set_vqmmc() and prepare them for
>>>> the fact that mmc_regulator_set_vqmmc() can return a value > 0, which would
>>>> happen if the signal voltage switch did NOT happen, because the voltage was
>>>> already set correctly.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Cc: Alexandre Torgue <alexandre.torgue@st.com>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: Ludovic Barre <ludovic.barre@st.com>
>>>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>>> Cc: Patrice Chotard <patrice.chotard@st.com>
>>>> Cc: Patrick Delaunay <patrick.delaunay@st.com>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Cc: linux-stm32@st-md-mailman.stormreply.com
>>>> To: linux-mmc@vger.kernel.org
>>>
>>> Applied for next, thanks!
>>>
>>> I took the liberty to re-work and simplify some of the code, please
>>> have a look at my next branch to make sure I didn't screw something
>>> up.
>>
>> Where is your next branch ?
> 
> It's listed in the MAINTAINERS file.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

All right, this one. The adjustments look OK, thanks.

I noticed this one in mtk-sd.c:
/* Apply different pinctrl settings for different signal voltage */
if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
	pinctrl_select_state(host->pinctrl, host->pins_uhs);
else
	pinctrl_select_state(host->pinctrl, host->pins_default);

I would almost think that the MTK platforms would support 1V2 modes too,
so the above should rather be:

if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
	pinctrl_select_state(host->pinctrl, host->pins_default);
else
	pinctrl_select_state(host->pinctrl, host->pins_uhs);

But I have no hardware to test, and it's a topic for another patch.
