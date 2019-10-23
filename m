From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Date: Wed, 23 Oct 2019 17:33:13 +0200
Message-ID: <20191023153313.GB5153@kunai>
References: <20191018131338.11713-1-hslester96@gmail.com>
 <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chuhong Yuan <hslester96@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 04:32:49PM +0200, Ulf Hansson wrote:
> On Fri, 18 Oct 2019 at 15:13, Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
> > failures.
> > Add checks for them to fix the problem.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/re=
nesas_sdhi_core.c
> > index d4ada5cca2d1..dc5ad6632df3 100644
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pde=
v,
> >         if (!IS_ERR(priv->pinctrl)) {
> >                 priv->pins_default =3D pinctrl_lookup_state(priv->pinct=
rl,
> >                                                 PINCTRL_STATE_DEFAULT);
> > +               if (IS_ERR(priv->pins_default))
> > +                       return PTR_ERR(priv->pins_default);
> > +
> >                 priv->pins_uhs =3D pinctrl_lookup_state(priv->pinctrl,
> >                                                 "state_uhs");
> > +               if (IS_ERR(priv->pins_uhs))
> > +                       return PTR_ERR(priv->pins_uhs);
> >         }
>=20
> This looks correct to me, as I guess if there is a pinctrl specified
> for device node of the controller, it means that it should be used!?
>=20
> I understand that this is only used for those variants that supports
> UHS-I via the renesas_sdhi_start_signal_voltage_switch(). Wolfram, is
> this fine you think?

Well, I don't like to bail out because this error is not fatal for basic
operations. How about releasing priv->pinctrl again with an additional
warning that pinctrl settings are broken and will prevent 1.8v modes?

Opinions?


--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2wcrkACgkQFA3kzBSg
KbYLrA//c8zF4HqJkaFNFIInZh0QWFD/4DVtK/SARs7eE/Ccf0DEE3hKk8WxvZAQ
r21YVOhBw/dPlgog4xF0zBZZ2B4KIptDyJRZPVj/ZVoFBFrA1w+hu4HlUtiJMr79
apZNpwlhSkxTYfO6PEo4wuFuGmoLRA6qj+PJDeFb9uAWdxMUTU26KVwa6jZBAbE6
Hzfzvs4OXZGoawXSxfzY9IkwtHKR8CWaB8FpcdUSN88wwWVMopejAVMr2zUrOeec
6E6/mjT29Qut+rBl0SUcZZyy/9ZKsAsrslFOU8YLAMknHAonz0NYO+6XKu26qRhH
wHgv6/6htzpeFJh8f8wbQ4aRdeRuCJFFvcAd1bqeTrWJ5sFq1MYFMRJs38bFgs1J
AbWD5BBSC2nIGhHGXt9dHv7hxl4SDE+JCZu+VNjbdJOYqbGlNBMGyMXfZ2ZjPNS1
Z8cwz4l6KModx+s4sqM0BkSbn/uLzlCtmVHN7s/lLs0FMXOG4NQkKZwgowu6cKJX
/PzXcT4N3Roswar2c5sncYHMPvTYNkknmp2T9qXQ3XELHZsb9f5xgONyzxNjwap1
K2H1ZCuoTrJMpi7NNQwmG5NovFEcAOQ7qlRlCE2ITBniH4XFeduveigSntXnioEE
K5RKUqi+9gOjU9+BbXxLSzo8OCrF+6o+psCNCUWdVQHbnTgtKsw=
=S45A
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
