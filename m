From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
Date: Fri, 15 Jan 2016 08:02:19 -0800
Message-ID: <20160115160219.GB3904@atomide.com>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth>
 <20160114172549.GC5783@n2100.arm.linux.org.uk>
 <20160114224025.GA26988@earth>
 <20160115091421.GD5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55554 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcAOQCX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Jan 2016 11:02:23 -0500
Content-Disposition: inline
In-Reply-To: <20160115091421.GD5783@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, ivo.g.dimitrov.75@gmail.com, aaro.koskinen@iki.fi, nsekhar@ti.com, khilman@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [160115 01:15]:
> On Thu, Jan 14, 2016 at 11:40:25PM +0100, Sebastian Reichel wrote:
> > On Thu, Jan 14, 2016 at 05:25:49PM +0000, Russell King - ARM Linux wrote:
> > > There are very good reasons not to do this: that will result in
> > > configurations where MMC_OMAP_HS was set but without REGULATOR_PBIAS
> > > ending up with MMC_OMAP_HS being disabled.  That doesn't help the
> > > root problem, which is "why has the kernel boot regressed for my
> > > previous working configuration?"
> > > 
> > > The solution proposed here adds a message to the boot which points
> > > out fair and square what needs to be done to rectify the boot
> > > failure.  Adding a dependency just brings up the question "where
> > > has my MMC driver gone?"
> > 
> > The best thing would be to have no regression. Just printing a
> > message means I have to build another kernel. But more importantly
> > the message may not be visible by the user - e.g. if the display has
> > not yet been initialized.
> 
> I agree in principle, but that's not possible here (see Tony's mails
> on why the PBIAS stuff needs to be optional.)  I'd agree with changing
> the Kconfig if PBIAS were a hard and fast requirement, but it isn't.

Yeah. Probably the best solution for cases like this is to boot with
a small initrd. That way you can get usb console and networking going
before mounting the real root and you will see kernel messages with
only minimal things built in. You can build a small initramfs with
CONFIG_INITRAMFS_SOURCE that is appended to the kernel so you can
also boot the legacy user space too with that if needed.

Regards,

Tony
