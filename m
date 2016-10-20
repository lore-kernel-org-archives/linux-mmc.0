From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Fri, 21 Oct 2016 01:04:51 +0200
Message-ID: <20161020230451.GA2199@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161020132852.GB4177@katana>
 <SG2PR06MB1165B756B67D1D101E91A7B38AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60846 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752376AbcJTXFF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Oct 2016 19:05:05 -0400
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165B756B67D1D101E91A7B38AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I'll submit a v4 of this patch series tomorrow.

Please wait a little. I'd like to use that feature on R-Car, too, so I
wonder if the additional feature flag is the proper path.


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYCU2TAAoJEBQN5MwUoCm2QFYQALV8bG2ZHNlLycHbJWvgsyRw
v27RUODZ5fQ5iL3C8IjX/um+kiSpik9Hzv5NriVoXi3vuCXhmKASaqM+atcM12Pw
fXZvQVYSTNwVcPIjbhTOWt0BGfOacT/2WJxm4MGZ9P+k3qvHSooaddpdFdmA0MWQ
P2dB3EuLMt2hKiODcypaI6z51myhID+LYHtvC8tBBbIHcSzpQXHj4LmUF02BHCrm
qRJTnKY49hWWvCv1TZntNDdJ1/YYFCj6CvwE3vpqY7ruGlVOoD48LI/Imv6iO0sQ
+Ayr8FeWL6AGdJT0dScfky5NYueAaTurlAv+kUMrwKfrYOmJ521ZtJ7boeK/edZN
Lcdf/6GEA74ZIaYSPbj2v0N8APOAH0Jw/5/VXLwgq2Dk2lzZ51h/6B+y/6paevSD
uEn0E0eWzgXclnNegJh8dGDcsnNDaolTAHnMeihUdit8KTiT/ToUQMSbyQDaLPgG
r5Lh6iJDVtyk4HKMQaCqRpN06mNW1M+Gh53OBoyfXMDpJf6cI0aMUr5jAbsYP2ja
UuJPKMCjpZ2V6YBr4xEaQ33duSunC7ZnO56ZdIGg4GQEpXm1J9jvxlMxni1Lxr/i
iLsgSiUCURebD3biey/cYHN57VvQsJKzps7DNLD9jyQuFXkGgM24vX+IZGuDoQcK
TUqerMKeoETPOb3wAjPW
=NECn
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
