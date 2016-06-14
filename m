From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: Change the enhanced area related sysfs output format
Date: Tue, 14 Jun 2016 12:12:43 +0200
Message-ID: <20160614101242.GA1603@katana>
References: <1465893186-6399-1-git-send-email-beatax.baranowska@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58981 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbcFNKNC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Jun 2016 06:13:02 -0400
Content-Disposition: inline
In-Reply-To: <1465893186-6399-1-git-send-email-beatax.baranowska@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Beata Baranowska <beatax.baranowska@intel.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, aisheng.dong@nxp.com, wsa+renesas@sang-engineering.com, gwendal@chromium.org, chaotian.jing@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sebastianx.jarosz@intel.com, Chuanxiao Dong <chuanxiao.dong@intel.com>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 10:33:06AM +0200, Beata Baranowska wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>=20
> When the enhanced area feature was not enabled, the related sysfs will=20
> have -EINVAL(-22) value, so change the sysfs output format to display=20
> the correct value.
>=20
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

What about introducing attribute_group an use the is_visible callback
there, so they won't get displayed at all?


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXX9iaAAoJEBQN5MwUoCm2EFEP/385txw8VNGypHknLM6P1Xlj
xnbsZpJ9v/tyo1sNpG+hJ9hgtrkSjv/g8uBBQGIWmqdnoMRgW2BNx8a7rbVbArWR
ZcQCXcxK7qwLiNqcf6aYUaWqF778n6Xq9p30nlTAkQJxm2718knDYqYfsh16GkMo
u6K/8jmU1HSGfaG9McBhYnv23X7DECx++5SxHdCRnE8AZCPtUaIe2MK4rXUr2eW7
Hzgao/6TfCawAH6vj47L+EdC7myyUymC78nb36IfLaFw2StjRDIJGJxTUZXBY7mV
HJBfnWUAX0FXZQNN4ebz48JKwDBNuBQXa4G6iZXki9rVvdY0xBxJcAP5scOHumv2
lwCn/PX8LPzCKGdFrsuksIi2gN6eh87asaIdB/vV6reeJaVzaY8fDUxj6SgpStEF
9ahYYZfoqM53wpi4CJV6FqHkdC6s444wSnmiWMUdaPU/XuqwfKbYLBdEakStF4W8
cpg375NiWpAsNVZyDMdr4RV0XL5lMfG8hyH1gF5wU7Lmk0Ix2tZc8wtHFzWRHKdE
l7xgcz4KFigeaTAD+r3cSFqJxJ/ZZ2sfMT34vD5nmapcH/66Uc8e+JusGJBCY5w0
0XJ++B3PGV2SBfVwMdW1Bgf4dKMFAsPudWcec919L22pmX1AGOOL3x3YUdolvfwI
reUpq7aOjBAjszb7xcaH
=jxxR
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
