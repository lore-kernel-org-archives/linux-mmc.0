From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Sat, 17 Mar 2012 08:58:09 +0000
Message-ID: <20120317085809.GD17243@flint.arm.linux.org.uk>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com> <20120315173047.GB17243@flint.arm.linux.org.uk> <4F62FE47.8020709@stericsson.com> <20120316085307.GC17243@flint.arm.linux.org.uk> <4F6306DC.5090601@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39154 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab2CQI6Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Mar 2012 04:58:24 -0400
Content-Disposition: inline
In-Reply-To: <4F6306DC.5090601@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

On Fri, Mar 16, 2012 at 10:24:44AM +0100, Ulf Hansson wrote:
> On 03/16/2012 09:53 AM, Russell King wrote:
>> On Fri, Mar 16, 2012 at 09:48:07AM +0100, Ulf Hansson wrote:
>>> Although, right know I would vote for having a more active maintainer
>>> for MMCI; please no offense Russell, I realize that your are fully
>>> occupied with a lot of other cool stuff. I think Linus could play a
>>> great role in this; especially since he also will be able to test
>>> patches on many different ARM boards.
>>
>> No, I explained why I haven't applied your other patches, and I explained
>> at the time my concerns with your patches which zero out and restore the
>> power and clock registers.  I repeated those concerns several times but
>> the issue never got resolved.
>>
>> So that gives me no other option than to slow down applying your patches.
>> It's not that I'm not being responsive.  It's that I'm purposely being
>> slow over these changes because comments on the patches don't seem to be
>> hitting home.
>>
>
> Then I totally misunderstood you. I did send you an explanation to why  
> the registers could be zeroed out, which you did not respond to.

Yes, because you completely misunderstood what I said to you.  I showed
you with extracts from the code what happens on suspend - the IOS
handler will be called to turn power off unless mmc_card_keep_power()
is set (which only a very few SDIO cards would set.)

You replied saying that if the IOS handler is called, the card power and
clock will be cut.  Yes, we both agree with that, that's not what I'm
trying to discuss.  What I'm trying to find out is why you want to save
the power and clock registers after that's happened, zero them, and then
simply restore them on resume.

When you can properly explain that, it may be that a better solution is
to fix the core such when mmc_card_keep_power() is set, it really does
only stop the power being cut on suspend, but still results in the core
asking for the clock to be stopped.

> Moreover, I did not receive any comments/acks on the other patches. Are  
> you only looking at the first one in a patch series or do you mean that  
> the other onces looks OK?

No idea, it's been such a long time since I looked at them that I've long
forgotten what I thought about the remainder.  What I do know is that I
could not apply any further patches without the one which is under
discussion.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
