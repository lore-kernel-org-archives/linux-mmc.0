From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Tue, 19 Oct 2010 21:36:38 +0200
Message-ID: <20101019193638.GB31336@pengutronix.de>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com> <20101019150743.GA26784@pengutronix.de> <4CBDB694.4000209@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57454 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0JSTgo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2010 15:36:44 -0400
Content-Disposition: inline
In-Reply-To: <4CBDB694.4000209@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: r65037@freescale.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, cjb@laptop.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2010 at 05:17:40PM +0200, Eric B=E9nard wrote:
> Hi Wolfram,
>
> Le 19/10/2010 17:07, Wolfram Sang a =E9crit :
>> On Tue, Oct 19, 2010 at 02:49:01PM +0200, Eric B=E9nard wrote:
>>> this patch fix timeout problems on i.MX51 as suggested by
>>> Richard Zhu.
>>> more tests are needed to check if this quirk can be removed
>>> for i.MX25 and 35.
>>
>> Didn't you have such boards?
>
> I do have, but I can't do the tests until next week because of other prio=
rities.

I'd suggest to add a proper patch next week then (maybe together with corre=
ct
usage of the MULTIBLOCK-quirk, too?). It's a new driver, so adding update
patches late in the cycle should not cause problems? Of course, Chris makes=
 the
final decision about that.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky980YACgkQD27XaX1/VRuUCwCgxM3f5JssZwDZp83GKZP4TLDL
UDwAoLTHO66fesNEhI58vRsxTfKVwqnm
=yRfE
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
