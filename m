Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E1CCA47A
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jun 2022 12:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiFNMBO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiFNMBN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2022 08:01:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E275747387;
        Tue, 14 Jun 2022 05:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99292B81863;
        Tue, 14 Jun 2022 12:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C38C3411B;
        Tue, 14 Jun 2022 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655208070;
        bh=BQ+K8h3b8NTc0PJ1YVsLsJAAKVHpadGIqdfwE7gJ6EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHZY2f5ThjG7pguJisAlbIb+1htLs+Nc0tQKLX/CwGfJJ3e4ZLjqz9vaw6RabX47/
         4631C+fahuuV6n7feTi1CEmA+UdnNun5lmCo3Wew/nV0mQ7A/P7BfGxLr2OHQC8a/M
         w7soKXBx2iVGgM34iRsHnO90tQt/mt0r8mOzBzbkedSqO0Jn99HOQFcViO9R+OXTSs
         7TzIg8Ls1Yrn3NKp/7URjwc9F17lp+3o1HmlxlO5kNJpoiSj/5pvuHy8JmuCExyonq
         Xi1vBcUypUxqZN+9xht9NNEVewgRSd4uVgCWW1oOGRwg72SHiN+/Q2z20XAkaGKfJh
         8ZAX1Zlse6b/g==
Date:   Tue, 14 Jun 2022 13:01:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 11/15] spi: cadence-quadspi: Add compatible for AMD
 Pensando Elba SoC
Message-ID: <Yqh4fO/OFW6DKmyX@sirena.org.uk>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-12-brad@pensando.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QD+xTY9ZegCZALRr"
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-12-brad@pensando.io>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--QD+xTY9ZegCZALRr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 12:56:54PM -0700, Brad Larson wrote:

> +	/*
> +	 * If a hazard exists between the APB and AHB interfaces, perform a
> +	 * dummy readback from the controller to ensure synchronization.
> +	 */
> +	if (cqspi->apb_ahb_hazard)
> +		(void)readl(reg_base + CQSPI_REG_INDIRECTWR);

You shouldn't need the cast here.

--QD+xTY9ZegCZALRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKoeHwACgkQJNaLcl1U
h9BzAAf/X0wGG5ThEi1bnamNc2nxsc2NVq/sQg9/BZE6fNlcgYGwg73KZznuhleu
tSQpBsn3Ymko/E7aF/JzRdBUoJOLpU3vQhcuVt67hXYdQV40NbJk9PQZFoLgBUk9
YF/C82tFviC7ew8ImqJQ2rMPGXKTYtmofoz6SjbqQjUhaS/MpGXwwaek2oeYcgxt
XYXhaJKFj7ACfQKnVv6APjpqyLYpDN5HuIKvOEvAA+z0z35nM1GpY141XFn8liYB
lvZKIPd6sQLen83SW4BlmZ1RfkyCwTqLKWzhT5cQQLW5ljzR5sZjBRD/JXM00fGr
9NDR5Q3Pv/cSVpW8himxFIUAnv3/Ew==
=/+w/
-----END PGP SIGNATURE-----

--QD+xTY9ZegCZALRr--
