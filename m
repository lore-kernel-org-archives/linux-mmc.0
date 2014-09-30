From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] mmc: add new au6601 driver
Date: Tue, 30 Sep 2014 12:11:56 +0200
Message-ID: <542A81EC.40708@rempel-privat.de>
References: <1399543099-31613-1-git-send-email-linux@rempel-privat.de>	<CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>	<53B3D562.1030707@rempel-privat.de> <CAPDyKFpZVKu-uHwNfXocVb7FbgEN3NxiLHCPR38bSh_zsA4w6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AQaeXravrp0IuFGIsKkOTf80JWg4Gbvtm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:63107 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaI3KML (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Sep 2014 06:12:11 -0400
In-Reply-To: <CAPDyKFpZVKu-uHwNfXocVb7FbgEN3NxiLHCPR38bSh_zsA4w6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AQaeXravrp0IuFGIsKkOTf80JWg4Gbvtm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 09.07.2014 um 14:52 schrieb Ulf Hansson:
> [snip]
>=20
>>>
>>> I am just a bit curious, does this controller support hardware busy
>>> detection on DAT1 line while waiting for command completion?
>>
>> Do you mean AU6601_REG_BUS_STATUS?
>> See at the beginning of patch.
>=20
> While reviewing the code, it seems like the controller are handling
> hardware busy detection on DAT1. On the other hand you don't enable
> MMC_CAP_WAIT_WHILE_BUSY, shouldn't you be doing that?

Hi Ulf,

what is better way to use sg with dma? This controller support only
0x4000 alight addresses. It is possible to solve it per driver basis,
but i have seen already more then one driver which need it. Should it be
done in  mmc block code? Any other suggestions?

Thank you,
--=20
Regards,
Oleksij


--AQaeXravrp0IuFGIsKkOTf80JWg4Gbvtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EAREIAAYFAlQqgfAACgkQHwImuRkmbWmqbQD/U4MDj3O34BuPDNppz4kxiPJm
W9DCDWtIj++cYFkey6UA/i8lv2QOpG0/SUfqmPfjVrY7c3R1Vs0E+brRQPmbqLZ9
=vhFR
-----END PGP SIGNATURE-----

--AQaeXravrp0IuFGIsKkOTf80JWg4Gbvtm--
