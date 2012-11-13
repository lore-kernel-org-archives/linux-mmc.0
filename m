From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] regulator: treat regulators with constant volatage as
 fixed
Date: Tue, 13 Nov 2012 18:42:57 +0900
Message-ID: <20121113094255.GW18224@opensource.wolfsonmicro.com>
References: <20121113090007.GS18224@opensource.wolfsonmicro.com>
 <1352799334-13898-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BlkQeOBdElZ1aiuH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352799334-13898-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org


--BlkQeOBdElZ1aiuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2012 at 10:35:34AM +0100, Marek Szyprowski wrote:

> +	if (rdev->constraints->valid_ops_mask & REGULATOR_CHANGE_VOLTAGE)
> +		return rdev->desc->n_voltages ? rdev->desc->n_voltages :
> +		       -EINVAL;

The idea here was to avoid the ternery operator completely.

--BlkQeOBdElZ1aiuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQohYYAAoJELSic+t+oim9eLEP/2eMb6/Enz2SZrG7HudK/bkS
Ck3p8cVqd46yIKY9MsmhTiGo6KkKIA+N/CVatKXDdJLIJIjA9iPkFdTczEsCQA1+
w2dO8TZV3OiWR6L0ncUzWOT8M3FNaQ7BKpndin1zmjjP6L7TW6BcwmTu5ZfMurzH
0DHpFw4VtJhFWlO+9LWFDmmy7k5ihAkruwoSQcQbAizoW8jSO6pz/HhMbNZ0Nij8
PWmtpozqe/orXzZ3mZubeq0jLiDudBFjLteBtwyNDV0TxXLGzqYZZoCTK8p39lNW
TjO+ecIAcGmhfh6y82lgeegpajwF9lLYAcs38DdLl8ldOP/7747IKLt443MBOlYa
0IsWqNnnW2Kqyr07R9bXJqjUENC72d+i1k3MKiJkVAHsSa2lOuRa1pmubIJOVM1N
3qvrGN6m5oSz2ErhukdsWH550yx6zsWmCppCDz4Wp2fu3HND1duDr1z1ZSxvzuFa
zWdw09aRDbhN8bf3uzNqLl766iGYSaO1HBnl5JU4OiC0OMyghxjkTw2SabVQWO8W
Kz8v5JIu1W3JsCyyW5fSdSs8a6VO1Uy4ccS1i9wX0c8cN1gwpGSEmTikovNiQSMV
ZTnWIxLhAMgsDIqH5MzMC50X7toHV43yVuHuyFeACr3gIwK1Ki96/HQWlZ+M0xwl
ji2qjNLjeCI54437IMEN
=Yxoe
-----END PGP SIGNATURE-----

--BlkQeOBdElZ1aiuH--
