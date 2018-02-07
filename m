From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/3] mmc: renesas_sdhi: add eMMC HS400 mode support
Date: Wed, 7 Feb 2018 23:21:44 +0100
Message-ID: <20180207222143.mscy7c2gi63jbvtc@ninjato>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-4-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jvudi3d5udb3ngnt"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119133906.11280-4-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--jvudi3d5udb3ngnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	/* Reset HS400 mode */
> +	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
> +			sd_ctrl_read16(host, CTL_SDIF_MODE));
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
> +		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
> +			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
> +			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
> +

This looks like code duplication. Can't we simply call
renesas_sdhi_reset_hs400_mode()?


--jvudi3d5udb3ngnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7e/cACgkQFA3kzBSg
KbYRBg/+JS8KGYFF7Cebg12JTzQK4Dy1fdRk3K/ctSSqe6fekD77dXOPmiPfzOjy
Rq9JbLe5zYcUXhT8LN7qNGAbYQf5EAA+K/uaBdj2hDx5s0nTFUnksS9yT/9qeQSo
1Gvlr0soQDZHhFrMTGH71vmUqOH2OBY5UTlSpGcxZ0skDgvJElKTLfseTv9LEZIW
MbeJPrCNuO80PolQycQnmnzu97igAyWlxILfw0XDhFONifcTJ/hiJKHvRCFHm35R
meQWrkhZYNlvTnnRa6rBX9fA4GlewuvvXhQOxGrgtclDulCxVWTrCfXBVJSZt+ec
k/goFUt3Sjtk96TLDbaRuwH22IMqiMhXibrSHCyxA8ahc3oaJ6dZ6OH5QcocomWI
KkvXSab5n+HIkekY4oiyWtHHr0nSkCHC9Wpvgp1EJ74C3JPIbGBKMRTQlgr7nC8x
goxHCaHtln423k3tGQc8aTnRjah8NlUG5b5AHb4rFyFOhANUnuDLGDglxPZ2OqIq
MhT+dbytVw+r2mboocRx4Of4fb3HgBMiaqXLE20wehuky3Bu/J5NaLj/nL6x1e0N
ZwHGmlotI79x2eRGFCvgAybRPIKwx4i8D1KLY+YtJF7zYIlr0qHewh4d4ZYlWZq0
155i6XAXQEkddo4E41G+fbzKkx4yuIHaVblpeMWxUFRhPCgBFn4=
=btYf
-----END PGP SIGNATURE-----

--jvudi3d5udb3ngnt--
