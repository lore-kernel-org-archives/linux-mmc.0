From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock
 is disabled
Date: Sun, 10 Feb 2019 22:32:21 +0100
Message-ID: <20190210213221.GC2061@latitude>
References: <20190207225211.GA17552@latitude>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7184002623262560004=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190207225211.GA17552@latitude>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Michael Turquette <mturquette@baylibre.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============7184002623262560004==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 11:52:11PM +0100, Jonathan Neusch=C3=A4fer wrote:
> However, as soon as the mmc driver (sdhci-esdhc-imx.c) disables clk_per
> in sdhci_esdhc_runtime_suspend[2], the whole system locks up in some way.

I've traced clk prepare/unprepare/enable/disable calls and got this
right before it hangs:

[    1.280981] sdhci_esdhc_runtime_suspend: unprepare clk_per
[    1.283356] clk_core_unprepare esdhc1_per_gate
[    1.285191] clk_core_unprepare esdhc_a_podf
[    1.286881] clk_core_unprepare esdhc_a_pred
[    1.288568] clk_core_unprepare esdhc_a_sel
[    1.290220] clk_core_unprepare pll2_sw

I suspect that there is a dependency on pll2_sw that is not represented
in the imx5 clock driver. I'm comparing it to the Reference Manual now.


Thanks,
Jonathan Neusch=C3=A4fer

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxgmF0ACgkQCDBEmo7z
X9sINBAApuuzxXq9D6VZLxr0ABlrqGVUN9QMdqizhS4PcNi97B4Ax5J1dDGCXaJN
U1J1GwA9WQgC3/khCiP04XAc1qp6/2KkobDFl/IjBNPZRcBS/qeBemePKhAWH9Jh
ICqYCbKZCkxpcLD8zFpY4XtzC16fdk5CTeXEJLjb83JcWY+p8KBkLGCl0SQyJuJ5
pHS79Cgw1RhGYS4zF3a8AO8o4Llccl1PdshUlXNOZ4rFS3Ep68A03cBoWI+PWuhU
auF0HmYufLhajjeaDFaMv9uzBSM5vylxIsEtKJzxLChgOP5sAwIMGFxyo1sDAab5
A6GovivJ/jtQpK/mVSoHqazyt1226c0LXV2Sg6erImmCUkAzcHPAzRPeRJqqCt0Y
IUaLY7jWPQSUMmh+XjMuGUuDuJbuTetb/1TJBK94aAzndMn12fojEDRtOgtvpW3d
KaZKj2tk/250uC6q+GvQClF7iZEadl7bmu/QQfEpfMU61qH7IOmw7wrGFueQLelu
HDX+GRpoe0qsYdYtFOmsYYj5ocyLRgF/F8ycEyK9Ea+WOr76JS2+ycDkSit8uxcl
JiAHh3xMGQz7Mt0sTMdChfg5ee6ruxanfB/SzSeurpBmg4fmdCJmt7JYZbwC3NBI
CfjjX/RM10JpwYk4YVxxekG/ZOP+jO9JDIgHWZTIFkHt6oat234=
=Ejgh
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--


--===============7184002623262560004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7184002623262560004==--
