From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH resend] mmc: sunxi: Use new timing mode for A64 eMMC
 controller
Date: Fri, 7 Sep 2018 10:15:06 +0200
Message-ID: <20180907081506.lj26hmbaisacefih@flea>
References: <20180906153304.22239-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7161781507083962342=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180906153304.22239-1-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============7161781507083962342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vrv2k7n7ccak4zpw"
Content-Disposition: inline


--vrv2k7n7ccak4zpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 11:33:04PM +0800, Chen-Yu Tsai wrote:
> The eMMC controller is also a new timing mode controller, but it doesn't
> have the timing mode switch. It does however have signal delay and
> calibration controls, typical of Allwinner MMC controllers that support
> the new timing mode.
>=20
> Enable the new timing mode setting for the A64 eMMC controller. This
> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
> chips that support it, and can deliver such throughput.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vrv2k7n7ccak4zpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSM4kACgkQ0rTAlCFN
r3Sr/Q//Vk8TcsbRlRT25Bbvrdm5h8gbNcbRNxQDBat02MwA91p2xzMWWdffJCeE
Bk6Bt4Z0KxpiuL27dQKONXbxwpbCJBmgPM6zkhHcpZLwSDz5H33LfNZu2/V4f7J8
38VmPSGjHaNoIq+2V4WtN1FWgTZqZdcmUUUOJ1Ey5Bl5tLks+44NeF1urLllbhrH
EsDAEzCmoxI4te1Gt5VFguzEz8gn5dc8Y0xou35kC4/6sQt17FIz9P9mGXYdUxW8
McnKkJhk1wxTIGLEZNrr/TZfUlhc31NdeOTSAXxRerVCBAvvF0OQb23cP6hOOshe
jAsre6yu2iMhCq1hDR3SAtKVFEBbcq9yX6aITmcrjAcheIlDT3lZ2IcogNcuZScP
+tKZYXFVA6I09uRBF+k6FaWgTq4ihSP8OToAbQz7mozYRVAm+HiH44woIeHLR3e+
fqe4RInonm++zrkOyFqCYkFDV5pHXTaSPTLb+v5X4pV6vcNoWL6Ybv+7nMtTQDiy
ZZVVAOfOOpZGQuz9hdg9bE3Tu2MGHgZONnMcj6fRgayhfV95wdDTL2FKqKhHq2Lm
WJXY1gTucTM/cUttIktmoxTEZpuRoGNzlsksZtSUNONtmYWRtdomqJzNt8F4xjsO
JVY+NMZwTr9rS6MzfdFrOcgIfyvghoxuEvCNv/USv9H+DfZWcNY=
=1jAB
-----END PGP SIGNATURE-----

--vrv2k7n7ccak4zpw--


--===============7161781507083962342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7161781507083962342==--
