Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B97CC4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 12:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKBMG3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKBMG2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2022 08:06:28 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345822BF8
        for <linux-mmc@vger.kernel.org>; Wed,  2 Nov 2022 05:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=wdpOdE0mX7Wm8pn3wC3VbU7PWW+4
        g3jJfKezsJjvE78=; b=GfefESF+J5HgwryTaWvwzjLFrkK8D5/p4+NuWfjZqphM
        jCnUplF08OiwMnzUrANccFtoqPWf5BoPOUVot5hlBhGN/7/P5FZCAo3QGHqe0Rz+
        WoNGiWnyO2pjZHvujjXKXHy5YKU32ahFCavyU54cv5dGaY8rJwVcuGurKqiERko=
Received: (qmail 2188212 invoked from network); 2 Nov 2022 13:06:22 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Nov 2022 13:06:22 +0100
X-UD-Smtp-Session: l3s3148p1@SyEYq3vsXsQucrSg
Date:   Wed, 2 Nov 2022 13:06:18 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 11/14] mmc: tmio_mmc_core: Remove
 local_irq_{save,restore}() around k[un]map_atomic()
Message-ID: <Y2JdOpasX22Zu83S@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
References: <20221005101951.3165-1-adrian.hunter@intel.com>
 <20221005101951.3165-12-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rOtwIKVlMgU+NtKK"
Content-Disposition: inline
In-Reply-To: <20221005101951.3165-12-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--rOtwIKVlMgU+NtKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Okay, testing turned out to be not so easy because injecting working
non-aligned buffers seems not as trivial as I thought and would require
more time than I can afford for these old systems. Some light testing
did work, though, but this is not enough for a Tested-by tag. The Rev-by
tags still stand, of course.


--rOtwIKVlMgU+NtKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNiXTYACgkQFA3kzBSg
KbYRkQ//abd7uY9w+4Qs0Pbwu7lnyuCkCQy42iGGjPJNApBPh0riLNi5CaYLWHTx
tvhEbDR6gXbdiYCmJtIC1yvEM7w0+8w5R5nD2U6rrRo1NypZtylcKN2Xrz6FJ1hZ
etzLJe4EDj9RU6Z7Ff3OqtyzhEtwmYB4T8BebzGxlq45fkVXF7mccdrkD17QKGD9
MZgvMehAUuqQOnQMb7BzK7XdZfIisCVGoU49kNtYEKn9vCuhlcqH+qzEqt6hiKcU
2gUWB42kAHZxjByxVh9VuW2XAMt54PcmEmMmmaNb3s6OeGli9TxXsfU/GcOJfzP/
ljwo0iHg9eP8VMhniwuKok8jD6KoeDelZZLjbrJcbwf8aInnyJwZnFLkQoNroHaP
nXvb++uvMBwE7AATkpJfHLrbdIKR/SqUkyQBBi6hHOZfPkKsIfO4gCu9GvkbJK/s
ry4VdqAQFI0q0tDwa9tXO0/SKbEXEz13muMOUCHrZvT7cYUie1W9sbpoUoRYjBml
egZnzuDztKiScR1EhRhQUuQ4ta1IQ0eXaDB4MpBs9zmZF9AOXHDDu2ntRHQzB+zI
zrso70IpiBHsTXol8L50452WwLIa/3U2bn2koJibppbsgQkUCuepgvTrlrGezt2b
rPiOz37spnmvGWo3iM11sCYrBnjPSMpjKmjME3RIbOuzw1Iqb28=
=YpRp
-----END PGP SIGNATURE-----

--rOtwIKVlMgU+NtKK--
