From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix max value of clkd
Date: Fri, 21 Sep 2012 20:14:59 +0300
Message-ID: <20120921171458.GA10409@arwen.pp.htv.fi>
References: <1348240872-16068-1-git-send-email-balajitk@ti.com>
 <CANfBPZ8wpbMeePM8wOJ59gN0LKx3Ed+qRfnBeez18Nyq2DJ2Jg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANfBPZ8wpbMeePM8wOJ59gN0LKx3Ed+qRfnBeez18Nyq2DJ2Jg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2012 at 10:28:00PM +0530, S, Venkatraman wrote:
> On Fri, Sep 21, 2012 at 8:51 PM, Balaji T K <balajitk@ti.com> wrote:
> > clock divisor can take a max value of 1023
> > update code as per TRM so that card init can be handled with
> > higher IP clock frequencies from which clock to the card is
> > derived.
> >
> This is difficult to read without some punctuation / capitalization.
>=20
> > Signed-off-by: Balaji T K <balajitk@ti.com>
> > ---
> >  drivers/mmc/host/omap_hsmmc.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
> > index d9af5f1..073b9ff 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -75,6 +75,7 @@
> >  #define ICE                    0x1
> >  #define ICS                    0x2
> >  #define CEN                    (1 << 2)
> > +#define CLKD_MAX               0x3FF
>=20
> It'd be nice to have a comment on what 3FF stands for and it's
> relation to clock in MHz.
>=20
> >  #define CLKD_MASK              0x0000FFC0
> >  #define CLKD_SHIFT             6
> >  #define DTO_MASK               0x000F0000
> > @@ -478,8 +479,8 @@ static u16 calc_divisor(struct omap_hsmmc_host *hos=
t, struct mmc_ios *ios)
> >
> >         if (ios->clock) {
> >                 dsor =3D DIV_ROUND_UP(clk_get_rate(host->fclk), ios->cl=
ock);
> > -               if (dsor > 250)
> > -                       dsor =3D 250;
> > +               if (dsor > CLKD_MAX)
> > +                       dsor =3D CLKD_MAX;
>=20
> Can these two lines be written in one line as
> "dsor &=3D CLKD_MAX; " ?

maybe:

dsor =3D DIV_ROUND_UP(clk_get_rate(host->fclk), ios->clock);
dsor =3D clamp_t(u16, dsor, 0, CLKD_MAX);

--=20
balbi

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXKCSAAoJEIaOsuA1yqREnBMP/AzJL1THvHMfBvMInl7+kJGu
QSR0p4z8Gm3KsildNVt+7wcf5XfWGOtt2lwimw7w62EBni47lj6XrIe5fiFC7Ksm
kD0vkO762RenHEnLJI15QQL4+TB/HIDZsL1uFwswDdmrlZZTbMRnlMGH/2luqhvx
qGSS+bvANTbHPNWGm+7os4COo8Nlmnft4UVLDI41z/by7QhYvNS/MCguL2nzWDxq
9W9QvKsbnHOpu41YXggEPDEMCLEHgV3WqD9NjJnmUQ3xI5/z2Vjb95hZXtEoU3Op
7zs4UGjhKYw9sLKwGzSfUVnPqBCrkkyoAF2NY7KsklUrts9S0WkKQWAtdnW/wvda
r6CZMufcjr7ikT8fPsIYLP737E3xC8RN5k/EOe+M7q6vf9kPu76l98h/rNEH9KoL
q2O4N3tmw7lwgeYPzaErX7adDKnLhpSw+jJvaYjXzUCd4aznFsSqlS5BiPV44Guu
OPT/gFfICCL/SpzInlQY18CeDh8o2k/T4rCphc6I/Kg/ogYypt7Pcr8OaKRNfdC/
eeWLnzCcwIJ6lGLO5w/c02ZoSCSXu92Bi/GzhdWfY1l4zStl14pVAyi8AnKvGsMz
lvQ6+jxfbo0V+TIy3N8Bo2y4bYxlWB1f8X2DNk762rcYU5s3Fa3W5l3zZh7e0J4m
0nOyeizL/f3ghnsYMLHl
=Mo2L
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
