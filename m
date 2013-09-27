From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] mmc: core: Fixup ocr mask setup to prevent spec
 violation
Date: Fri, 27 Sep 2013 11:44:05 +0100
Message-ID: <20130927104405.GB19304@sirena.org.uk>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
 <Pine.LNX.4.64.1309162253320.17217@axis700.grange>
 <CAPDyKFrvPkwAVfi8gv0hG3DKeiJm+_AqODhERX=O0ZxB-gcHiw@mail.gmail.com>
 <Pine.LNX.4.64.1309171008190.20367@axis700.grange>
 <CAPDyKFpfe7mL4aLBo4S4tibpoL8DoiK3TiVzPvc4V-eG1Yrm_w@mail.gmail.com>
 <20130917110429.GR21013@sirena.org.uk>
 <CAPDyKFqMhE54bi-B+8TswObs=PTj31kxjPcDoDuyLoOQsKStFA@mail.gmail.com>
 <CAPDyKFoXmfzSG931MTUhg3B4KPL3aR_0Uw=N=iiRKBg94YHntw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="olLTNZSltDMg5Vbm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:43351 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3I0KoK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2013 06:44:10 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFoXmfzSG931MTUhg3B4KPL3aR_0Uw=N=iiRKBg94YHntw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prasanna NAVARATNA <prasanna.navaratna@gmail.com>


--olLTNZSltDMg5Vbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2013 at 11:56:26AM +0200, Ulf Hansson wrote:

> To go forward, I suppose our discussion shall not prevent Chris from
> merging this patchset? We shall be able to address your input as work
> on top if this patchset, right?

To be honest I don't think I saw the original patches so I can't offer
much comment either way but that seems like a sensible idea.

--olLTNZSltDMg5Vbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRWFyAAoJELSic+t+oim9NqoP/ipdEyvut16mjQFZ324WJ1xV
6HfaqAz1FGT7OzUlmEaCw/Xn09ApXXIZYZC5UezlP7emvtjGVcSd98WlvP7CD+hD
NINasZoogPmTQA09AxPAPvApc782zRIrAbAabT2mo3/1ZU+RuzGUY4W1vEGKE1WE
OGcaF7JcyYKXN2+E8umr1EtYfibA22QIxaG/6Vd2p3aiabzWSGKWYvSH3ZtAz5iK
J8ctgvNY4uyFCbmHEDxPkEOTCWIKwfpkDjwIEm0ZY4qbFBnl333FUKSdIJxf41fU
t0TytToeSlBuCet2esx9kHTziY5oXVw+RM3LKS3nU/wUpR5w3j3S+5iTYJybMYUG
AMT9mOTLwiX1St4ZFeTV8JQBtL5m82yOHGVkDQ5KW1cGPGRmxX2T430VP8E6U0DH
6bdTMz6FEPpB4oQkVaY0FktLGbwOKUh2qLp59Rr7DEoXyBTTvsNowrPFodV0DrnY
5GjSquXyNKV1B0plJFXyTK8X+Hpy8zOAd+eXdRIj13wEz8dmJsUWtBxJWcOwJFyK
PZSaKfpMDg9UevE+iNT1CdNeDDUrraGWK2ZT7sCcd3WcRFjTD23Hkboh03wofQ8W
4yXdj4/Jq0J2BSeOGeT1WCzkaVtkMrHSstxjM3+6s2JjzOOo97A52FJFmTo4MM8S
ttQURZZWyaJ3fHSUpPoS
=XjMD
-----END PGP SIGNATURE-----

--olLTNZSltDMg5Vbm--
