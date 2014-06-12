From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] MMC updates for 3.16-rc1
Date: Thu, 12 Jun 2014 08:41:40 +0200
Message-ID: <CAPDyKFrWdPGnNrFnY-zt9_MoFVH-S1vgOCNyrb-4sqxBEeaN-A@mail.gmail.com>
References: <86ha3so84o.fsf@void.printf.net>
	<CA+55aFxBwteZeUHG+Z-cdLU_YCO4f8TDuYvGmXc0-v9M1H11+g@mail.gmail.com>
	<CA+55aFyEbFLFWLKP5kHw85qTRNoviFk8LhivxXJgAMROdvJtsg@mail.gmail.com>
	<Pine.LNX.4.64.1406120724100.5160@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:41984 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbaFLGll (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jun 2014 02:41:41 -0400
Received: by mail-qa0-f50.google.com with SMTP id m5so1108506qaj.9
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jun 2014 23:41:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1406120724100.5160@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Chris Ball <chris@printf.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 12 June 2014 07:25, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Linus,
>
> On Wed, 11 Jun 2014, Linus Torvalds wrote:
>
>> On Tue, Jun 10, 2014 at 2:50 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >
>> > Also, that new drivers/mmc/host/usdhi6rol0.c driver is one f*cking
>> > noisy compile, and knisr certainly has never been tested in a 64-bit
>> > environment. Please either fix it, or make it depend on BROKEN.
>>
>> Guys? Seriously, if that driver isn't fixed, I'm going to mark it
>> broken myself. It pretty much generates as many lines of warnings as
>> the rest of my "allmodconfig" build combined.
>>
>> It's extremely annoying, and the crazy warnings are likely to hide
>> potential real problems elsewhere, so right now that driver has
>> negative value. I do a lot of allmodconfig builds during the merge
>> window, and I am not going to look at that warning much longer.
>>
>> Fix it promptly, or it gets disabled.
>
> I sent a patch a few hours ago:
> https://patchwork.kernel.org/patch/4338531/ Since it's only changing print
> format strings, it should be a trivial one to review, so, just waiting for
> Chris to pick it up and push it to you. Sorry about the trouble.

I pick it up, and likely together with few other fixes and send a PR
to Linus in a few hours.

Kind regards
Ulf Hansson


>
> Thanks
> Guennadi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
