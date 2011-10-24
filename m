From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 11:14:16 +0100
Message-ID: <20111024101416.GK9893@n2100.arm.linux.org.uk>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com> <20111021173637.GG21648@n2100.arm.linux.org.uk> <CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com> <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com> <4EA51C4A.7040802@stericsson.com> <20111024090432.GA9893@n2100.arm.linux.org.uk> <4EA53181.2050700@stericsson.com> <20111024094203.GI9893@n2100.arm.linux.org.uk> <4EA538A3.9070501@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57932 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab1JXKO1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 06:14:27 -0400
Content-Disposition: inline
In-Reply-To: <4EA538A3.9070501@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

On Mon, Oct 24, 2011 at 12:06:27PM +0200, Ulf Hansson wrote:
> Russell King - ARM Linux wrote:
>> On Mon, Oct 24, 2011 at 11:36:01AM +0200, Ulf Hansson wrote:
>>> Russell King - ARM Linux wrote:
>>>> I repeat: if you cut power to the card, you have to re-initialize it.
>>>> Re-initialization takes quite a bit of time to re-detect and setup
>>>> the card.  You'd also need to re-configure things like the transfer
>>>> mode and so forth.
>>> Right now host->vcc (vmmc) regulator is controlling the power to 
>>> card.  Not the MCIPWR register!
>>
>> Maybe for you, but that's not the case on all platforms.
>>
>> You *really* need to get out of the idea that just because your
>> implementation works one way that everything works that way.  You're
>> working on a cross-SoC cross-platform driver, and you need to take
>> account of how other platforms work.
>
> Sorry for being a pain in the ass. :-) I am thinking of the above, even  
> if it not seems like that.
>
>>
>> In that case, there *are* platforms which the MCIPWR register does
>> indeed control power to the card - and setting this to zero _will_
>> power down the card.
>>
>>> I would be very surprised if any hardware has this kind of setup, 
>>> that  the PL180 itself controls a regulator.
>>
>> ARM dev boards all use the MCIPWR bits to control an external power
>> switch - there's no adjustment of the voltage except via soldered
>> links on the board.
>
> That explains it!
>
> My believe was that since the bits for controlling the voltage levels  
> etc was not used (which is replaced with directions bits for  
> ST-version), this functionality was not used either.
>
> Could you maybe elaborate a bit of how the power is controlled in the  
> ARM dev boards? Would it be possible to control such a switch in "GPIO"  
> manner instead? For example via the vdd_handler or similar?
>
> I will also think if and see if is feasible to re-design and see if this  
> hole feature can be controlled by the variant struct instead. My feeling  
> is although it can be kind of messy. But let's see...

The MCIPWR register contains two bits to control _the_ _power_ _state_.
See Table A-4: the MCIPWR signal.  See section 2.2.2.  See section 3.3.1.

The MCIPWR signal controls the external power switch.  This is the only
signal for it.  This is the only connection for it.  There is no other
control form for this power switch.
