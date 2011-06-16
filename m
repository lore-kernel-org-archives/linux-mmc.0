From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2] mmc: Enable the ADMA on esdhc imx driver
Date: Thu, 16 Jun 2011 14:00:09 +0200
Message-ID: <20110616120009.GA23579@pengutronix.de>
References: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
	<20110616115133.GC31375@pma.sysgo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0874262283=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110616115133.GC31375@pma.sysgo.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pma@sysgo.com>
Cc: avorontsov@ru.mvista.com, pba@sysgo.com, linux-mmc@vger.kernel.org, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>, kernel@pengutronix.de, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============0874262283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Unfortunately register differences are common. Is there better
> approach than patching it in low level functions like this?

I am all ears for suggestions...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk358EkACgkQD27XaX1/VRtQ0gCgiEoLzrt4oi5bXUXoHyuwM2Gk
j5sAn2NJQiHA4AI4slO2dZL7Ee06xOwr
=YMfy
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


--===============0874262283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0874262283==--
