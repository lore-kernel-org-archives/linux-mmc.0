Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE14CC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 10:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C452421527
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ajP0QiV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbgEYKEN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 06:04:13 -0400
Received: from www.zeus03.de ([194.117.254.33]:32938 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbgEYKEK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 May 2020 06:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=PAB2mIN9js8S+ABcBEcyyxPOwwt4
        yXjmItbyOUrDGEw=; b=ajP0QiV5Pulri9qjkr8lfwaCWhU/eIOPnkJhpDfSIVDG
        aqGHQzzqN1nBVOaI0nExurxqIURuCeIfg2jA8pxlxvgy7Ex4suWT+uWgtvJq3kKC
        HU8x3WKlEBUv+Thd1aVZvPLsq5ZPRObhdjN01JJuPBMFOxN96SK2JY2oHb5Ubrs=
Received: (qmail 2286621 invoked from network); 25 May 2020 12:04:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 May 2020 12:04:09 +0200
X-UD-Smtp-Session: l3s3148p1@UTKUGXamUOIgAwDPXwX9AARUgaNQd9RX
Date:   Mon, 25 May 2020 12:04:08 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started'
 while probing
Message-ID: <20200525100408.GA1149@ninjato>
References: <20200519152445.6922-1-ulf.hansson@linaro.org>
 <CAMuHMdXc8jzLoKbb_heX-Ftb+3RNOQRtEX=7NS4KxWdxUfBcwA@mail.gmail.com>
 <CAPDyKFpBo3T-RhszJq8wL_wTzsVmo9zz=Ng6G=2R=Jx2XyrdFQ@mail.gmail.com>
 <CAMuHMdWX8PrKA-VNFPAegAxE5vb_xDEnqSoytksfxPSuYaiv2Q@mail.gmail.com>
 <CAPDyKFrzY67it3UbDDTCe-z95_sKO5EQaiGm=6NbmPDJ8fFqcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrzY67it3UbDDTCe-z95_sKO5EQaiGm=6NbmPDJ8fFqcg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Note that this does mean that all PM domain providers that do not rely
> > on pm_clk, but have their own start/stop methods, need to be aware of
> > this quirk, and should take care of reference counting themselves.
> > Fortunately there seems to be only one:
> > drivers/soc/ti/ti_sci_pm_domains.c.
> > Unfortunately it doesn't do reference counting, so if that PM domain
> > driver is ever used with a driver that calls dev_pm_domain_start(),
> > mysterious things may happen...
>=20
> Good point. Perhaps we should document this somewhere.

I haven't understood all of the details, but Geert's description sounds
like we definately should document this. Anyone up for it? Otherwise
I'll dig more into it...


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7LmBQACgkQFA3kzBSg
KbbZ6Q//XuzlSd6Ye13IiiD8pZ0SmiDXpUneW/GZW0c1xoljFBVBO0M7/soXDFUF
KVsSjMEKA9J51Je3ztBHyEyrfvSHX4jQUGI91jedTLaAMfIaXpw25iBi6FHvvpoU
WELz+f/iRWLyix8E3SJpQR0sdf1lXVSvLwztoFJLLdOOUF9WHwvjJqr7wlUYM9b1
+2MDM+8tpzcUZj02vclCi9tMu+zH6UoJyBdy+PYlM/KsHgiJbUUIQV0YnI4VpGLq
6Vh9oVUXtzIS2gqBAycicP8MXSmcHKlHxXG3zZYvw4z24pOYo/M24yMeM26m2a/a
/hH7OLD++wBcWCxDxSCLeF/6rCd7oy1/kt1GhCsFGYvkhwQl4IJTxEIc4+BupIOE
QlBIq4gYTtPnHDTubpiHMT7miMP0eanY9Fg1zygx8AvA4RXcxkyX8RCoMXs95INM
dVv2guFvx/59yo/NJS0aW/Isw87paS5vnIClPGd4AX0pj0mUZkiDb+1u+XD9Ukyn
Sgr6prKLOiCxtPnF9Ztvfxg5tbr0uKm6tjkEpnPEPxIa3gwJ5y+xJlVvNy4NzSX6
OVSw+MWj/rgs3pyrHoIbQ1YnjLoHXVEMNNecPfKcTQPb1WdLSnAn0D7gQoAGaJMQ
bhZFS7uIHQj9MLZdHbO1a450zWpnApr2PwilTS/7L/axMjSdfKE=
=hs4N
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
