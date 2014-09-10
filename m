From: Pavel Machek <pavel@denx.de>
Subject: Re: [GIT PULL 1/2] SOCFPGA updates for 3.18
Date: Wed, 10 Sep 2014 10:33:37 +0200
Message-ID: <20140910083337.GA5178@amd>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <20140909141756.GA30100@amd>
 <4134101.OOENTRabu1@wuerfel>
 <20140909210232.GA539@amd>
 <CAPDyKFr35646zQUDUnv9LYy9jtY7r343hev9FrhxOfjVMb6MJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45961 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaIJIdk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Sep 2014 04:33:40 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFr35646zQUDUnv9LYy9jtY7r343hev9FrhxOfjVMb6MJw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, grant.likely@linaro.org, robh+dt@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, marex@denx.de, dinguyen@opensource.altera.com, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, "arm@kernel.org" <arm@kernel.org>, dinh.linux@gmail.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Wed 2014-09-10 09:13:27, Ulf Hansson wrote:
> On 9 September 2014 23:02, Pavel Machek <pavel@denx.de> wrote:
> > On Tue 2014-09-09 17:02:34, Arnd Bergmann wrote:
> >> On Tuesday 09 September 2014 16:17:56 Pavel Machek wrote:
> >> > > Jaehoon Chung (1):
> >> > >       ARM: dts: socfpga: unuse the slot-node and deprecate the supports-highspeed for dw-mmc
> >> > >
> >> >
> >> > This patch is a bad idea. It removes support for two mmc cards on a
> >> > single controller -- configuration hardware supports and configuration
> >> > that allows using u-SD card on mcvevk board.
> >> >
> >>
> >> Your objection comes too late, and to the wrong patch, since the
> >> driver and all other users have already been changed. We had a long
> >> discussion about this when the issue first came up, and we could
> >> not find any example of dw-mmc actually being used in a scenario
> >> with one controller that has multiple devices attached.
> >
> > Well, this is not first time I raised this. 3.17 is not yet out, so we
> > still have chance to fix regressions without major fuss.
> >
> >> Apparently every user out there instead uses multiple controller
> >> instances instead. Are you sure that the socfpga implementation
> >> is an exception from this?
> >
> > Marek Vasut has the hardware. His board apprently has uSD and eMMC,
> > and I believe it has just one controller. I'll try to get details.
> >
> 
> Just wanted to highlight some of the reasons to why the earlier
> discussion we have had, came to the conclusion to remove the slot
> node.
> 
> 1) The mmc core don't support multiple cards attached to the same
> host, it never has. Also, I am not aware of any requests that
> suggested us to add it. Due to obvious reasons from performance
> perspective it's simply a really bad idea, that's likely also why
> there haven't been any requests for it.

Well, that's Linux problem, right? (And why is it bad idea, btw? The
bandwidth will be shared between the controllers, ok, that does not
sound too bad.)

> 2) On the host level, the support for handle multiple slots in DT for
> dw-mmc has been broken. While dw-mmc parsed the DT nodes for slots, it
> screwed up configurations. Thus the support for slots have never
> worked as expected from DT point of view.

Well, DT is supposed to describe the hardware. From your description,
it seems that linux does not support two slots on one controller and
DT parsing code basically ignores the slots. (Logical, if it can't
support two slots).

So now we are breaking DT description due to Linux limitations. Which

a) makes it hard for any other os not having same limitation

b) makes it hard for people to fix the limitation

c) does not really solve anything

d) breaks backward compatibility with old dts

If nothing, d) should be argument not to do this.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
