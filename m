Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D7EC4332D
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 19:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB82E64F7E
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 19:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCKTqA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhCKTpm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 14:45:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C547664F7C;
        Thu, 11 Mar 2021 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615491941;
        bh=Gy7PSWDQSFUvNkcrjH47onXm/Q4ayMlS0UVLkNOcjQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KE77RvIgbkO2LsXUxAFU9OiAM1Iarbu4zWMiwP1EX3iCFc+By8eXmjG2l1N85Bjta
         Fc+ZvLSCva5VqFGJ9Zo782D1CAu5XCgbm6+Sth8OH5ow8EhmtXu1tmcZl6v7Q6IWRK
         J+dYzx4/HpF9K9fLhFWl6sJi+k2qPCmF+ai6eJQEz8wRkwIG4Ug6JP/Jh9w2hkyqBt
         SI5XxrpRczYf1RpfkeeO8MMMfmfW4IzaFW4TlE22TjsyBQw2ui1lMCMVxsZDCcW4lH
         4/eWNDNPHMHtSm6OIB9vSAZzTyax5fSys4hnswmTyIaLlc4O/SYpAWEm6h0c4/KWwU
         zTbTGmpixF79Q==
Date:   Thu, 11 Mar 2021 19:44:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 07/14] spi: spi-geni-qcom: Convert to use
 resource-managed OPP API
Message-ID: <20210311194428.GK4962@sirena.org.uk>
References: <20210311192105.14998-1-digetx@gmail.com>
 <20210311192105.14998-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <20210311192105.14998-8-digetx@gmail.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 11, 2021 at 10:20:58PM +0300, Dmitry Osipenko wrote:

> Acked-by: Mark brown <broonie@kernel.org>

Typo there.

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBKcxsACgkQJNaLcl1U
h9CCwQf/YgdbtNf9PavLnlj2DLbt3ouIlpPHcKOE/TTUk8rz11Ty425gmd0BkWuF
nQ84jHEogkMEY875FCkOf0usr+fdLbt3pjCZEOmG5sbuC45Tlh8VCEZXARUy3MKs
pcoTuTgcdl1MkTr9oa4bmFSqyOp/7wU8upJNylFHJcO0VRTJK4gMbjUWfExGaY5v
zKIHi8XCL6nueEkUnHiaVUVS/vfc+fpO/nwkJ+oAz5FVcp+Gn3bwIDqk9rGOVLMl
g5TPTkwPB55F1V90oGmmHLIwI1QbVrKQl3PbZOD/L00IuZ80DGQEik76SvlLDdf3
GuFkyj3iTTz/L9skiJSOJLKYVVZIBw==
=Yrbl
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--
