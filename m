Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D897AC77B7A
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 17:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDQRPt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 13:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDQRPr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 13:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F68A47;
        Mon, 17 Apr 2023 10:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2452562155;
        Mon, 17 Apr 2023 17:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73900C433EF;
        Mon, 17 Apr 2023 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681751745;
        bh=Ar210rKGPKuILnpDS5s4+q18d5eqdiuCqZZ4JpgYU5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjvO5jGW4dVyzB0xA/L0PtCpjzZ4O1of1Ka3VQoA6VX1B8GeGfFnopG3X55eItuX6
         7eyhv7BKvfpPCAzsaX9ASRGuhu1shbAUPGXDyYlcHdAlUYgxswYGdFn/egOt59xCJi
         XBdkH/w2BotEGmA5gcbLQxwpTwZ+nePLkHgtlccFWjNBBea2Cah5P+9UdEpwWmwTBR
         9SEeBEZ0FkDK7KxRZ7zhOdSyZTo0hr4sqkWSxaNKOHKoVWgtCr8+AKDL6m7xTtwSRV
         9PwRW+jZxIuaUCSpyGaD/rO8ktKOX0k4PK6dXgy5drcPtG75EmAu+OC6uy7Mmw7HqY
         aJWgJt1c1IWJg==
Date:   Mon, 17 Apr 2023 18:15:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 03/15] dt-bindings: spi: cdns: Add compatible for AMD
 Pensando Elba SoC
Message-ID: <9c7aec03-265f-414e-9a3f-9511f40cbbc0@sirena.org.uk>
References: <20230410184526.15990-1-blarson@amd.com>
 <20230410184526.15990-4-blarson@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y3QWPZq3ZHOCu8GE"
Content-Disposition: inline
In-Reply-To: <20230410184526.15990-4-blarson@amd.com>
X-Cookie: You can't push on a string.
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--Y3QWPZq3ZHOCu8GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 10, 2023 at 11:45:14AM -0700, Brad Larson wrote:
> Document the cadence qspi controller compatible for AMD Pensando
> Elba SoC boards.  The Elba qspi fifo size is 1024.

This does not apply against current code, please check and resend.

--Y3QWPZq3ZHOCu8GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9frYACgkQJNaLcl1U
h9B3jQf+LoKtFdxP8+ZXFtvgBvCs44/hkaDUu6Qz2NRI+d4wgLknS/P0fkqNa5fb
+PJIu76z/h9YjljFPaAdIue6USY+0g4kZZTfXjb24QmTtrPPqDzsE1bFXIKGC9iJ
ABTT8U+DwIaagK+1fl/37rer8Bi/RsYY5fH+UesiXMyfHNE8QWdDiJ7urGQTfJG/
h76thHZ3gTS298ZURH0cQcNv99loPpYl+Fnh2GX55hnZ7dGVPHpg+nFL4Xwd3ebB
AYRp8z9zv6ary86tDU2IKdtlHZtUjYXuUOp5BkYOgec7MdxOY9k9CbT/b8wj+O3S
fclEugSoM9qmO77Y88oIULqIb+aTBw==
=97Ia
-----END PGP SIGNATURE-----

--Y3QWPZq3ZHOCu8GE--
