From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
Date: Thu, 14 Jan 2016 23:40:25 +0100
Message-ID: <20160114224025.GA26988@earth>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth>
 <20160114172549.GC5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160114172549.GC5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, ivo.g.dimitrov.75@gmail.com, aaro.koskinen@iki.fi, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, khilman@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 14, 2016 at 05:25:49PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 14, 2016 at 01:07:06PM +0100, Sebastian Reichel wrote:
> > On Thu, Jan 14, 2016 at 02:45:20PM +0530, Kishon Vijay Abraham I wrote:
> > > Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms =
that
> > > have PBIAS regulator) in order for MMC1 to work.
> > >=20
> > > Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for us=
ers
> > > using a olddefconfig or a custom .config.
> > >=20
> > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > >  drivers/mmc/host/omap_hsmmc.c |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> > > index 7fb0753..7086bd6 100644
> > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > @@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_=
host *host)
> > >  	host->pbias =3D devm_regulator_get_optional(host->dev, "pbias");
> > >  	if (IS_ERR(host->pbias)) {
> > >  		ret =3D PTR_ERR(host->pbias);
> > > -		if ((ret !=3D -ENODEV) && host->dev->of_node)
> > > +		if ((ret !=3D -ENODEV) && host->dev->of_node) {
> > > +			dev_err(host->dev,
> > > +			"SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
> > >  			return ret;
> > > +		}
> > >  		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
> > >  			PTR_ERR(host->pbias));
> > >  		host->pbias =3D NULL;
> >=20
> >=20
> > Is there a good reason against adding "depends on REGULATOR_PBIAS"
> > to MMC_OMAP_HS?
>=20
> There are very good reasons not to do this: that will result in
> configurations where MMC_OMAP_HS was set but without REGULATOR_PBIAS
> ending up with MMC_OMAP_HS being disabled.  That doesn't help the
> root problem, which is "why has the kernel boot regressed for my
> previous working configuration?"
>=20
> The solution proposed here adds a message to the boot which points
> out fair and square what needs to be done to rectify the boot
> failure.  Adding a dependency just brings up the question "where
> has my MMC driver gone?"

The best thing would be to have no regression. Just printing a
message means I have to build another kernel. But more importantly
the message may not be visible by the user - e.g. if the display has
not yet been initialized.

-- Sebastian

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWmCPSAAoJENju1/PIO/qaXMwP/2LlL/M6L8LeFRAiEIM+xskg
GMEpDVYlXK+GLys9vzswT5PXjgsdjH8yJXP1v0XB8VOBV5XjED11H28tn2EuXOV3
3RIT/tm60XGCC8IX8NWiqSZY5dGzrw7UKPPDJnZcnxb8uMrUCOBdB+qgYmAXDfqM
Xd8BUGzNg30IXEPzbAjUZxCzV3V8iTEARURfrBGMJBPkXocTUmmGEdmRCmwwrbrb
8gKdKqv+SIEf1cp2AUz2wU7wtqrnqnNxoBrNC5I8q+4hDI9iqcwXLJLjAYm83ikf
hP+7UC6icPm+vGHrJlenQxGAK+AGnCTo0jkxS3ZuAZuKHY5yzvVHUsgTFAEeNvoI
gSDYW0oZXt7DxbtaXbJdVrpliSytwa6ShVniUzyuCddlyRgSdjT/jCnp0XrwDqik
lbK5fgoZzwe9EhPXJW401BugjgYAqtNnB+pBUWkO8qtBVqEE+MhmOdmA7Q4SsLTx
8OH0cQueQi5I59kN5M0h8KM7XbGoZhUcXUniMhXWbOIrC/W/y1Q293ngDAc9Fd7y
knZr3zLqeP5GYMnC4hHA9DR4NUVzfLWfIrexibGzEEORpKdCHpKaGY7+xR827rZ+
I8D8D2IBTWn2rCjPtqWm0rI50PaaCWcR29J0ArcmqYfAVvtuJW5mLKGdxqsY6l1I
THrD07n1yEPIGRkREn6a
=vqwN
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
