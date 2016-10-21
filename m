From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Fri, 21 Oct 2016 23:56:39 +0200
Message-ID: <20161021215639.GB1450@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161020132852.GB4177@katana>
 <SG2PR06MB11652EB5B1A40583636F8FB28AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20161020231245.GB2199@katana>
 <SG2PR06MB1165F5878C8417068E7364628AD40@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165F5878C8417068E7364628AD40@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> For the VERSION register, the low byte is the version of the IP, but
> the upper byte is a number that the design group that made the part

I know. It is just that I haven't seen this one "in the wild" so far.

> > This SWAP register exists on R-Car as well. Out of curiosity, what is t=
he
> > register value of 0xE804E0E4?
>=20
> 0xE804E0E4 =3D 0x0001
>=20
> So...something is there!

I am quite convinced there is this BUSWIDTH register. If you are
interested, try setting this to 0 and see if it works without the 32 bit
register patches.


--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYCo8WAAoJEBQN5MwUoCm2wKoP/ip8Ye4fbRIFOaUChGtwUFMU
KVWtAg2Y9U27YNtuZnVTutSZXnspaleWVYAp+YsDb/yEL+aXqIHB5bdiR4ALcxUI
cmHJcOP24APF4NgL8YpcAm6OKUmzvBJDInNki7YOpGXXrvQ4IWV/EnnpG4FFE3RM
d76ORctFW1bwHiAnhBJ4St4pq0GYOTJN9LTKy7XB2RjRZiej2MzIipmduDyF+zqJ
/BZpvTrX+Ekq3f3RoH50QIXBp0B2FiLE6jUPgDXy+LnbgnjaJqJ/1C66Gf+PNQKS
tWumbUWGvhwKRNOZzg8mu1znu0b7KTi03TwLvp6W1gfos1yxZ70ecxHBaRiBwOYx
Y6BB07sOk9dH8SseO5DoJoY3Qu2DppocB04w7sVkyus03QIxfVMK2Zo6721INesX
7sgFm7drA7QdEeA0eVuhrJb5o2GkMQQ25KEPxw5w6YI1oQJcWO1jv0zMzJqVvWbJ
9Y9YaNhDGSGmH+wUDEUnalzTB0qkMtULGMzfvUVjwH4zVh4msXNHqbvGwtOcZhmz
Uyb3YG+XJ18H0G8vzffdsFlMZKUox+yw15ffunvJ5ZAbN38Ay24SXWuMtPF9KQA1
I/ucYE4q3b40CE0B9bAqVhF6vZxkivhkShIQsEU8/MylbSe2ICdp+oBd0jctKZiZ
fsizRoZz+cnRuL9HXAyb
=oVOr
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
