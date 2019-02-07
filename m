From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is
 disabled
Date: Thu, 7 Feb 2019 23:52:11 +0100
Message-ID: <20190207225211.GA17552@latitude>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0725896704381766306=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@intel.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============0725896704381766306==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently porting mainline Linux to an i.MX507-based board
(preliminary DT here[1]). Recently I've enabled esdhc1 in the
devicetree.

However, as soon as the mmc driver (sdhci-esdhc-imx.c) disables clk_per
in sdhci_esdhc_runtime_suspend[2], the whole system locks up in some way.
Booting with CONFIG_PM=3Dn "fixes" the problem; commenting out the
offending line in sdhci_esdhc_runtime_suspend lets the system survive,
but leaves the MMC controller in an unusable state (of course it's not a
proper solution anyway).

I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
unfortunately, the i.MX50 reference manual doesn't have the table called
"Output clocks from CCM".

Does anyone have any ideas or patches that I could try in order to
narrow the problem further down?


Thanks,
Jonathan Neusch=C3=A4fer

[1]: https://gist.github.com/neuschaefer/27cacf0acf5411219be9372d728d1163
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/mmc/host/sdhci-esdhc-imx.c?h=3Dv5.0-rc5#n1412

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxctpQACgkQCDBEmo7z
X9sCRhAAw9ITjTQEEXDivDeMdj/6i8kc+QsJ8gfnBBBykbRlr3Y9bgb1wLrJNKwv
+Ge6OSrQ3tlx3rSVrw2BQaLg6iCxjEuYdmklvOtJ/g58oNVGqi+ZHXz6g0I/2S87
K7TQY+OTbbEd5RU69wRwe5XUYc+sGGovHxDORRghMGfulVz5a9LpHbClqEnNF/GV
VeIkASq3D4xsRrMEoAHhqDWATLyBHxNvMp00BdXoAnswuxmVrNqFtkUOVF/D0F3I
Ex8iBvVuGPbM05zQUXEc7EcBPh+pYYZAhbtfwZxLDgnG+ua18gVJcD3JVvxI8Fys
4kK9Jf5yv45GPRwm0YmkA3edxqQBZEL+HyOCFnWVINzEd7+q4vS4PL7+zdPWuJnV
cxul84iPn0AuO8yFOrFdsG1K6ETU2l+jnc95kJcTV4Wh2R041ZO64RkZkaExznLm
alEL1eMHEZ9mQPdRmvXZsAIdE6OvBBOhsJnwnXShrGB5+CO6/QIl+clwaqTR5Prl
mns8K60gBXA1B2NS6p0QgjeD9DGhTUTANlMA3X3dw5KHxaxnk1Y/tr2JxvdqE6Yo
uliAwEFxFZUWFvUh6yi5oqunEY0bBUQmch5HPHWP2uXc4yuk4a05JjfhUjbczL2y
42kPZzU8rCBLkowsLewstnxgoXcHUTwBkIootFGocsJpjckvlXo=
=ajnv
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--


--===============0725896704381766306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0725896704381766306==--
