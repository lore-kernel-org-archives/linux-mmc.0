From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/6] mmc: sunxi: Always set signal delay to 0 for A64
Date: Wed, 11 Jan 2017 22:17:58 +0100
Message-ID: <20170111211758.wt24lx5b63rgujia@lukather>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
 <5eff19eec2b110bb643a38e7fef221208f585589.1483980339.git-series.maxime.ripard@free-electrons.com>
 <96ba5fd8-d551-5993-f347-202c47efec8c@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4654577174496252882=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <96ba5fd8-d551-5993-f347-202c47efec8c@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============4654577174496252882==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gqetourdkzxndam3"
Content-Disposition: inline


--gqetourdkzxndam3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 12:30:41AM +0000, Andr=E9 Przywara wrote:
> On 09/01/17 16:46, Maxime Ripard wrote:
> > Experience have shown that the using the  autocalibration could severely
> > degrade the performances of the MMC bus.
> >=20
> > Allwinner is using in its BSP a delay set to 0 for all the modes but HS=
400.
> > Remove the calibration code for now, and add comments to document our
> > findings.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 50 ++++++++++++-------------------------
> >  1 file changed, 17 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index b1d1303389a7..ea9552a0d820 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -683,41 +683,19 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_=
host *host, u32 oclk_en)
> > =20
> >  static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_of=
f)
> >  {
> > -	u32 reg =3D readl(host->reg_base + reg_off);
> > -	u32 delay;
> > -	unsigned long timeout;
> > -
> >  	if (!host->cfg->can_calibrate)
> >  		return 0;
> > =20
> > -	reg &=3D ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
> > -	reg &=3D ~SDXC_CAL_DL_SW_EN;
> > -
> > -	writel(reg | SDXC_CAL_START, host->reg_base + reg_off);
> > -
> > -	dev_dbg(mmc_dev(host->mmc), "calibration started\n");
> > -
> > -	timeout =3D jiffies + HZ * SDXC_CAL_TIMEOUT;
> > -
> > -	while (!((reg =3D readl(host->reg_base + reg_off)) & SDXC_CAL_DONE)) {
> > -		if (time_before(jiffies, timeout))
> > -			cpu_relax();
> > -		else {
> > -			reg &=3D ~SDXC_CAL_START;
> > -			writel(reg, host->reg_base + reg_off);
> > -
> > -			return -ETIMEDOUT;
> > -		}
> > -	}
> > -
> > -	delay =3D (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
> > -
> > -	reg &=3D ~SDXC_CAL_START;
> > -	reg |=3D (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
> > -
> > -	writel(reg, host->reg_base + reg_off);
> > -
> > -	dev_dbg(mmc_dev(host->mmc), "calibration ended, reg is 0x%x\n", reg);
> > +	/*
> > +	 * FIXME:
> > +	 * This is not clear how the calibration is supposed to work
> > +	 * yet. The best rate have been obtained by simply setting the
> > +	 * delay to 0, as Allwinner does in its BSP.
> > +	 *
> > +	 * The only mode that doesn't have such a delay is HS400, that
> > +	 * is in itself a TODO.
> > +	 */
> > +	writel(SDXC_CAL_DL_SW_EN, host->reg_base + reg_off);
> > =20
> >  	return 0;
> >  }
> > @@ -806,7 +784,13 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc=
_host *host,
> >  	if (ret)
> >  		return ret;
> > =20
> > -	/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
> > +	/*
> > +	 * FIXME:
> > +	 *
> > +	 * In HS400 we'll also need to calibrate the data strobe
> > +	 * signal. This should only happen on the MMC2 controller (at
> > +	 * least on the A64 and older SoCs).
>=20
> Which older SoCs have this calibration register and a DS signal?
> Is that supposed to mean "other" SoCs?

That was supposed to mean that newer (than A64) SoCs might have that
calibration on other controllers than MMC2. But you're right that it
actually applies only to A64 anyway, I'll remove the and older part.

> Other than that:
>=20
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--gqetourdkzxndam3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYdqD/AAoJEBx+YmzsjxAgMCsP/05AHRdsoBuCsYNAPg3LNHac
dpPP8ufBe7OPcHqFEO7Anhe7ry4ung0IZ0jdpkHQEx4FzzEUjhe/BvgmF0rHKNVO
0nbUQHD9Bi9lky9nZcfSXYQ0esFNJYDW6NXr6IbICiIZJjlbAqtUYdvXLGMxhz5w
c20sBzBy/tEUuLTv4dcCvwyZTXANYDZ2Jnw91evcrzSFgJD3HPUhnZ2+8BWEJIgF
Mx8vba/RHsbpsY1mweg2Gg9OBgTy4LPT2/z9xWrVj8rsdgedoJG7xtrBs0gt4w9N
7MitCD9oAiz4VgCyaoXcBesfllitaf2OC/wZxvRhxFah33JaUksVINdcs/5XXgcn
uiza359pZYnsT5A/yDR9ARz890MUdc9OwmVgQ2kO8mZWjrZ75mANTlxYC0Kg6YzL
Icd7ZiBmifBa9ItgmucumUy9IDVQ91GHjeNnn/XhHFwn8mH9ewULXutH5W3DWkuH
//D/Rb3aqrXMtoaJ/P3+Hgmj7d93OuafSDVkJj7vqix/dih5nnCwCxtAD8Ce7wFz
+a/cMuO5ce7IhIcKuftfei8ZKw3jcJkOnIglCD1ARjSyE08UpDt0t69npn7EHAQk
42sL6gM2iG4CCVcaVkbvxHz/zZ0brlNmiF2nmtxxz18IC0BgrkVpndbImxy47jdn
XqPtb2EF5F+rVJmVHfWR
=4Pbw
-----END PGP SIGNATURE-----

--gqetourdkzxndam3--


--===============4654577174496252882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4654577174496252882==--
