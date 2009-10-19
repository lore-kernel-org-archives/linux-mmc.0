From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 7/14] drivers/mmc: Move dereference after NULL test
Date: Mon, 19 Oct 2009 09:56:04 +0200
Message-ID: <20091019075604.GB11449@pengutronix.de>
References: <Pine.LNX.4.64.0910170839430.9213@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52348 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbZJSH4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Oct 2009 03:56:06 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0910170839430.9213@ask.diku.dk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sat, Oct 17, 2009 at 08:40:02AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
>=20
> If the NULL test on mrq is needed, then the derefernce should be afte=
r the
> NULL test.
s/derefernce/dereference/
=20
> A simplified version of the semantic match that detects this problem =
is as
> follows (http://coccinelle.lip6.fr/):
>=20
> // <smpl>
> @match exists@
> expression x, E;
> identifier fld;
> @@
>=20
> * x->fld
>   ... when !=3D \(x =3D E\|&x\)
> * x =3D=3D NULL
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <julia@diku.dk>
Other than that

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
