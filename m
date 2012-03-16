From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Fri, 16 Mar 2012 09:48:07 +0100
Message-ID: <4F62FE47.8020709@stericsson.com>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com> <20120315173047.GB17243@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:60152 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757310Ab2CPIsj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 04:48:39 -0400
In-Reply-To: <20120315173047.GB17243@flint.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

Hi Russell,

On 03/15/2012 06:30 PM, Russell King wrote:
> On Thu, Mar 15, 2012 at 03:30:36PM +0100, Linus Walleij wrote:
>> From: Linus Walleij<linus.walleij@linaro.org>
>>
>> So since this driver is crucial for us (as in ST-Ericsson)
>> to have actively maintained, and since it is marked orphaned
>> I will assume maintainership for it starting with the 3.5
>> integration cycle. The idea is to collect patches and send
>> either patch sets of pull requests to Chris.
>
> Actually, I still want to be involved because I'm far from convinced with
> some of the patches coming from Ulf are correct for ARMs implementation.
> That's why I'm purposely not applying the MMCI patches in the patch system
> in a particularly fast manner - I want there to be a decent amount of
> testing between each set of patches.
>

Without going into too much details about the patches I will just say 
that I have very much appreciated your review comments on my patches 
historical. That has definitely improved the quality and I have gained 
even more knowledge. Thanks a lot!

Although, right know I would vote for having a more active maintainer 
for MMCI; please no offense Russell, I realize that your are fully 
occupied with a lot of other cool stuff. I think Linus could play a 
great role in this; especially since he also will be able to test 
patches on many different ARM boards.


> For example, the next patch in the series to be applied is:
>
> "mmc: mmci: Decrease current consumption in suspend"
>
> and as I've explained before, it does this by saving the MMCI power and
> clock registers and clearing them.  This has the effect of stopping the
> clock, and in the case of ARMs hardware, removing power from the card.
> Therefore, the card will require full bring up, including reassigning
> the card address for MMC cards on resume, and simply starting the next
> command will not be possible.
>
> As I've already tried to explain, on the normal power management suspend
> callback, these registers should _already_ have been placed into their
> "card not present" state, so saving and zeroing them has no useful effect.
>
> Moreover, saving and restoring them across suspend is wrong because on
> ARM hardware there's a sequence of power-off, power-up, power-on which
> needs to be gone through to restore power.
>
> So, I've queued up the 10 patches which I'm happy to take for v3.4, and
> that's all I'm taking for v3.4 until I can find the strength to have
> another discussion with Ulf over this issue.

I have yet not gained your full confidence, but I will continue to work 
on it. :-)

Regarding the around 10 patches; since it lately has been very responses 
to my patches for MMCI, I have hesitated to send more patches. 
Internally at STE kernel git, we have around additional 10 patches... 
bugfixes, cleanups and new features (UHS support, DDR support).

>
> As there's an interdependence between the various patches, I can't apply
> any of the later patches even if I wanted to without these "power saving"
> patches.
>
> So, it's not really unmaintained or orphaned...
>

Kind regards
Ulf Hansson

