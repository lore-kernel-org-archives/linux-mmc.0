Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD6CC4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 08:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7A9610A7
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 08:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhHZIRj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Aug 2021 04:17:39 -0400
Received: from www.zeus03.de ([194.117.254.33]:41882 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240144AbhHZIRj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Aug 2021 04:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=RJo39oy741qZCW0ZbGmJFq0iuHhh
        A6+0KVBYL9ke0MQ=; b=L1nXEQQYGrqfKqBaWX0bdVuu2PfrEWgXF6U+u8Q/dRcb
        gpuWElCbwH+8Lwk4DhiXGp8JUAcP3bgyXhukGK9cpktEfVmZ98AfOIaVohazahzO
        dsOoZgy0NbsBLJEMtX7/kKpbiIZ/s5aURYQlIqbmC26KVPbn1GRgLGMvFdXTLUU=
Received: (qmail 925646 invoked from network); 26 Aug 2021 10:16:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Aug 2021 10:16:50 +0200
X-UD-Smtp-Session: l3s3148p1@R5vw/HHKIMIgARa4RSUSAccDwLt/uLTb
Date:   Thu, 26 Aug 2021 10:16:45 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 3/3] mmc: renesas_sdhi: do hard reset if possible
Message-ID: <YSdN7YWXwC0HvE3L@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20210317091622.31890-1-wsa+renesas@sang-engineering.com>
 <20210317091622.31890-4-wsa+renesas@sang-engineering.com>
 <CAMuHMdU6=rTHjvcgK8GBzd3OL_9YFqV77=KsAEGJvAVapnhsOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xeongPL9vndL6v/z"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU6=rTHjvcgK8GBzd3OL_9YFqV77=KsAEGJvAVapnhsOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--xeongPL9vndL6v/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 28, 2021 at 04:36:17PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Mar 17, 2021 at 10:17 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > All recent SDHI instances can be reset via the reset controller. If one
> > is found, use it instead of the open coded reset. This is to get a
> > future-proof sane reset state.
> >
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Thanks for your patch, which is now commit b4d86f37eacb7246 ("mmc:
> renesas_sdhi: do hard reset if possible") in mmc/next.
>=20
> This breaks SDHI on koelsch (R-Car M2-W).
> In v5.10, v5.11, and v512, it works fine:

I think I have a fix and will send it out in some minutes.


--xeongPL9vndL6v/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmEnTekACgkQFA3kzBSg
KbZA3Q//SdJ7hP34+geEDyzWnwrw6zoxdZGpiqiErooaZ/eP7+Ecobpjjg5yNc//
ais5HKTG20FRLOyfZ35+RP8ixInR0w8QeeJQENdf+OLB+wKwMYhVLDklqLg3uXyx
KZSaic63EYLYlieHul22DhoMou/uz8vWIh2Rjc6TrItV71RFZLb3GVv9//mPGoWG
IRcmor7xVJ9U2/W7d5zq9sKk8fZOMam4mYl6WG7MsNEeWWvHI9IUYgs302jLuD+g
GzqixDScE+zbuMMAJQolWOYLFokAic1+MA0eRLUxpEfzftHNgJZIKc/ybzvbCYmJ
8HaQ26St3ck3I9FmrpanQyXfAtDRoM7Me0aJOtR1CsrL+y36SsR20gT4YelumaWF
YZFQa7Uv6ICVB3lSPdmOMAVmJf8ubzRv55OzhvPeIyVDhnNMvyuzzC8G+Rakve94
HJqj0ITqBd/gpRbsvwsoOBF8Zl4JcWsVKE6ZhRcFA+h97Kc8otQSN1XsgmrWquYC
n9qneCUEK4QOQrm9HGIW1tTn613ws7XTizPNQ827NRIyQ8zdIDiSKrlxVMgczhMe
6XKFWYknTeiZgsWXsEiziYCyHYantsHzDJImN3C6M9OLxAJ05/r+wSaF1LfKZqKt
aU6ljWUePT1vETrofwqE3A5n1KB5ki0JlZrRdRUpdeWIEW4RDTc=
=akwU
-----END PGP SIGNATURE-----

--xeongPL9vndL6v/z--
