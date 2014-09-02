From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 03/12] clk: Add a function to retrieve phase
Date: Tue, 2 Sep 2014 11:50:08 +0200
Message-ID: <20140902095008.GT15297@lukather>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
 <5402F5D6.4080100@redhat.com>
 <20140901102026.GL15297@lukather>
 <54045820.7080102@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8e+hhEznXhH+0Bab"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36660 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751503AbaIBJzR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 05:55:17 -0400
Content-Disposition: inline
In-Reply-To: <54045820.7080102@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org


--8e+hhEznXhH+0Bab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2014 at 01:27:28PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 09/01/2014 12:20 PM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Sun, Aug 31, 2014 at 12:15:50PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 08/30/2014 10:03 PM, Maxime Ripard wrote:
> >>> The current phase API doesn't look into the actual hardware to get th=
e phase
> >>> value, but will rather get it from a variable only set by the set_pha=
se
> >>> function.
> >>>
> >>> This will cause issue when the client driver will never call the set_=
phase
> >>> function, where we can end up having a reported phase that will not m=
atch what
> >>> the hardware has been programmed to by the bootloader or what phase is
> >>> programmed out of reset.
> >>>
> >>> Add a new get_phase function for the drivers to implement so that we =
can get
> >>> this value.
> >>>
> >>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>> ---
> >>>  drivers/clk/clk.c            | 17 ++++++++++++++---
> >>>  include/linux/clk-provider.h |  5 +++++
> >>>  2 files changed, 19 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >>> index d87661af0c72..7dbceca694f1 100644
> >>> --- a/drivers/clk/clk.c
> >>> +++ b/drivers/clk/clk.c
> >>> @@ -1797,8 +1797,8 @@ out:
> >>>   * clk_get_phase - return the phase shift of a clock signal
> >>>   * @clk: clock signal source
> >>>   *
> >>> - * Returns the phase shift of a clock node in degrees, otherwise ret=
urns
> >>> - * -EERROR.
> >>> + * Returns the phase shift of a clock node in degrees. Any negative
> >>> + * values are errors.
> >>>   */
> >>>  int clk_get_phase(struct clk *clk)
> >>>  {
> >>> @@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
> >>>  		goto out;
> >>> =20
> >>>  	clk_prepare_lock();
> >>> -	ret =3D clk->phase;
> >>> +
> >>> +	if (clk->phase) {
> >>> +		ret =3D clk->phase;
> >>> +		goto out_unlock;
> >>> +	}
> >>
> >> 0 is a valid phase, so this will cause the phase to
> >> be read from the hardware each time if the phase is 0.
> >>
> >> Perhaps make clk->phase signed (if it is not already), init it
> >> to -1, and check for it not being -1 ?
> >=20
> > Yeah, I'm not really proud of this code either, but yours would expose
> > this -1 into debugfs, so I'm not sure it's really better :)=20
> >=20
> > (with -1 being a valid phase too)
>=20
> According to the comments in the patch adding the original phase functions
> valid values are 0 - 359. And you could use clk_get_phase from the debugfs
> code.

Yep, except that if I see a value -1 as a phase, I would assume that
it's 359, but maybe it's just me :)

Mike's solution seem great, I'll go for that.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--8e+hhEznXhH+0Bab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBZLQAAoJEBx+YmzsjxAgLlIP/2B5D9rC7JhQ7FdkHoURUHy7
ybN8Dlv7rFPGuG2fGNMmzxVOMaNFOTa6lr2di2lQtDkK4jKeXj4oqRaS3ulpVjV7
JaIxy26NVDWytPDvVNb0UJcNOoj/Ld6csZ9mHt9H7MP6guSkzgAlHEomqUwLP1A7
I4l7AWDdNe4o1p32b/5N0n+DgrM+ivHFtD6aqD8uXlY7fBfu1ScyNNWnBDbUGFhy
nrhfiNsAPyCXpS7lpP5tlNL01envMEyHg0McNHouuV7sE9va4arRKtZbkVKPjSHL
UI8dcLDBtygCzrZSQVDAIXUra/n/EqDBrq7n845iP6s6B61X1cFDRc2B8K4a6imE
3mazTmE2DMBf0g+QwFXSrcIsku+jvIMTFX0Yz3UnDj9DrHFcZ+N8LpHPjYOl8fDm
oRE8EUDGBfH2RmyZ2tSIibltU7C6TcINvsX/s6PepJ7+c54pxGNtHHTHE5s9PjRG
ya6b2POqQ6Bd5MyAyZsWaYz+S4LtSsFzdQWN8MMo86Zlk4rQjzGBpNBF7rVZhvYx
I1ibwlDmllCGevhlcZWeibxEwcGtPJU4zIdH+On+n7ok/mojGQkvq5jirtBgZ2yW
fxDftMYZLAXqKJL2dApDJB997WBQn2PN8Slgz6gneiNCyWyupbo4TRuvnH7fmv7X
MSwkXr6rPonBC+41V8g5
=rwC0
-----END PGP SIGNATURE-----

--8e+hhEznXhH+0Bab--
