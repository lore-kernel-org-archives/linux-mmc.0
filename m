From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Mon, 18 May 2015 09:58:40 +0200
Message-ID: <CAPDyKFqa1O-=TvgH-XyXC0L+XkEBOp1vUkt9YhuuDdg=jjVdVw@mail.gmail.com>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
	<1431673364.13197.10.camel@transmode.se>
	<1431674695.13197.14.camel@transmode.se>
	<20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
	<1431693634.13197.29.camel@transmode.se>
	<20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
	<1431851766.6782.7.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34285 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbERH6l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 03:58:41 -0400
Received: by qkgx75 with SMTP id x75so104501036qkg.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2015 00:58:40 -0700 (PDT)
In-Reply-To: <1431851766.6782.7.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>, "haokexin@gmail.com" <haokexin@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 17 May 2015 at 10:36, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Sun, 2015-05-17 at 13:06 +0800, Kevin Hao wrote:
>> >
>> > How about this one:
>> >
>> > From af6b18c056b6064424bd2ab1f9989bbadae5e701 Mon Sep 17 00:00:00 2001
>> > From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
>> > Date: Mon, 20 Apr 2015 22:36:55 +0200
>> > Subject: [PATCHv3] sdhci-of-esdhc: Support 8BIT bus width.
>> >
>> > esdhc_readb()/esdhc_writeb() did not adjust for 8BIT.
>>
>> Do we really need this for the 8bit bus support? There is already a specific
>> API for setting the bus width, this change seems unnecessary to me. That is
>> also why I choose to revert that patch. Did I miss something?
>
> We do, the bus API really only works well when the bus bits are in another
> register but the HOST_CONTROL register.
> The only reason 4BIT works is because its bit placement is where
> SDHCI expects it to be. 8BIT is not, so unless readb/writeb funktions compensate
> for that they will overwrite what the bus API set earlier.
>
> Atleast this is my understanding, Ulf?

Sorry, I don't have enough knowledge about sdhci to give you good answer.

>
> Didn't this patch work for you either?

I have dropped the "sdhci-of-edsdhc: Support 8-bit..." from my next
branch for now.

A "Tested-by" confirmation of a new version of $subject patch, would
help me to know when it can go in.

Kind regards
Uffe
