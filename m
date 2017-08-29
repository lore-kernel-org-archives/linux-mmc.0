From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 29 Aug 2017 06:58:23 -0700
Message-ID: <20170829135822.GR6008@atomide.com>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
 <c9342689-f09e-44af-0975-d43ef122a477@ti.com>
 <CAPDyKFqCZFM7UmHyQCm=DwwZXJvzUde3pW0HqARKrsgfgxSuaw@mail.gmail.com>
 <0c7e0705-d9c2-4499-54ba-cbd84589dc01@ti.com>
 <20170829115050.3axlr5uysmqlhvd2@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38342 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbdH2N61 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Aug 2017 09:58:27 -0400
Content-Disposition: inline
In-Reply-To: <20170829115050.3axlr5uysmqlhvd2@earth>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170829 04:51]:
> On Tue, Aug 29, 2017 at 04:50:22PM +0530, Kishon Vijay Abraham I wrote:
> > On Thursday 24 August 2017 04:59 PM, Ulf Hansson wrote:
> > > I guess we have two options.
> > > 
> > > 1) Allow us to invent and use new bindings - and a new compatible.
> > > When everything is implemented in sdhci-omap, we can deprecate the old
> > > omap_hsmmc driver and its corresponding compatible/bindings. At some
> > > point later we can remove the legacy driver/bindings altogether - of
> > > course that might take a while. This option allows us to re-think some
> > > of the old bindings and really clean up some if its related code. For
> > > example, I think "ti,dual-volt" is a bad binding. Instead it would be
> > > better to use the existing mmc bindings about which speed mode the
> > > controller/board supports (as the voltage level comes with it).
> > > 
> > > 2) Invent only a new compatible, but stick to use the old omap hsmmc
> > > bindings and thus also deploy the similar code dealing with them. When
> > > everything is implemented move the old omap_hsmmc compatibles into the
> > > new sdhci-omap driver and them remove the old omap_hsmmc driver. At
> > > that point we could also deprecate the old omap hsmmc compatibles, but
> > > to me that is rather pointless.
> > > 
> > > The two options has different advantages, feel free to pick any of them!
> > 
> > Okay. I'll send a new version with option '1' (new compatible/new bindings).

Agreed.

> > And when we deprecate the omap_hsmmc driver (some time later), we'll add
> > support for the legacy bindings in sdhci-omap driver (so that old dtbs continue
> > to work). Tony, are you okay with this?
> 
> I think you should Cc Rob Herring and Mark Rutland (DT binding
> maintainers). This sounds like "I use DT to describe driver
> behaviour" instead of "I use DT to describe hardware".

Yes please.

> I would expect the conversion to look like the one done for UART,
> see CONFIG_SERIAL_OMAP vs CONFIG_SERIAL_8250_OMAP. Both use the
> same compatible value and you can choose using kernel configuration.

That does not work unfortunately :( We are now stuck in a situation
where two drivers are attempting to probe with the same compatible
and we can't enable 8250_OMAP because of the user space breakage
with the device names. And I'm actuallly thinking we should add a
new compatible for 8250-omap to be able to start enabling it one
board at a time.

It's best to enable devices to use the new compatible as things are
tested rather than hope for some magic "flag day" flip that might
never happen. Having two days attempting to probe with the same
binding just won't work.

So yeah, I agree with Kishon that we should stick with generic
and sdhci bindings. And then we can start already using it for
boards that can use it, then eventually when we're ready, start
parsing also the legacy bindings and maybe drop the old driver.

Regards,

Tony

