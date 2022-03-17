Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53475C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Mar 2022 08:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiCQI4D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Mar 2022 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCQI4D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2022 04:56:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5551CAF23
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=HjPmz2Ga5G8Vj2cnXScLES8GLciR
        Lx9DNNktST9XckY=; b=bNCIJqbn7GumthizLZCASHzto2yiEG4xv2a3gCwqktP2
        /SRoRQEPAEoeRfgKQtzCQ9R8wdOhz97i/LaJC+nsa4DqALSd5L63vGkOU7PeiECi
        E6LCHH2SFZ8xABGI4M0luUbSGtJDD7XEqJYEhjcjNfi9+Jrm5exNBx2Rc6zQGOA=
Received: (qmail 3380571 invoked from network); 17 Mar 2022 09:54:44 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2022 09:54:44 +0100
X-UD-Smtp-Session: l3s3148p1@Q5Z0LmbaOs0gAQnoAEd5ADwsgXkBgqk7
Date:   Thu, 17 Mar 2022 09:54:44 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/G2UL SoC
Message-ID: <YjL3VAlsqzCtXPLM@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220315153258.21097-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tG1BYTBMChgnHQNN"
Content-Disposition: inline
In-Reply-To: <20220315153258.21097-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--tG1BYTBMChgnHQNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2022 at 03:32:58PM +0000, Biju Das wrote:
> Document RZ/G2UL SDHI bindings. RZ/G2UL SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--tG1BYTBMChgnHQNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmIy91AACgkQFA3kzBSg
Kbb22w//WlsMf1JqyhJFzYpfFuqxfdAZIjN3xP0sQo3x7YZ2wfsykLhgwcCXdABX
otWfOaJxnsJrTBq5eJKJcWcNI9wkVNa7qdovuy1wZbL5OHBqMAJK0sXfR55dyJRv
lqpximRNnsNz3poP7gBwfoIaCt1u2VjKLizsGFSxF8lMJHSU91KYS+AalzCyYE0N
t+6Fpqno0ugAZ1zXcUmVhI+oZ8rgr2XsDdUPvK95rECODcxcXRukrsLHM3ZF0sht
++DniY/AyOyyDrwFTwTcukpV/QHHdwMaP6RAYrALQeprCyx5Lj2CociUrmvGqUC5
qARlYXq54p3dqaErHJ6EezkK0I8EikZO/R5ipy2VssFi6teux9hRXlVzjm7I/3fS
LiBBgJqDR7HW7Jj2A0OOoAc3IEisSjaGQyih74HJD8LGCWGeFlDvp2pN8N4k4NCT
pkIV2O8WjmnrGRlsdTVnUC0xmmEN900vMGGaLhfNpiXzUsfRamn52DEl3y9vG+q0
6jvwmmF/w6GOYO9TPfPTET5o5YdxFF+fMghzWRWHdh8zqXcPHAPayJP+JUhasLI6
Md9c+jcX1hJo9uAmw0xuIWOQiwN4QzPcZ567ekYow18sJQskjW6LWb0oOgldQLEf
jNhTP3v8n+uacSKsQo/NvKmGBdivhbrRWJ5dkwZfXWWGD1UgLnQ=
=gGDg
-----END PGP SIGNATURE-----

--tG1BYTBMChgnHQNN--
