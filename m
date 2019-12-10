Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A6C2D0BF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1138120828
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLJWVl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:21:41 -0500
Received: from sauhun.de ([88.99.104.3]:42794 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfLJWVl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Dec 2019 17:21:41 -0500
Received: from localhost (p54B330BE.dip0.t-ipconnect.de [84.179.48.190])
        by pokefinder.org (Postfix) with ESMTPSA id A76B32C0616;
        Tue, 10 Dec 2019 23:21:39 +0100 (CET)
Date:   Tue, 10 Dec 2019 23:21:39 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 0/5] mmc: renesas_sdhi: prepare for recent HS400 updates
Message-ID: <20191210222139.GC8683@kunai>
References: <20191203200513.1758-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFpXanmDQq-minnX4KNLVSMatOQRnuT59sDdAZC_MDkp8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpXanmDQq-minnX4KNLVSMatOQRnuT59sDdAZC_MDkp8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Applied for next and by fixing up the comments for patch 4, thanks!

Thanks for fixing it up, Ulf!


--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3wGnMACgkQFA3kzBSg
KbY9JA//YKcg0TY5VmstRvyECWMbNg3r+7gnMK64TVUO7p1x6RwxG/bmDTWux9fv
aVEaU6J/tEvu5F/nwSeWIdKwwPjvPn3BgLD8pkowztjXKUbGAVGNhVBRGx99WmLd
QAM8zkkp2yQ4QeS7bq9y0ljbKhzIWETFRiU7w18CgRmJLKtIvGuyM+5mSdoe89AK
fuX8kqtO5l9M6/j04fMNeVb3wkMX5hkk1eHvmBZ+MMCNAUwLaSk4UReX1OPtCGTL
Lz87J+tgfvxrfBw1FmC2afvUV5cRyrY3NPN5eBAEndkamH2c1U8DSuyvBVvOGHVn
fbfKmOWlCynGOFVaDiSq3tDYcVvODrAINTF6YUmECOuYr5Xt/rBmkk024Nzfl+VE
eljvPO6OyHLt2K+Ayu777EMShfnm6IF9p9t/MZsOjaaO5vidUW3gyLg17XaqmouE
foLituluMEGe7A6gTlqm9GUN+S4R5+8siDbk1/0JJ3Y4lbsUJ4QM0X7gl6XvIfzU
gA/DE7uBQw4INBEJekUc/cSjnmyD8Z20eMXymDB+ebzXcrOMnSSkPKe6YR65/nGK
vvG/cGCtI1L1R8h0q4fDotG3+Hl6+IPltC8hhO2eisGwl6ngF3eLAgtuwKhZGFRc
EMgprYysU4KA4fc44AFN9oT/BeaC8sGam8WUe0aD4u5Ef+5WyDs=
=r2E+
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
