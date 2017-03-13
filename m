From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: timeout waiting for hardware interrupt CMD19
Date: Mon, 13 Mar 2017 12:12:49 +0100
Message-ID: <20170313111249.cslock3xcupvxmu7@ninjato>
References: <CAMuHMdWHJvKv_Kva0LWL_hekGgkZdR=FHcOdoShpMtzQuXhD2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wradajgsrs53bgnt"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWHJvKv_Kva0LWL_hekGgkZdR=FHcOdoShpMtzQuXhD2g@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--wradajgsrs53bgnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
> +sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
> +sh_mobile_sdhi ee100000.sd: Tuning procedure failed
> +mmc1: tuning execution failed: -110
> +mmc1: error -110 whilst initialising SD card

Thanks! We have some tuning fixes in the queue. Let's see if they help
here...


--wradajgsrs53bgnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljGfqoACgkQFA3kzBSg
KbaEdg//dBIGFfcpzWcNQK6SGNnFoKm+k/V2ob3JJXR/eRDBhoebLxC9dU+WiDhN
G0+ZGRNEjbI+puKlymnXCNHuj9KZSyGabIgXHn44TqQ3oAAjkMZrl2t9DtZ/pGM3
9StEupEgvKp63HMJnl0XAg9GW7jbXeCnSisSzXckoC9vZtJOkla9WyB6omJth95Z
WFLhF31OrHzg2rGsxiTpxx6qYfhsyobmFgQ5FO3o+viBhblxMz8iVqrAmjGwOqY6
itVyxITEU6AdAWZamO+KCNbLymX1sArYVzZgzgqYEL/o/azR2s+y77V7K4fWInk4
Vx3Ldv7SGFbwHRM0fkZ1G8BSbyV76a3x2t19j0AlEIItTWl8+r9C6/ppan9Z5XHo
V31fQzqntlXvWPLQNuCJVBjZQwrlJt1LZucoshgsfgUR8oBxbQraey1GxQeOQ8S0
04KNls2noZb1m/S+mdCJgPWSlxBD9+i1fqeSgCbrdTACfCyz+y7OcfmCIL2uoje9
zHCTUWZ76lyAMpwDTfUEmLanQ9IEsOHwUm8kBuOuUjXMgn1MebtEE8MNhbiW7/Vo
r2xYGuxjWAyz7Iz2SAkn953AsUK1iuKG/9OSDkmD5VH1bairPpF4XA91yai4ZXnC
VZBFfY7fZAzF0sMwGf7bJaTGTQdnT77Pz55S0ENZCQMKoEcIMv0=
=NmCz
-----END PGP SIGNATURE-----

--wradajgsrs53bgnt--
