From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 3/7] regulator: add pbias regulator support
Date: Fri, 20 Dec 2013 08:13:08 -0800
Message-ID: <20131220161307.GB27438@atomide.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-4-git-send-email-balajitk@ti.com>
 <20131219163300.GK27438@atomide.com>
 <52B4124F.8010903@ti.com>
 <20131220155721.GX27438@atomide.com>
 <20131220160917.GY31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131220160917.GY31886@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

* Mark Brown <broonie@kernel.org> [131220 08:10]:
> On Fri, Dec 20, 2013 at 07:57:21AM -0800, Tony Lindgren wrote:
> > * Balaji T K <balajitk@ti.com> [131220 01:49]:
> 
> > > But interrupt was never used/tested AFAIK, there is some settling time
> > > before the generated interrupt status is truely valid, so pbias interrupt is not
> > > reliable.
> 
> > OK. Do we need the standard regulator property startup-delay-us for the
> > PBIAS regulator then? Or if it's always fixed, I guess it could be done
> > in the pbias_regulator_enable()?
> 
> That delay is supposed to be the time for the startup of the supply
> rather than any detection code.  It should be set using enable_time in
> the driver if it's not system dependent - the property is there for
> cases where the delay depends on system configuration (eg, due to the
> capacitor values).

OK thanks. Let's try enable_time first then as we've had a fixed value
for years for it. If there's some difference based on the card
capacitance etc that can be added if needed.

Regards,

Tony
