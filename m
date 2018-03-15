From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 8/8] mmc: sunxi: Add runtime_pm support
Date: Thu, 15 Mar 2018 13:04:13 +0100
Message-ID: <20180315120413.yafkee4wgf4pyulq@flea>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
 <052c21c000f64c28fd6b64c4db11e4b706bebf79.1520520655.git-series.maxime.ripard@bootlin.com>
 <CAPDyKFoJ0KftG1VxzdM97ubFJ25M+X0EjgOPc6HxewgyZMPipg@mail.gmail.com>
 <20180315100411.iqcnwqws623ws6yn@flea>
 <CAPDyKFpzi2fbSHPUaJRnBmb7YLCzwD0fTFStXgY1eB136m2gEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4634075046190891183=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpzi2fbSHPUaJRnBmb7YLCzwD0fTFStXgY1eB136m2gEw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Quentin Schulz <quentin.schulz@bootlin.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--===============4634075046190891183==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6gq43pagxbgkfhhz"
Content-Disposition: inline


--6gq43pagxbgkfhhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 15, 2018 at 11:24:36AM +0100, Ulf Hansson wrote:
> >> > +static int sunxi_mmc_runtime_resume(struct device *dev)
> >> > +{
> >> > +       struct mmc_host *mmc =3D dev_get_drvdata(dev);
> >> > +       struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> >> > +       int ret;
> >> > +
> >> > +       ret =3D sunxi_mmc_enable(host);
> >> > +       if (ret)
> >> > +               return ret;
> >> > +
> >> > +       sunxi_mmc_power_up(mmc, &mmc->ios);
> >>
> >> Instead of doing power up, you may need restore some ios settings,
> >> such as the clock rate for example.
> >>
> >> You may also need to restore some registers in sunxi device, in case
> >> it's possible that the controller loses context at runtime suspend.
> >
> > The thing I was precisely trying to avoid was this :)
> >
> > I could save and restore registers when the MMC controller is put into
> > suspend, but that's pretty much exactly the same sequence than what is
> > done in the MMC_POWER_UP sequence in .set_ios.
>=20
> Well, there may be some overlap.
>=20
> >
> > So it just felt cleaner to just do the power_up sequence at resume
> > time. It avoids having to maintain the list of registers to save and
> > restore, and it involves less code overall.
>=20
> I understand.
>=20
> >
> > It suprised me a bit that the core will not call .set_ios with
> > MMC_POWER_UP at resume by itself, but I guess there's a good reason
> > for that :)
>=20
> It does that when it runtime PM manages the mmc/sd/sdio card, don't
> confuse that with the mmc host. That's because it needs to follow the
> (e)MMC/SD/SDIO spec, which don't allows you to just cut the power to
> card without first informing (sending commands) the card about it.

Ok. So this might sound a bit trivial, but I'm confused now about what
set_ios is supposed to be doing.

I thought this was about the MMC controller itself, but from what
you're saying, it seems that it is used for both the MMC controller
and the MMC card itself, with the powermode being about the MMC card,
and the rest about the MMC controller.

I guess we're mixing the two then, especially the power off part that
will also reset the controller, or the controller that is initialised
only at power on. Other MMC controller drivers I could find were doing
the MMC controller setup unconditionally, so I guess we have room for
improvements here.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6gq43pagxbgkfhhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqqYTwACgkQ0rTAlCFN
r3SQJA/8CzaEVwv1JdfNwbbQt41dHcCNdlD/BDqaM2SdQwodhEWNtGJj8lxayRBY
VOBmgXYY8fyh3BHboS2Gv2mMzDPGeGFT1XINapA6LxiaM6hjY0hh27JZgC3sTX5S
Ql1ILoltrsj2uWdO96f6JLw2sGQ3VNqXfTwRtdCPpo2rYnYWHX+9yvj4JTrsIbB4
XyD8HVU7R2TmRnl8ejLNyDSaiMBd9j7zgk2dh4wjx/iLjclOc4Eo0yBLb98jHtEd
P0jWRCeD3X/MOktljWKLsv8GyNmmUg2vYXnDfIXcnqyXxO0ldhdqfDMX+Kw7sVo6
Uu74hv1i3JjgFD8NIPh+buq0mgMbXXpsAe+/j0P/Ht4egT/fpMh+tLC31KV+c2VL
a4jgU3eKPJ2ulR6olXxebssf3VzSI03egbhYDEXSXY2m0Hz49CROTOFgeA9Chlur
Jj9TRQXc+q9TpKCgT9LPSQ63rZEmBQR3fC3tvTi4CIhUQ16kv10AXkoRlQr0odJP
OPcDsc96PAeoBTMwnQgqVIuUcHUy0BfNQuwYbdKaywrpthYKIRGtFakVssOT8yUH
VGTw3dvEb0G6OngCPexoU/1G9xUgnGw+mLC9YMdE5KcmOWEON3zrlC7mdr3Mn8h/
9FsOVGf1EBAVFbowCDifWWGFCxEzqqYx7DS1OtM13yiK3G60JO8=
=i9mm
-----END PGP SIGNATURE-----

--6gq43pagxbgkfhhz--


--===============4634075046190891183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4634075046190891183==--
