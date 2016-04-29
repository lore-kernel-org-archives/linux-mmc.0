From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Fri, 29 Apr 2016 22:29:20 +0100
Message-ID: <20160429212920.GA19428@n2100.arm.linux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
 <CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
 <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
 <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59699 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbcD2V3z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 17:29:55 -0400
Content-Disposition: inline
In-Reply-To: <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Jon Hunter <jonathanh@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>Pawel Moll <p>

On Fri, Apr 29, 2016 at 02:17:45PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 29, 2016 at 2:13 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Apr 29, 2016 at 01:04:48PM -0700, Doug Anderson wrote:
> >> Russell,
> >>
> >> On Fri, Apr 29, 2016 at 12:57 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> >> * Presumably on a PC you've got an extra bit in the middle (like grub
> >> >> or something like that) that can help you resolve your UUIDs even if
> >> >> you get your kernel from somewhere else.
> >> >
> >> > You are over-estimating what grub does.  Grub doesn't resolve UUIDs at
> >> > all.  Grub just passes the kernel arguments in its configuration file
> >> > for the entry it is booting to the kernel.  It's a static configuration
> >> > found in /boot/grub/grub.conf.
> >> >
> >> > It doesn't probe devices for UUIDs.
> >>
> >> OK.  The point was: if folks on PCs have a workflow that works for
> >> them, wonderful.  That workflow doesn't work so great for me.  My
> >> workflow doesn't hurt them.  Why is it bad?
> >
> > This discussion is over, since you're not willing to actually discuss
> > it (illustrated by you cutting and pasting this same thing four
> > times in your reply.)
> >
> > My NAK stands until such time that you can partake in a reasonable
> > discussion.
> 
> The point of pasting it several times was that you'd answer it.
> Apparently that failed.
> 
> Perhaps you could answer the question I posed?

No, because you haven't taken the time to think and consider my
reply, which gives you insight into how your "problem" is no
different from the situation that everyone else has, where it
isn't a problem.

I think the "problem" here is that you've got used to coreboot
doing something that very few other boot loaders do, namely it
automatically extracting a rootfs UUID for you.  The rest of the
world doesn't have that luxury.

So, instead, you want to stuff more code into the kernel to work
around what you think is a problem - a problem which seems to be
unique to yourself.

The UUID and label solutions were created by x86 people to work
around exactly this dynamic device problem, and as my previous
replies have shown, it is superior to fixing the device assignment
as you're trying to do.

However, I don't expect that you'll like this answer, and you'll
probably just re-post your same question after each and every
paragraph rather than considering whether the already existing
solutions could solve your "problem".  So I'm just wasting my time.

This is my last reply.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
