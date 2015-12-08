From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
Date: Tue, 8 Dec 2015 14:17:44 +0100
Message-ID: <CAPDyKFrVQ_4u9rYN41w8y+uZwgxSCHZzpPRUTa5RswTkapOFTQ@mail.gmail.com>
References: <1449528845-25189-1-git-send-email-tony@atomide.com>
	<CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
	<20151208003213.GU23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33835 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbbLHNRo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2015 08:17:44 -0500
Received: by qkdp187 with SMTP id p187so27752091qkd.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2015 05:17:44 -0800 (PST)
In-Reply-To: <20151208003213.GU23396@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

On 8 December 2015 at 01:32, Tony Lindgren <tony@atomide.com> wrote:
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
> Yes it broke WLAN for omap5 that I just got fixed.. It only uses the clocks
> art of the pwrseq currently because of the delay needed.
>
>> Also, I am interested to know more about the waiting period you need.
>> I assume that's because of the HW's characteristic?
>
> At least TI wl12xx and Marvell 8787 need a delay after enabling the the WLAN.
>
>> Why can't we have that being described in DT and then make
>> pwrseq_simple *wait* if needed?
>
> We can, but I'm thinking that we might be better off adding support for
> regulators to pwrseq. Both TI wl12xx and Marvell 8787 get power from the
> battery, and probably have an integrated regulator.

Sounds very reasonable! Perhaps some of the delays can be handled
within the context of the regulator then!?

>
> Also, the delay and the power up sequencey can be more complicated than what
> we currently support. In the 8787 case, pdn pin needs to be asserted for 300ms
> after power pins are stable and while reset is held high.

I am for sure open to extend pwrseq_simple, please go ahead!

The initial version provided a proof of concept and the
infrastructure. I expect and want people to extend it to suit their
HWs.

If we at some point find that pwrseq_simple starts to become too
complex, we may add another pwrseq type with a corresponding new
compatible string.

[...]

Kind regards
Uffe
