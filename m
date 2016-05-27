From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/4] mmc: tmio: enhance illegal sequence handling
Date: Fri, 27 May 2016 13:34:15 +0200
Message-ID: <20160527113415.GB1663@katana>
References: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
 <1464057797-29951-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47407 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbcE0LeY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 May 2016 07:34:24 -0400
Content-Disposition: inline
In-Reply-To: <1464057797-29951-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2016 at 11:43:14AM +0900, Simon Horman wrote:
> From: Ai Kyuse <ai.kyuse.uw@renesas.com>
>=20
> An illegal sequence command error may occur if there is a stopbit or
> cmd_index error as well as a CRC error. The correct course of action
> is to re-enable IRQs
>=20
> An illegal sequence data error may occur if there is a CRC or stopbit
> error,  or underrun. In this case set data->error correctly.
>=20
> This is in preparation for enabling tuning support which relies on
> differentiating between illegal sequence and other errors.
>=20
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> [simon: broken out of a larger patch]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Breaking out this one really helps the understanding and the review of
the series. Thanks for doing it!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSDC3AAoJEBQN5MwUoCm2yVYQAKBCZfl3sVOqOnpmALeDub2z
uoEU5oCa1e0bZi81CD63Bs7YuUsE9UmrnPjPRE7GAsKMCA+SAIGrBuaytz9gJZAY
HTWSeIZ+5eGBZuzb4EcZIswhh3h8Ym/z6K2BEyf3BwrKkN5zNhu2xB0Nu4hwnnpc
utM5PUpdG3O+iHhggyaRoJwSCULYeBSR/eEdJDmsHCC5ykj7IDSsEBQf4SMYe7W9
gOLst7IsdvvZiKMWJWTOgEoSMiL0p6X/eTw1AwSa/HNVu/Jxb6FvcVO4m3IJ7WlE
VF4CId9zKYOS+0deJb/vy4OeXW6j2syDOVzIskGwk1nmQVpuFcO+84CWywof0wxb
ZXhfzXiSGTn2gj5sMzwhqmnHDu7GPojtCPiUD8QA17BZXetOqLwQS80CHaqAeUUH
oocgJhQ2BcY3KWqp767WhGP6pRuDas5X7u12aXFb6Ba8FyNI7uVUe/k8kUdVue6l
GpYdryePMEy787MNygt9uRmjP6JhjGbW/ZiQoAOxzrEMP671y9FCwPDtpWkXpVv1
C2+b3tEXOwx2hzbshDP9UMkfcxBjNUZQzqIweNnS2iFiyEwDThH9L8cVjhq4eUMv
LYvHTmoLcyvGqObLzlQo39yy262sjVOEsA+E/m+7A+QffNixvpuBsdj1qjH7WhkY
H5lYAAl3fHa+8cU5DoJJ
=GRtI
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
