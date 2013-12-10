From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/7] regulator: add pbias regulator support
Date: Tue, 10 Dec 2013 14:39:32 -0800
Message-ID: <20131210223932.GW13171@atomide.com>
References: <20131210104005.GB29268@sirena.org.uk>
 <1386686098-7779-1-git-send-email-balajitk@ti.com>
 <20131210183330.GK13171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131210183330.GK13171@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131210 10:34]:
> * Balaji T K <balajitk@ti.com> [131210 06:36]:
> > pbias register controls internal power supply to sd card i/o pads
> > in most OMAPs (OMAP2-5, DRA7).
> > Control bits for selecting voltage level and
> > enabling/disabling are in the same PBIAS register.
> 
> Good to see this, few comments below.
> 
> > +++ lo/Documentation/devicetree/bindings/regulator/pbias-regulator.txt	2013-12-10 16:58:28.907927745 +0530
> > @@ -0,0 +1,21 @@
> > +PBIAS internal regulator for SD card i/o pads on OMAP SoCs.
> > +
> > +Required properties:
> > +- compatible:
> > +  - "regulator-pbias-omap2" for OMAP2
> > +  - "regulator-pbias-omap3" for OMAP3
> > +  - "regulator-pbias-omap4" for OMAP4
> > +  - "regulator-pbias-omap5" for OMAP5, DRA7
> > +- pbias-reg-offset: PBIAS control register offset from syscon base address
> > +
> > +Optional properties:
> > +- Any optional property defined in bindings/regulator/regulator.txt
> > +
> > +Example:
> > +
> > +		pbias_regulator: pbias_regulator {

Hmm one more comment. This should containe the standard property:
			reg = <0x02b0 0x4>;

And the parent SCM driver should claim the whole SCM GENERAL register
area as defined in "Table 13-68. GENERAL Register Summary" for omap3
for example. So that would be the following for the parent:

			reg = <0x48002270 xxx>;

The size needs to be checked and it may need multiple regions or instances
defined. That way we can use the drivers/mfd/syscon.c SCM driver for all
the misc registers without having to redo the bindings.

Regards,

Tony
