Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FCEC433F5
	for <linux-mmc@archiver.kernel.org>; Sat,  1 Oct 2022 06:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJAGoC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 1 Oct 2022 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAGoB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Oct 2022 02:44:01 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F86186026
        for <linux-mmc@vger.kernel.org>; Fri, 30 Sep 2022 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=J9kDdu4Xhq3zPjIqX/LrqapmX156
        sICYxulpSgXuzKw=; b=C2ELv2QVqIR3P67V/tdgrhal8jlWsowD7fdxaNgVR3sb
        x0Vp99ILYYzOOvLP7D2+EW1RIb1HXrYt8UxruYlIhmPBStjU5iuxlXAl7OsC2GH1
        rhcR9QnGeo5BbZCwfbYS3H9ZXIuTUYcjloJM90Ool5GVJ1v/F3s3q3ihw4KhuPE=
Received: (qmail 859038 invoked from network); 1 Oct 2022 08:43:58 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Oct 2022 08:43:58 +0200
X-UD-Smtp-Session: l3s3148p1@HdNXb/PpE9YucrO7
Date:   Sat, 1 Oct 2022 08:43:57 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: sh_mobile_sdhi ee100000.mmc: timeout waiting for hardware
 interrupt (CMD19)
Message-ID: <YzfhrXt2gj+J+WVw@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <CAMuHMdX_fQU5khvcOK-fuZoYArJpjT0057WGQ=t1=Ehf8+piqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D6bP5lXDFRikW1uZ"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX_fQU5khvcOK-fuZoYArJpjT0057WGQ=t1=Ehf8+piqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--D6bP5lXDFRikW1uZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 10:53:55AM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> When an SD-card is inserted on Koelsch (R-Car M2-W), I see:
>=20
>     sh_mobile_sdhi ee100000.mmc: timeout waiting for hardware interrupt (=
CMD19)

Is this a regression? If so, since when? I seem to recall this is
"expected" on Gen2, we ensured that it retries gracefully and
successfuly.


--D6bP5lXDFRikW1uZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmM34a0ACgkQFA3kzBSg
KbYeVxAAiHfjcSaqkG4tCN1FNeE0CTCS7FOwlLVm9ReNQGxbFZ+EdzkxCLjWdXUi
zj9St4Ymjsv4r0z0vTFr3VL7K2Xcw5x4wG8XGtKpr5AkLw2V3tlGDDvc5YC2saBe
ZwQAeBtMSzDUvPuM91ecAPyZa0isyeTeEtPvDXBk7UjP3bTBZUGljr4ivroRPg0+
SNPHLNTRM8eyGSoX5izaN/SpUBfr/9A15ed/or3KUrVLywBjb2TWcEmi/eb5MyN2
lz74rcrTD2o0YY8srEFWTxeS0Rjhv8HkeoLPRC9EUUeCZM2l3Tuss5bBOXLhn6OO
EOAU+waRSCXhCTgFSPh8VyY0TRlCCcHL76koUqS0RSdZpwgPNBrkhModsoHrGCG/
hPhaa1g1aOfci+dKMX6lmTNn2chYdg+uZDJ1oMV6gtTMq4wPh9Qm6nmI2XqMflcP
g4+DXEHTPkS7bRVNEa5ES+c2b4tFynxtmHlc+OAziUdDTfgiqJWNG293W+xuVYY2
ghaWMt4fqmbzVU6HFAKxfAmy+bGp5a/xGXB+y+KlINcPeywRuL4ShM5H9uCXaE0G
l2e3k4oOdrI7do5/eFnH6uYR5xg4rWgNsEYnxUwC8zXARKleYUGbFYGnDpKovCE4
hgo4DqTKKNHLE1zh/yXORuEeiKZSr+NRUqgZZRH4DmCejGLmlWc=
=7tFQ
-----END PGP SIGNATURE-----

--D6bP5lXDFRikW1uZ--
