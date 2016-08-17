From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/9] mmc: tmio: Add UHS-I mode support
Date: Wed, 17 Aug 2016 21:08:04 +0200
Message-ID: <20160817190804.GA11930@tetsubishi>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-4-git-send-email-wsa@the-dreams.de>
 <CAMuHMdVyNsm+hpoJfjxLkKt_5zydx9csgPB0zqCdtPMipqmFFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56937 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbcHQTIb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Aug 2016 15:08:31 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdVyNsm+hpoJfjxLkKt_5zydx9csgPB0zqCdtPMipqmFFQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>     [<c02f9d04>] (__mmc_start_request) from [<c02f9fa0>]
> (mmc_start_request+0x104/0x118)

This function calls card_busy only for SDIO cards. I assume you don't
have one inserted? Maybe the "broken-cd" property doesn't work correctly
and causes side-effects? This would explain why it only affects SDHI1
and not SDHI0.


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXtLYUAAoJEBQN5MwUoCm2mhQP/iFegrzc0jZC2fxb8HFtTjIR
PKVeubFWEXxuczir+OxFuX/VKfb8Fr/Jppnsn9ZIhLvpSkUHskDkE+sJpaDfwaDI
NGBs97gSuZcHC+KCuY1wbaXdmnXYLpWfaRjBPSNBMCG4Knf4QAGh7R0pVeKXzZ4G
yu3oExaJ5s++rlms1mszBW4nFz6VqXFvqTg5HGvNUpBgmvlIWkVJTpkxR7bqZbnS
vRG+dIEgDEDWlcfHKLacaIFieB1SZ2CQnurgQh3NiCxgDAdNlT4DVZyNzeRYval8
B3q57cTZhEFt9T9mEsSJ7eDw7lwxKOlTn9kdEUlSfi7/044ucl05B5lCoohHrPtk
wD7SqFeSQ1jJPJKWH6srsDlrGEdLZqE/xaqas+LuoyXMmu8g5IgNYN8iFoOgXHNc
KuaAnzJIt77yYRwlo+IfrqFVLwWQUx2oJiymC1YOX5DP/+xYEEP1QGNIdEi8cEsT
qfD0vdy5lxCSAWOBwD7DoQ/yBVEzje43uQB0VaS7SYfVxtPl6yL7UwZaCV/T5tyQ
qEbhPuMntJWlWFbbrDsTfzYhgy/eZUb/FlkJ0ACkv8qIyd5tbC5TdsGo4LPuPqB8
HwZnKldM3+2zpspkmOpMVKw8zkQNSU6D5KfzmA+0+8YbiP1gBTWsSNzsBh3I+zHv
yrPQgv9uzt/xF1ltaxpL
=X+Ly
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
