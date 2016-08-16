From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/9] mmc: tmio: Add UHS-I mode support
Date: Tue, 16 Aug 2016 21:55:15 +0200
Message-ID: <20160816195514.GA3998@tetsubishi>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-4-git-send-email-wsa@the-dreams.de>
 <CAMuHMdVyNsm+hpoJfjxLkKt_5zydx9csgPB0zqCdtPMipqmFFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51888 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcHPT40 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2016 15:56:26 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdVyNsm+hpoJfjxLkKt_5zydx9csgPB0zqCdtPMipqmFFQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The first SDHI channel (ee100000.sd) doesn't seem to be affected
> by the problem.

Hmm, I sadly don't have any docs about 73a4 and/or its SDHI variants.
I'll ask around.


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXs2+iAAoJEBQN5MwUoCm2RakP+QEXqQ8oTsgIFyGDBqwmRCGH
s3Uql6NY1s9k2aEFzkL4M+zu6LYB6SjQnnUUaBKb7oUD6wauFUm17AmwDZDmbAb/
qkINkZegoyTxxVq2+No0dytXD1Q5tf+Pv9Ol3pDbPSZmrAKIlCCF2WRC1qTwKMbh
C62RQKQShk8UAWRXtlm5lO6XYczTRWFphjFrdHs36TjqqctjLfLF6B9mfS3cOZN7
WvQcMx+etY9wBJd8gi5y8+rlV8rHRLMpTFeZ14YybP2O1p2TSKcuAa6PxvHl3RlM
TNw7DHYAJNgq7gYSYMpPWlD3f30mvKOFMZEJZ7GutCb5ykrx2Yi35sOuLnIL1t4y
xmleJWolUVraczecVGImn6r9YnwBWFl4wRCWsBnGTihW5PR4WcH/Tt8Ec0NDV/e3
VM/zOzOT7xBehvvVOVkhxibq9yiddH54Buo6EXaaN+xrFFOtNSZm71SNWYgeYClM
Kf0DH/crWp7DLcfQQ+TuWaniQZxVO6ngm0Ph+naQVQvnfK0/fOX/eFuaRUgPTfYw
UNzgnZfTdYhRTnx20k+t8qI6NMY6sBLEW6+HoxhhuVCYmZX1bmhuMv6IqR0IkYNy
uylWhbJVLU7GjmgQ99O83g0PokoYmpjVikqCrZxv7qP7hAaNLElp0VuZZBwSdMWY
HBy9JtNZZFygwyHxAQZM
=pr5X
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
