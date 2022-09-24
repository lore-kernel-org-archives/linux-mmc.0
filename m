Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D00C6FA83
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Sep 2022 10:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiIXKSx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Sep 2022 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiIXKSp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Sep 2022 06:18:45 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68999115F54
        for <linux-mmc@vger.kernel.org>; Sat, 24 Sep 2022 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=40+cVYHRDPfCh3D9aUZHJ9S9JKpS
        9w9OZ7EXw3pdl2c=; b=qKMHN0tgG9ouM7BPiAB+511eYKOeQOckMp8Atc/iWWGW
        p7rWzRRikLGKoDuOgattda9Cn7GmOe20pU7FpsWibY933Yaru1W2p6nQgnvJ/oRW
        0+turlLy31XVAfrkD9pKu3qbpX+LPODEHd9VajC4jbhlpbLoJI3mhDXI+i0hl9w=
Received: (qmail 2393394 invoked from network); 24 Sep 2022 12:18:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Sep 2022 12:18:29 +0200
X-UD-Smtp-Session: l3s3148p1@NzRlnWnpZgtZzIsq
Date:   Sat, 24 Sep 2022 12:18:24 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Fix rounding errors
Message-ID: <Yy7ZcJ8h2VCtUDnW@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220922085511.1078256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MBTWagKiUV+jT0FE"
Content-Disposition: inline
In-Reply-To: <20220922085511.1078256-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--MBTWagKiUV+jT0FE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> v2->v3:
>  * Renamed the variable new_clock_margin->new_upper_limit in renesas_sdhi=
_clk_
>    update()
>  * Moved setting of new_upper_limit outside for loop.
>  * Updated the comment section to mention the rounding errors and merged =
with
>    existing comment out side the for loop.
>  * Updated commit description.=20

I really like the new variable names.

> +	 * To fix rounding errors, eg:- (533333333 Hz / 4 * 4 =3D 533333332 Hz <

(What is the '-' after 'eg:' for?)

> +	 * 533333333 Hz) add an upper limit of 1/1024 rate higher to the clock
> +	 * rate.

I know Geert suggesgted this. I think, however, this description is too
short. It should be mentioned IMHO that this rounding error can lead to
the selection of a clock which is way off (the 400MHz one). I liked this
example from v2. Geert, what do you say?

Happy hacking,

   Wolfram


--MBTWagKiUV+jT0FE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMu2WwACgkQFA3kzBSg
KbapiA//QnMg7cERiiTFzgJY+MDZ1wjdcRrnVqaizrcmHf2FpGndKBVXNS5oc+Ll
d6Aw08LEELwMymV3R9uaUOSCkjE0ZvPfPcP8do5SAorhUUw2WVrxK57qra+eST/P
GYQenruzaFCKJECN7Cqud1vSdzBuxT/ddZivvDOJLeGaQH70xkWy9aaUwvK1+49c
KDZ+Zd78g9lGkQtibtz2xk3Lgv2NcXkGmyTMfLCG0x2nl77CKZHXc2JiAdKRSGPl
BzDNuuoe8fHXgz3EicVVTpkL0tXLr1JaklZHH21JB9Rf/VxiH+mCJ6iSI7YEPOEQ
1C4iOzYWJlFCnyEfSQhSncoDayzqQP8QLH2axj+/56O8a3+SZN9l5vFGXlVdYvMc
y1BuDw7Mzdz85M4PF869k3TQXBKqcABdJbx/N09k3vOP/+tjHSpnoCdTD/HrXthc
3R8atAxzyqBOvb2brx/xAQj6776ziZEdyNPWoeDNxJXuvJmitsxJWCg/sk0B4epg
c1bdnbE+SpJaNg85bcIjwvl2/mDscvSqwnLW/r8c7UC0HViJLjycV29yJpr8DWX9
DiXQPKI0OZ75O2nBBNPtWsyL82b0tNa2msZK0E7zWLnowlzzLtjRPrbp+Rn4+i33
WNxy6aWzgJugEjq9Ig7vQHuTz5pNCddLoAgPtcmxGc8ltxZGtMs=
=zDRQ
-----END PGP SIGNATURE-----

--MBTWagKiUV+jT0FE--
