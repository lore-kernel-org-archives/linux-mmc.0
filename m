Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39680C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 15:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiDLPEK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356820AbiDLPEH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 11:04:07 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4455F53A72
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=YmSscQGIr0fenF5PApaAiIJlZf2O
        KoUUqeenesSMeao=; b=HKUOJogWW+KdUR6XjGsca4uFlC34C1u9NsmS5dcj9cc/
        yghszCyW/OPSso6b95SCBkrKFIzb1WxZ23c6ivdeIDJJsGk7NmpWs7JXFkezptXN
        ouOEMWemmEeGknrWdE6cbWjLjcueWG/Ob+WqJaQk67VB/qZEIzpVqbom2yGbxRg=
Received: (qmail 1088823 invoked from network); 12 Apr 2022 17:01:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2022 17:01:45 +0200
X-UD-Smtp-Session: l3s3148p1@d7DJVnbcJtMgAwDPXxStAGpcStzhFfdv
Date:   Tue, 12 Apr 2022 17:01:43 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: RZ/G2M Hangs when booting some SD cards
Message-ID: <YlWUV1SW4lVLjIZi@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
 <YlR9TCeV8FJVu38U@ninjato>
 <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
 <YlVApjtNOBLgA0hy@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="foCaO6i8SYDHLAha"
Content-Disposition: inline
In-Reply-To: <YlVApjtNOBLgA0hy@ninjato>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--foCaO6i8SYDHLAha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Anyhow, I'll report back with results from today.

So, no news here. When the board is "cold" (hasn't been used for some
days), probing the SD card occasionally fails, but after some reboots it
just works. I don't see a pattern.


--foCaO6i8SYDHLAha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJVlFQACgkQFA3kzBSg
KbaOBRAAmv8TbOSx+CIcNaJYWOLQNiQ+30Rkec305cNGYT5ZRpLHhB2wt9TK8N7F
53m7NzlKJKPIq5GJZgmyZlenUJG5tpRcK/sMuSisD8dhm7seG/7YvkUuHoVpSuGD
uSoLLox1cdfaWgcKq3Z9KOiTE+2yvhtTWqLqKnQC82GqfkqRC4mQuj472Mcra6bC
BYBOUARC0ejRe/u3GDGoSMT7i5sIeEMLJL7nL/7FpPznRVd3yzN8oixzgGg8R+kl
/yWvCEKUVdQsSA9urXRApQwYSwkZMmiD+j3sKLgUbSB4kDhkaHVuKtj9DiFvrZ1U
++g2KkzSiEsadmfpUf66kL74WA9q5j4K8PEBYS5uMjKcrXoc77+DJCOFuGUCdFuU
LR2z78OI27cuahe+qO4ilDpigxAk8A/ZnYTNX1rVabe+Ge2kl05EdXdiJLbgp0J0
PCf8EJB6Pi2zrtg3AOjJ8L6Sj20m2cVCGzWGRuwEYbZ3PJSYA5x+1R0ADvMP/GFU
vM15Ie8p+V8QR9qGw43fV/ce+GGzllGIDsyqn3A+RadgtJDk3WQDG7fpJYt7EeV7
IvzbsyH5sEzCl5AZQhzwvmfgRsLMXTTUOHh6asbh8rtO6fs7nBW4rwIqvh3RKT8X
SRBFnqSC6tsR/fIIbJ8SCfJ6Cvp0uqjl5SSfOTEtKovW3OSl4Ig=
=en/p
-----END PGP SIGNATURE-----

--foCaO6i8SYDHLAha--
