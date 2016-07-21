From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/3] mmc: sunxi: Add support to the Allwinner A83T
Date: Thu, 21 Jul 2016 10:58:38 +0200
Message-ID: <20160721085838.GH5993@lukather>
References: <cover.1469082481.git.moinejf@free.fr>
 <0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42741 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751320AbcGUI6k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2016 04:58:40 -0400
Content-Disposition: inline
In-Reply-To: <0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Maxime

On Wed, Jul 20, 2016 at 08:28:47PM +0200, Jean-Francois Moine wrote:
> The rate of the PLL-PERIPH clock is usually set to 1.2GHz in the A83T.

Uh? The datasheet says to set it to 600MHz.

> This patch sets the phase delays of the output and sample clocks
> accordingly.
>=20
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> Note: The impacted phase delays are only for 50MHz.
> The phase delays are not used in 50MHz 8 bits DDR (new timing mode).

Actually, they seem to be, in the new timing mode register.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkI6+AAoJEBx+YmzsjxAgFDIQAJ1DC51ZL2q8zBkLBAm+kBEO
yP7iezwVA6DgDOue+fP+978GtnJmYmtLy+bATfPscka/jXxMcVW8XtNoqrNHJYtL
xOFUcsNcDWmKCP7dMGxcTSktzV0sMo2WWpEwI2gKacp55EG629fPlNQAVbTV5s9r
EFm808BgFiWFV1tT7uYtJ5Iwi2wJcsAQSZIFdyLe1ZIC1gfCw5JNgyVhWRrrxAnR
ErRLp9WnAU2m7YXkT09+UefFu7ODjWI4OlMsYrrE3yP1X+o4h9xgj7ulLgnPcg2p
sKhlKSOLkpZUaO6pmoVDdi4bCOxQiJjeDngDZqlCTvI7s8azZ6OJE3itd6OkBvrQ
t4GZzXVJo5bd0D8XHaOMae7gp2esX7WRZeH1S07pHyLG4KxNwmenn1YJKCV8rZA4
7F6HEieFI52ELPrxP/xDgaYUeZAdjCPl706+DRdANREQk5j6Tl8x3mD4Z3LA4Kiu
eJ/8cbfITG8spTHRXKo5FoMyTMKUNUB3XP1Zs+icC0pe2B+9BNQVQ7eLz/MgBXBz
vFvRAafqVbpcDHrwcyDocPK+QJSVq74whF/6n76ODRCjA+wSyw77kkQ8BGesbmjX
7s3hFRt/Ex63wuqb5BY89dqLp7FFJcOvvgxMILF1W2ZDXnApwA5eG2e+Oqs42cQq
5n1vLT685jJagEqZBhYt
=kC7T
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
