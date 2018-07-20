From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 0/7] mmc: sunxi: Add runtime PM support
Date: Fri, 20 Jul 2018 16:51:43 +0200
Message-ID: <20180720145143.qgvlk2gbegxwwcfs@flea>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
 <20180716171428.ud3zsmeccds545si@core>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6941415843493561596=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716171428.ud3zsmeccds545si@core>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, ulf.hansson@linaro.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mmc@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============6941415843493561596==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="idkpt7dudc67luip"
Content-Disposition: inline


--idkpt7dudc67luip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ondrej,

On Mon, Jul 16, 2018 at 07:14:28PM +0200, Ond=C5=99ej Jirman wrote:
> On Mon, Apr 16, 2018 at 04:22:58PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > Since it's introduction, our MMC controller has had its external clocks
> > running all the time.
> >=20
> > While that was working great, the power usage and most importantly the =
EMI
> > that it generated was pretty bad.
> >=20
> > Let's implement some runtime_pm hooks with an autosuspend to shut down =
the
> > whole block when the MMC is not active.
> >=20
> > However, some SDIO devices will not probe properly if we keep shutting =
down
> > the controller, so the autosuspend is disabled for the SDIO devices.
>=20
> I've tested your patches on TBS A711 tablet (A83T). I get this in the log:
>=20
>   sunxi-mmc 1c10000.mmc: fatal err update clk timeout
>=20
> Interestingly, this only happens after the first boot. If I hard power cy=
cle the
> tablet (removing/reinserting the battery) the first boot after that, ther=
e's no
> timeout, and WiFi chip connected to the mmc controller works.
>=20
> Any other reboot (even power cycling via PMIC), it fails with the above e=
rror.
> Maybe there's some unforeseen interaction of runtime PM with mmc-powerseq=
 used
> for the wifi chip power seuencing? Do you know what's the above error abo=
ut?
> I don't know anything about mmc subsystem.

It's kind of weird. Do you have an oscilloscope available to look at
the clock signal (and the reset gpio) and see if there's any
difference of behaviour?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--idkpt7dudc67luip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltR9v4ACgkQ0rTAlCFN
r3SWPxAAlfmt5AJFbYpvD6Ey/oCUarn1FrcLBJnWlhc9EZKRaex9rcvXisug0+3V
ZG25OfCfZtoAirIf6eFuLUe67NnkenL/JdSSMdK3LKX7e2D4om122F/AfY/eOKyL
t/t4WrSBNj4rk33yXcXWWofuDSYLLkj/gZcWS9crX/2lFTdBjQrZL+a9sRkQ1kC2
J6JP/ytqZK6PHuSCd/Bzrio+qKmsZHgAIA7HQVXI44DQ6cQ446urh0V/Sg3qf3Qa
AfSJbfOVC/XpqXVBFtE4E1urQvQVepIN0nAHV5fCYsJZgOwk/56vTCrGFqscVlC+
MTP953vO0/4hHoguAqB5FW4h2erxE9Xo5Fb/wlkggzzUc8dJjKyU51bWJN5FPGXG
f5q8/70w57E1s7dD/lTdMzPnnc6efzetKvqoYZfgSToni5RHP1Ih0ewsSt9sdObb
kn8dzYvQL/9+zIG7SHx5E0Y8WRF2Uu9SJheUPHsnovmz3D2EoCKq3iHdtBWk/s8A
DyBi6IqP/cnuyZ4BfZzVwn1X1RRuKPtadhUW0IdBiwQZsGsDz3QGgIykzoLPBT+Y
YT6Pxf7tj7GA9bMpvcHImFStyCs6oYwxMZi8e8mKx6/UYFWZgkB0jTvkekRTS7an
POz7SZF4rPeXUCfoGROnkAqmFxHuMb3cPHS9YaUhrMdwAzgZE7o=
=M8v7
-----END PGP SIGNATURE-----

--idkpt7dudc67luip--


--===============6941415843493561596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6941415843493561596==--
