From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Mon, 26 May 2014 15:22:25 +0100
Message-ID: <20140526142225.GF22111@sirena.org.uk>
References: <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iqMm74K5rg2eMP7U"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:43182 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbaEZOXS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 10:23:18 -0400
Content-Disposition: inline
In-Reply-To: <538321AB.4050006@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>


--iqMm74K5rg2eMP7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 01:12:43PM +0200, Hans de Goede wrote:
> On 05/26/2014 12:38 PM, Mark Brown wrote:
> > On Sun, May 25, 2014 at 09:20:52PM +0200, Hans de Goede wrote:

> > until we've powered up and enumerated.  The only time that there's a
> > problem and would need to specify exactly what the device is in the DTS
> > is if we need the custom sequence prior to being able to do that at
> > which point I don't see much option.

> Specified !=3D driver available. Determining whether or not we should pow=
er
> up based purely on there being a compatible string is not going to work, =
as
> even when using simple powerup we still need compatible strings for non
> powerup settings like sdio signal drive strength, oob irq, etc.

If there are compatible strings but not one we've heard of then we're
back in the situation where we may as well not bother powering up in the
first place since we've no idea what to do with the device once it's
powered.  If we fall down a list of compatibles and decide that the
only thing we know about the device is that we can power it up (this is
distinct from the case where we probe the device) I'd expect the device
to be turned off.

> So the only way this will work is if we delay powerup until we've a driver
> available, which may be never if the module is not build, or whatever,
> and without powerup the user is never going to figure out he is missing
> a module. Basically adding a driver flag for blacklisting from the simple
> power up logic means inserting an unnecessary initialization ordering iss=
ue,
> which we really don't need as each ordering dependency is usually one too=
 many.

I'm afraid I'm really not seeing a substantial problem either way here,
powering up the device isn't going to help us find a driver for it and
the UI around reporting that the device is there without a driver should
hopefully be unaffected by its power state.

> > I don't understand why not powering the device up would be a sensible
> > default or why other OSs would also choose to implement things that way.

> Because if we are not 100% sure that our simple power up logic will do the
> job properly (i.e. in the right order), then the SAFE thing to do is to
> not power up.

So long as we've got a clear way of saying that we might need to do
something special I don't think we should have an issue either way;
it's mostly a case of how we specify.

> What if a user takes an older distro kernel, where the driver does not
> set the opt-out flag you're suggesting since at that time it did not
> have its own power logic, then tries to boot that with a dtb file written
> for a newer kernel (where the driver does have the opt out flag), and we
> start powering up things in the wrong order and let the magic smoke out
> of various components on the board ?

Conversely what if someone fixes a bug in the standard power up sequence
in a newer version of the kernel but then tries to run older software?
There's plenty of ways things can go wrong with this stuff.

> Also note that this is a perfectly standard use of compatibles, compatibl=
es
> are typically used to indicate which driver should be used, in this case
> the compatible indicates that the simple powerup driver should be used,
> where as if another powerup driver should be used another compatbile will
> be there instead.

We don't typically actually bind multiple compatibles for a single
device.  We've got a bunch of options we can choose from but we
generally pick the one that matches best and ignore the others.

> Where as what you're suggesting is to always pick driver foo, unless
> driver bar is available and has a special flag saying to not use foo, this
> is a whole new way to use compatibles really, and not one which I think
> we want to introduce.

I'm not sure I'm buying the idea that we have a powerup driver that's
meaningfully not part of the main device driver.

> > Well, if things aren't going to work either way for these devices
> > without extra stuff it seems it doesn't much matter but it helps the
> > simple case to have things default to working.

> The simple case still needs a child node describing the needed resources,
> adding a compatible =3D "simple-sdio-powerup" to that at the same as crea=
ting
> the child node in the first place really is no extra effort at all.

=46rom where I'm sitting it's more effort since instead of just putting
the device in there (and possibly also some other devices that are
software compatible) we have to put in another compatible string which
is really just a boolean flag to be used in conjunction with the others.
That's harder to think about and we clearly don't want to go through the
compatible list, decide that we don't know how to handle the device
except power it up so go and do that.

If it were done as something like "set boolean property X or
powerup-method =3D Y in the card description" or whatever it'd seem a bit
annoying but not a big deal, I think it's the fact that it's getting put
into the compatible list that's really concerning me.

--iqMm74K5rg2eMP7U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg04eAAoJELSic+t+oim9944P/ikCnvQiEVy1A1fAONFf8Kxf
8JTP5Pd/55tQXn5F8YRc24dS7tVoR6MST2CRBqqrRBsaFqWP7CcPOeizmdPucBgA
4MV26ieKVibfo6rZvky6jbHod1MWFcBoAd4K0Tnh3Odj2Q7ORIjkAc3d6MwyVG/Y
soqx28qK+X/MYXcqprg5Oz6iIbAvSn6GtrG2BN1Tc4CoSmkAxmoBGmO1HqyfRddf
SkcLmo9pdpe0+1wDVtlz9bLf5A4+QJPakLyQVDBNAFNBPLT9X9iNCvNLj+GvY6s2
4vdZT69IlJ5U4sq2WexI8g51H8T+8zDN6GPcV2qpdzYfp5zSzrdGFRSrhXZtidem
zs86ze70Rb/qbx52li5aabTu33pKWkYsrLFw/ZNtWFEw85a1pPy/7p5k0T+MdmQL
NxBrUALFqsCbMPW8HryO5XEpgbRALaBJl0+Nvo/vTx9NX1TTszOFuw4ZT87I3r2y
L3CEt7BKMrwzt09y/Vq6ujRLQwTcrhAGuBR2VnuXkZo0E5DE6levRhq+enoAWFnz
RoANdVF16FEsJ0mX36ww9jGa03hqjSND26sb6h9IE5cuiEF0VE96oprJxDmZl6Ce
dtZPoCwmp8y0N51Ht1tHpuxaSZ3GxFGaUe9MHPOEM0iqVy9ezljtIFMFL12Eau22
ZYtOKMbT7gjQB6ewBKG+
=411+
-----END PGP SIGNATURE-----

--iqMm74K5rg2eMP7U--
