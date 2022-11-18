Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D1DC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 20:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKRU4A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 15:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKRUz7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 15:55:59 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2868A169
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 12:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=3E/cYoyzu92Y6AWu73KvJ0mVEJaf
        DE50kDc/XW0zaU0=; b=Rc0Ignazh7Ny5jE8Ovd/CO23cZfmHmJfbbg8bNJzX8gg
        aF4BrzSb5wSjyc+PAzCJzBUgumxmA4QaxbtO5ScAzqKkajRXQoOLZ2ovjFhQDnD8
        GdUxS86BcqJUXlaxMeySKN+UnresOsBQXRQIgXpBs/5aItaP950iHGKRawNao8A=
Received: (qmail 1904128 invoked from network); 18 Nov 2022 21:55:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2022 21:55:54 +0100
X-UD-Smtp-Session: l3s3148p1@BpR47sTtPplehh99
Date:   Fri, 18 Nov 2022 21:55:53 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Duy Nguyen <duy.nguyen.rh@renesas.com>
Subject: Re: [PATCH RFC 0/6] mmc: renesas_sdhi: add support for DMA end irqs
Message-ID: <Y3fxWVI/6kvsVdgC@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        Duy Nguyen <duy.nguyen.rh@renesas.com>
References: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFqA1RtcaGMCQgDsKKju4izHWJRAD12SqqirNm+TWLt_hA@mail.gmail.com>
 <Y2LBiOqomYJ2E/Gd@shikoro>
 <CAPDyKFr1UR3QX4X45TmShADDpOEuxnadcvyTGaXLhcxKrAxbow@mail.gmail.com>
 <Y2QHKcgNOTA8d6aV@shikoro>
 <TYBPR01MB5341615451524AA587210447D8099@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SxUxVhIB1EEZjPDT"
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341615451524AA587210447D8099@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--SxUxVhIB1EEZjPDT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Our test team tested this patch series on R-Car E3 board and they didn't =
observe
> any regression. So,
>=20
> Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
>=20
> And, I tested this on R-Car H3 board. So,
>=20
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thank you very much, Shimoda-san! Have a nice weekend.


--SxUxVhIB1EEZjPDT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmN38VQACgkQFA3kzBSg
KbZbsw//QHsq7Tl9fIEUZqcftLL5Tdrd2XN038Lx4QogjWRBTlB7T+WtHmX1NhOl
vyG+XfRqs0PYXKOezkbFbH8zQxrAMrmzrp0nTGa2nSKf7Kxmx5YeZ/+JL5b2nNbO
+RQjTlmqBPPa37tT3dpXFEHrZXJgQ3i4c+2CoSFyDWk4cEKjaZYfcq4qPE4eCBsm
IY6fScwRj35NGA2FaHhHzuz3idrEGLcj+9M6YFDwfPa8As8AlDFIYy/ixKqLk9CM
iSUMKjzLd0bzo69vbh+gsuxylE1jSmp9RvngZ1oxDkxE55O3KvzvjicDf5xCkRgM
czcswfAddgH4g5d6CxfF/a6Y1ehDMTyrnGKfK3o6GnLxHoBG0xmGYWmxWqiwD0Ww
7CBS0HND2wc0YjCsB7HvN4CfbPQLh0nqY7Q6T3rPEw1XRmdzJqHk7m4FIVjCXZSK
tJb8Cr/+J+HKOf4fZnrGtO4i2NuWc8DHUHXjSb9IjTpPP9G2oHxswO6wP9ftBZiP
ZTnqGjQrLXvtdpYgqP8kdFqDKh8p9JZDl1Ko5iOioWaThfGoUoVFKYNT3CkG14CW
cDevklGR/xI5HOixO7M1r56YKym69bglP9LDFTeRKiAQsDgJTxCCFxowmK9aC7x0
FpP694ofCksfYZiseaNTG0aNRQ0utZWYbuq/lWuEHnqCp6zRIIk=
=dhBf
-----END PGP SIGNATURE-----

--SxUxVhIB1EEZjPDT--
