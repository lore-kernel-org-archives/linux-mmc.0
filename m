Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE87C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 05:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8295761152
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 05:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhKJFrY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Nov 2021 00:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhKJFrY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2021 00:47:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6BC061764;
        Tue,  9 Nov 2021 21:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=XKGeqJIYO+lXOLSgLOgckhybYcbrlqamxdYjsBQnxnk=; b=h/JHkgtP2VJG+QeaETTKQCAlPS
        aBL+9ZBuv9V32CD0/9dX+CDu/sknLiG0Dj3M3F2o8WFWqQBTmyVvlduhTsZB8PQDmghwSvPtOo+Lw
        Quy8l2BF3Q0q9QCblIqAUBi5G0wsRzSSh7kODpcIcv1LddmRdPauh8lnYty4mYYOshL8qSZFaJept
        X+Xrnjy4rlLWLNCTa3aFnqyKQnHifHCM6YAnyEqgks1R6PA/c1Kr6MwTeteIsWqn2uT+JESJKcGl0
        23pAQUvpGRhf4OGTaezO0Qu0+oskTaBYqFSc4KyXGTaOqEsLRyd8bHTop43+gjt7dPGfK8k1BMkl1
        AAtqtxlQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkgPM-004VRj-FR; Wed, 10 Nov 2021 05:44:29 +0000
Subject: Re: [PATCH v2 1/2] mmc: Add SD/SDIO driver for Sunplus SP7021
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>,
        "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-2-git-send-email-lh.kuo@sunplus.com>
 <6c5c6e83-8176-8b4a-9c2c-f01a262de5de@infradead.org>
 <d25f2bff024b40fd9691960221c0bebe@sphcmbx02.sunplus.com.tw>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <92e8310d-0688-0df3-2422-4b179fd9cbbd@infradead.org>
Date:   Tue, 9 Nov 2021 21:44:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d25f2bff024b40fd9691960221c0bebe@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi--

On 11/9/21 9:40 PM, Lh Kuo 郭力豪 wrote:
> Hi
> 
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Wednesday, November 10, 2021 10:33 AM
>> To: LH.Kuo <lhjeff911@gmail.com>; p.zabel@pengutronix.de;
>> daniel.thompson@linaro.org; lee.jones@linaro.org;
>> u.kleine-koenig@pengutronix.de; ulf.hansson@linaro.org; robh+dt@kernel.org;
>> linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org;
>> devicetree@vger.kernel.org
>> Cc: qinjian@cqplus1.com; Wells Lu 呂芳騰 <wells.lu@sunplus.com>; Lh Kuo
>> 郭力豪 <lh.Kuo@sunplus.com>
>> Subject: Re: [PATCH v2 1/2] mmc: Add SD/SDIO driver for Sunplus SP7021
>>
>> Hi--
>>
>> On 11/8/21 11:58 PM, LH.Kuo wrote:
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 5af8494..2aba9eb 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -1091,5 +1091,15 @@ config MMC_OWL
>>>    	  This selects support for the SD/MMC Host Controller on
>>>    	  Actions Semi Owl SoCs.
>>>
>>> +config MMC_SP_SDV2
>>> +	tristate "Sunplus SP7021 SD/SDIO Controller"
>>> +	depends on SOC_SP7021
>>> +	help
>>> +		If you say yes here, you will get support for SD/SDIO host interface
>>> +		on sunplus Socs.
>>
>> 		   Sunplus SoCs.
>>
>>> +		If you have a controller with this interface, say Y or M here.
>>> +		If unsure, say N.
>>
>> All 4 lines of help text should be indented only with one tab + 2 spaces,
>> not 2 tabs, per coding-style.rst.
>>
>>
>>> +                Sunplus  SD/SDIO Host Controller support"
>>
>> I am thinking that this last line should not be here at all... ???
>>
>>
>> thanks.
>> --
>> ~Randy
> 
> 
> I will make change as below  is it OK ?
> 
> config MMC_SP_SDV2
> 	tristate "Sunplus SP7021 SD/SDIO Controller"
> 	depends on SOC_SP7021
> 	help
> 	  This selects the Sunplus Host Controller Interface
> 	  support present in Sunplus SP7021 SOCs. The controller supports
> 	  SD/SDIO devices.
> 		
> 		If you have a controller with this interface, say Y or M here.
> 		
> 		If unsure, say N.

Too much indentation on the last 2 (non-blank) help text lines.
Should just be one tab + 2 spaces, not 2 tabs.


-- 
~Randy
