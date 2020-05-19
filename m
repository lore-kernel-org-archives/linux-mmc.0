Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30413C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 09:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C873206D4
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 09:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aWHSvZ7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgESJJw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 05:09:52 -0400
Received: from www.zeus03.de ([194.117.254.33]:50744 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgESJJw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 May 2020 05:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=0SYJk9+3u4SBFYrTG2RiYc79thOJ
        IptilkttCtpyR00=; b=aWHSvZ7yKgeBfHVHB527SBfobtwsk+O8ceEcFG2aXZHX
        IQUCATtGzj6gSzo5E79SIqBVTaH39WSQyblQ/5jQndUfZ43avRW6BKmRGtNLjOQ6
        SNS4HdzWNIdKuXAneqUy5AnE9AlY/syCVGsU8ikpDEb8ElBTmAnXxjYgGoC1z3E=
Received: (qmail 187589 invoked from network); 19 May 2020 11:09:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2020 11:09:50 +0200
X-UD-Smtp-Session: l3s3148p1@579PpPylBOMgAwDPXxCmAFNwG0mTH/5q
Date:   Tue, 19 May 2020 11:09:50 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started'
 while probing
Message-ID: <20200519090950.GI1094@ninjato>
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato>
 <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
 <20200519084653.GF1094@ninjato>
 <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 10:53:28AM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Tue, May 19, 2020 at 10:46 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > > > Can't we put it before the custom clk_enable()? And then clean up
> > > > further like this to have the main clock only controlled via RPM?
> > >
> > > I understand what you want to achieve, but to allow that to work we
> > > need to consider the below things first.
> > >
> > > 1. If the driver is built with CONFIG_PM unset, then runtime PM
> > > doesn't work and hence the clock won't be managed by a PM domain.
> > > 2. If there is a platform configuration where a PM domain (genpd)
> > > isn't going to be attached, then the clock needs to be managed locally
> > > in the driver.
> >
> > Similar to what Geert responded, for Renesas SDHI both is always true
> > AFAIU. Geert?
>=20
> For Renesas SDHI, both are always false ;-)
> I.e. CONFIG_PM is always set, genpd is always attached.

I hope it was obvious that this is what I meant :)


--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7Dol4ACgkQFA3kzBSg
Kbbn0Q//aby8zly97QeY6Jd4IeVvEIO41MhfXmb732fWS1flQZNZ6905hwtsVeiG
L5expCq02FGM+VuXFEzSxZX4lHLbUx/KbgDxpgufz6Tl2WWG3mLM/D4zGcY07wUS
Lw9Z50pv8v6/GmHa4C7mzhyaLu3UhaKEFmfdtxZjZanXJ1sJ6xToDpAeoBFqCbkL
JgdjSw6H5N66CLopsjAh+DdmbNkQL0/sFDxG5h/SX94mBeelB3OOMmsevwiwaUr0
EeAaG3HgxLmj7zSe4koz19ShfZOtnrYxMgjjpBfUi3ThuFC/YWdQY1scR5r/d5+h
APGrpT0gdmD14nsTAl7SwvkeVVH7n1YhUn090Y6c0vuxP8zQnXFgOJYRq7rtunhM
3eBP/vzBFmZ0k7Djg7x59hAEua69pkralV8EBUFh7elfeEdBPUqvQtUJINyd0mo9
0RE/b8dJxwPSO+r1+67Rd6hPrCMYxUR0hDAEy0JDc6AHVmzTxIbheKAR0P1ldW3G
JL8xj9RIBUj0Qm47o8sFHRKSTfrtIriuA0/wTi5yJ3mwJmnYph2XUpFFYhfZZHRK
IE6y9SRZf0COMDZG9wg0aWHHniLPkOiz6RVRk3HCr4kCEkZuil5OHXlt+pSJ6vmI
DVTUXCcFtPl0NqpDYzzaYpWMNhzHi1on8obTxyj9aTr1cPLQvHM=
=6R1c
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
