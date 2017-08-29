From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 29 Aug 2017 10:39:14 -0700
Message-ID: <20170829173913.GD6008@atomide.com>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
 <c9342689-f09e-44af-0975-d43ef122a477@ti.com>
 <CAPDyKFqCZFM7UmHyQCm=DwwZXJvzUde3pW0HqARKrsgfgxSuaw@mail.gmail.com>
 <0c7e0705-d9c2-4499-54ba-cbd84589dc01@ti.com>
 <20170829115050.3axlr5uysmqlhvd2@earth>
 <20170829135822.GR6008@atomide.com>
 <20170829170920.xpgk5ywlvfgrtbqi@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdH2RjS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Aug 2017 13:39:18 -0400
Content-Disposition: inline
In-Reply-To: <20170829170920.xpgk5ywlvfgrtbqi@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Rob Herring <robh@kernel.org> [170829 10:09]:
> On Tue, Aug 29, 2017 at 06:58:23AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170829 04:51]:
> > > I would expect the conversion to look like the one done for UART,
> > > see CONFIG_SERIAL_OMAP vs CONFIG_SERIAL_8250_OMAP. Both use the
> > > same compatible value and you can choose using kernel configuration.
> > 
> > That does not work unfortunately :( We are now stuck in a situation
> > where two drivers are attempting to probe with the same compatible
> > and we can't enable 8250_OMAP because of the user space breakage
> > with the device names. And I'm actuallly thinking we should add a
> > new compatible for 8250-omap to be able to start enabling it one
> > board at a time.
> 
> Is that the only problem? Presumably, the SD driver doesn't have a 
> userspace facing issue.

No userspace issue with the sdhci-omap. But the sdhci-omap driver
still has the issue of trying enable it for everything at once and
expect everything to work. The sdhci-omap driver can already be
used for boards that don't need power management for example, but
will break things for devices running on batteries.

> > It's best to enable devices to use the new compatible as things are
> > tested rather than hope for some magic "flag day" flip that might
> > never happen. Having two days attempting to probe with the same
> > binding just won't work.
> 
> Aren't you just picking whether the flag day is in DT or the kernel? I 
> guess you're assuming one kernel build and it would be switching all 
> boards at one. 

Right, this would be risky and would take unnecessarily long
to use the new driver on boards that can already use it. While
power management won't work yet, I'd expect the sdhci-omap be
faster on SoCs that can do ADMA.

> > So yeah, I agree with Kishon that we should stick with generic
> > and sdhci bindings. And then we can start already using it for
> > boards that can use it, then eventually when we're ready, start
> > parsing also the legacy bindings and maybe drop the old driver.
> 
> I assume there are some other common properties you would switch to in 
> the transition?  You could make the legacy driver bail from probe based 
> on presence or absence of other properties. Or you could just blacklist 
> converted platforms in the legacy driver. The point is that the problems 
> are solvable in the kernel.

Yes this could be done too. But let's enable it on per-board
basis rather than attempt to flip it on at once.

> But if your really want a new compatible, I don't really care. It's 
> only one device.

Both a new compatible or a check for some resource work just fine
for me as long as the driver can be selected on per-board basis.

Regards,

Tony
