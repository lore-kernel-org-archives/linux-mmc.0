Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF5EB64D7
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jun 2023 10:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjFUK2p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjFUK2o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jun 2023 06:28:44 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7EC1718
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 03:28:31 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 454BD84702;
        Wed, 21 Jun 2023 12:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687343298;
        bh=BW00PWpGlh7yYHRpVC26ZsA28wp0RU49ewRTlWz+bZY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zn/3mGZernOgBae8jRUw4PysQEDa2GF3V1pF2Fa4w6wEtcrVYVPYdo0Y69BXgvw9/
         t2W9/uGBBNeGmX/PirF6ZPUZM4tMNfe22jwGwgygWyJpAQS6QKSBH0DwJSGJmH3nzi
         hOMB4iLWsyGWIo+0WxtZvsYlLxP4qDATMvW/M15xYhVgILnGeMeeD/EHt3PQCSW7eu
         f8aDFZIJdmM1Dvbgb/GYLnSKooVvZdXip9EE1TCrokpAt2B9PeaSNaLNh4s2oC1jeR
         KtJGiZ3UG3HYCC4Vh01cPHEM57F7H4F1d8yYcB2GbVlV3AfIp3pwEpXaKvmztbRcsS
         6ZbTGdOWBsi/A==
Message-ID: <479e7562-b398-039c-8872-41e34de58a93@denx.de>
Date:   Wed, 21 Jun 2023 12:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/11] mmc: core: Use BIT() macro
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20230620104722.16465-1-marex@denx.de>
 <CAPDyKFqZ_r=gjpRm833ax4LwASCTGAuO0a0ABXo-kN8dtYje-Q@mail.gmail.com>
 <289cd876-e6e1-8610-bcb6-b0259c68fd89@denx.de>
 <CAPDyKFoLaYegCxw35XPNWuzg_F4M-UPho=+XweB+V4oCXaMxGA@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAPDyKFoLaYegCxw35XPNWuzg_F4M-UPho=+XweB+V4oCXaMxGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/21/23 11:18, Ulf Hansson wrote:
> On Wed, 21 Jun 2023 at 04:36, Marek Vasut <marex@denx.de> wrote:
>>
>> On 6/20/23 13:15, Ulf Hansson wrote:
>>> On Tue, 20 Jun 2023 at 12:47, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Use the BIT(n) macro instead of (1<<n), no functional change.
>>>> Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> I don't think the benefit of this change is worth it. For example,
>>> it's quite useful to run a git blame to see the history of what has
>>> happened.
>>
>> Understood.
>>
>> git blame does allow you to specify either --since or revision range though.
> 
> Yes, but I think you get my point.
> 
>>
>>> So, sorry, but I am not going to pick this up - or any other similar
>>> changes, at least for the core layer.
>>
>> Is this a policy of the mmc subsystem to reject all code clean ups then ?
> 
> Of course it isn't, I regularly pick up clean ups.
> 
> My point here is that the clean-up should make the code better, in
> some way. I don't think converting to the BIT macro helps in this
> regard. It may be preferred to use the BIT macro by some and by others
> not.

ACK
