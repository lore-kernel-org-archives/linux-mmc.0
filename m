From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
Date: Fri, 18 Dec 2015 23:19:58 +0100
Message-ID: <CAPDyKFr8e6wDxkGwnOwijQiOgF7oq6gCoHmqbubv6oSbpYbwqg@mail.gmail.com>
References: <1449528845-25189-1-git-send-email-tony@atomide.com>
	<CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
	<20151218161406.GL23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35345 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbbLRWT7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2015 17:19:59 -0500
Received: by mail-yk0-f172.google.com with SMTP id v6so74308042ykc.2
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2015 14:19:59 -0800 (PST)
In-Reply-To: <20151218161406.GL23396@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

On 18 December 2015 at 17:14, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [151207 16:20]:
>> +Linus
>>
>> On 7 December 2015 at 23:54, Tony Lindgren <tony@atomide.com> wrote:
>> > Commit ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
>> > changed the handling MMC power sequence so GPIOs no longer are optional.
>> >
>> > This broke SDIO WLAN at least for omap5 that can't yet use the reset GPIOs
>> > with pwrseq_simple as a wait is needed after enabling the SDIO device.
>>
>> Can you elaborate on this. Did it break omap5 or not? :-)
>
> Ulf, is this patch queued for v4.4 as a regression fix? I don't see it
> in Linux next or mainline trees?

Ohh, I guess there where some misunderstanding. I made a bunch of
comments on your patch as well, so I have been expecting a new
version.

Sorry if that was unclear!

Kind regards
Uffe
