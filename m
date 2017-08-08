From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT] arm64: dts: renesas: salvator-common: enable SDR104 for SD
 cards
Date: Tue, 8 Aug 2017 20:54:45 +0200
Message-ID: <20170808185445.GA2170@katana>
References: <20170802201311.1394-1-wsa+renesas@sang-engineering.com>
 <20170803074351.GC19671@verge.net.au>
 <20170803155357.GA3826@verge.net.au>
 <20170803155520.GB3826@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:58386 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752295AbdHHSyr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Aug 2017 14:54:47 -0400
Content-Disposition: inline
In-Reply-To: <20170803155520.GB3826@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As it is an "RFT" I'm happy to apply it if you repost
> it or otherwise indicate that is what you would like to happen.

As discussed in a chat, I tried SDR104 with my SDIO WiFi cards:

H3:
- one slot worked flawlessly
- one slot could load FW but failed to read status
(with SDR50: both slots work)

M3-W:
- both slots could not load the firmware
(with SDR50: one slot works, one fails to load FW)

The cards, however, were correctly identified as SDR104 and there were
no tuning errors and no other SDHI related warnings.

Changing TDSEL in the PFC did not change anything.

The manual of the WiFi card (u-blox EMMY-W1) mentions a maximum line
length of 100mm. Measuring a direct line from the SoC to the slots,
I'd think we are very much on the edge of that. And given the length
of the SDIO adapter, we are surely exceeding that :(

Maybe we should do more tests with more boards? On the other hand, it
seems the WiFi card is running out of the specs.

So much for now. I'll sleep over it and try to get more data tomorrow.

Regards,

   Wolfram


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmKCPAACgkQFA3kzBSg
KbZ/YhAAtAb8x24atSDy3O3RlAqNRqJ7SJhXTxB3aF0KfwWcUQsyVpcUKRpBltNB
5PboVOwsTjH7y3gIcf5Ed3WUHHqWqPqlQMP2rmNYWN/B6ryAmXv1DIq9ZOo2bDB0
d0IInhgoFQibsFott+nV0jpFX+TrCFa8ehLV98M4mZFaKdpJjMVLsza2ey1EyaBT
5E8waEMjq+Q9n0jwLiyubesEFKP82rQ2tl6UKepooqrMc23Zg3wYtPmqHuXMQLHe
+6RPhlwjSRcu1mvbOaQKAD4mDXX1K+7RDwSwQPpZxkpKHLPH8fv8ND4xMb5oJCu0
CbBVtL42hTm4AIPyRzNT4LMqnyJTfMv0QZtkzyeFQIZGJJYutFHtbnQTheT9m7Lc
IjvZIl7mQeNbmWNyIn5xQBAFbIyIJ7AN20GTsNYb4dlntU42n/+5Nqn+/YY6kIps
jjxkczvTlKBPQG8Ii+8tKNcoUMmqGhu/czadsT6OgaO7EaPd/Tk4yjRzIdRKNkBM
VesldVUsVKt6kKxHCFfxyanfO8n7T7kwS+87GYTlr5gz/LWsVMkD/x7AyhubMQjM
4EUW46ZbCgUyStUDTIEA3KanutCbOjh4bZITyC2VaqaQGmgyukRqeT26tMBalr/3
BXyrKD1Jw2nGuW/dukZ7HXmKaHxykzBL3qzSrz4zPLSNmm+yCAI=
=BTMy
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
