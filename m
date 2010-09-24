From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/4] Adding support for esdhc on mx35/51
Date: Fri, 24 Sep 2010 12:58:42 +0200
Message-ID: <20100924105842.GD10334@pengutronix.de>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net>
 <20100924064310.GA30543@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0D4BFC@zch01exm22.fsl.freescale.net>
 <20100924085744.GA10334@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0D4C19@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44128 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0IXK6o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2010 06:58:44 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D4C19@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2010 at 05:40:15PM +0800, Zhu Richard-R65037 wrote:

> Hi Wolfram:
> Sorry to bring the confusions to you.

Well, no worries, maybe I was not clear as well. Hope we have everything
clear now :)

> I will use your git repos and make up the missing bits (i.e:the
> HOST_CONROL and so on) and verify the func on MX51 BBG boards later.
> BTW, Is the URL of your git repos the following one?
> git://git.pengutronix.de/git/wsa/linux-2.6.git

Yes. I pushed out the current status of my branch, but I haven't
implemented all requested changes from Anton yet. Will do on Monday.
If you can't afford to wait for this updated branch, please keep your
changes well separated to reduce merge conflicts.

Thanks!

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkychGIACgkQD27XaX1/VRt3sQCgtFNKK9+GHm45NxTnIjDZfkmS
EJAAnRghTTg7WqHtfKeFgzc+3zVz+eYl
=ik/j
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
