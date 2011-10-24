From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 12:17:01 +0200
Message-ID: <4EA53B1D.9090208@stericsson.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com> <20111021173637.GG21648@n2100.arm.linux.org.uk> <CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com> <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com> <20111024093632.GH9893@n2100.arm.linux.org.uk> <CACRpkdY6rzYsYQW+GACL6Ux8o=Eo-3wn62O0YZxJZ=F2WbE4DQ@mail.gmail.com> <20111024095638.GJ9893@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:53340 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754061Ab1JXKRY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 06:17:24 -0400
In-Reply-To: <20111024095638.GJ9893@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Russell King - ARM Linux wrote:
> On Mon, Oct 24, 2011 at 11:54:00AM +0200, Linus Walleij wrote:
>> On Mon, Oct 24, 2011 at 11:36 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Sun, Oct 23, 2011 at 02:31:39AM +0200, Sebastian Rasmussen wrote:
>>>> I guess the patch would appeal more to Russell if mmci_runtime_suspend()
>>>> only cleared MCIMask0/SDI_MASK0 and MCIClock/SDI_CLKCR and left
>>>> MCIPower/SDI_PWR unchanged. It may be the case that the signal direction
>>>> bits need to be cleared for the ST-Ericsson PL180, but I haven't yet verified
>>>> this on my Snowball dev board yet.
>>> There's also the issue that the specs call for the clock to run after
>>> a command has completed for a certain number of cycles, and that the
>>> clock must continue to run until the card reports not-busy after a
>>> programming or erase cycle has completed - that can be long after the
>>> previous command has 'completed'.
>> It's 8 cycles on MCLK required.
> 
> _Plus_ keeping the clock running while the card is signalling busy.
> 
> If you don't clock the card while its signalling busy, it will never
> go non-busy (the data line becomes frozen.)
> 

Good point!

Is the aggressive clk gating feature in the mmc framework taking this 
into account as well?

Potentially the framework could do a get_sync/put (in claim/release 
host) to prevent hosts from being runtime disabled. Similar how the 
enable/disable mechanism is working.

