From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Support module reset
Date: Sat, 20 Aug 2016 12:29:41 +0200
Message-ID: <20160820102938.GA27552@mithrandir.ba.sec>
References: <20160819140003.22608-1-thierry.reding@gmail.com>
 <5bb05c13-9813-6b19-3a22-77502ff3ffa6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5bb05c13-9813-6b19-3a22-77502ff3ffa6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2016 at 05:44:32PM +0300, Dmitry Osipenko wrote:
> On 19.08.2016 17:00, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > The device tree binding for the SDHCI controller found on Tegra SoCs
> > specifies that a reset control can be provided by the device tree. No
> > code was ever added to support the module reset, which can cause the
> > driver to try and access registers from a module that's in reset. On
> > most Tegra SoC generations doing so would cause a hang.
> >=20
> > Note that it's unlikely to see this happen because on most platforms
> > these resets will have been deasserted by the bootloader. However the
> > portability can be improved by making sure the driver deasserts the
> > reset before accessing any registers.
> >=20
> > Since resets are synchronous on Tegra SoCs, the platform driver needs
> > to implement a custom ->remove() callback now to make sure the clock
> > is disabled after the reset is asserted.
> >=20
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 38 ++++++++++++++++++++++++++++++++++=
+++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-te=
gra.c
> > index 1e93dc4e303e..4c29a64721aa 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/reset.h>
> >  #include <linux/mmc/card.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/mmc.h>
> > @@ -65,6 +66,8 @@ struct sdhci_tegra {
> >  	struct gpio_desc *power_gpio;
> >  	bool ddr_signaling;
> >  	bool pad_calib_required;
> > +
> > +	struct reset_control *rst;
> >  };
> > =20
> >  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> > @@ -464,6 +467,16 @@ static int sdhci_tegra_probe(struct platform_devic=
e *pdev)
> >  	clk_prepare_enable(clk);
> >  	pltfm_host->clk =3D clk;
> > =20
> > +	tegra_host->rst =3D devm_reset_control_get(&pdev->dev, "sdhci");
> > +	if (IS_ERR(tegra_host->rst)) {
> > +		rc =3D PTR_ERR(tegra_host->rst);
> > +		dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
> > +		goto err_clk_get;
> > +	}
> > +
> > +	reset_control_deassert(tegra_host->rst);
>=20
> Why just not to do a proper reset here? You won't need a custom .remove t=
hen.

We could do a proper reset here, although the Tegra CAR driver currently
doesn't implement it. I'm also not sure whether we can implement it
safely because not all resets use the same sequence.

That said, we could do a manual assert/sleep/deassert cycle here, just
to be on the safe side.

Also, the custom ->remove() implementation is still necessary to make
sure that the device is held in reset after the driver's unloaded. It
isn't strictly necessary to do that because disabling the clock might
be enough to stop the hardware block from consuming power in most
cases, but I think it's good practice to do so anyway, if for nothing
else than force the next driver to deassert the reset and hence start
=66rom pristine hardware state.

> > +	usleep_range(2000, 4000);
> > +
>=20
> Is this sleep after deassertion really needed?

Yeah, I think it is. There are various bits of documentation that
suggest that a delay of at least a few microseconds is needed. 2 to 4
milliseconds is probably a little excessive, but this isn't in a time
critical path anyway, and the large sleep avoids any potential subtle
timing issue. It's also in line with what other drivers do.

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXuDEPAAoJEN0jrNd/PrOh+G4P/RG04LYpkP2z9qm4LXECIAqA
w1ce3vgIAzNB46fVC1dcL7dJsP2gxMh1iVx7vVNbsdt7M/UCxWPx9Co9LaiLQ7Ar
XcshE2IPC2oGWj2voHL6ckNccBUREKBvkdjw5PYrK3hyU66rHklUG+2Pw4WjixNj
td2oLm9lfutT2UJEpCYavT1HYsyvZ67UyfHLkhacjCeSIdLGjcldsyIZRopdvOwu
IO3Nxb/jcbdl5dOLKfmqHXl7rVKtHyit2/LK2/FLGCc7DMBEKAz9PdGqIZU6DQJd
dDjOUPK5XkrNQvzbYwf/SbazoEwtHRg0c09VXaWBBb4ej7N97EalNYGsuKP/JWEr
rjnKmQw/GZb94+JD3yOJ1CdiYG5LcxcwK7M+7BWnyEwxjqK2DTJiEC8ZKxLE3sEf
7NslztS5LbsOisJj54vmra9davFBg8Lr0Z/zE3TXzCMf16pWZv5AQ5X2nI7GdjMU
TLaI275suikiBYxjD0J31ORLbEuY7ZiCbmyu+ehAg2O7qcDE5WqiJj5fYLCYgPZR
wVYzWnDFg+Pe9n6mq04rUvt64k3Rh8pjzRPAIPSGZDWCuR/x2HbNaVG/fIIu1NWJ
or/an+lNm0DnYk5e5KgHnMYyOUbV56/ws3RiKcr44mudt9keprf7OuOhn5Uhps4y
CeRQIUG6CN8v8klmZRFq
=yweS
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
