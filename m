Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9FAC56201
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3404622253
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 14:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="zmhhMpBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKTOvO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 09:51:14 -0500
Received: from www.zeus03.de ([194.117.254.33]:39078 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgKTOvO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 09:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=1rCGpsXgE6NUHy85wd86XpoNDlTq
        HrGpHm9mYeyg5bM=; b=zmhhMpBUak7u4Td9EiKi9B2lriOeErSYA3v4ifxLj7Qa
        icWgRd/0htvCSy3r0fGrU9kMFN2an/2plzWtJUKiFQ/K4FAP5Pwt8CBXFM9R033t
        CmEf5NmjcVyCXhWhB3VO632sUEsIuDbjmzwI9nt4sRuWN/DHgTkPoo6Na6qwUL4=
Received: (qmail 1516414 invoked from network); 20 Nov 2020 15:51:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Nov 2020 15:51:12 +0100
X-UD-Smtp-Session: l3s3148p1@b/m9+Yq0/NwgAwDPXwi7AEBAgYxIRHZX
Date:   Fri, 20 Nov 2020 15:51:11 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH RFT 1/3] mmc: tmio: set max_busy_timeout
Message-ID: <20201120145111.GB2353@ninjato>
References: <20201120142629.98222-1-wsa+renesas@sang-engineering.com>
 <20201120142629.98222-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20201120142629.98222-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	host->mmc->max_busy_timeout = cycles / (clk_rate * MSEC_PER_SEC);

This should be "/ MSEC_PER_SEC"! Sorry, it was a bad merge conflict
resolution :(


--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl+319sACgkQFA3kzBSg
KbYU3w//XWZHKpPEywjJw4Dq8HGSMxEWcnSFPpdBg51/vS5TuPiKPcGQSAX9AdCS
dKkN8Xwf/89p0A+9Du7UfZy/gLcimKC9QcHvqezFfykT1ZX2J5T1BhW+WmgGunGx
L+htmJs3qn+DZZh1Jx6sDd9wZ1dFtsMT8QNa+G7KnZJmlVzOCMLDMWuleBbe1Xp/
/LJDGS9OOh8O89CKzmDHpAXh6iCuHLYqp9ysdGwzDS/Ozbb5bOWOK+u7OGbF4p7C
VFMyz9P3ksTd2UHYMozBzN2JybouvmhG3Cv1JISDIlD6mwC0hqwADZo/nt79aaoX
7jHewecNLm0CPvCgJxMZWtuCfu6fky3pWHzhhbL4Tqof5UEnIeObsQtEiYsp2Utq
UIGMN7rtsBeAvEOILgvG5IZb9jBeSrOjqVOlv7/OMh4V69dF/6dW9IPYa9sePc8K
bejvTxclkPWDUun2v1nTt+SnhyEM6HPPo2aX5sqHNU01wOkbfLGjGFnCBdLXRt1y
rKVrmVaJs1GFpQKdNikL8jvzBx5V0W7rhaJ0mCEPfaWdvTyAfTlmak/MDyvJ4ugc
+wVl0nfwcV1Ub/CuDxinVP25EqnQpVUJ9iyIvP+pWHVT7bUvDM3Zr4kUUWTn9a+z
oOIuK1vuc5eI18370MOtgB/TyUDw3WgpmtGiRVp4LEGcUDtEhIc=
=FvCM
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
