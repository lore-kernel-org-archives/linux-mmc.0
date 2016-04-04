From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 7/9] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Mon, 4 Apr 2016 17:17:09 +0200
Message-ID: <20160404151708.GF2983@katana>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-8-git-send-email-wsa@the-dreams.de>
 <CAPDyKFq2HZFw8ZFH0LzYGRBidcKFsmz2D4LrHsm8DviU+ZkGGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFq2HZFw8ZFH0LzYGRBidcKFsmz2D4LrHsm8DviU+ZkGGQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +       usleep_range(5000, 5500);
>=20
> Why do you need this delay/sleep?

My datasheet says to wait at least 5ms before re-enabling the clock
after a voltage switch...

Ah, found it in the core. It is doing it for 10ms. Maybe my search
pattern was not fuzzy enough ;)

Okay, so this delay can go.


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAoV0AAoJEBQN5MwUoCm2r2kQAKzJMIkQHOaQVl+RoGoZjy4z
cpc/7ldY5WuOMd4U/Q0CV1XVMuxGbWzjVoVmGes6JK9PzTVLoR1jUh+WO0fZHqlL
ETPo80ZI1VQM4ozw4PjXdNA1z1CD1ZUDzzvNw/XByqNXpsUdd52wVzXpf5bSi6Z4
YE1Lw0bqx+ctRGPoOQRgsyBK+dleBhTPQE2aj657REtXZfarAKabkWUW176XmefQ
uBIG9cSbQD1DHlT1eDbtXcnMYm5uFuY+C64jfzF5QT07UZv6AZrutLfjT40Bxr6Q
nWJuQp+836QuPyJ3kz9E83UQayMXpCfJz+Ox1HF59gaJY94H/e1YzkPIJCz4tqGK
2zi6o3DsoT8JyV02yEOWEHA76uZJqwbHyi7CfIc9Y/+wSZ4bN/LUH08RTAMKcfij
f2H9j/Hr9KDdIWsiGA+/RHabVVyUK40eMS+nmG4cF66WPbY5T+IFJRYCymxSO1PQ
MJJKeiKGSfmhCBbL5VRwCbcxpNmfGjeqiit8063eOAxobZ4UZzdLv7i0UEKvG/CL
RRvq5Thp65HGpc3AMBLFMOP3kTR4tR4bQP68IUpM37eXC0ts1vqNieJzQJkMOqqe
OuWCSQ7DKXo7A2lytNpNUxY+HBFSdND/Qyk3HFJGZGdKqp6EzJX9IvbiMR75AyRb
WC4Ig9r4y3jnv9kQHa9T
=6Q8a
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
