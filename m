Return-Path: <SRS0=Rn8H=CN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A62DC43461
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 06:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF1C2074D
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 06:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="wD+h8Nmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIDGfU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:35:20 -0400
Received: from www.zeus03.de ([194.117.254.33]:54378 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDGfT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Sep 2020 02:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=PEKAdGICSpG+StaimtD2YxLUKeqb
        Rz1HTpHr/NM8LWg=; b=wD+h8Nmwe2DlaHl4ZY9ljquKBmzVTAjJx9KGimQRYUxR
        wYZBPTs3mCywOYZzIcxu6hTN9Lz65eAP7L1ynZeG3nsJ7nM/j3TbMGTUGbgzPR+n
        2wb8m2rKBabCi1Qxnc6p5MtLaj3UqYvyp6tjbhy44mF6Kvu3DdbLAvZ6+lWvrL4=
Received: (qmail 3473265 invoked from network); 4 Sep 2020 08:35:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Sep 2020 08:35:14 +0200
X-UD-Smtp-Session: l3s3148p1@KxpNEneuIKEgAwDPXwlxANIWpbLKE1Uh
Date:   Fri, 4 Sep 2020 08:35:14 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, swboyd@chromium.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jun Nie <jun.nie@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Ray Jui <rjui@broadcom.com>,
        Robert Richter <rrichter@marvell.com>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that
 existed in v4.14
Message-ID: <20200904063514.GB1506@ninjato>
References: <20200903232441.2694866-1-dianders@chromium.org>
 <20200903162412.3.Id1ff21470f08f427aedd0a6535dcd83ccc56b278@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20200903162412.3.Id1ff21470f08f427aedd0a6535dcd83ccc56b278@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 04:24:38PM -0700, Douglas Anderson wrote:
> This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
> probe") but applied to a whole pile of drivers.  This batch converts
> the drivers that appeared to be around in the v4.14 timeframe.

The LTS granularity of patches is a nice idea! I will keep it in mind.

>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

In general, I like more coverage of async probing. It makes sense for
SD/MMC, I think.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 1 +

For these two also:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # SDHI drivers

The speedups somewhat match the expected values and no regressions when
checksumming a large file.


--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9R4B4ACgkQFA3kzBSg
KbZ+dRAAtEZ/QivEThvaA26nN4oN+/Pl5wfutbbddoY6FBwhRfVLeGOUmIaQyCzO
WxUZXCY6DhTTk6fBdM4DBdt9gZESHaWmmfimgOYszW7pN+ZjdmC/74/yx9jQtDd9
zPGcMtbBdzc++3QBJhS+yrCmCVK8k/h9uk4IcBeXYCOxGkt2ZTIs+K+2U//wRTdn
GIJv7NBXmUVkzRE6eumCfgJNM9haAzmm/QGgshIXdupqQ6VCpAE6Me+nFNPk5yPB
HC9wwsinQjlx3ntGCrQm+Nj0eRYBjiBVLALKneCSr3r0+j2iEcBOED5O5Zayu6Fo
J6M4qEkn+snojb7MHNqyylcjKwqA2x1masuuOPe8P2LxXrVjQ5myPtcgYjr6YIK7
/MhB6xX7G0C0YXlbMOLrJkXpU9UMUkcm+6nMeaw1e7HOFnzrx6gpYuK7qn+rkeh+
rsN0TTY8jrb/Ad9+Kt1VDiAAUAH60NVqRhCq/z04/6vmpXzfJ3Pu6Tpl+eif7C6k
HRm/rG+Xh3uuwAN0FdsJwi3cwV/vgVd1Fl9XoFWvZZQJ7bZI9B+J6AF8wpOmqDjw
VIq0DacTmlEXJ8oOPr9UjHvHT8RTUGDSyrbI8F5K5+QY4qjnuruzT7tHkwmNxYgX
MXiTodCMQ/oRfdVt0jKHNWxh/oOyoUyeHlUS/IAbefp8BH6bBS0=
=RWIN
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
