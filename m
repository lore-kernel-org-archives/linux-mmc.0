From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 11:47:15 +0100
Message-ID: <20130613104715.GC16677@laptop>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-7-git-send-email-balajitk@ti.com>
 <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Balaji T K <balajitk@ti.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, ext Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 13 Jun 2013, Linus Walleij wrote:

> On Thu, Jun 6, 2013 at 9:14 PM, Balaji T K <balajitk@ti.com> wrote:
>=20
> > PBIAS register configuration is based on the regulator voltage
> > which supplies these pbias cells, sd i/o pads.
> > With PBIAS register address and bit definitions different across
> > omap[3,4,5], Simplify PBIAS configuration under three different
> > regulator voltage levels - O V, 1.8 V, 3 V. Corresponding pinctrl s=
tates
> > are defined as pbias_off, pbias_1v8, pbias_3v.
> >
> > pinctrl state mmc_init is used for configuring speed mode, loopback=
 clock
> > (in devconf0/devconf1/prog_io1 register for omap3) and pull strengt=
h
> > configuration (in control_mmc1 for omap4)
> >
> > Signed-off-by: Balaji T K <balajitk@ti.com>
>=20
> You *need* Lee Jones and Mark Brown to review this.
> Maybe Laurent has something to add too.
>=20
> Ux500 had the very same thing, and there this was solved using
> a GPIO regulator for "vqmmc" a level-shifter. I vaguely remember
> Laurent doing something similar with the SH stuff.

I haven't seem much of this patch-set, but this certainly looks like
it should be handled by a GPIO regulator instead of pinctrl. States
are easily declared in a 'struct gpio_regulator_state', which the
framework then uses to set the correct pins for the required voltage.

And yes, 'vqmmc' is a good place to store the this regulator.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
