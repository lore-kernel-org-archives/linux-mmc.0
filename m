From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock
 is disabled
Date: Sat, 9 Feb 2019 17:24:49 +0100
Message-ID: <20190209162449.GB2061@latitude>
References: <20190207225211.GA17552@latitude>
 <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2217695590600289084=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Michael Turquette <mturquette@baylibre.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--===============2217695590600289084==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 10:50:28PM -0200, Fabio Estevam wrote:
> On Thu, Feb 7, 2019 at 8:52 PM Jonathan Neusch=C3=A4fer
[...]
> > I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
> > unfortunately, the i.MX50 reference manual doesn't have the table called
> > "Output clocks from CCM".
>=20
> Please check Table 5-10. CCM_CCGR3 Gated Clock Mapping to Target
> Module from the MX50 Referene Manual.

Ok, the tables show:

For i.MX50:
[1:0] 0 ipg_clk_root    eSDHCv2_1
[3:2] 1 esdhc1_clk_root eSDHCv2_1

For i.MX53:
1=E2=80=930 CG0 esdhc1_ipg_hclk: affects ipg_clk and hclk inputs of ESDEHC-=
1 (esdhc1_clk_enable)
3=E2=80=932 CG1 esdhc1_perclk:   affects ipg_clk_perclk   input  of ESDEHC-=
1 (esdhc1_serial_clk_enable)

Table 18-3 (Output clocks from CCM) in the iMX53RM shows that
ESDHCv2-1's ipg_clk_perclk is esdhc1_clk_root, so the clock structure
does seem to be the same here, between i.MX50 and i.MX53=E2=80=A6

(The reason why I looked at i.MX53 is that there are several i.MX53
boards in tree, so it appears to be well tested under mainline Linux)


> Does the change below help?
>=20
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -102,7 +102,7 @@
>                                         reg =3D <0x50004000 0x4000>;
>                                         interrupts =3D <1>;
>                                         clocks =3D <&clks IMX5_CLK_ESDHC1=
_IPG_GATE>,
> -                                                <&clks IMX5_CLK_DUMMY>,
> +                                                <&clks IMX5_CLK_ESDHC1_I=
PG_GATE>,
>                                                  <&clks IMX5_CLK_ESDHC1_P=
ER_GATE>;
>                                         clock-names =3D "ipg", "ahb", "pe=
r";

Unfortunately, this doesn't help.


Thanks,
Jonathan Neusch=C3=A4fer

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxe/skACgkQCDBEmo7z
X9u2ohAAvLuVCy5ZxTQDN0CXlBDu1D7PpvjueQHOOrySP3dRUCnU+ClFXGmp7PSH
ijXwP///CybSSTos9kfOKMqkyMauddznp13b+Gn0G0dankm8eAptjAoMV2puW6HY
XbF3T+2ISbUWZDZCzaJxw29VsKjxLDcP6x1DDTIeNqVMwta9Bi3tIUIhwRDvxrAw
UFsHmM2kyLqiAbjtMTHXKMtcK/QydZ1fZnv/tHZTZeeomAowNc5vxgnjINETb/PD
mVRr9ZALblq+Z4vgLwIIAomcQyEU+kdJv3ebpR1q4J0oxkIceWl12+W9k1EUlLEN
T4BUdxHEQ2kplvYFw1eoTLYK0P+HNoAdLlPUpzBxWo/Srxc8hnS61vs5IGIGzFAm
qt1ZbVm95N5j6tgzmVefCClYdl389ReYyfKl6R0g/YKYhh9nSZvPfEFY5vWZB0pq
msPMq95W7ivkMM43hydHqT2IHdl+CGeAcP8ldEBFoQUX8FHmbYnepHbL0ZgvgLTN
dtFhHj6xvzfa8CxFMX8QUYen1bSYWc+/9Nxfrq8S9BZJs9mw7yHqKrdu1YYssKok
f414MXSOjUIKV0Wjqhyn+CsAp/vD7/efrwl7+aayIfCjVGP+NYvgJ0a4vxvM0J5o
dRLQL/r5Wn4l+IE73KjjNb+BtsKBnn2KvSOLdMT1lX4KNDp7Ti8=
=hKLs
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--


--===============2217695590600289084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2217695590600289084==--
