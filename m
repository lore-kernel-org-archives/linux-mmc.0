Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4FFC5519F
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B13022227
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 09:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="00gsGl7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgKTJoq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:44:46 -0500
Received: from www.zeus03.de ([194.117.254.33]:58128 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgKTJop (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 04:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=8Twhw8N2/x1rWRtqq1j1hIZiT6gO
        57ge+7Zy+bk5zbc=; b=00gsGl7sgjMQzEX9gErboy7zZiyPqxihtZ7dgAWTmeVI
        5hVrK3c8RnAhrNRz2x0IlNPGvQ2Ch3cnV7nCsHcRmuvQkYCDjKy6IoVoE6g2uLFi
        cDBghC09BCZfWtSPlFB9R1q3u8bS/WjUubMLz39cAAnHvzBh1rQlny/VNpB66Ec=
Received: (qmail 1413809 invoked from network); 20 Nov 2020 10:44:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Nov 2020 10:44:43 +0100
X-UD-Smtp-Session: l3s3148p1@SVmysYa0NtggAwDPXwi7AEBAgYxIRHZX
Date:   Fri, 20 Nov 2020 10:44:42 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mmc: tmio: do not print real IOMEM pointer
Message-ID: <20201120094442.GA2353@ninjato>
References: <20201116164252.44078-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20201116164252.44078-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 05:42:52PM +0100, Krzysztof Kozlowski wrote:
> Printing kernel pointers is discouraged because they might leak kernel
> memory layout.  This fixes smatch warning:
>=20
>     drivers/mmc/host/tmio_mmc.c:177 tmio_mmc_probe() warn: argument 3 to =
%08lx specifier is cast from pointer
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl+3kAYACgkQFA3kzBSg
KbZ3BA/9Ge4QmT0WWRGO4YzgxY1scUkUeySGQRe1BhY5PpqAocL3IWdM/PRfY4vZ
RUz2blttOZYrcC20XGD1nbEk/VeFv1obk5huYZLeBgEIMyoKInDXcSe550+PU+Wc
bRCthO4B8PRVK7qWGsiU4EqF1ojq7n+tzm2JP5DFtKJhxVPon3R1BbX6+mJInEM9
BkGzafdOOkNuShpbCw3wbuNyVZLEQPXjYN+MnXYXzER+Yb/ZChv6yJumrjl0QLOW
5RTsOiqXYwaWtxJZAyOqVRYp7vL7pOzp/Urs64iwx1L9U5oLO8AN5wBXLwgMzX9n
4yRlbbuhchao0cjHWWg6MvDzKCjeyW0HGns8cf7p4koEV/LucQxhf0n+BdUG0GVX
FzNTCZiLABHRQ+Wv0yJ9qPAwpp+x2zdlEnualKMrjSxgY6snUk2bDBjzdoBAQ45J
V/oBuhMJSfWe9ze1PXPabvXpU1NrUt6tM4xxI6KqKoPzZ6qkPMVcPIebjRh+uvrv
lV95aNPBIJKIPgJTE6yGx5BYmnSeXbgusuuTYvFsMMHsO0Fk0krd7Fc2SWnbJW77
2+bomUERBZMN07ckyTLV7IAAoMcoYIHY/zrlgyOYttvxBE+rqQ7THXEYiOn+jtUz
EbHhKSMWWOkDG49uVv0lkopfpzG0BcnFBWzrd+E+4PggPIjC9jw=
=pmSN
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
