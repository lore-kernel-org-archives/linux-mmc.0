From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Sun, 25 May 2014 13:34:52 +0100
Message-ID: <20140525123452.GS22111@sirena.org.uk>
References: <537DC832.3020006@redhat.com>
 <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com>
 <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WY7SQse5SL2UjpIj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42041 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbaEYMgc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 May 2014 08:36:32 -0400
Content-Disposition: inline
In-Reply-To: <53806F26.6050706@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>


--WY7SQse5SL2UjpIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 24, 2014 at 12:06:30PM +0200, Hans de Goede wrote:
> On 05/23/2014 06:27 PM, Mark Brown wrote:
> > On Fri, May 23, 2014 at 01:50:40PM +0200, Hans de Goede wrote:
> >> On 05/23/2014 01:22 PM, Mark Brown wrote:

> >> The compatible is not a Linux specific thing, it is a marking saying
> >> that something needs to take care of enabling the clks (and whatever
> >> else we will make part of the binding for this compatible), before
> >> scanning the mmc bus.

> > We could just say that the mere presence of a child node with the right
> > properties is sufficient to trigger the bus to do the startup?

> Yes, except that most involved property names are standardized, ie clocks,
> and we want to be able to opt out of the KISS mmc core code for
> (future) complex power on sequences.

This is why I'm suggesting keying off the specific compatible strings
for drivers that want to opt out of the helpers rather than having a
compatible string to enable the helpers (which may depend on the
particular Linux version if the feature sets of drivers change for
example).

> > If the device is sufficiently complicated to need a special power up
> > sequence I'd expect we'd be able to have a compatible string which would
> > provide enough information for us to figure things out.

> Hmm, so what you're suggesting is indeed more of an opt out then my initial
> opt-in to KISS powerup idea. So to be clear what you're suggesting is:

> mmc core walks host mmc-child nodes. Loads drivers based on compatibles
> there. The checks a flag field in the driver to see if the driver wants to
> opt-out of the KISS powerup code. The problem with this is that it won't

Yes.

> work reliable with modules, think the mmc probe being done from the ramdisk,
> and the driver in question only being available from the rootfs. I really

Why is that a problem - if we have no driver for the device there is no
point in powering it up in the first place is there?

> believe that using opt-in with a compatible such as simple-sdio-powerup
> is by far the safest thing to do, and as an added advantage we don't need
> to worry about how to deal with the future complex power on cases at all,
> we leave all the room in the world for various future scenarios. since as
> soon as the simple-sdio-powerup compatible is not there the mmc core will
> behave as it does today.

Please remember that the DT is *supposed* to be an ABI - systems are
supposed to be able to ship with a fixed DT and have it work with random
operating systems they have no knowledge of (and may not even exist at
the time the DT is being created).  This means we can't rely on removing
a compatible string later on.

> >> Hmm, good point in that case actually having these things in the
> >> child node makes most sense, because then the driver can find them
> >> their. Note that the mmc core enabling things does not mean that
> >> the driver cannot later disable them if needed.

> > Right, that's good idea for solving the problem - the child device can
> > either share the reference with the bus or have some way of getting at
> > the object the bus requested depending on what's sensible.  Only

> I don't think there is a need to share references, ie for clks multiple drivers
> can hold a reference and they can be enabled / disabled multiple times, only
> when the last enable is countered by a disable the clock will really be disabled,
> iow this should all just work. Anyways these are all implementation details
> lets focus on the bindings bit first.

The reference I'm referring to here is the enable - a driver should not
normally disable something it didn't enable itself.

--WY7SQse5SL2UjpIj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTgeNdAAoJELSic+t+oim9i/gP/1DsNckp7YUBhbwKAGlKHr4R
MtzeIHNWHvLcrp4OBEW4XdVc0CgAJhaE91LUE42zZsbe4+sJh7B9cJg0D2P2rJO4
ZJRk5nS4mbGl2rynFL1KsDuUs1CMq6B5qR9Uu48XpQGLyaBVz16SvCb1J0X/7imD
Qv2tW7wuCySUJUAilecert2OiwDiz5ux1W+/xcewXM3XHO92XzcIrz8+RX5iDFM2
/dvAEVfduRso1VBWFQQX5WB78n3sN6yrJSgU63bIndSCjLg4nLuAYDTWC0JndmDg
BR1ZzW3oWIesrS0N9jx79dR5g3RlQZb5Tx7idAdKN6L8z+pA9EUimb0Qo6PfSWSZ
2s6ZXel2wu9LWYgwFL4cEW1aN1SkVc5eQIGgIO3n2384JBEmMFd+8i+ExiXD+vGL
kuAd4XnV7D/DR5ZqmMP0XYIN75qT4KCvmkM9XnUswPhLsxTxXZXpahj8fkHsFAqn
CQBoLDjhtH1prqx9fjkFHsQKElU1Xra2VCwEYH++ZNMW+lk7dE2Mv4uJgOcjaN3K
q4CPEz33sfCYlGWLZNIBlXMDZGMPmPqsxiaGHcuTYoxZ+NM6AO/6VEcloE7UoRXg
El8Gn2PFoKvlKNAboaraz3020+dOgA7j4uw8vRyJab0u1SN5N3sQ029IY/CPuUnH
AEGZy7HskEjBxdzb9a0R
=MEDJ
-----END PGP SIGNATURE-----

--WY7SQse5SL2UjpIj--
