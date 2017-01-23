From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Mon, 23 Jan 2017 12:16:39 +0100
Message-ID: <20170123111639.nymy775co2uckxu2@ninjato>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2lbiu4wiujionirm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48228 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbdAWLQo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Jan 2017 06:16:44 -0500
Content-Disposition: inline
In-Reply-To: <20170110210848.GA25542@bigcity.dyn.berto.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>


--2lbiu4wiujionirm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

so I scratched my head around this a little more... I don't have an
explanation, but want to highlight some interesting points:

> [    2.954859] mmc0: new ultra high speed SDR50 SDHC card at address aaaa

So, this is an SDR50 card. The patch in questions adds tuning support
which is only needed for SDR104. The whole tuning procedure is not (or
at least should not be) exercised.

> Oddly enough the error are only printed when I insert the SD card in the=
=20
> mmc0 slot. I can insert/eject the card multiple times in mmc1 and no=20
> error but the first insertion in mmc0 and boom. Only difference I can=20
> see are the clock speed between mmc0 and mmc1.

That actually makes sense. mmc0 is SDR104 capable and has the SCC unit
which is needed for tuning (note the larger register space in the dtsi).
The other mmc cores do only SDR50 and do not have an SCC. Because your
warning is about a broken pointer, I wonder if it is about accessing
SCC? Maybe in hw_reset? Wild guess, though. On the other hand, the
register ranges in the dtsi look ok, so I'd assume the IPMMU should have
all the info it needs? But I don't really know...

First thing to try: please remove the property "sd-uhs-sdr104;" from
your Koelsch DTS. I'd expect this makes the warnings go away. If so,
readd the property and instrument if sh_mobile_sdhi_hw_reset() gets
called. One outcome might be that the printouts might be tied to the
warnings.

> I can interact fine with the card (I tried checksumming a large file and=
=20
> compared with a known good) so it's not broken. I can also interact with=
=20
> other devices using the DMAC+IPMMU without similar warnings being=20
> printed at all, I tested with i2c6.

That is relieving and also makes sense in the way that nothing in this
patch should be needed to get an SDR50 card running.

Regards,

   Wolfram


--2lbiu4wiujionirm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliF5gcACgkQFA3kzBSg
KbYsshAAlQgOWYmPsQO6MJe5yiT2iDorfixt3POfderiwARju+ZQVRUIizTFAcqW
KQfANp3jk4NeKNToExIxJxRuJq2x72BodtYQZW7Zo9liXF9WTfnUS5uEKQJaewxb
JbGWQ4zHxwTOin/eT+s3WADxrg9jD0FAh5AcwKTjRAj0G5kGc4JueNSpF1QJGTeJ
8/9trXVlsMquo1efCI5tOg0vxW3CHKvqKJzYhFkOS2cyJm+9TdzAieVBgtpj2S0n
xwx23C8qNd1jkmhoeYCWoEjLU/ktcMYSkCl3oqA6WR7xpaBagaSE4R3zG/Ud267G
fOn/mqrRLoeqtcFLX7xZ8SMUsp/NJ2adzWvr6WisJkr4wkxzTXQQ7b1BUJ6Z2+vx
lLl/a06PNC5KtqHROET76jXB3LFsfDu/fx5OrNkTvDDJ9GYyX+W1278fvBoQITNE
v+jqIEQ22D4EBxZWCcknmn3v/TAqy6O1y4/Mda5X0pDD8lKAEPW2DwOtmovRe6ma
G+RVtaAX/ZbeB4KBjagRtj8O791SJW/w/snMu9pnammbNLckjmFUulGmDLbDGPHq
W+LW1g2iK84h4QmsFQspEcpyDIq5idl6qy4x1WXiUK5VE0UnzUr0s6z4gS5/KE23
coe+U1P5pFcnNNzos6vv1TmnfMvzTaUeSxtjB+WIv61Sef0W7eM=
=DKf5
-----END PGP SIGNATURE-----

--2lbiu4wiujionirm--
