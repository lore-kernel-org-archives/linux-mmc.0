Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3BC352BE
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D092F206B9
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 14:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394630AbgDPOpt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:45:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59665 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgDPOp2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 10:45:28 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4932855s3kz1qs0p;
        Thu, 16 Apr 2020 16:45:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49328549w7z1qr41;
        Thu, 16 Apr 2020 16:45:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id t3tG6krWam4d; Thu, 16 Apr 2020 16:45:24 +0200 (CEST)
X-Auth-Info: GYv5afvF6lwk4PgXwg2jbVatvzq66dJF1aHOuKPA3yc=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Apr 2020 16:45:24 +0200 (CEST)
Subject: Re: [PATCH 1/3] mmc: Prepare all code for mmc_set_signal_voltage()
 returning > 0
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
References: <20200401195722.208157-1-marex@denx.de>
 <CAPDyKFoDB=d5B-2u_Y0e-XVzPQE46JBUTPwY_b_xzESm3NnjwQ@mail.gmail.com>
 <58d6bc7a-b772-e8cc-6120-b0adeb128070@denx.de>
 <CAPDyKFrAgLMUqU4oSRX64VoDQMMFZuM3KtUq6SL770XDSc+QbQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <20d299ab-ea7e-be85-7c5b-fd10e21a117d@denx.de>
Date:   Thu, 16 Apr 2020 16:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrAgLMUqU4oSRX64VoDQMMFZuM3KtUq6SL770XDSc+QbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/16/20 2:07 PM, Ulf Hansson wrote:
> On Thu, 16 Apr 2020 at 12:29, Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/15/20 10:40 AM, Ulf Hansson wrote:
>>> On Wed, 1 Apr 2020 at 21:57, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Patch all drivers and core code which uses mmc_set_signal_voltage()
>>>> and prepare it for the fact that mmc_set_signal_voltage() can return
>>>> a value > 0, which would happen if the signal voltage switch did NOT
>>>> happen, because the voltage was already set correctly.
>>>
>>> I am not sure why you want to change mmc_set_signal_voltage(), can you
>>> elaborate on that?
>>>
>>> I thought we discussed changing mmc_regulator_set_vqmmc(), what am I missing?
>>
>> Because mmc_set_signal_voltage() optionally calls
>> host->ops_>start_signal_voltage_switch() , which can now return value >
>> 0 , so the rest of the core needs to be patched to cater for that.
> 
> The issue that you wanted to solve (at least by looking at the
> original patch) was to understand whether the vqmmc regulator changes
> voltage level and then take different actions based on that in the
> mmci host driver.
> 
> You don't need to change anything related to mmc_set_signal_voltage()
> to accomplish that, do you? Moreover, I am worried that it may affect
> the host driver's expectations from when
> ->start_signal_voltage_switch() may be called.

So, shall I just patch all the sites which use mmc_regulator_set_vqmmc()
with something like

return mmc_regulator_set_vqmmc();
becomes
ret = mmc_regulator_set_vqmmc();
if (ret > 0)
	ret = 0;
return ret;

?
