From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support for DCFG node
Date: Fri, 11 Dec 2015 09:26:52 +0100
Message-ID: <CAPDyKFpMruD0M+JB9jwuk1xTRcVRpJYNh7+DAT+22Tu2orS9wg@mail.gmail.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	<1448594417-22515-5-git-send-email-yangbo.lu@freescale.com>
	<1449596781.15946.126.camel@freescale.com>
	<BLUPR0301MB2065B5878A43F66982D6B30BF2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
	<1449635607.15946.165.camel@freescale.com>
	<BLUPR0301MB206558CB317D48AC5CEF3642F2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
	<1449680419.15946.176.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35226 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbbLKI0x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2015 03:26:53 -0500
Received: by qkfb125 with SMTP id b125so28210875qkf.2
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2015 00:26:52 -0800 (PST)
In-Reply-To: <1449680419.15946.176.camel@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>, Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Xiaobo-R63061 <X.Xie@freescale.com>, Li Yang-Leo-R58472 <LeoLi@freescale.com>

[...]

>> > > The fsl_get_svr() you suggested is also an idea for this.
>> > > Then, may I know is there a guts driver in kernel?
>> > > Thanks a lot.
>> >
>> > There isn't, but there should be.
>> >
>> > -Scott
>>
>> [Lu Yangbo-B47093] Ok, I'd like to try. But can you suggest where we should
>> put the guts driver in kernel?
>> Thanks.
>
> drivers/soc/fsl/
>

Okay, go ahead and have a try.

BTW, there is actually also a corresponding include directory to use

/include/linux/soc/..

Please keep me posted.

Kind regards
Uffe
