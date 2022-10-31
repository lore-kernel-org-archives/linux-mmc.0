Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F148ECAAA1
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Oct 2022 19:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJaThL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJaThB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2022 15:37:01 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F313F46
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2022 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=8oAWEy/NUHRiH0BlpnQq/zyLbpk/
        KJSWrramJU5Iy7Y=; b=T8BgccJ6BGBdNI/RhQ5iYbsW1qVw4NmFCmauO4FN7ixF
        KRyDEtmDsgHN/K9kExXrzUpy4klxuVBSKl+UCuTp6CqLUpfwOYBe+cXoQqOt510n
        KA3TGKX8XCgj/78eFW9XdDtLJP1c8jkOiHNB189sCnrQ3rzNT9ib3wDlN+Ji+JM=
Received: (qmail 1497143 invoked from network); 31 Oct 2022 20:36:58 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 Oct 2022 20:36:58 +0100
X-UD-Smtp-Session: l3s3148p1@dTHiulnsTqMujns0
Date:   Mon, 31 Oct 2022 20:36:55 +0100
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
Message-ID: <Y2Aj15elzHIPEYqz@shikoro>
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
        protocol="application/pgp-signature"; boundary="ml+MGP4tzBghihDH"
Content-Disposition: inline
In-Reply-To: <20221005101951.3165-12-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--ml+MGP4tzBghihDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05, 2022 at 01:19:48PM +0300, Adrian Hunter wrote:
> A long time ago the kmap_atomic API required a slot to be provided which
> risked the possibility that other code might use the same slot at the
> same time. Disabling interrupts prevented the possibility of an interrupt
> handler doing that. However, that went away with
> commit 3e4d3af501cc ("mm: stack based kmap_atomic()").
>=20
> When the second argument to kmap_atomic was removed by commit 482fce997e14
> ("mmc: remove the second argument of k[un]map_atomic()"),
> local_irq_{save,restore}() should have been removed also.
>=20
> Remove it now.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you for cleaning this cruft! Looks good.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I should be able to set up a board for testing this week as well.


--ml+MGP4tzBghihDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNgI9IACgkQFA3kzBSg
KbbUJw//dcAYEvUUpyOAMVHayzjJiGj6ALdQcJMLliMJcLd6p7+KB3t7Tk0kmGHM
QSRvqaMXzQhVtEes5r7sR1I+Qxzmxw84PTPRGz9oZMJLwQDa0AXmdChFGuK9PZUS
JFyCYcFnMmpypfT9RBL4NqgFq30Jpdu+6dxHe0z0OiQHsjsgwnz8Sd0c0Zvyi1JB
3p0jN8o/L65AY53u/Ch88xq50zSwYjrsvIVnMJ/6Blvb0dosAlj4SMYesmTv+ztC
4bT7TQ9K3MeutfuQlC9UvuzpCpNiKnw18u/6nRQ5U3z58Z2vXa9jDHzE6FNaQQd0
bVD7RycXkhyCGCRmzoe1HKGWHz9ZKwfCl5tiTtGga20hUQv+5rrdyGGxfkogZC7c
5+HCrGIfwLFmRJLbdd3jPoMQA+SczyvgF3+OLa+iHLAe+EUQVGpVdArhzxfLgIv9
aOWApKV0bBapCy80y2nwPBNpSd6utYDQWwfx/ldocvHZu0T3KyiUv0eESFUoiJ1o
BQyBsJpEJ8xQFR3OtyfHmy9GNwEMkMgQ1IxDVbzwK/iqoEo8hGHJMqSfq77Igb1c
3n+VzsWga84QW7+T9VCX9/3YCls5pfBtPmDTkuWJhh54uLayfrl4TQ8pa38rv6Eo
QBZK56oFkVKzSx8atSQYxFCbUAbhEUTYx8wjGKKiMcsqHX7eF7I=
=6wwZ
-----END PGP SIGNATURE-----

--ml+MGP4tzBghihDH--
