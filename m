From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Sun, 17 May 2015 13:06:02 +0800
Message-ID: <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
 <1431673364.13197.10.camel@transmode.se>
 <1431674695.13197.14.camel@transmode.se>
 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
 <1431693634.13197.29.camel@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:35652 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbEQFGJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 May 2015 01:06:09 -0400
Received: by qgdz60 with SMTP id z60so282558qgd.2
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2015 22:06:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431693634.13197.29.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> How about this one:
>=20
> From af6b18c056b6064424bd2ab1f9989bbadae5e701 Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> Date: Mon, 20 Apr 2015 22:36:55 +0200
> Subject: [PATCHv3] sdhci-of-esdhc: Support 8BIT bus width.
>=20
> esdhc_readb()/esdhc_writeb() did not adjust for 8BIT.

Do we really need this for the 8bit bus support? There is already a specific
API for setting the bus width, this change seems unnecessary to me. That is
also why I choose to revert that patch. Did I miss something?

Thanks,
Kevin

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVWCG6AAoJEJNY7TDerrFx384IAKEDbCo8PyYkoITG202eW4BP
1fJXdjWwf0DAGctZ5DZtJoiKg8dlrO6SOj9rdkAl9lDXxP0xEEWEbY2kvV7YQ/80
R24is3SakAWebe+qw0qIDGSF0Xdn0PPO8MnO0P5EQA4o/Qhr9QsK4mlH+C4JHhvY
qd7HzB4DckRQGuUmCfWgf/aNdujRG4NuuJ8g5xXLhYIDLHigL2HQH/nG32PiyBTH
LLVljRgKbiZsSnMg7cG0BDgRUn+QBOhF5VBK5k8D6pmd1jlB/ot9MArxgFXaIsc+
SqTXtOiBcxFIfMn1nKmYvn4jYJg3IXyp5/xyAxr+1i50XGexemwFLPW26VkhgGg=
=2G24
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
