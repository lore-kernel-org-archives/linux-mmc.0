Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F8EC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775D3204EF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="y/KIpgwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgESIq4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 04:46:56 -0400
Received: from www.zeus03.de ([194.117.254.33]:39862 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgESIqz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 May 2020 04:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=5jl9uMw3o797162auGC9yh1M7ohm
        QAKGrTifZlPrcYM=; b=y/KIpgwU/z1DWFbxYETSDxjLtqADjCKCwEZfpjPugJqB
        pnfQioFOyMa414LizlKWeFmBZuycpMD9f/3p5jq+vUGeasmYzjyYplKsLdfTvnRD
        rTGSIrUm1GR9NPpL84uV156vAhqEQo25Uz2KGmEVEjdmK8PSKlbJ7wl86HQN27A=
Received: (qmail 179869 invoked from network); 19 May 2020 10:46:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2020 10:46:53 +0200
X-UD-Smtp-Session: l3s3148p1@Ygk7Uvyl8OIgAwDPXxCmAFNwG0mTH/5q
Date:   Tue, 19 May 2020 10:46:53 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started'
 while probing
Message-ID: <20200519084653.GF1094@ninjato>
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato>
 <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Can't we put it before the custom clk_enable()? And then clean up
> > further like this to have the main clock only controlled via RPM?
>=20
> I understand what you want to achieve, but to allow that to work we
> need to consider the below things first.
>=20
> 1. If the driver is built with CONFIG_PM unset, then runtime PM
> doesn't work and hence the clock won't be managed by a PM domain.
> 2. If there is a platform configuration where a PM domain (genpd)
> isn't going to be attached, then the clock needs to be managed locally
> in the driver.

Similar to what Geert responded, for Renesas SDHI both is always true
AFAIU. Geert?


--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7DnPkACgkQFA3kzBSg
KbYAlw/9GZZiSCDvnmCFMrUELeObGHGXYxlg5TlRiGOmmVLolRrm44rzh9yTrVKs
YuDKuoNNWks8+/khuKMCETu41zvxol3njx3EMzVVGV/o7X6xIEz1+lyIxU+gKe7T
b577r7/vfXUzT4GpeGiIVyLcatot+EWjuaaPoN0DfDaafu5nvOz6/y4bEk6V6ABa
4/YJI1RW8nkhgp0ELnO9GG83i/h8q4rMnwDfCp41XzECzzR1T6bYeJj/ktoG/Bzh
i2hZKoxbO6fCg2TiM1jSYVCik836dpKPyZOJYTyqP1n1l3aLMEsNHEL75ojhnSmG
yTHUTxPIMlOTehhKUJK3yLrGNTvgHw16hFg4153CyRyKqhOS7PYFISB250vzaYTn
LJe7kRrHLPaLiHKSxwOeZmpOe9zF09UWKlrFx1DD3kpZYfmhbxfV2clKgpdtugol
MkMiJO9aCWVJDgjwu5BrkRp78nZ91FuRiZIgtHdyRkv6JBtLOQtVQx6ZLWSspfCn
CzhJ4epxuetFj5xyPyycKicb0g8Z++voOlFjRJ/GNw9mQVIAT2vJaKNXGCLYWmbA
S4euE1Pcn2XABs/nPEhNRPAGE0+nEg/7X47iBtaIkyzI73LJCLy6uMUbUjQSOwrf
XE2TPC7SOw7qvlySzYjuIIS9PcGOlthDd7y5kiH+3Ga9bebtugs=
=TLWP
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
