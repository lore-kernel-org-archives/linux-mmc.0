From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v3 0/4] mmc: renesas_sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Mon, 26 Jun 2017 22:16:50 +0200
Message-ID: <20170626201650.GA3595@katana>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:51498 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbdFZUQw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Jun 2017 16:16:52 -0400
Content-Disposition: inline
In-Reply-To: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> this series adds support for the internal DMAC used by r8a779[56] SoCs.
> This is achieved by adding a new variant of the SDHI driver for this
> DMA controller with compat strings for the r8a779[56] SoCs.
> Compat strings for these SoCs are also removed from the existing SYS DMAC
> variant of the SDHI driver.

Okay, I tested some more today. My conclusion is that the series works
so far. However, it quite often triggers a SDR50 retune with one card.
And that sends an explicit CMD12 which we don't handle well. I always
suspected the code to be imperfect, now I have a proof. So, that is a
good thing but seems unrelated to this series to me.

Another card does not retune and works flawlessly.

I will sleep over it, re-test tomorrow and if my findings will get
confirmed, then I'll give my Reviewed-by tags to this series.


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllRa60ACgkQFA3kzBSg
KbaBoRAAgwNnDzRIeg83wF2Xe5rHUNOYCAkgi1JSBp3gTdVIa7QC3/Pyg3UKU7P4
t7SQXoz1D/5NLbAuQQV0ESPHFUsOmRzxeHGq+cU/DqTiRVOsIThgw7182fnnfipZ
ZM1G2wG/gyi07An/5OKhTxtY0X+m/bCCY7Y/8Xd73YsOSBgpZrZyFa5saQhDuMAr
vXV4sP7t2g/BfMkm1GVlU1Tq67BwgyQ7//39UQTKfXO2t9NgyNoRYMufBS7UtDUK
3+U5RVX1R7y9T4ZXzwrkcjzMGbU1450Fx5Im7WbuAbsqF7qEwWzh4GNl6+ZqV9oK
VXdSvC2DQoYZoKdo3QrOT9POVpaAUELCb1k5M8EcvekjwbgZ/Ux1tfa1PoRhNYgn
EuEfoWNfS0CP1fZolwzQwtW8HNEbyImVTFcNtc6nlIm/71wOv4W0f/itSKIubGEH
wQWsS4I1qiR0hpNfr48pbBg+3JvlLRhBC5mogu+N/99Ovl4IlYfTuojKduZvC1JO
3cSxVOX8WxNKUaOOzIjFhwu8liQeBEEv2NozVHcZ6F98IWz2IJyfBExUuQFhFwph
Yg08IX5LpOtE8ireq3jy1G/wgedVCLWJk4TLbZSAiV3Ub5pZdZYBPzXwwabbOC4I
QFwOvHU/iHM89hMYQfOi8CCQR8kfq/VemRK3zWfDZsJxm3LsymA=
=njh0
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
