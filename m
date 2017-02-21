From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document
 pinctrl-ingenic
Date: Tue, 21 Feb 2017 12:20:10 +0100
Message-ID: <f19fea79c2616455f5f08070923428cc@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
 <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
 <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
 <fd3c507484a9ee34a08c9f92e60624db@mail.crapouillou.net>
 <CACRpkdbAA33FFrMgx-eZPmpBBfQ_hF+=dSu0hANVthdbadicDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:36622 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdBULUQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2017 06:20:16 -0500
In-Reply-To: <CACRpkdbAA33FFrMgx-eZPmpBBfQ_hF+=dSu0hANVthdbadicDg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

Le 2017-02-20 14:56, Linus Walleij a écrit :
> On Thu, Feb 9, 2017 at 6:28 PM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
> 
>> I was thinking that instead of having one pinctrl-ingenic instance 
>> covering
>> 0x600 of register space, and 6 instances of gpio-ingenic having 0x100 
>> each,
>> I could just have 6 instances of pinctrl-ingenic, each one with an 
>> instance
>> of gpio-ingenic declared as a sub-node, each handling just 0x100 of 
>> memory
>> space.
> 
> My head is spinning,  but I think I get it. What is wrong with the 
> solution
> I proposed with one pin control instance covering the whole 0x600 and 
> with 6
> subnodes of GPIO?
> 
> The GPIO nodes do not even have to have an address range associated 
> with
> them you know, that can be distributed out with regmap code accessing
> the parent regmap.

OK, but then each GPIO chip 'X' still need to know its offset in the 
register
area, which is (pinctrl_base + X * 0x100).
What's the best way to pass that info to the driver? (I assume it's not 
with
a custom DT binding...).

Regards,
-Paul
