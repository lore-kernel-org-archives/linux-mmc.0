Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E9C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 20:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D5120823
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 20:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="tWAcsHni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgETUcW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 16:32:22 -0400
Received: from www.zeus03.de ([194.117.254.33]:60964 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgETUcV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 May 2020 16:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=mXl7smbdveSJQbHulzBTxhQgLWsq
        v0R7IK20OzufJ5A=; b=tWAcsHni7UwfZOkryUXQixoWzvvMLgDsYM6HJK28z0ru
        GWHDsGU/O3Wg4MWjExVeo3d4ROxoSamJc+if3HDdRSg8Q272/JxoMyaX0safbk7b
        M+MblU96v8I6P6mh0HNyS2w2PrPGtcaD/q/IDoONyyIRGWQdgn5mzB0sGa+dtTQ=
Received: (qmail 779749 invoked from network); 20 May 2020 22:32:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 May 2020 22:32:18 +0200
X-UD-Smtp-Session: l3s3148p1@kIjaShqm8KcgAwDPXwjBAPZbXQqYFqkx
Date:   Wed, 20 May 2020 22:32:18 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at
 remove
Message-ID: <20200520203111.GA4634@kunai>
References: <20200519152434.6867-1-ulf.hansson@linaro.org>
 <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
 <20200520154906.GE5759@ninjato>
 <CAMuHMdU99uc8fUO7gPVh1K-ZwqgpqfvFB7fVckrKzC8N-8wa8A@mail.gmail.com>
 <CAMuHMdUdT7MJkArMNcuX-uaryqR3qALfJSDJapBaXy8F6isffQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUdT7MJkArMNcuX-uaryqR3qALfJSDJapBaXy8F6isffQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Commit 9b0d6855e756b60d ("mmc: renesas_sdhi: enforce manual correction
> for Gen3") fixed it.  However, there must be other later changes that
> have impact, as reverting 9b0d6855e756b60d and reapplying 7a7dab237027
> on both mmc/next~3 and mmc/next gives a working system.
>=20
> Let's call it a day, no more bisecting today...

Thanks for the work, Geert!

This non-deterministic outcome already convinces me that we should
really first try to reproduce and fix the stalled SCC case before we
remove the workaround again.


--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7Fk9IACgkQFA3kzBSg
KbbrLxAAkd68XOHdf3IOsTepqFYJ35bSqfyLBP5n7R2CEuxe5D6ralo6R9jE0hfC
udmHiI8eCQYq1AO1yHORnSc2vqYndFMOwZIlP5kdqSNIOq9Zjm+vhjEjekgasqwW
u+rMZDnbxR3ffXAwl48RDyx719ueOhp2V8AJZ0lDyhK2GyXCkq1HIhXu8xRW6SIG
7QQCGAEfV4hRPVDa+6YboCPGKTvtLE0hW5GqIU4Lrl0gLV8JzAaExMedwhAjwWzh
GYodfyYn0Sc5bVp0d2C9rnI5hLz6+lolpcnU89r9WYsWASb0JRPbrXfFOo1SibQE
xD7zvHFS8WSoaeNmT+UPPB2zRDn9fzCLotiTBBxnJHlKb1GC/A2hmp5PGYLBJZXe
pQA5VzSCkR2j16Tv7txHal6qLkQa8EQoIkf4+guddRUnCqYHuSMzKXe8TeS0piPg
FQN4sH4+aa2C44xrx6415BAofWmPyW6xU/bcJELJwxXYiqqF32pMFxrDSJeJZXjw
SZA9ZrcG4xsY6I/hw5cIlnQAlqWGWt5B718nOIZqF79nffca9a/VGaUCXUYyGymP
KVZWX2Ceqyw+fOpgqbMQT+DNz3kkZHujuFLSvXuegCPBWz1FicNOeUAYeTUJpbmV
8sDADPtBxyE6HyYT3oXRuEShnu1Y/ARXM9A39T+KPhdOy9wcdvc=
=pDbP
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
