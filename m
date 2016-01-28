From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/21] Totally remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Thu, 28 Jan 2016 11:29:46 +0000
Message-ID: <20160128112946.4d750fae@lxorguk.ukuu.org.uk>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
	<56A8BF22.8010509@intel.com>
	<20160127132348.GY10826@n2100.arm.linux.org.uk>
	<CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
	<56A97A27.4000501@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57812 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967331AbcA1Lai (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 06:30:38 -0500
In-Reply-To: <56A97A27.4000501@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 28 Jan 2016 10:17:11 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:

> On 2016/1/27 23:07, Ulf Hansson wrote:
> > On 27 January 2016 at 14:23, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:  
> >> On Wed, Jan 27, 2016 at 02:59:14PM +0200, Adrian Hunter wrote:  
> >>> In my view Ulf needs to explain how the SDHCI library is going to work,
> >>> particularly in the absence of new callbacks.  
> >>
> >> We need to add new callbacks as part of the conversion to a library,
> >> otherwise we're very much into a total rewrite from scratch (which
> >> I think is far too much work, and prone to errors) or a big flag day
> >> to switch everything over (which will require a moritorium on sdhci
> >> patches while the effort to switch everything is ongoing.)

Agreed that won't work. It never works. You simply end up with a bigger
mess, a giant backlog and lots of people sending patches "on appeal" to
Linus/GregKH because the maintainer is being unreasonable. At that point
it all gets messy. It has been done (IDE) where the old core code simply
couldn't cope with the new hardware, but it was a nightmare

> > of it's bad code structure. Therefore I have taken a quite simple
> > approach by rejecting new callbacks and quirks, in a way to prevent it
> > from being worse.  

Which merely guarantees that the problem gets worse, because everyone
just puts their SD patches into Android trees instead and then when that
device is needed in Linux proper the crap hits the fan or people write
uglier and more hideous hacks buried elsewhere.

Eventually something gives way, and it will always be the maintainer,
because everyone needs to get their devices supported. You can guide new
callbacks in constructive ways but not stop them.

> If someone is willing to be the maintainer of sdhci, he/she can create
> a separate files and rewrite it to be a library. Then we reject to
> accept any new variant drivers to use the old sdhci struct and encourage
> it to fit the library one. Then ask the variant drivers who use the old
> struct to migrate its code to fit the library. Until all done, remove
> the old sdhci. Does that make sense?

I don't think it's the best idea. From past experience with other layers
of code the most effective approach (except for IDE which *was* a dead
loss and rewritten) has been something like this

- Take a small function with a quirk in it that one driver uses
- Split it into a clean function and driver specific function, put one in
  the driver and one in the core
- Replace the call to it with a call to ->ops->whatever()
- Add it to the various drivers operations structure as it gets invented

repeat until done.

Some things are shared so you end up moving vendor common quirks to
perhaps an "intel" file or a "designware" file rather than a single
driver, but the theory is the same and it ends up in effect as a class
with some overridden methods.

After this cycle has been repeated a bit you actually have the real
structure of the core code and the areas it diverges are visible. All your
ops-> methods are the points of diverge and clearly labelled. If you want
you can then go through finding all those that fit the pattern where they
diverge in the form

	do_stuff
	standard_method()
	do_stuff

and if the ops callback is not deeply buried look at kicking the whole
method back out completely so it becomes a true library method that
drivers can wrap or call.

It can be done. The 8250 serial driver has been going through this
process for some time (although it didn't start from quite so bad a
position as the sd layer), and the tty layer went through chunks of it
several times in its history.

And above all - it bisects.

Alan
