Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4640C433E6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 09:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CE264E12
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 09:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhCDJai (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 04:30:38 -0500
Received: from www.zeus03.de ([194.117.254.33]:43748 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237615AbhCDJaN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Mar 2021 04:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=fO6NdWqp3/183GzeU74QNCNFala7
        vA6wT5XWXfj1Nvw=; b=uFPwCu/tdSn6wTaV9GK7swIbk+KdrgqDpyn+MgcK4GIZ
        5NSgz9b9EpLdmPvuotJzr+OhbgJgKs+B+1eRKD3ZvaYRrAGK7OZYCoAWeS9lImFM
        WLq3/9O9/Imv2Fb890N9Y+c/DR5ia7kuh1YPnsodcjols6GKD+UKus0PZFam1bI=
Received: (qmail 1778904 invoked from network); 4 Mar 2021 10:29:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Mar 2021 10:29:31 +0100
X-UD-Smtp-Session: l3s3148p1@pd/VmrK8JoJQT+F6
Date:   Thu, 4 Mar 2021 10:29:31 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 1/2] mmc: tmio: support custom irq masks
Message-ID: <20210304092931.GB967@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20210223100830.25125-1-wsa+renesas@sang-engineering.com>
 <20210223100830.25125-2-wsa+renesas@sang-engineering.com>
 <CAPDyKFrdxYNBeV4Fy_NJ+1JdF9OtHaxXmSdnvyepAPH4cxUs2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrdxYNBeV4Fy_NJ+1JdF9OtHaxXmSdnvyepAPH4cxUs2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> To be clear, I am awaiting a v2 of patch 2/2.

Thanks for the heads up! Just sent.


--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmBAqHsACgkQFA3kzBSg
Kbbnsg//a5YoKBpCGOMvbH8Hx7+gLnOkIgV5vlntmb1W2ilT9SRwjjAQnxH0sM7L
ydLttNW+qljVhl1wHJYDw5h/JuZMvefUTfr+eFsnCn/BKuh7VKnWbIqiyLf4hmmW
qqqAz/44VUxWZlc1hyZsq2Sn1R9pTSMygvTh6dlZnbdJmHaj3MaYbIwdFH28foo3
a8wqNLaV67ObIefHxVmIoiCE6O94r1XUk6UjVLLXoYKj6UWV/t7BxnuF2fpIMJ34
bfOXxwJKBNICEw9K/GdrLXppNunDYyGVWRm2RiMT5/jn5Cpq4+iYJ6xjYZ6ReFrk
JA0eJa1ZbdOoPlJfR/fFZqSjupkK67I8X+uEDk5PzIoHpXA81IdWzAajnJMDLrFC
fAD0fYjV+MEpnnPbhDmZjauLGl2pD7aLUsiOEJqGVGmUuJybzrbyNCDZ5DO03NYQ
1H0R4hgnOihpTW7WhQCASQz+uISX82EYRGgQqaMwgRk+gKL6PjZF22rkVCQTAqWf
Y/IkwukQXQ08IBgMY9yDVcUjgqC1tKxx+Uxou+YNIoaXjG2Kg7yu2PdfR+T0wFVm
l4m+daRVeDJpXsEkURgtLzBjCIbrtrL59vfzGTg/bgT49lDrqo5BH4HIADS/PCFB
qstG73vOYQaeuwCeYHskN7lmhIspVHekK+kZ517WtglrfQ9iGaM=
=YhA8
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
