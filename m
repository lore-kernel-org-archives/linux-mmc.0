From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 22 Feb 2011 01:46:17 -0600
Message-ID: <AANLkTi=ZOUrNoT1W1n3d+9KTMewKZ3kxo71AQsas9OpD@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102171647.46190.arnd@arndb.de>
	<AANLkTimGrT_p_5xdXJv5UURPMC0cwJCPkZ=xcX5Nk=o=@mail.gmail.com>
	<201102201539.08496.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:59839 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab1BVHqV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 02:46:21 -0500
In-Reply-To: <201102201539.08496.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Sun, Feb 20, 2011 at 8:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> [adding linux-fsdevel to Cc, see http://lwn.net/Articles/428941/ and
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/105607 for more
> on this discussion.]
>
>
> I think it's good to discuss all the options, but my feeling is that
> we should not add so much complexity at the interface level, because
> we will never be able to change all that again. In general, sysfs
> files should contain simple values that are self-descriptive (a simple
> number or one word), and should have no side-effects (unlike the delete
> or the policies attributes you describe).
>
> The behavior of the Toshiba chip is peculiar enough to justify having
> some workarounds for it, including run-time selected ones, but I'm
> looking for something much simpler. I'd certainly be interested in
> the patch you come up with and any performance results, but I don't
> think it can be merged like that.
>

Sure. The page_align patch is just going to be a single sysfs
attribute. All I need to prove to myself now is the effect for large
unaligned accesses (and show everyone else the data :-)).

> In the end, Chris will have to make the decision on mmc patches of
> course -- I'm just trying to contribute experience from other subsystems.
>
> What I see as a more promising approach is to add the tunables
> to attributes of the CFQ I/O scheduler once we know what we want.
> This will allow doing the same optimizations to non-MMC devices such
> as USB sticks or CF/IDE cards without reimplementing it in other
> subsystems, and give more control over the individual requests than
> the MMC layer has.
>
> E.g. the I/O scheduler can also make sure that we always submit all
> blocks from the start of one erase unit (e.g. 4 MB) to the end, but
> not try to merge requests across erase unit boundaries. It can
> also try to group the requests in aligned power-of-two sized chunks
> rather than merging as many sectors as possible up to the maximum
> request size, ignoring the alignment.

I agree. These are common things that affect any kind of flash
storage, and it belongs in the I/O scheduler as simple tuneables. I'll
see if I can figure my way around that...

What belongs in mmc card driver are tunable workarounds for MMC/SD
brokeness. For example - needing to use 8K-spitted reliable writes to
ensure that a 64KB access doesn't wind up in the 4MB buffer B (as to
improve lifespan of the card.) But you want a waterline above which
you don't do this anymore, otherwise the overall performance will go
to 0 - i.e. there is a need to balance between performance and
reliability, so the range of access size for which the workaround
works needs to be runtime controlled, as it's potentially different.
Another example (this one is apparently affecting Sandisk) - do
special stuff for block erase, since the card violates spec in that
regard (touch ext_csd instead of argument, I believe). A different
example might be turning on reliable writes for WRITE_META (or all)
blocks for a certain partition (but I just made that up... ).

So there are things that just should be on (spec brokeness
workarounds), and things that apply only to a subset of accesses (and
thus they are selective at issue_*_rq time), whether it's because of
accessed offset or access size.

I agree that the sysfs method is particularly nasty, and I guess I
didn't have to make a prototype to figure that out :-) (but needed
something similar for selective testing anyway). Nothing else exists
right now that acts in the same way, and nothing really should, as
there is no feedback for manipulating the policies (echo POLICY_ENUM >
policy, if it doesn't stick, then the arguments were wrong, etc).

You could put the entire MMC block policy interface through an API
usable by system integrators - i.e. you would really only care for
tuning the MMC parameters if you're creating a device around an emmc.

Idea (1). One idea is to keep the "policies" from my previous mail.
Policies are registered through platform-specific code. The policies
could be then matched for enabling against a specific block device by
manfid/date/etc at the time of mmc_block_alloc... For removable media
no one would fiddle with the tunable parameters anyway, unless there
was some global database of cards and workarounds and a daemon or some
such to take care of that... Probably don't want to add such baggage
to the kernel.

Idea (2). There is probably no need to overcomplicate. Just add a
platform callback (something like int
(*mmc_platform_block_workaround)(struct request *, struct
mmc_blk_request *)). This will be usable as-is for R/W accesses, and
the discard code will need to be slightly modified.

Do you think there is any need for runtime tuning of the MMC
workarounds (disregarding ones that really belong in the I/O
scheduler)? Should the workarounds be simply platform callbacks, or
should they be something heftier ("policies")?

A
