From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] MMC: error handling improvements
Date: Wed, 16 Feb 2011 19:41:42 +0100
Message-ID: <AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:53085 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1BPSln convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 13:41:43 -0500
Received: by pxi15 with SMTP id 15so240063pxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 10:41:43 -0800 (PST)
In-Reply-To: <8yaoc6c7tan.fsf@huya.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

2011/2/16 David Brown <davidb@codeaurora.org>:
> On Tue, Feb 15 2011, Russell King - ARM Linux wrote:
>
>> This patch is for RFC only; it needs splitting up somewhat. =A0Howev=
er, I
>> wanted to get it out there for some comment.
>
> Just for kicks, I applied this and ran it on an MSM target (8x50). =A0=
It
> seems to cause lots of:
>
> =A0mmc0: Data timeout
> =A0mmc0: Controller has been re-initialized
> =A0...
> =A0mmc0: Data CRC error
>
> and I can post more if you would find them interesting. =A0Eventually=
 the
> MSM mmc driver derefernces a null pointer in the interrupt code.
>
> It's also possible this is finding problems in our SDCC driver.

The SDCC is obviously an MMCI derivate, VHDL hacking
on top of ARMs source code for PL180/PL181.

Why do you insist on maintaining a forked driver?

Please consider switching to using mmci.c like everyone else.
The quirks we have in place for U300, Nomadik and Ux500
should show you the way for how to do this (yes we did the
same thing, hacking the ARM VHDL).

If I remember correctly I could even see that some early
Android sources were using Russells mmci.c driver before this
fork was created.

Yours,
Linus Walleij
