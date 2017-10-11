From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: renesas sdhi driver and DMA
Date: Wed, 11 Oct 2017 09:08:43 +0200
Message-ID: <20171011070843.nxmcx7wotjlbtzzd@ninjato>
References: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
 <SG2PR06MB1165529F4559C7D6CD23CA9C8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i3oyzcl5gch43egf"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33681 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753822AbdJKHIp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Oct 2017 03:08:45 -0400
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165529F4559C7D6CD23CA9C8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--i3oyzcl5gch43egf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Isn't it SYS-DMAC compatible (sigh)?
>=20
> And to answer your question, it's a completely different IP than the=20
> SYS-DMAC. It's still a multi-channel linked-list descriptor based system=
=20
> like SYS-DMAC, but a complete different set of registers.
>=20
> However, it's a nice piece of IP so we'll probably continue to use it=20
> for future RZ/A devices.

When asking the question, I mixed up RZ/A with RZ/G, so I wondered why
the latter has something different. For RZ/A, it is obvious to me that
DMA has a different controller. Sorry about the fuzz!


--i3oyzcl5gch43egf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlndw3sACgkQFA3kzBSg
Kba+og//ZBotQeCxHltp5YXkrzgxGHmBoIXb+bwxzwyGqb+vO0rgcH/trVGauYUn
EVdaGIxwfpvT0u0ZyTIkO3zPxUeZJNlPMTjhW1+IzJMuMoEvKPJ4YMLnyt9KuZa8
d6wQ+JVhIuR2SGU5i7f7+6wm4GsBXanuR2Wv+Aj3m4PIm/ZJCzMGPeWl6htJ14Qu
qqoMwUSIQsPUXfNuBroC/GbUgFn0fYNSdQuEeaD7BT4CwRIJe5lntcyYr6pPRx7N
TgdniPaaYXHzUQWO/TmMeuMtNJTjPH2feTqZenXBuwu3QBjXq4Npy3lH36kaONb3
ERFN3y8HtpnMHVQ8rVE4Pa0g1ZcVLvivL8MPE0cgDi2TPrCEPg4uphppoG4wE96V
lb6wO1B92RNZuOGLpIdgFTlvwpVtggGPZMoZwSNPi+xKT09Oa9haG8ZXywa1w3Ap
IX13pONTgR3Vf7OniGCOaufwn78D4OfjXItHkX5qJtGKunGTe8JJ0MzNeh33AS1h
2uRdMtW3GwDreSRrEB7L6Im0BGMdokrl1NASiTuwiMd/vvEI4pThhkcKQMUFK2t0
fLW3o6KUmhFbv3C7SAYmbSXTgIXXekdZfSrLTEWHNO7uhifSf25zg7zXgEwI6qNT
RG9os7g9DOq8gggLB7jRBgo510Yh8XJSmhVO7wNBlgzhs+rUH5E=
=dmfY
-----END PGP SIGNATURE-----

--i3oyzcl5gch43egf--
