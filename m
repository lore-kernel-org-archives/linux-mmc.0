Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246BCC2BB85
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 10:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8221D91
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 10:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505012AbgDPK3o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:29:44 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36353 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504990AbgDPK3Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 06:29:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 492wSV5QF4z1rxwD;
        Thu, 16 Apr 2020 12:29:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 492wST1pVdz1qql2;
        Thu, 16 Apr 2020 12:29:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0DYRRijQeN0m; Thu, 16 Apr 2020 12:29:11 +0200 (CEST)
X-Auth-Info: /XEEsugNMl+LmNBN+5lO+hx+UQo4PhpvciL91yDHS5o=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Apr 2020 12:29:11 +0200 (CEST)
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
From:   Marek Vasut <marex@denx.de>
Message-ID: <58d6bc7a-b772-e8cc-6120-b0adeb128070@denx.de>
Date:   Thu, 16 Apr 2020 12:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoDB=d5B-2u_Y0e-XVzPQE46JBUTPwY_b_xzESm3NnjwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/15/20 10:40 AM, Ulf Hansson wrote:
> On Wed, 1 Apr 2020 at 21:57, Marek Vasut <marex@denx.de> wrote:
>>
>> Patch all drivers and core code which uses mmc_set_signal_voltage()
>> and prepare it for the fact that mmc_set_signal_voltage() can return
>> a value > 0, which would happen if the signal voltage switch did NOT
>> happen, because the voltage was already set correctly.
> 
> I am not sure why you want to change mmc_set_signal_voltage(), can you
> elaborate on that?
> 
> I thought we discussed changing mmc_regulator_set_vqmmc(), what am I missing?

Because mmc_set_signal_voltage() optionally calls
host->ops_>start_signal_voltage_switch() , which can now return value >
0 , so the rest of the core needs to be patched to cater for that.

[...]

>> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
>> index 23b6f65b3785..50977ff18074 100644
>> --- a/drivers/mmc/host/dw_mmc-k3.c
>> +++ b/drivers/mmc/host/dw_mmc-k3.c
>> @@ -424,7 +424,7 @@ static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
>>
>>         if (!IS_ERR(mmc->supply.vqmmc)) {
>>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
>> -               if (ret) {
>> +               if (ret < 0) {
> 
> This change makes sense to me, however it's also a bit confusing, as
> the changelog refers to changes for mmc_set_signal_voltage().
> 
> As I understand it, we want mmc_regulator_set_vqmmc() to return 1, in
> case the current voltage level is the same as the requested "new"
> target".

Yes. So a failure is now only a return value < 0.

>>                         dev_err(host->dev, "Regulator set error %d\n", ret);
>>                         return ret;
>>                 }
> 
> [...]
> 
> So, to conclude, it seems like $subject patch needs to be reworked a
> bit - just keep the changes you have made to the host drivers, then
> throw away the other parts in core.

I think the core parts are necessary as well though , see above.
