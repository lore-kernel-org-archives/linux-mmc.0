Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22010C77B73
	for <linux-mmc@archiver.kernel.org>; Wed, 31 May 2023 06:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEaGve (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 May 2023 02:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjEaGvd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 02:51:33 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A4123
        for <linux-mmc@vger.kernel.org>; Tue, 30 May 2023 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=ovSGUKQv1yLGUe/1wzGBQuvfA/5a
        /ca60ka42azaUX8=; b=dYfszS2Lg5y2yc4xrp04U++O3sXqRxbUqRFNjrZ1VVGi
        iZhKZpgRIEco40CSdbB3am3F1nl5cZERw9tJtma9Ry3s5DVq49wkOWTzIETU8TX0
        vPnWoahExVneuk06jCvCUTzSWNxMkr2KbP0w6/hN4noiwGkvviwT+FqKLixSJ7w=
Received: (qmail 1181487 invoked from network); 31 May 2023 08:51:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 May 2023 08:51:23 +0200
X-UD-Smtp-Session: l3s3148p1@+oJOv/f8pMAujnsI
Date:   Wed, 31 May 2023 08:51:19 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: RZ/G2M Hangs when booting some SD cards
Message-ID: <ZHbuZyuQ+uZKul+c@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
 <YlR9TCeV8FJVu38U@ninjato>
 <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
 <YlVApjtNOBLgA0hy@ninjato>
 <YlWUV1SW4lVLjIZi@shikoro>
 <CAHCN7xLLsXikG=8zSM=udqnqwvbkqkSLH8iYcuLiLVvHa=LPPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3UAe18m39CeG+/90"
Content-Disposition: inline
In-Reply-To: <CAHCN7xLLsXikG=8zSM=udqnqwvbkqkSLH8iYcuLiLVvHa=LPPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--3UAe18m39CeG+/90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Adam,

I am very sorry that it took so long until I am now able to respond.
First, too many other duties with higher priority came in. Second, the
card didn't fail 100% for me after all which made debugging still
challenging. But it failed often enough, so I at least have a pointer
now.

> From what I have been able to determine, the U-Boot code explicitly
> disables DMA during the tuning phase:

...

> However, Linux does not disable the DMA, and the value of taps is zero
> and the tuning ultimately fails.

I disabled DMA while tuning but it did not help. It finally turns out
that adding a delay after each tuning command seems to help. U-Boot does
this but Marek (the driver author for U-Boot) cannot recall why he added
the delay. I'll send a patch in some minutes.

All the best,

   Wolfram


--3UAe18m39CeG+/90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmR27mQACgkQFA3kzBSg
KbYR1g//X9zxWSaT/uhB5h7RerYeaHLhXDHkVJfQtrewRouPAuHIn35pAMp4SE6A
9+1JnDxfuoUix6kxQBucqSm0GaXOUoSK/vwZmfUlRNOpp/NwVEihYHtpHTPsdOvM
ECdLmM58AVobD3leE51Hn7fDSA7ZyMpv0H87wIXn4hViwMRSu/VGh+eNT+bvHTe8
UX3uX4hWqyipwio/E5dMh+RhyJRiz9w9/3cH0pbI8VU2lF86w7N0cfUB64lYgbr9
Z/lU6N97+oRroaL5WKmafu8TSSQhvoTUASgXYvejfD72Z9cMD8cy/sUStmguwxaR
5k8/bsOSeEd3Ia3YmZGye9s072FW0yOL/HrVJUZoXR8bvV6elfvhvBzXoruP86El
aVkGxgcgm1dayFj0bUX3yP5bEfvacf3aVrwEf64NldWA8g3PVHsJAaeBTVyK5RTn
6je5MxrcAUIXOAvqjiDH/jw0kgW1u6fgchDy1AjwJ73pQw8KZfI0iEgInVXxK3+T
zrEGu2/Ax2uqMPCexYBNU3dktuOxjECZL+G0gE5QytE98dEkZeBfB2gBorqwpOPU
Xq1OjnrKVULCanlMDMdvgrxlRxokQAtALv7ne8JlDSHkIsIyonFhzm6EWFPYLh/x
idonD/bXPDlFFX5Wuv6yWz0asQWvLOvrmmkqudqICHGhVPMMW4k=
=OKOY
-----END PGP SIGNATURE-----

--3UAe18m39CeG+/90--
