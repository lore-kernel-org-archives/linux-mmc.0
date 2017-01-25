From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 7/13] mmc: sunxi: Add more debug messages
Date: Wed, 25 Jan 2017 10:16:51 +0100
Message-ID: <20170125091651.pss4mokis4ncdkwf@lukather>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <102ea884b296dae38ab28369ce14aa7a7998dc80.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFqE7hMdwweE4zX4TcH5qCThb2_NQh5PNA_4coJQUrCwfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gqrzmkn77wz4r5v4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqE7hMdwweE4zX4TcH5qCThb2_NQh5PNA_4coJQUrCwfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org


--gqrzmkn77wz4r5v4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 09:22:24AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Add a bit more debug messages that can be helpful when debugging the cl=
ock
> > setup.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index f0f6922bca8a..40ed287ceb1c 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -661,6 +661,9 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_ho=
st *host, u32 oclk_en)
> >         unsigned long expire =3D jiffies + msecs_to_jiffies(750);
> >         u32 rval;
> >
> > +       dev_dbg(mmc_dev(host->mmc), "%sabling the clock\n",
> > +               oclk_en ? "en" : "dis");
> > +
> >         rval =3D mmc_readl(host, REG_CLKCR);
> >         rval &=3D ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON | SDXC_MASK_=
DATA0);
> >
> > @@ -737,6 +740,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc=
_host *host,
> >                         index =3D SDXC_CLK_50M_DDR;
> >                 }
> >         } else {
> > +               dev_dbg(mmc_dev(host->mmc), "Invalid clock... returning=
\n");
> >                 return -EINVAL;
> >         }
> >
> > @@ -753,6 +757,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_=
host *host,
> >         u32 rval, clock =3D ios->clock;
> >         int ret;
> >
> > +       dev_dbg(mmc_dev(host->mmc), "setting clk to %u (requested %u)\n=
",
> > +               clock, ios->clock);
> > +
> >
>=20
> A better option is to update mmc->actual_clock. That value is
> available (and the requested value) though the debugFS nodes.

Ok, I will change that.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--gqrzmkn77wz4r5v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYiG0DAAoJEBx+YmzsjxAg6wgP/2SeyeTUZjfvBheW0vLgDAFU
hVJxQ678FkkBrpOimEl6NWtsSwRkfSrXvmoKFqoHB+wehvpIbzDpjfLGXgeW2+bH
+pns6shhVo+kFBjELtgngStio0Tf6Rc+9y0eBzGIg6UMPs3mlUELPTfL18eTzGZV
bp6Kj6df1347jqELEPKsItMZ3/jkOn8gIS2D1440ILDbQEh7T5w/tE/+NpZvuapO
hswBr9TQwQdm7hNw4K66/0z+1Ev3czbW7UIbOZFPexotHwXOJHbPp+lLYFlieqDU
StFKEDDm58wvqG22I1wkGZ2j8uHCsKUQjmqdsrVC2Bler4s0ZZJuRirCHwzmHGSE
DqRZITYrtYDJwotOFNbKDwoQG8V9quGg0BEKhMl9jwzRASMGg3mOjouQAOh6KACg
9OP6AgI9ARfygVVCu+WK6/7va5rW0beac/AH8gETKAxHrXHrs1Y67WbLDGgAsgT/
q2m04GsaRker8n6jDtm0fMvB9xgGJQNioDudNTCh7tXUnF9hVyr80shJUz3CADG/
NaCnM+uDgLSxO2+el/5HqwoeT1oo94rq3CUvZ+f8Idf4iIwBQ1z+jstGtbY1+KUC
S9QoCxptvqeqz5Wx2EgElAOPn/8RmmfA7/zJufRaXmy0eFrpx4iv2yDdUEIT8GeX
SYkOpdaAfRbhao2hVeXH
=WSnq
-----END PGP SIGNATURE-----

--gqrzmkn77wz4r5v4--
