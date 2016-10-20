From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Fri, 21 Oct 2016 01:12:46 +0200
Message-ID: <20161020231245.GB2199@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161020132852.GB4177@katana>
 <SG2PR06MB11652EB5B1A40583636F8FB28AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60888 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757846AbcJTXMx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Oct 2016 19:12:53 -0400
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11652EB5B1A40583636F8FB28AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> However, for version 3.0 that will be posted shortly, it will start to in=
clude the SDHI section.

Nice. Could you ping me when this comes out?

> > * Does it have a version register (CTL_VERSION)? If so, what does it
> >   say?
>=20
> 0x820B

Okay, this is a version I have not seen before.

> > * Does it have SD_BUF0 width setting (named either EXT_ACC or HOST_MODE,
> >   so far always comes after the version register)? If so, what is its
> >   layout?
>=20
> There is a "EXT_SWAP" register. It is the only thing after VERSION.
>    VERSION =3D 0xE804E0E2
>   EXT_SWAP =3D 0xE804E0F0

This SWAP register exists on R-Car as well. Out of curiosity, what is the
register value of 0xE804E0E4?


--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYCU9tAAoJEBQN5MwUoCm20k8P/023NSqqQ5DFGeyXfO66XixY
/G4XdfqDpGiqRbWmSWdTGg3+ddOwDvssOP2EFlHDbDUfl5bwNiBsKlbHqyvQSJ30
1ojNIDKk/k7tLN7YdtcTr6V1CqBBhKGiNHi7N3HUJfJYAkXfs6iCmLGh8z/mCKyF
dM+089oW/0knzcvz/jwoleS1PXmI5i+qRECVKyo/6LKJmgzxlT/cMs5/IzPqpxvh
k7TeW46JvI3Q3OrxR/S6hUs90n+6/C3bMvNiKWQCQ2AP188gACrEuTxhtlvVpqsh
TO0nOFOz9h5HIVvPi2+zWo0RyEz+aZbbF1mmkAOCfjawsPvAW3ImKAP8jzooaw4C
IyIhwBFHlH1YDoOqWtHqTSBGbKVjX9SzzyREMhJb4BqEKaeLnW9AEFY7Q0XexF0L
F3MCg5MqHIHVvatNwx6kkXWJlLdotLajZb6C2ExggDVD+x4GSqcjHLTx8+4ucCUP
go0AChM9dsldMSfu4gKZdb5Xf1tmeOujlwrRB8TC5flsVBKhRKV2qBY56FiaicJI
6/D9+cmzZQXik/LIWUBaLpjTexKgM4+cdgF5UKmFqGllIRB/BoACR6DRrS/ny/j0
/wnaQOzMrCBkVkVmPraI9kmWTHQleJhwE5bz8WSZ8f1wFW+uGTOnXmtYxy2FcVAm
RObc8Ofb32RautAlRWqj
=bZkT
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
