From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Wed, 4 May 2016 14:46:53 +0200
Message-ID: <20160504124653.GA23838@amd>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
 <20160504071801.GA17045@amd>
 <CAL_JsqJ4Pzuip9VUpwryy_xK6XSZ6E+kus3wD=T4wcTHav=9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56498 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbcEDMq5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 08:46:57 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ4Pzuip9VUpwryy_xK6XSZ6E+kus3wD=T4wcTHav=9iA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.

On Wed 2016-05-04 07:25:42, Rob Herring wrote:
> On Wed, May 4, 2016 at 2:18 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Fri 2016-04-29 19:12:48, Russell King - ARM Linux wrote:
> >> On Fri, Apr 29, 2016 at 10:32:15AM -0700, Douglas Anderson wrote:
> >> > This series picks patches from various different places to produce what
> >> > I consider the best solution to getting consistent mmc and mmcblk
> >> > ordering.
> >> >
> >> > Why consistent ordering and why not just use UUIDs?  IMHO consistent
> >> > ordering solves a few different problems:
> >>
> >> NAK.  Really.  Use UUIDs, that's the proper solution here.
> >
> > Except that UUIDs do not solve the problem.
> >
> > You have just booted of nfsroot, and you want to format u-SD card in
> > the external slot. How do you do that?
> 
> The same way you format a USB stick when you insert it.

Well, and that actually brings related question "how do you format the
right USB stick if you have 5 of them connected". PCs don't have good
solution, but that does not mean it can't be solved.

And no, its not really the same. At least in N900 case, I'm not really
sure if you are expected to manipulate the u-SD card while the system
is on. It is under battery cover.

> If you have built-in versus removable, then we should expose that
> information to userspace rather than some arbitrary encoding in DT
> that 0 means built-in and 1 means removable. Or if you have multiple
> slots, then use "label" to provide meaningful slot names.

Yes, labels would be nice. Plus the slot numbers should be stable, so
that booting does not randomly break.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
