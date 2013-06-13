From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 17:17:31 +0100
Message-ID: <20130613161731.GA28134@laptop>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-7-git-send-email-balajitk@ti.com>
 <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
 <20130613104715.GC16677@laptop>
 <51B9DEE0.1060305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:62073 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab3FMQRi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 12:17:38 -0400
Received: by mail-ee0-f51.google.com with SMTP id e52so5284206eek.10
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 09:17:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51B9DEE0.1060305@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, ext Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, 13 Jun 2013, Balaji T K wrote:

> On Thursday 13 June 2013 04:17 PM, Lee Jones wrote:
> >On Thu, 13 Jun 2013, Linus Walleij wrote:
> >
> >>On Thu, Jun 6, 2013 at 9:14 PM, Balaji T K <balajitk@ti.com> wrote:
> >>
> >>>PBIAS register configuration is based on the regulator voltage
> >>>which supplies these pbias cells, sd i/o pads.
> >>>With PBIAS register address and bit definitions different across
> >>>omap[3,4,5], Simplify PBIAS configuration under three different
> >>>regulator voltage levels - O V, 1.8 V, 3 V. Corresponding pinctrl =
states
> >>>are defined as pbias_off, pbias_1v8, pbias_3v.
> >>>
> >>>pinctrl state mmc_init is used for configuring speed mode, loopbac=
k clock
> >>>(in devconf0/devconf1/prog_io1 register for omap3) and pull streng=
th
> >>>configuration (in control_mmc1 for omap4)
> >>>
> >>>Signed-off-by: Balaji T K <balajitk@ti.com>
> >>
> >>You *need* Lee Jones and Mark Brown to review this.
> >>Maybe Laurent has something to add too.
> >>
> >>Ux500 had the very same thing, and there this was solved using
> >>a GPIO regulator for "vqmmc" a level-shifter. I vaguely remember
> >>Laurent doing something similar with the SH stuff.
> >
> >I haven't seem much of this patch-set, but this certainly looks like
> >it should be handled by a GPIO regulator instead of pinctrl. States
> >are easily declared in a 'struct gpio_regulator_state', which the
> >framework then uses to set the correct pins for the required voltage=
=2E
> >
>=20
> Thanks for the pointer, but wondering why is it named as gpio-regulat=
or
> and how it is different from fixed-regulator.
> After going through git log description, I understand that voltage/cu=
rrent level
> for a particular regulator is controlled by a set of pad/pin on the P=
OWER IC
> and pad/pin may be usually connected to gpio pins if it is needs to b=
e
> configurable and ground/pulled for constant voltage.
>=20
> Collection of gpios logic level are modeled as state for particular v=
oltage.
> But gpio is not used in my case.
>=20
> >And yes, 'vqmmc' is a good place to store the this regulator.

As I say, I didn't see much of the code, only parts which looked
similar a voltage level-shifter.

The difference between fixed and gpio regulators, is that the former
is exactly that, 'fixed'. You can turn voltage on and off using a gpio
pin, but you can't shift the voltage. Something which is required of
your use-case. The latter switches between voltgages via a set of gpio
pins, for instance, your use-case could look somelike like:

static struct gpio_regulator_state sdi0_reg_states[] =3D {
        { .value =3D 3300000, .gpios =3D (1 << 0) },
        { .value =3D 1800000, .gpios =3D (0 << 0) },
};

But if there aren't any gpio pins involved, then this isn't what you
want either.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
