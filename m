From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] mmc: add new au6601 driver
Date: Thu, 03 Jul 2014 15:54:55 +0200
Message-ID: <53B560AF.1020609@rempel-privat.de>
References: <1399543099-31613-1-git-send-email-linux@rempel-privat.de> <CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jJw1lDFspdWUbeWjfAQN41d6PabXeixE2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:57349 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964836AbaGCNzF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Jul 2014 09:55:05 -0400
In-Reply-To: <CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jJw1lDFspdWUbeWjfAQN41d6PabXeixE2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

i would like to use advantages of sg buffer and make dma part of my
driver a bit simpler, for example make use of dma_map_sg, but this
controller accept only 4K alignet 32bit addresses. Are there any way to
force this alignment in mmc-code?

Am 16.06.2014 12:02, schrieb Ulf Hansson:
> Hi Oleksij,
>=20
> Sorry for a late reply.
>=20
> On 8 May 2014 11:58, Oleksij Rempel <linux@rempel-privat.de> wrote:
>> This driver is based on documentation which was based on my RE-work an=
d
>> comparision with other MMC drivers.
>> It works in legacy mode and can provide 20MB/s R/W spead for most mode=
rn
>> SD cards, even if at least 40MB/s should be possible on this hardware.=

>> It was not possible provide description for all register. But some of =
them
>> are important to make this hardware work in some unknown way.
>>
>> Biggest part of RE-work was done by emulating AU6601 in QEMU.
>>



--=20
Regards,
Oleksij


--jJw1lDFspdWUbeWjfAQN41d6PabXeixE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlO1YLIACgkQHwImuRkmbWlvYgD+LVjb7CI73teqnETPT9I9IDLR
31DHv7+z0+k22EZ5EtAA/0OuSAJ0dxWLeArcV1Ulp2eBg0LHE2Z+RwcmkbBYMuid
=J/qs
-----END PGP SIGNATURE-----

--jJw1lDFspdWUbeWjfAQN41d6PabXeixE2--
