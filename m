From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 6/7] mmc: sunxi: Add runtime_pm support
Date: Fri, 15 Jun 2018 17:12:26 +0200
Message-ID: <20180615151226.6752hykfyr367qho@flea>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
 <4514368de4ef7b4224be455f2d9e6090b464e819.1523888566.git-series.maxime.ripard@bootlin.com>
 <1caa07d2-17ad-18aa-9216-037c06b36281@arm.com>
 <CAPDyKFqc-+cr64DW0r_2V_vM=r45CuFrx5z4_fYf=sebb5EfQg@mail.gmail.com>
 <CAOi56cX4B=meWmRJz=qvmpxooiWQ+fADRZ4pSd=iimTiWUdRAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4287247518559769516=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOi56cX4B=meWmRJz=qvmpxooiWQ+fADRZ4pSd=iimTiWUdRAw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Quentin Schulz <quentin.schulz@bootlin.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chen-Yu Tsai =?utf-8?B?KOiUoemOruWuhyk=?= <wens@csie.org>, thomas.petazzoni@bootlin.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--===============4287247518559769516==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wljb62syexo3ejsw"
Content-Disposition: inline


--wljb62syexo3ejsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 07:45:03AM -0700, Kevin Hilman wrote:
> > >
> > > With a working kernel, I see SATA and the wifi SDIO being probed.
> > >
> > > Happy to help testing stuff if you have any idea.
> >
> > In principle I would start with avoiding having the sunxi-mmc driver
> > to probe. Or bail out early in probe, whichever is the easiest for
> > you.
> >
> > The point is, if the sunxi-mmc driver doesn't even enable its clock,
> > it would be interesting to see if there are other that depends on it.
> >
> > One could also play with clk_disable_unused(), the
> > late_initcall_sync(), which can be turned off with the module
> > parameter "clk_ignore_unused".
>=20
> I added clk_ignore_unused to the kernel command-line, and that didn't
> help, so it's not just an init-time clock that's causing the problem.
>=20
> > Anyway, to hide/fix the problem for now, we could add a call to
> > pm_runtime_get_noresume() before the sunxi-driver calls
> > pm_runtime_enable().
>=20
> I tried that and it makes the kernel finish booting, so that smells
> definitely like the MMC is disabling a clock when it goes idle that
> some other device (or CPU) depends on.

I quickly looked at the A10 and A20 clock driver and I have not seen
any obvious mishap.

If you have ftrace enabled, could you add the trace_clk_disable*
events (along with tp_printk since the kernel seems to break the
entire boot).

That will allow us to see which clock is disabled and shouldn't.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wljb62syexo3ejsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsj11kACgkQ0rTAlCFN
r3R+8w/+NXxYUozVSA+S3MJriZ6CJ5AQCzhmYFPB4SuvpAfW1tx03H1z9wqEqTiX
k4ZAMHglt5NZp6LhihZkk+Vj20geYQBIrUgXSCRX3Uyvl0v2PE1+wMQE5oiR4gzn
8/6oe7yXsaSYI9QSlQoYJXzIubw13IO+QzfLnEmv+TygraFwCN7lWfUKlLKLGdgG
Jc1X5JZCizV/ie0b6kD4865KhAeXDOkwv2vZ24ghAPTUpiKnkG1ZOiFhHc79o9zK
xQxtAt3YITk4DdGExpOZxcF+VXSR16RBL0DNBJpTtVTrBSFoUMUeNWmHuZcuPiYd
Gr/apf0DZKXTslSmPKiXNrcTjHP9nzfzJ8WvbR+HajNGOZVjQSY+uBebmCwogaGi
9Do9MWEkEGt0EUjRsGzbwS3yfnVI0GsvJ5M+dcUBXPXba2jER6bB09ftEMdkWAfq
8Culm0EMV56GwcEvvjMBY1SUQSaPjBtcT4NlLAt0IifBJg+w71O+GX1sc/GduBQj
rNUol1RIaX88jIxFdybXd8KeyoI9o+yWTlcEQwL/tZSI1zLngK/JwbakEnyeUuUr
phiVSA+E247cBOm7R1nOhy6CpFwxmTcD+fjICO5PGfGr6A2Xfqji4J8eqcoUKjwk
F6HoIhto/ss+H5EfZJhk9kEUdOaB+yUAZEYJTBjfRdKKtNgNtFE=
=h+xy
-----END PGP SIGNATURE-----

--wljb62syexo3ejsw--


--===============4287247518559769516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4287247518559769516==--
