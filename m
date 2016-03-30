From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds
 for our constraints
Date: Wed, 30 Mar 2016 08:25:00 -0700
Message-ID: <20160330152500.GU2350@sirena.org.uk>
References: <56F0624C.8010004@gmail.com>
 <CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
 <CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
 <CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
 <20160327090859.GH5028@sirena.org.uk>
 <CAMuHMdXuy2TxACTcsgOpZvrJEeTSQbCgCUmS9PXfBhhZfgbBBA@mail.gmail.com>
 <20160329145823.GK2350@sirena.org.uk>
 <CAMuHMdXx_=LzH7w+9u=o3WZ-qVPqMA2LDCeanvdGs-ywXRCy_A@mail.gmail.com>
 <20160329182725.GD2350@sirena.org.uk>
 <HE1PR0401MB180138D15E4D2101330543DC90980@HE1PR0401MB1801.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jp4gq2voFtVFKZdE"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB180138D15E4D2101330543DC90980@HE1PR0401MB1801.eurprd04.prod.outlook.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bjorn Andersson <bjorn@kryo.se>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--Jp4gq2voFtVFKZdE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 09:07:21AM +0000, Haibo Chen wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> In our sdhci.c, we call the function=20
> regulator_set_voltage ---> regulator_set_voltage_unlocked(struct regulato=
r *regulator, int min_uV, int max_uV)
> here, the parameter min_uV is 3300000, and the max_uV is 3400000
>=20
> currently with your patch (the upper operator is &&), when insert a SD3.0=
 card,=20
> it will do the sanity check, and return -EINVAL

> but when I change the upper operator from && to !=3D,=20
> before the sanity check, it will first get the current_uV, and then go to=
 out.
>=20
> I'm not familiar with regulator common code. Hope the upper describe can =
help you debug this issue.

No, that's not helping clarify anything.  To repeat what I said to Geert=20
this patch changes code that is only called when the regulator is
probed.  This means that the changed code is not running when the SDHCI
code is running.  You need to investigate what exactly is causing the
error.

Just randomly thrashing around with a separate bit of code with no
coharent explanation for what you think is happening is not helping
here, we need some analysis of what is going on.  The change you are
both proposing is guaranteed to break other boards since it means that
the case we supported originally where we set a specific voltage that is
specified by setting equal minimum and maximum constraints is no longer
going have the voltage applied.

Having taken another look I *suspect* that the SDHCI code is broken in
the way it enumerates the set of voltages that can be set and that this
will probably trigger in other situations where the set of voltages that
can be set is limited but I can't put my finger on it, someone with the
ability to run the code will need to investigate.

The following patch *might* help the SDHCI but I'm just guessing and
like I say it looks like this is flagging up a problem in the SDHCI
code.

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regula=
tor.c
index f45106a44635..cd828dbf9d52 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -43,10 +43,12 @@ static void of_get_regulation_constraints(struct device=
_node *np,
 		constraints->max_uV =3D pval;
=20
 	/* Voltage change possible? */
-	if (constraints->min_uV && constraints->max_uV) {
+	if (constraints->min_uV !=3D constraints->max_uV)
 		constraints->valid_ops_mask |=3D REGULATOR_CHANGE_VOLTAGE;
+
+	/* Do we have a voltage range, if so try to apply it? */
+	if (constraints->min_uV && constraints->max_uV)
 		constraints->apply_uV =3D true;
-	}
=20
 	if (!of_property_read_u32(np, "regulator-microvolt-offset", &pval))
 		constraints->uV_offset =3D pval;

> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Mark Brown

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--Jp4gq2voFtVFKZdE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW++/JAAoJECTWi3JdVIfQLAIH/3n53T8m+WIzN63kYqRK6+Wc
DuTrCqo5x+lPHk9d66lvu9YjqvQn0jZo/M4dmi7wYUQFnMxl68UobN6D0xHFwSyF
h6qcS6RxeXrPoJREBt4ppGqkVhI1tWDktwqPWDerEE61DjTces8fHTkh1f7DjKL1
OBxPf++CXtrZkrMrsM/JML0uwDp5B3S97T1Mka5vMigjEb1/dxVOkMpjn4f/ky8x
aArLFblsSMrQuOo3IpTFC157KD2LL9Wqz21/cx1bOUr4gx/OyIUFflQauxKGUQFj
G6AN+Vv62sd+5DDqq+2fEHe/xbmrTipkztZkuzO7f8/LBktpk8BM90abTtfTynI=
=3yX7
-----END PGP SIGNATURE-----

--Jp4gq2voFtVFKZdE--
