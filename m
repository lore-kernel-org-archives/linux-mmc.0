From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [MXS MMC 4/5] Check the return codes of clk_enable() and
 mxs_reset_block()
Date: Tue, 6 Dec 2011 20:12:03 +0100
Message-ID: <20111206191203.GE7835@pengutronix.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5774364288467657337=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============5774364288467657337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2011 at 02:41:29PM +0100, Lothar Wa=DFmann wrote:
> Add an int return value to mxs_mmc_reset(), so that the return code of
> mxs_reset_block() can be promoted to the caller.
> Also check the return code of clk_enable() in the probe function.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> -	clk_enable(host->clk);
> +	ret =3D clk_enable(host->clk);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc),
> +			"%s: failed to enable clock: %d\n", __func__, ret);
> +		goto out_clk_put;
> +	}
> =20
> -	mxs_mmc_reset(host);
> +	ret =3D mxs_mmc_reset(host);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc),
> +			"%s: failed to reset controller: %d\n", __func__, ret);
> +		goto out_clk_put;
> +	}

Why __func__ here? dev_err and the msg itself should be indication enough?

Otherwise

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7eaQMACgkQD27XaX1/VRsmVQCgo5C27YH0V2JpiZdVCoLmhRk8
R0sAoKv1OoiKTNL/O5v9j3Pgi3rxLL/B
=3SQY
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--


--===============5774364288467657337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5774364288467657337==--
