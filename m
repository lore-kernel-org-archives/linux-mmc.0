Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF3C4320A
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637EA61037
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 16:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhHDQPa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhHDQP3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Aug 2021 12:15:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AC5F60F35;
        Wed,  4 Aug 2021 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628093717;
        bh=SU7iytpCAGzQPHujZgCX1j7w+mEyOgO8m5L4Sfkfong=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0iuJnE+Iq2qLARWx2kO/wSRb9gScSFH2nSxE+ddHBNkgc+DefJHN4DSiqejGP2/E
         4gHjzSW2bJZufF+GODGh0BLiCo8vrStx6Wr2Ikc+kDy/gPKWdX69wjdvTURirYRdQP
         yCY2AuyK9zN73Zw4glL3i/xCcNy0f80gjzop3EzmqAthLGu/Cz+tnGKkt1eiTrwyRG
         K8cXR8i87ZRn3/oJtNKkCmeR3IRw5GAE/eGTXrj7z9AZrnuwaaX4hoKsEaLHL6tXQu
         L67m89axZ3atNglt5rGg0LeIeJMJ97jK3SOy+DmbDdY5sV/RTCrdK40YD4t5iZoxqN
         wlemh04Wm9Y8g==
Date:   Wed, 4 Aug 2021 17:15:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
Subject: Re: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
Message-ID: <20210804161501.GB26252@sirena.org.uk>
References: <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 04, 2021 at 10:32:52AM -0400, Peter Geis wrote:

> Removing the vmmc phandle from the sdio node is an option, but then it
> doesn't fully describe the hardware (it's also a non-standard 4.4v).
> I had considered changing the check in dw-mmc.c [1] to continue in the
> case of -EINVAL, but there are other places in the regulator framework
> that can also return that and it doesn't address the underlying issue.

What is the underlying issue that you don't see as being fixed if the
MMC code is able to cope with not being able to read the voltage?  If we
don't know what voltage the regulator has then no amount of wishful
thinking is going to give us that knowledge, if we want to proceed with
controlling the device then the MMC code is going to need to make some
decisions about what it's safe to do given the limited information it
has available to it.  Otherwise there's no option other than providing
the information about the voltage.

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEKvQQACgkQJNaLcl1U
h9C12Af8DblVDI9WXSmbrPRXViKHLSNZFzqp2ZuGthopEX5957SrGd87e5iV+I/g
gre6Jo3qS3dGIailxhWX4Tcyd/OztkwsS4V9ep1FBb3Iqo6qBbByMHwD/w2wF7sw
zYDzwdN0yUltexPHqnPjxatTxrTL09SM8NnIl0018t1hl5UKtM/KU8YN6nFJEPLH
4Q2ooIe2pPSz7gsg4fW1xsmxJXCqUulFtoyK59mwoHrvfdrLWWIXvvCh87c7LCxk
kwhYlg3SbIcZlZvLL1lVcMbPnZj6F3lClwHbzhy8jAP/LXF0rtFjbvDjZJZUImq/
3BOF/lOC6PcaomF/mguPVTzZj2XXoQ==
=L2o3
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
