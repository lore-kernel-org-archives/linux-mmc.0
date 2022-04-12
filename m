Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C7DC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 10:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiDLKQG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378027AbiDLJ7d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 05:59:33 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBC31907
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=2CAhY7IKumQJVlwImdkuwFw7Nd0T
        SrqAcUxKb8rI2mc=; b=1NxaPaVQGS8PUNc7Vz+gLp7ce5zd0ZaNCeU50UvFEjQj
        qowJd3MhGt81FnJSZavswtuwjyAd4HGRHgvZAPNvz7V4wcPt4QVqvjqG2FXvjbgh
        LxjQfb88mxJdaSIfpuvTca43jlFyYeUEkoVkNGiJeL2AYAwJAKH1HJlhS9PkkX0=
Received: (qmail 974035 invoked from network); 12 Apr 2022 11:04:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2022 11:04:42 +0200
X-UD-Smtp-Session: l3s3148p1@0JXDWXHcwOYgAQnoAGZ4AFi7qjeMIP6q
Date:   Tue, 12 Apr 2022 11:04:38 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: RZ/G2M Hangs when booting some SD cards
Message-ID: <YlVApjtNOBLgA0hy@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
 <YlR9TCeV8FJVu38U@ninjato>
 <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vhXuqUUAmMzNR8hx"
Content-Disposition: inline
In-Reply-To: <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--vhXuqUUAmMzNR8hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Adam,

> I have cards that fail 100% on my RZ//G2M.  I have an N and H as well,
> but I haven't tested them yet.

That would be helpful to do. The board which fails for me is Salvator-X
with an M3-W SoC, so that matches your G2M. The other SoCs work fine for
me.

> Unfortunately, a colleague of mine tested positive for covid-19, which
> prompted several of us to get tests, and I received a positive test,
> so I cannot go back to the office for at least 5 days.  (I am feeling
> fine today)

Oh, get well and negative soon then!

> I was given permission to ship one out if you're interested but I have
> to wait until next week to test anything or ship anything. Please
> don't feel obligated to accept the card,but I know it can be easier to
> have actual hardware.

That would be awesome if you could send me a card which regularly fails.
Thank you! I'll try to reproduce the issue again today but if it fails,
then I'll wait for the card to arrive.

> Thanks for responding.  I'll try to get card info / part number from
> my colleague.

Great, thanks. It will be interesting to know. My experience with cards
is that they may differ from one batch to the other, though. So, it is
not guaranteed that I'll see the same issues when I purchase card with
the same name.

Anyhow, I'll report back with results from today.

All the best,

   Wolfram


--vhXuqUUAmMzNR8hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJVQKMACgkQFA3kzBSg
KbYWhA/+Jqge+WsFWodyAcvjj9vqsNpSa+i1YvF3R6tAfguQzex2m063DPk50u0O
sm1Hsndg1CoRIjRc+hYoWnUG3oZvr/WSixQzLBK5SctsJnvuYAEOPLjkrvmPnFfz
v0eEzdmqaoQwz3Yu6vl+hiTIdG8Gp+FSIcxUSEDat1Ex6Zw0yEBZNmxLG94SMeJg
rnqHno9g0QENpKZKHb1p+YlRpUy7J4guUEA7Bk0xGJCHg7s8iGvhWKpUzsbT/FRX
2kDfSMR3gAKddoJF+McvB2juq3VDx4XtrXoAIpKvQI/+eA0185kgoe+6Kzrh11Gu
KYYODOM0LlwfznEo155fH83aA1rGhzCyHvPmEnyGM7abyWiCi5cBfy2dLxfB4HMW
ej3ZMNtPUT1Q+Yi4LnhUF+MFUzeEZOspZ75hgGeznZrWpu45cXh0sZeQc4uxt0x0
Gd4FpFUwUwTpcLzQX2DTn+kFrZFdvhroPrnwbCZl3HZmasv+PomjtKfu+jdlAuE+
fVDFBV7rF32C4+9UWVt5XYi9q4xhDTMHK8haFeJI99vjpcF0XsEcDVixS4JVnVXP
dnE6SNvGg/McYJrfX9WJ3Etj/8NDYTRFP7C8daGcxwW2alj72mUI5kU6r7rOVCBB
qH+xsWDIDPFSH/AnZ3+UlBS190W+kdT4kr+EMN4sOzXUTGtAeFA=
=fKg+
-----END PGP SIGNATURE-----

--vhXuqUUAmMzNR8hx--
