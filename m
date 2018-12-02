From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v6 1/2] misc: cardreader: add new Alcor Micro Cardreader
 PCI driver
Date: Sun, 2 Dec 2018 11:44:06 +0100
Message-ID: <c61aab2e-67b1-2cab-253c-bc78b3ff384a@rempel-privat.de>
References: <20181202103046.29377-1-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181202103046.29377-1-linux@rempel-privat.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, peter.wein@gmx.de, drake@endlessm.com, chiu@endlessm.com, linux@endlessm.com, morling.huang@alcorlink.com, bob@alcormicro.com, jin.tsai@alcorlink.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr
Content-Type: multipart/mixed; boundary="b0CoB1SiiHs1gUzIX5qni7VQYS6dFUB3D";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, peter.wein@gmx.de,
 drake@endlessm.com, chiu@endlessm.com, linux@endlessm.com,
 morling.huang@alcorlink.com, bob@alcormicro.com, jin.tsai@alcorlink.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <c61aab2e-67b1-2cab-253c-bc78b3ff384a@rempel-privat.de>
Subject: Re: [PATCH v6 1/2] misc: cardreader: add new Alcor Micro Cardreader
 PCI driver
References: <20181202103046.29377-1-linux@rempel-privat.de>
In-Reply-To: <20181202103046.29377-1-linux@rempel-privat.de>

--b0CoB1SiiHs1gUzIX5qni7VQYS6dFUB3D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 02.12.18 um 11:30 schrieb Oleksij Rempel:
> This driver provides support for Alcor Micro AU6601 and AU6621
> card readers.
>=20
> This is single LUN HW and it is expected to work with following standar=
ds:
> - Support SDR104 / SDR50
> - MultiMedia Card (MMC)
> - Memory Stick (MS)
> - Memory Stick PRO (MS_Pro)
>=20
> Since it is a PCIe controller, it should work on any architecture
> supporting PCIe. For now, it was developed and tested only on x86_64.
>=20
> This driver is a result of RE work and was created without any
> documentation or real knowledge of HW internals.
>=20
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

Forgot to add a changelog for this patchset:
20181202 v6:
- split one patch to two patches: cardreader and mmc
- use SIMPLE_DEV_PM_OPS in mmc driver
- use ida_simple_get/remove
- move DRV_NAME_ALCOR_PCI to cardreader driver. Other defines are shared
between drivers.
- fix some typos
- rebase against 4.20-rc4 and test it.


--=20
Regards,
Oleksij


--b0CoB1SiiHs1gUzIX5qni7VQYS6dFUB3D--

--BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlwDt3YACgkQdQOiSHVI
77TowQf/XmHatoSDzOtQayi6Q8Opi2VhhQOeyxLNn0b/8mlI3Wq9QZpda61JR9ot
3FjGg0gHqgOPpoIPQhWFpiLnbw/nhhTAvY+EWlP84H3nuxjqHSU61rM6zxYvrBx3
pQXlDFwU8LvpLMWr5vEXfTOlAe+q1aaHZxzyWG7kKKDCFTgBQQ3lKSjQXAy8dLQC
tu0H5OY8KVunh4UkPUJDXi8v5diCYOqcqEwBPHRVPi9IG0733QGfU0V8FUeo42RH
gvCtKUpBu1kvsfnZqh1UM6Yapox5d8VBUWmvJT2ulQqQ9an/QgeljMgIFFXyc9wo
6CsVAwOEFqRVEYK1D/s1Muw1ApUgww==
=VK1e
-----END PGP SIGNATURE-----

--BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr--
