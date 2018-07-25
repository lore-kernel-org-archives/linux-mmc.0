From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: tmio: remove unneeded variable in
 tmio_mmc_start_command()
Date: Wed, 25 Jul 2018 12:18:11 +0200
Message-ID: <20180725101811.6yk2zwszxnglwbcx@ninjato>
References: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nytesogl7eas6chi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--nytesogl7eas6chi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 05:46:14PM +0900, Masahiro Yamada wrote:
> Pass TMIO_MASK_CMD to tmio_mmc_enable_mmc_irqs() directly,
> and remove the variable, irq_mask.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nytesogl7eas6chi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltYTl8ACgkQFA3kzBSg
KbZXIA/+PT9xcJ/J1LK8EN5l3KaMInvK0UpkRkGfevWGmdDxE5SK/OmQZu276ZmQ
3hqZpbc6t5x0x7q5Knvk4c1RJGORvR9Mb34mJ+CeoL/dKbZNxNb/+H7WEe/bWe58
pkdMy7BGQSZ2N8nUPXvDKMFkGFIkQdztiQnGHO7H+DP7RyR8IYbjLtQaEKHUqX+/
5JB5G8souuInfPot8z/B2JVm0gRz9CXBhVxpPHK6XGgF2soeVWLTZvoucamunFbR
TA40iBe4A4PoOM+14hXyO1c1Ge4ZF3M7vmbIBpCOiWV24TEJKCacvkdkwnys3Rzn
Zj0KUEsRzRQ8hJE/fzYPWFnYO4zAvGXBY+vTxa4pyDg1+NfjAwpz5iehKlOug2sK
x+a1DN0s2cW0m4qEVy7PNok9QsjtA3YjTMzmqyDQ8IYjXHA2GtvPq35XLDs71/fc
bLvHsnKxvJ6CVKI6x3AnfmjL8WBjuGMXO0HVSjMra93YuzSItWUis4rHc73wefB6
dUOVXkhKclnum8k2XQRsg1CuMwLmZ0zw4T8so+Xrw4y0Xg5v5CmYwCyTNS8yB6gc
ATgQT0lO7GUlS6rTOppFHcgc2a41ah7nGZbmp9QaocGtspb3Llh1PS35pB9qR/Ip
U7t4UskTSjwgoEyztgTOZMfUjn2kNFzpEPF3qxwtGjcd+MFK+BA=
=sRwi
-----END PGP SIGNATURE-----

--nytesogl7eas6chi--
