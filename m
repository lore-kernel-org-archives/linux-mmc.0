From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
Date: Tue, 5 Feb 2019 10:51:28 +0100
Message-ID: <20190205095128.shc73w377gkb2hyk@flea>
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-3-wens@csie.org>
 <20190204093427.vg63e5xmd7u52leh@flea>
 <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
 <20190204134110.dvo3qvnhiksqig2l@flea>
 <CAGb2v64RAfa1zTq+A0Vjc6TPZ7K9z7qU6qNd8nfKm1U87xDcxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ep7x3z4weqysn6n6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v64RAfa1zTq+A0Vjc6TPZ7K9z7qU6qNd8nfKm1U87xDcxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Chris Blake <chrisrblake93@gmail.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--ep7x3z4weqysn6n6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 04:42:53PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 4, 2019 at 9:41 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Mon, Feb 04, 2019 at 06:16:24PM +0800, Chen-Yu Tsai wrote:
> > > On Mon, Feb 4, 2019 at 5:34 PM Maxime Ripard <maxime.ripard@bootlin.c=
om> wrote:
> > > >
> > > > On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> > > > > The MMC device tree bindings include properties used to signal va=
rious
> > > > > signalling speed modes. Until now the sunxi driver was accepting =
them
> > > > > without any further filtering, while the sunxi device trees were =
not
> > > > > actually using them.
> > > > >
> > > > > Since some of the H5 boards can not run at higher speed modes sta=
bly,
> > > > > we are resorting to declaring the higher speed modes per-board.
> > > > >
> > > > > Regardless, having boards declare modes and blindly following the=
m,
> > > > > even without proper support in the driver, is generally a bad thi=
ng.
> > > > >
> > > > > Filter out all unsupported modes from the capabilities mask after
> > > > > the device tree properties have been parsed.
> > > > >
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > >
> > > > > ---
> > > > >
> > > > > This should be backported to stable kernels in case people try to=
 run
> > > > > new device trees (that declare newly supported modes) with old ke=
rnels.
> > > > > ---
> > > > >  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunx=
i-mmc.c
> > > > > index 7415af8c8ff6..a01433012db0 100644
> > > > > --- a/drivers/mmc/host/sunxi-mmc.c
> > > > > +++ b/drivers/mmc/host/sunxi-mmc.c
> > > > > @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform=
_device *pdev)
> > > > >       if (ret)
> > > > >               goto error_free_dma;
> > > > >
> > > > > +     /*
> > > > > +      * If we don't support delay chains in the SoC, we can't us=
e any
> > > > > +      * of the DDR speed modes. Mask them out in case the device
> > > > > +      * tree specifies the properties for them, which gets added=
 to
> > > > > +      * the caps by mmc_of_parse() above.
> > > > > +      */
> > > > > +     if (!(host->cfg->clk_delays || host->use_new_timings))
> > > > > +             mmc->caps &=3D ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DD=
R |
> > > > > +                            MMC_CAP_1_2V_DDR);
> > > > > +
> > > > > +     /* TODO: UHS modes untested due to lack of supporting board=
s */
> > > > > +     mmc->caps &=3D ~MMC_CAP_UHS;
> > > >
> > > > I've tested up to SDR104 and it works on the A64 at least
> > >
> > > That's good to know. What board was this on? I had given up hope wait=
ing
> > > for a vendor to produce a board that could do proper voltage switchin=
g for
> > > SD cards.
> >
> > On a Sootech SoM, that had an HS400 eMMC and an SDR104 Marvell WiFi
> > chip. I don't have that board anymore, and the website seems down now
> > though :/
>=20
> Bummer. So no commercially available board still. :/
>=20
> > > > > +     /* TODO: This driver doesn't support HS200 and HS400 modes =
yet */
> > > > > +     mmc->caps2 &=3D ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> > > >
> > > > And HS200 works too.
> > >
> > > OK. I thought there was some special magic required in the driver. Ma=
ybe
> > > that was for HS400 only? Again, what board was this on?
> >
> > Yeah, that was for HS400 only
>=20
> OK. So would unblocking UHS and HS200, but not enabling them by default,
> which is essentially the original behavior, work for you?

Yep, that's perfect

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ep7x3z4weqysn6n6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFlcoAAKCRDj7w1vZxhR
xeBTAQDTD1TeSPYHWCfSOpA49MiOgyqfqfJf9WsbGmRTM/kV9AD+LTPEbrIm1YC1
p84q4fNuLhLgueCaZ63WpNbbl/K9Egg=
=CT8r
-----END PGP SIGNATURE-----

--ep7x3z4weqysn6n6--
