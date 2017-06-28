From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v3 0/4] mmc: renesas_sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Wed, 28 Jun 2017 16:40:02 +0200
Message-ID: <20170628144002.3k5e22rxsz6q3iwp@ninjato>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
 <20170626201650.GA3595@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="34rdj22ltsg5nvie"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56707 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdF1OkE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 28 Jun 2017 10:40:04 -0400
Content-Disposition: inline
In-Reply-To: <20170626201650.GA3595@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--34rdj22ltsg5nvie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 10:16:50PM +0200, Wolfram Sang wrote:
>=20
> > this series adds support for the internal DMAC used by r8a779[56] SoCs.
> > This is achieved by adding a new variant of the SDHI driver for this
> > DMA controller with compat strings for the r8a779[56] SoCs.
> > Compat strings for these SoCs are also removed from the existing SYS DM=
AC
> > variant of the SDHI driver.
>=20
> Okay, I tested some more today. My conclusion is that the series works
> so far. However, it quite often triggers a SDR50 retune with one card.
> And that sends an explicit CMD12 which we don't handle well. I always
> suspected the code to be imperfect, now I have a proof. So, that is a
> good thing but seems unrelated to this series to me.
>=20
> Another card does not retune and works flawlessly.
>=20
> I will sleep over it, re-test tomorrow and if my findings will get
> confirmed, then I'll give my Reviewed-by tags to this series.

I could successfully move around big files on Lager/H2 and
Salvator-X/M3-W with multiple cards. The md5sum of the files matched.

The transfer speedups match Simon's numbers.

On M3-W, one card has problems because it wants to retune and that
causes problems independently of this DMA driver. M3-W works fine with
other cards. The card in question works fine with H2.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--34rdj22ltsg5nvie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllTv8EACgkQFA3kzBSg
KbapZxAAh3QYGRtpxyiNT0NEo2ysstOVHWZ3EuwwNA4DaTZap6BE6zTLAMf+IKO0
dJDp1zQxBOa8XN76vlF0NrOMSysL4xy+BcrE2r3ZnQP/3h3OaIymE1CqQjI9UFdD
nlU2W28Rg+0w+P54Fb1iZGn2RJJKr14nO+3yytnAVgdpm1pKwpuW/Eug9Q7FJkUt
LY6pr9IWN3iq+Zk1+t1XrlTxCQNSwlLSP+g/NwesEql1YMtHcC/9t8bcT0MEE+cm
ChZwoLCC4v9haIY/hPu9iURyuglwH5e601R6118OqZBpfvt+5e3d6R2qogMMs2Yf
5tLedYrFG9CCbDJ8FcTlrrcKRXdzkK/EBMkynduQ6ALKNoyfUur1VkgH8Yvs+3IP
3oT4gccY6xvnaVMcoahKWpQh8WIyoL+brAFJOgAG8Jn1xhgdA55F/eNSLA/5NLP0
bWAW1pkvI1Cffh0gSgJvjFHU09Khsso8G0m+hZ6QU9pkBC5JBBB159B6HZrwIsiU
LKe0Dw0uwmnHgZFnct5CbewxmdzMh3bARxbdJBHABHk26QSY1tsfgfY+d+4aSryK
XneJlyFtkHdeSOlJF4qk+wiTU47hdGydYlY7Qmac3bhN3fdDXQ1fny5wQd7fUNO4
45g3QffIU6pSAJWDMH++g8tWHYLJQVHISEoeobXB2q1bsZxAvcg=
=X1+8
-----END PGP SIGNATURE-----

--34rdj22ltsg5nvie--
