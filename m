From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v2] mmc: add new au6601 driver
Date: Tue, 04 Nov 2014 11:37:57 +0100
Message-ID: <5458AC85.5050807@rempel-privat.de>
References: <CAPDyKFpZVKu-uHwNfXocVb7FbgEN3NxiLHCPR38bSh_zsA4w6Q@mail.gmail.com>	<1411801899-5236-1-git-send-email-linux@rempel-privat.de> <CAOyx1LpwJmWyrg07mc-UsDMZ=Mggs91SWq7e9GWb83H5k86Dwg@mail.gmail.com> <54420821.5000600@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gfDusIHPqEP19MOE4iVgQAfa4kiu2RfDH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:60264 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbaKDKiG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:38:06 -0500
In-Reply-To: <54420821.5000600@rempel-privat.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, ulf.hansson@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gfDusIHPqEP19MOE4iVgQAfa4kiu2RfDH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 18.10.2014 um 08:26 schrieb Oleksij Rempel:
> Am 17.10.2014 um 14:37 schrieb Venkatraman S:
>> On Sat, Sep 27, 2014 at 12:41 PM, Oleksij Rempel <linux@rempel-privat.=
de> wrote:
>>>
>>> This driver is based on documentation which was based on my RE-work a=
nd
>>> comparision with other MMC drivers.
>>> It works in legacy mode and can provide 20MB/s R/W spead for most mod=
ern
>>> SD cards, even if at least 40MB/s should be possible on this hardware=
=2E
>>> It was not possible provide description for all register. But some of=
 them
>>> are important to make this hardware work in some unknown way.
>>>
>>> Biggest part of RE-work was done by emulating AU6601 in QEMU.
>>>
>>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

Any updates here?

--=20
Regards,
Oleksij


--gfDusIHPqEP19MOE4iVgQAfa4kiu2RfDH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EAREIAAYFAlRYrIkACgkQHwImuRkmbWnp+AD/VPo+rCTA5RUTHatLeS8mgbXT
L/BKeT6k88xrFX5CeyMA/RIZV2YDa8liaekJ6/5XVPyj+Ci3WWKMmHgfUJ4EkcQC
=9l/M
-----END PGP SIGNATURE-----

--gfDusIHPqEP19MOE4iVgQAfa4kiu2RfDH--
