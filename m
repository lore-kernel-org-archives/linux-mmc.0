Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2C3C43603
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B9A2073B
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575480032;
	bh=Z4s0aZL6e4zpWNWkr4hHZYAzAMFFkRcXgzN8syoVOnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ev62ZBKYKVsZLz5dSPVY2Pd5K/M2+h4R2P/08MhgYyvaqPZmanX0vqxq+GZtlGWpB
	 eShCv7a/wd6Pn5vuMCyDgrJ/OgzK42gGhaHkxrNIGWUtd8NuhBtuoJzNeshlcNJlTB
	 eCDBNpomLdKo9YGq86rdVo7jfOHIDmt+yH9NsvT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfLDRUb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:20:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRUb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2019 12:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z4s0aZL6e4zpWNWkr4hHZYAzAMFFkRcXgzN8syoVOnk=; b=mHyrvLrGEfBIiTB26kXXxeZV9
        9oHb0lvhFSse2PjS2GLDDDiKaR8xyd0dbTIuNdfWfX/zd9XNZrI7fjf0S36+A4QCntyS+rMV3qtKJ
        byRO351poJSq2x/AzfPzXZuZlAK6NKMjFGGWRbG3jkQzdcvApXWPWeYElEN2+/bwJXhl0=;
Received: from 92.40.248.27.threembb.co.uk ([92.40.248.27] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1icYKC-0001No-SF; Wed, 04 Dec 2019 17:20:29 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 75FE5D0046D; Wed,  4 Dec 2019 17:20:06 +0000 (GMT)
Date:   Wed, 4 Dec 2019 17:20:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH] mmc: spi: Toggle SPI polarity, do not hardcode it
Message-ID: <20191204172006.GY1998@sirena.org.uk>
References: <20191204152749.12652-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eUqGrSc0O7wKBRnC"
Content-Disposition: inline
In-Reply-To: <20191204152749.12652-1-linus.walleij@linaro.org>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--eUqGrSc0O7wKBRnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2019 at 04:27:49PM +0100, Linus Walleij wrote:
> The code in mmc_spi_initsequence() tries to send a burst with
> high chipselect and for this reason hardcodes the device into
> SPI_CS_HIGH.

Reviewed-by: Mark Brown <broonie@kernel.org>

--eUqGrSc0O7wKBRnC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3n6sUACgkQJNaLcl1U
h9A9kAf/ajXkgKiO2whTtAAovvlmmoK98+0ZJfmv4xb+dA320M7Pws/7NYQOk3GF
xY2ZkhiSB51gWshA5bfpt+JixU9s+qgHzCSY7q4BKMUmTlpN0RhhW6GgnImmGtep
QuxVofangyXS8/kFakoJ7gxppMa+mFvmZfj/oSFBfgjhkXt3QalDWqaeIQgu8Oi0
OPNWkwqX9z2id5ADtbidZZqz2tI02hKA5gsJD1Sf0hXByrWjZmDgwG093u28JdfN
GRvSSP9JWY7jgdSNrIfSzAdQytbqh6oU2B6Z4gZ1AIRdBmcyOmSI6iYmz3LV2uMM
SNCITY2YfG0dWXi0YvV81HioqV01EA==
=Er7Y
-----END PGP SIGNATURE-----

--eUqGrSc0O7wKBRnC--
