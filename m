From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 02:53:54 -0700
Message-ID: <20130613095353.GX8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-7-git-send-email-balajitk@ti.com>
 <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64729 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758555Ab3FMJx7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 05:53:59 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Balaji T K <balajitk@ti.com>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

* Linus Walleij <linus.walleij@linaro.org> [130613 02:42]:
> On Thu, Jun 6, 2013 at 9:14 PM, Balaji T K <balajitk@ti.com> wrote:
> 
> > PBIAS register configuration is based on the regulator voltage
> > which supplies these pbias cells, sd i/o pads.
> > With PBIAS register address and bit definitions different across
> > omap[3,4,5], Simplify PBIAS configuration under three different
> > regulator voltage levels - O V, 1.8 V, 3 V. Corresponding pinctrl states
> > are defined as pbias_off, pbias_1v8, pbias_3v.
> >
> > pinctrl state mmc_init is used for configuring speed mode, loopback clock
> > (in devconf0/devconf1/prog_io1 register for omap3) and pull strength
> > configuration (in control_mmc1 for omap4)
> >
> > Signed-off-by: Balaji T K <balajitk@ti.com>
> 
> You *need* Lee Jones and Mark Brown to review this.
> Maybe Laurent has something to add too.
> 
> Ux500 had the very same thing, and there this was solved using
> a GPIO regulator for "vqmmc" a level-shifter. I vaguely remember
> Laurent doing something similar with the SH stuff.
> 
> > +       /* 100ms delay required for PBIAS configuration */
> > +       msleep(100);
> > +       if (!vdd && host->pinctrl && host->pbias_off) {
> > +               ret = pinctrl_select_state(host->pinctrl, host->pbias_off);
> > +               if (ret < 0)
> > +                       dev_err(host->dev, "pinctrl pbias_off select error\n");
> > +       } else if (((1 << vdd) <= MMC_VDD_165_195) && host->pinctrl &&
> > +                       host->pbias_1v8) {
> > +               ret = pinctrl_select_state(host->pinctrl, host->pbias_1v8);
> > +               if (ret < 0)
> > +                       dev_err(host->dev, "pinctrl pbias_1v8 select error\n");
> > +       } else if (((1 << vdd) > MMC_VDD_165_195) && host->pinctrl &&
> > +                       host->pbias_3v) {
> > +               ret = pinctrl_select_state(host->pinctrl, host->pbias_3v);
> > +               if (ret < 0)
> > +                       dev_err(host->dev, "pinctrl pbias_3v select error\n");
> > +       }
> 
> So why does the pin control API control bias voltage?

I agree, it should be a regulator for the MMC driver and that's what I
already suggested earlier. Having it as a regulator allows us to get
rid of all the non-standard before and after calls in the omap_hsmmc.c.
This way the omap_hsmmc.c code can handle the internal and external
voltages the same way.
 
> This seem so intuitively wrong as it can possibly get, clearly this
> is regulator territory.

The PBIAS for MMC1 is a mux + comparator for the MMC pin, so it makes
sense for the regulator driver to access the register via pinctrl API.
I think the reason why we have registers like this and the USB comparators
in the omap SCM (System Control Module) as the all seem to relate to
pin states.
 
> This also looks strange from an MMC point of view.

Yes I agree, it should be a regulator for MMC. Doing it this way just
adds yet more code that's usable for only one of the omap MMC
controllers.
 
> It just seems these bits in these registers should be poked at
> by the regulator world, not the pinctrl world. That the bits are
> in the middle of pinctrl things does not really matter.
> 
> > +       usleep_range(350, 400);
> 
> And the regulator framework supports power-on delays.

Yes. And it seems that the delays should not be needed, but instead
the comparator bits should be checked.

Regards,

Tony
