From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/6] mmc: tmio: add eMMC support
Date: Mon, 19 Sep 2016 22:26:32 +0200
Message-ID: <20160919202632.GA1425@katana>
References: <20160919124921.8172-1-wsa+renesas@sang-engineering.com>
 <20160919124921.8172-5-wsa+renesas@sang-engineering.com>
 <ddb477a7-4b3c-e67a-22fc-93432c4c75cb@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37708 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbcISU0m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Sep 2016 16:26:42 -0400
Content-Disposition: inline
In-Reply-To: <ddb477a7-4b3c-e67a-22fc-93432c4c75cb@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >+	u16 reg =3D sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
> >+				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
> >+
> >+	/* reg now applies to MMC_BUS_WIDTH_4 */
> >+	if (bus_width =3D=3D MMC_BUS_WIDTH_1)
> >+		reg |=3D CARD_OPT_WIDTH;
> >+	else if (bus_width =3D=3D MMC_BUS_WIDTH_8)
> >+		reg |=3D CARD_OPT_WIDTH8;
>=20
>    Why not *switch*?

Didn't look better to me.


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4En4AAoJEBQN5MwUoCm2J6AP/i8n9B8pL6dkkf6DI8pEmn0m
Rm+yQOYh135jp7QNG+eR5wK9U6KBqS0Esx2T8rGt5z2nFgHsRFktSRBv0Wjz6U+W
43ixOBmdlqQW94nxCxmIWm4iyOwX3VD/KaIAFnppewHhcXtjzqK+CJEu0Iv92xmt
pMck4pJOHhiffozuVKyIz5MmnTsmb7lLEjXfQ4fzAb0pbQqBc4yrTB4VRn6uQlAA
2sREmqRMNqFKtVSKmFVGtaqN4i/mmAedBnHpAJV66DJ+wN16URvFE5V26zkVRRYG
Rp0qqgr2lUApiUo7m/vgKnhXye4Qr/K5mIn6wSrYdzBaksoXbe4bggLECVtSqdpz
8QIa3h/2DWN8zR9USOgqozb6Ro/mUsT/Mz/MUYR/+aoLapgL2m4MDcAocFxd5ROA
ojzdOadlAP9f1In6FOx7MSiibHw4X4VdD6ViT7bLJcxPuJkoY122gLjuC+eAUDXW
4Z+njiAdUjaJaQVBErBCI6aWoIK1OwLR/3xbTyqFZlbQnpKqohQUd/u1UNoyWERL
TWRWoJSxMFofHPt5kHaRMIt8J7m2NYNv11ARPRxJ8RxtLn8a25MOteKyEZ+CxRqg
XKXkI47EWfG5XM7S/gu9F75p8ezVqevPlwMisHSv202Qujoi7T/10cuAUCzYTpPb
Q94lIukp8iVQoN0RxM+j
=WOcL
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
