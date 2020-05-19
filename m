Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F046C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 13:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A32D20825
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 13:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WotWE0Gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgESN4t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 09:56:49 -0400
Received: from www.zeus03.de ([194.117.254.33]:42212 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgESN4t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 May 2020 09:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=vhhhQScVj2yuyaXZEuN1mVQNFgwV
        yBfgImuozQNNeLI=; b=WotWE0GncwsD06WQ1jslCYTY4J9VSAdjUFPIITZfeNYl
        mKzLrkZBaFgzJsHEzJ0Rvn3KTv35LvLg5AoGXKTi6BggEBpjwiTzf1EItRjT0T6u
        wZ6ZNqcICEc0anG77UsQL7MkcoRRlt9bgGSMN/W5SNEQaeducrUfrRYkvN1ZFKk=
Received: (qmail 281627 invoked from network); 19 May 2020 15:56:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2020 15:56:46 +0200
X-UD-Smtp-Session: l3s3148p1@p517pgCmkucgAwDPXxCmAFNwG0mTH/5q
Date:   Tue, 19 May 2020 15:56:46 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at
 remove
Message-ID: <20200519135646.GA19235@ninjato>
References: <20200515140445.15218-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20200515140445.15218-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 04:04:45PM +0200, Ulf Hansson wrote:
> Before calling tmio_mmc_host_probe(), the caller is required to enable
> clocks for its device, as to make it accessible when reading/writing
> registers during probe.
>=20
> Therefore, the responsibility to disable these clocks, in the error path =
of
> ->probe() and during ->remove(), is better managed outside
> tmio_mmc_host_remove(). As a matter of fact, callers of
> tmio_mmc_host_remove() already expects this to be the behaviour.
>=20
> However, there's a problem with tmio_mmc_host_remove() when the Kconfig
> option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
> disable the clock via runtime PM, which leads to clock enable/disable
> imbalance problems, when the caller of tmio_mmc_host_remove() also tries =
to
> disable the same clocks.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Works fine on my Lager board, too. Imbalance is gone when rebinding, and
I can access large files on the SD card.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7D5ZoACgkQFA3kzBSg
Kbadxg//YfjFd0p2YpU5mwqtvjdXd+KSrRkbeDHVWviNdeqCdvVMvsB6T9/eod3p
tH/JGQWXJLmhAdJFuaTq381TMHpQ+ak2cnv5MMi0qj8dlAdhi83S+sEWQTF4Vky7
ceY45ulV9Ex5gz5gtYYq4Egj9hHaTW6aMR26w7op4NROAbbVNL2hhWOVTPlAb5av
XhKmzTo1DoP795mhz0TW32/VQPrxE+nxbvc6d+H7deywI6WPVuRPSx9PlnxPHnrW
SKxuNaVmx0nxKAQnWjNJhgKTIbSCXlvk7meTYQZNDtsYM4Oe/ecw1h9vfqsdLTV7
rgIb7Zj2R95rRd71tgrmyGyBmdBb1GAsUlPU85z2otXgPUN/yGIFYuG4GSieMdEe
IL+OojmUlHRQ0UW6UH/otzu9/nXZ69edew9OK3j6FcI/xagM4tuWn9btG+OhRCKQ
LOI5STnc5DIHl1OQDBhkCQAdsGb+OPI2EKkb0dLOaN3jIKjLpL4fMhxRoIlqAnfN
TGqYbVSnwKpzuKUFQVM2/eyUKB/SqP0GQmExrGmLGt7Byp4XB7TUjSBRjmBBll9e
S+x1iGrth1y+yKgIwjdp3Ut/iXYrm+LGYFtj6ghnNGKDObcdlSefPt6rkI+ehlMs
vPf1V2yrxSBt1DQafGJr8c9qSDhV6OOqdIb2uDjcuNv/V2sqt70=
=uAe8
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
