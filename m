From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 03/12] clk: Add a function to retrieve phase
Date: Mon, 1 Sep 2014 12:20:26 +0200
Message-ID: <20140901102026.GL15297@lukather>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
 <5402F5D6.4080100@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A+KMS/Wu1IRpMDFu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58714 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752389AbaIAKZE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 06:25:04 -0400
Content-Disposition: inline
In-Reply-To: <5402F5D6.4080100@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org


--A+KMS/Wu1IRpMDFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 31, 2014 at 12:15:50PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 08/30/2014 10:03 PM, Maxime Ripard wrote:
> > The current phase API doesn't look into the actual hardware to get the =
phase
> > value, but will rather get it from a variable only set by the set_phase
> > function.
> >=20
> > This will cause issue when the client driver will never call the set_ph=
ase
> > function, where we can end up having a reported phase that will not mat=
ch what
> > the hardware has been programmed to by the bootloader or what phase is
> > programmed out of reset.
> >=20
> > Add a new get_phase function for the drivers to implement so that we ca=
n get
> > this value.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/clk.c            | 17 ++++++++++++++---
> >  include/linux/clk-provider.h |  5 +++++
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index d87661af0c72..7dbceca694f1 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1797,8 +1797,8 @@ out:
> >   * clk_get_phase - return the phase shift of a clock signal
> >   * @clk: clock signal source
> >   *
> > - * Returns the phase shift of a clock node in degrees, otherwise retur=
ns
> > - * -EERROR.
> > + * Returns the phase shift of a clock node in degrees. Any negative
> > + * values are errors.
> >   */
> >  int clk_get_phase(struct clk *clk)
> >  {
> > @@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
> >  		goto out;
> > =20
> >  	clk_prepare_lock();
> > -	ret =3D clk->phase;
> > +
> > +	if (clk->phase) {
> > +		ret =3D clk->phase;
> > +		goto out_unlock;
> > +	}
>=20
> 0 is a valid phase, so this will cause the phase to
> be read from the hardware each time if the phase is 0.
>=20
> Perhaps make clk->phase signed (if it is not already), init it
> to -1, and check for it not being -1 ?

Yeah, I'm not really proud of this code either, but yours would expose
this -1 into debugfs, so I'm not sure it's really better :)=20

(with -1 being a valid phase too)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--A+KMS/Wu1IRpMDFu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBEhqAAoJEBx+YmzsjxAgp68P/12C8ZcHgyYv01hoKEU7tmLN
KQ6gJuwg4fmgN+6ixYJDcLPJYGeKhqj9xMm95ZjT06cYNZ7OAaEPJb/QyuwUyD05
H3WEbRO6YVqKpchLcKkIUq0mO96AMU8l4msISrdfyANjq0kwkmcR7MGU5w1XWGJ7
NMnK+NRX714kx2Xb1sK5VG5FAI3rSz3ScxF1RgDN35bgntH0lWOTkbgICHz4cHQF
avsx85qwS/8r8sxRzzEtL+6Fo/q9t9wI8BhC29Un/d9lTFU0qPp1okqdnFFceKTg
FavjRAS4lIE1B1l5tm+2tyoPE+OmQxCGWnRsOg1q8/5tf3d8YZ7aSNWcwE/p/AGh
rmmi37vzzbtK9ZFfTR0nQp8kORUloVPCo/3THcL7GACbemSPcw7cm8E9LPxaFuG0
VK+PSMY/hQsBKXwQ25FXLD7kE+Nb1QKbRC3rUXRueE+QFitWMxqN7aBCeYBiSBWv
l61G2uBkE63IFdunOkGAj4JO0TIVniu956vWzeJE30Ulcgqp9u7ZJyN4y8jmw2Rt
HUasirOiqsIdl2KI3dS/HuZDGsAEnEhqpyimdUQLAs1yljzbIhYAYettbt9PxhDM
wPKHBC/IrQTMhqy8qPGh9esm9P8/V137HglM2Xv6+z44ITxmYv8DPYrnB6JegBYt
OMvyhMKXLvcOeZ+0CjGA
=OKzg
-----END PGP SIGNATURE-----

--A+KMS/Wu1IRpMDFu--
