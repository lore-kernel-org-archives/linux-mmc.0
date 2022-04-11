Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA61CC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 19:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbiDKTNb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiDKTNb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 15:13:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFC21247
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=MEztGxiZtcGsGPF+82W7T5Yu1Meg
        YfdVgGjXGuZVdGU=; b=o0Rltl3PKROxYj+Wve184VZU8EyAl7LzNu5Wg4C1a8fV
        FtmDHzMNACv5CeKGmt890KXJkWqdMK1fmqwkSn9J2P5Upv6vEf0WPz6hBB2OVebC
        LQUSAibutqODI5vBP4G3/aN7b8pb2k8tGMinS0eLYh83OOnUIWi6jkoPsvEG3m4=
Received: (qmail 737394 invoked from network); 11 Apr 2022 21:11:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Apr 2022 21:11:11 +0200
X-UD-Smtp-Session: l3s3148p1@eHPjtGXciOYgAQnoAF35AOa1UwYynBBW
Date:   Mon, 11 Apr 2022 21:11:08 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: RZ/G2M Hangs when booting some SD cards
Message-ID: <YlR9TCeV8FJVu38U@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WWw6IyO/IIbz2K+K"
Content-Disposition: inline
In-Reply-To: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--WWw6IyO/IIbz2K+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> I was thinking about taking the math from the U-Boot and porting it to
> Linux to see if the issue goes away, but before I did that, I was
> hoping someone might have some insights to see if that's the right
> direction to go.

Thank you very much for your detailed report!

I have one SanDisk card which sometimes fails to probe on one specific
board, so for me it was really hard to debug the issue because it was
hardly reproducible. Can you tell me which cards fail and if they do
that realiably? Also which Renesas HW do you use?

So much for a first response. I will have a closer look at your findings
tomorrow.

Thanks again,

   Wolfram


--WWw6IyO/IIbz2K+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJUfUcACgkQFA3kzBSg
KbbLvg/+MxKB55cARvJVjhU2+ltb0asIDLSUsDLhroyr+pujqEruNzqIW+9mtGLu
obNhJcnQsBt2CNE8R8Btt/2diEEMCtzYG/W1xE/UM158RINq9A9zwtIaSOs4TvVY
1NEREvdOWpUn8csVpvXVyzueYwhd5mTK1AsHFpir0NOrU0CJ5rqDGKHx0j76c8Ph
30CFeK/qYqLlu/12yzPo2oLJCfRMfn2n3p9svcQZnZTvkEnB8dQPiYu5o4jpnoWJ
OSNkTihjJXX4v2sZ1Br1E+jgrl+aXCwsOMOrOsCoidjGh78ylwZPjzLmbNZ7n01y
9g4Ob6f3l/24ZBEvisgu/ZkfuFrLVYEUtq/XKpvPMzopVbz1PKonGyPsQPa3Az/n
xh5tUjd+blWXfA/snjcaCK7gZ7RoBr9xN5iQxvZ6NNGvtSmAB1/dGAw7ACnope0Z
WBcguTDCCXZ0qpLbVR/3MX4m2pT7HBh9eh7V/6eyM6vrbto8B6Vj3PmTl4DDEABu
fx1QVx3Bitf7Vre/3reAi2h+Jil5opVBUNkAS5RCvyMrHIz+4Ueq/W+lIsINHtgn
0lqqY8pDO5F48Oza3x3PKWhIxkcaK2PF275PItkC35uW2F5s6n/BljcOjXZx5Cu3
fY1G5osc9Ls1KbJqu9SX/ViPr/3rLXbWlswg7K2cOoc1l0wpuyM=
=+jOD
-----END PGP SIGNATURE-----

--WWw6IyO/IIbz2K+K--
