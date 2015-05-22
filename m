From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2, 1/2] powerpc/dts: add eSDHC compatible list
Date: Fri, 22 May 2015 15:47:44 +0200
Message-ID: <CAPDyKFpsRcuoakWSgSRJ7AbePrVQBtJW18eytsS+i4ArsnWGxQ@mail.gmail.com>
References: <1431657962-42443-1-git-send-email-yangbo.lu@freescale.com>
	<1431735910.3868.213.camel@freescale.com>
	<CAPDyKFrFdnnq6esR-JPB30sPnT_DZAUvgP9_3rN8O6A9f+8Hpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35779 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059AbbEVNrp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2015 09:47:45 -0400
Received: by qkdn188 with SMTP id n188so11537795qkd.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2015 06:47:44 -0700 (PDT)
In-Reply-To: <CAPDyKFrFdnnq6esR-JPB30sPnT_DZAUvgP9_3rN8O6A9f+8Hpw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, Scott Wood <scottwood@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 18 May 2015 at 11:03, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 May 2015 at 02:25, Scott Wood <scottwood@freescale.com> wrote:
>> On Fri, 2015-05-15 at 10:46 +0800, Yangbo Lu wrote:
>>> Add eSDHC compatible list for P2041/P3041/P4080/P5020/P5040.
>>>
>>> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>>> ---
>>>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
>>>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
>>>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
>>>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
>>>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
>>>  5 files changed, 5 insertions(+)
>>
>> Acked-by: Scott Wood <scottwood@freescale.com>

Thanks, applied.

Kind regards
Uffe
