Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB04C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Mar 2022 14:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiCAOyl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiCAOyf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2022 09:54:35 -0500
X-Greylist: delayed 225 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 06:53:50 PST
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE927EB3D
        for <linux-mmc@vger.kernel.org>; Tue,  1 Mar 2022 06:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=bHcc4GLjuPlwZ9IO4BDeSXmHBVnc
        FhSDywmcS2SRGdA=; b=MGgWp5uuX9D3Q+AJpYpCzzHdrAso6Wq65Xij/C7BZ2ip
        X12SMZOT+1S0c7n6yOBH2wei/3BADOzkKOC9Vrl3bl3xe0RP2bZBgdw5jMHH+pBw
        WTKr4oKUsKOfixXY4IKRGlVwllNLVtV/2gowjlJlKjJZMQFQhsl0bl96ZCuKgJI=
Received: (qmail 3900677 invoked from network); 1 Mar 2022 15:53:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Mar 2022 15:53:48 +0100
X-UD-Smtp-Session: l3s3148p1@Q1YYVSnZ7NQgAQnoAGI9AP6D0HJXVmR3
Date:   Tue, 1 Mar 2022 15:53:48 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
Message-ID: <Yh4zfIliNC2EzF4R@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Oa0wvzClD7zRdyN"
Content-Disposition: inline
In-Reply-To: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--1Oa0wvzClD7zRdyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 27, 2022 at 09:23:30PM +0000, Lad Prabhakar wrote:
> Document RZ/V2L SDHI bindings. RZ/V2L SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--1Oa0wvzClD7zRdyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmIeM3sACgkQFA3kzBSg
Kba/YBAAnssZXgvDGvV/aFRDKSkKps+gd9KCURFaUu26sXNfgUClvBWllhx70GQL
7X+wwp5hPk1VzAvyuz4xK2CbrhZyMZvW5Pa1b76eGkOcDifC7zsMhU3KFMFg6p/P
zoecKF+NqNgUViQ84TtUmnhsLy8UzoboV5NuFYFprAEp14+XateezTtLky7CS+Gg
Dr2HwNN9cecrnfIyDC77wdKnCtTnH56bW7aQVERbt63dnByEYGGR2URuYnbZieY/
Bo+funywtNneBXK9RCrpHcOWausGAuKOsE3Ub5BEfK37fi+WJKoWs8jlVxolYRD5
b1FVFIu/wwOtst1nuLbli+s3Xr/fhE04aUVdnr1eem1XiX6LzoV1KviEblmBuHpo
poDcUtin+HZKgFABIrKsrj/ZfYCt8gcmg5qFsehoiLyKKXw1ugQNGE67mmsZ5cyC
02BKGh7myLA6fkeVRZ1CEGsQLx0TDeRVaL+E9XYfUK2sg6MR2FJEKPZJWs0TneQB
OEKVeqAqOgOMI55j+McH99FF6RvKTa8sHW9fRD4DUnQgMeuPOmRdtg1qAtB9SEe9
c8/2DZRhcZhuKuQBMAVaKDuBixsb0FurrR9rp8hf5yvBL7OqsEiOnEJoY5B3yYoU
Zda5MEsid5RuycLDPnMnANWLQQasbqh9d8nwmTkNswiZr3NXkrw=
=Mah6
-----END PGP SIGNATURE-----

--1Oa0wvzClD7zRdyN--
