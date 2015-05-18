From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2, 1/2] powerpc/dts: add eSDHC compatible list
Date: Mon, 18 May 2015 11:03:28 +0200
Message-ID: <CAPDyKFrFdnnq6esR-JPB30sPnT_DZAUvgP9_3rN8O6A9f+8Hpw@mail.gmail.com>
References: <1431657962-42443-1-git-send-email-yangbo.lu@freescale.com>
	<1431735910.3868.213.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34124 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbERJD2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 05:03:28 -0400
Received: by qgfa7 with SMTP id a7so31919260qgf.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2015 02:03:28 -0700 (PDT)
In-Reply-To: <1431735910.3868.213.camel@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 16 May 2015 at 02:25, Scott Wood <scottwood@freescale.com> wrote:
> On Fri, 2015-05-15 at 10:46 +0800, Yangbo Lu wrote:
>> Add eSDHC compatible list for P2041/P3041/P4080/P5020/P5040.
>>
>> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>> ---
>>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
>>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
>>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
>>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
>>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
>>  5 files changed, 5 insertions(+)
>
> Acked-by: Scott Wood <scottwood@freescale.com>
>
> -Scott

Hi Scott,

Does the above ack mean you want me to pick up and take it through my mmc tree?

Kind regards
Uffe
