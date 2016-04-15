From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Fri, 15 Apr 2016 22:41:57 +0200
Message-ID: <20160415204156.GB3105@katana>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
 <1460477978.32355.14.camel@codethink.co.uk>
 <20160415202803.GA3105@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48471 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbcDOUmE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 16:42:04 -0400
Content-Disposition: inline
In-Reply-To: <20160415202803.GA3105@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > That seems like a bug in the clock driver.  If it doesn't have
> > independent dividers for each clock client then it shouldn't allow any
> > client to change the frequency.

So, we need MSTP clocks which do not use CLK_SET_RATE_PARENT on r8a7740.
Probably the best way is to use the "renesas,r8a7740-mstp-clocks"
compatible entry to determine the difference? Geert?


--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEVIUAAoJEBQN5MwUoCm2u2kP/RcBnAstJaJ+qtHrLIxYv/+Y
YJA883H6OnR6v28JdK0A7f8kbPmnrL8/CbnWqhh6SS4nRMAxXQShNH8+dr53VIB1
w2GRtCTp8Z7coXj9CU7IFrrsNyboPCX/koTUFiniVqtK7/jHJr9ibbFvBpQdy8Sp
ChwNxfl6tVIjt233kY1YMr8R9jtgPUqVtdAPeYATQdj901ksUoCxDec1DReRamm7
elxFx3tSiYW530QguClK++kiRKrHZMdvwVYX13CDpg5A5kJgU0U7h505r2MN9rdZ
K4qtczi8h6b41XNaIsJnZxeBZIyM11/EqxnOqlngZlQ5bzmymg5hCDyVawpbzlrv
T7plxaLJ/lOsOmfJaDPCAbWiBqKf6oWMM8Nztb5AdchYStykB5SWv05/wJRp389w
PQwfRe6ow8PTn3f6qw8xC9jv1N1fjI5uqiklDeXAy7YN6tbwbqTMsCVTe5q0bwSk
E6SqJmmAI3NPfKgkiNa8MtXBMNnqZQ47jRQMzCtlH+z+3JPOvtAIPvBlI84izfmd
24/V3dDG8MdlfJwGoT2iiFGTBFwimzfWpk56UpC4Cm1AEUBsZ5NpapOAgbpsMAoS
gpH2Gg1c1LA6wcHiymqZtkVSflAgNOp7HcFkp6Fu0UqxyZeO+tUaF4uvP+7ZHDtc
Q+ij2m1kVTJIklMuHjkq
=jLR4
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
