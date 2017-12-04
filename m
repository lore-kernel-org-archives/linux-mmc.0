From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 10/22] mmc: tmio: support IP-builtin card detection
 logic
Date: Mon, 4 Dec 2017 16:13:21 +0100
Message-ID: <20171204151320.4ypa2y5r335hcg7j@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-11-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dxnfmsw3nw7oplap"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-11-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--dxnfmsw3nw7oplap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +static int tmio_mmc_get_cd(struct mmc_host *mmc)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +	int ret;
> +
> +	ret = mmc_gpio_get_cd(mmc);
> +	if (ret >= 0)
> +		return ret;
> +
> +	return !!(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
> +							TMIO_STAT_SIGSTATE);
> +}

I wonder if we shouldn't do something like:

	if (mmc_can_gpio_cd())
		return mmc_gpio_get_cd()
	else
		return !!(sd_ctrl_read16_and_16_as_32...)

If we have a GPIO CD defined, I think we want the value of
mmc_gpio_get_cd() in all cases. It makes clearer that this is an
'either-or' case and not a fallback mechanism.


--dxnfmsw3nw7oplap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlolZgwACgkQFA3kzBSg
KbZ7HA/9HySQY4HYCrUYbbOVC54LDCPJ8qOOAOF7UP+P26LRujbvc8LX136dZCbP
qu9U3jdQCl88yt6f1VTLvTcx6MtJLNaluhFEy0YCwFetnaYeYx1E+NA7n7feOKep
dcV2Pwigz4eap13Qoce03wwqBCPKoHV/HEBSSRP55C2eQyTOBRJTYKsaEYDReCgV
vDrpC/+SPFkoLoYbVoKepqPxKjXFy17jwYKroGSG4D/ROFj3gWV58S34TsGcGcFZ
+LovrHYlYnaz3JxdE1M1JZ+q83b/yIQMfdu2uWdu0LBA9kuLXVCmyrd1xTyvtqyv
vaIICxUGs5UVmdFopvIJcAvGLE38NBEW45E29O+QE3DXdHDc+EUmn4kYAnr0B7bQ
rEAg0GtB2VaawtLrp1TvBEE6CgHPh42RO+PeD3e3jnkVuOkuktxeIfiL83QV6upv
B+bu7wLK+9DH99UYJvufJi1K9B4h71lxj/3D9ggTTr/7HqfGn3tfdm14mgp5vgUB
6Saa/y1abSaJfWnHt001ef6yAj2vrcgHLmWKB0qQPaZQj2YdMPoEKkXTk6/Qg66X
pumE8Dqd/ikkjnOxEaQQjvaZjAGNe3Dsz0lYQll9NExZH6CFyM4bqay5oI//o4Q6
iTI/MIk2skeoEvW7TkznLNQviMPjC3dcVeAc3j0T8yNu0KkVVNU=
=8lQp
-----END PGP SIGNATURE-----

--dxnfmsw3nw7oplap--
