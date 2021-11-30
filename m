Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C426FC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Nov 2021 13:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhK3NNs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:13:48 -0500
Received: from www.zeus03.de ([194.117.254.33]:34450 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238799AbhK3NNr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Nov 2021 08:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=NtYDnFa126rpafwLK/HDUSraXtg5
        SbNjx8aQisVzeQ8=; b=SFhA+/xml+BzbpqxELkSA4pscCZy1Jn9IDFIjkOUdBdN
        IO0BY7Uc3/o9px8mT6I/vkpIZPJ7ZiUBIo9mXIeWDEX8lEfvqfNOwXMOt8ChrlEl
        lLapnefM5cpRzvGUOG/LDpJiVPcOZHQHqZTJjzfuHLiQJwzAT1gX1ZsdNimMfss=
Received: (qmail 3806388 invoked from network); 30 Nov 2021 14:10:26 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Nov 2021 14:10:26 +0100
X-UD-Smtp-Session: l3s3148p1@KynjRwHSxOggAwDPXxCYAODRq/Cv/3uh
Date:   Tue, 30 Nov 2021 14:10:25 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: [bug report] mmc: renesas_sdhi: abort tuning when timeout
 detected
Message-ID: <YaYiwb/0L4pckgV8@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, linux-mmc@vger.kernel.org
References: <20211130104121.GC5827@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HOS/AFGgsfd8kJtB"
Content-Disposition: inline
In-Reply-To: <20211130104121.GC5827@kili>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--HOS/AFGgsfd8kJtB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>     695                 if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
>                                                          ^^^^^^^^^^
> This is not necessarily initialized on some error paths in mmc_send_tuning()

True. Thanks Dan for the report, I will send a fix.


--HOS/AFGgsfd8kJtB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGmIr0ACgkQFA3kzBSg
KbZZ/g//eYJO/nYOXHZBq3x6szdB5DKXbtcIpoI+ftn1Awx3xtJyKL1XWA1Y5e3f
38gM28klgeN9fK4HUDwv194eV3vv3/qYpepDQ80Mk0hfyr60wosmV3dnYAf2s+0b
aqn0RHqJ/EVO7oaleCiamoJxgSuN0R/pg1tfUuxHxq+cfS5rBmRIOmuwNXBpqnpd
lEcPYIRX2ZmUOj/Z73HiNboIb5shIDa596Ph3jzINNxE6TUIONockBn92dQvhV0Z
lbJa55UI19F4JGwL+/AuDu3i522po96+pUoOSbDxrmMaf4QhrzmzG5s8bfquvI/U
VLYrjji5fvXKfj1OO4bnW67p508kx52rmc1djynYKJHPhACpov29vpBq9O7cipi9
kmelbH8S5G0zXlak/hjsovxEkN0gEV4utsQtwDb4Up6S44Lz26pual4ZENTueKXw
Y6diGxNrKFzFPEeUJj358Vb612GlW2BW5VhRIkjt9ehmi88lqe4t9k4vnMMtPqzz
b4O9ykuPYbJ23AJy4NZ8KPDIDd68m2+kHMQi6nfiCBQqrTox3DLoytwjqGkxVGAH
YKueDuePQ28H3XFlTbLGC/8WhPt3R2D8Pg7t2qQdsrq3vXupQzMpS+m4HVD1tnHM
RiJbJk/E9OO1IysoBbu+fdykV8rJiO+VwapcEb1i3XL7/fBopdE=
=eFbC
-----END PGP SIGNATURE-----

--HOS/AFGgsfd8kJtB--
