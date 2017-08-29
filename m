From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT] arm64: dts: renesas: salvator-common: enable SDR104 for SD
 cards
Date: Tue, 29 Aug 2017 17:42:37 +0200
Message-ID: <20170829154237.vdt3hbtjnos2eu2c@ninjato>
References: <20170802201311.1394-1-wsa+renesas@sang-engineering.com>
 <20170803074351.GC19671@verge.net.au>
 <20170803155357.GA3826@verge.net.au>
 <20170803155520.GB3826@verge.net.au>
 <20170808185445.GA2170@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7n63g63hwhwit2t"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45448 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdH2Pmj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Aug 2017 11:42:39 -0400
Content-Disposition: inline
In-Reply-To: <20170808185445.GA2170@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org


--v7n63g63hwhwit2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> As discussed in a chat, I tried SDR104 with my SDIO WiFi cards:
>=20
> H3:
> - one slot worked flawlessly
> - one slot could load FW but failed to read status
> (with SDR50: both slots work)
>=20
> M3-W:
> - both slots could not load the firmware
> (with SDR50: one slot works, one fails to load FW)

Update for my H3-ES2.0:

 - both slots could not load the firmware with SDR104
 (with SDR50: both slots work)

> The cards, however, were correctly identified as SDR104 and there were
> no tuning errors and no other SDHI related warnings.

This still holds true.


--v7n63g63hwhwit2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmli2kACgkQFA3kzBSg
KbZNUA/+K5IYz1Xdq97zbdVG/ao9djes8S2Qbl52cTBgBRjMNSY61uWa9eU9Knh1
GP7o2DHL+mTORIrC4ulJ1Gz4b578TTaEG6JEmTKZNafvSYdorbQpjd5fSldO4/0u
D6+0kapgHKR1AqJSULHqbhtx18zKjeFnawb5DePa6iHBcp6pQz0CQ4Qn2PpkOPPO
UA9QEKsSMUaoiqeJBdg/obG3G5bqGrf6WiDrfLrhDWYhC56YZg4JP+pTXOMytdXS
iWA6xZ3P2VhIRihU0Qw0U8cZHywqed4iK6sVlkms6CU5ZINPYv4SVMxlQWCVy3/f
QJBtxDR9KvPwC1j7vsn2BbRqf7CPuXwwLon3UELBH/A/A8TolY6ocL24Ctl4j6Dw
ejQAJNzGcgyO9HqeDQNhvzbdIZ7Y1MVkiQ4DJYLDmmKaHkkZ6/bJXPDFoEhz/uX0
0HzQh+oKq49IDdPd+OTYimMS5slogowa0ThRblnITHvgWiYyHopAzD2SteeHQmdE
v/pNkkvN2TpX+mkpnvXULUxap9khzigZx+FTYF/b6QKfXQSAuh8fAR05dZ35II2N
V7Hen8e7sZv9iLMo0jR1+N8WmRR7HvOmoZicmcM3UsEdwJop2M+4WB9kmLnJs2VX
Ye6yHW4C93FR7+SKAbXi5ClQAe/3vWks7Bt7UTVzc6cwshbStiw=
=u0+x
-----END PGP SIGNATURE-----

--v7n63g63hwhwit2t--
