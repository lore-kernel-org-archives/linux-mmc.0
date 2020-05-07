Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_HEX,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF74FC38A24
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 11:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFEF20870
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 11:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="pgCCX3wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgEGLXB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 07:23:01 -0400
Received: from www.zeus03.de ([194.117.254.33]:50558 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGLXB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 7 May 2020 07:23:01 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 07:23:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=SdKy8iDU7Alnp6uHDvNeGnGfcawE
        GR6FnzZWKpyn6dg=; b=pgCCX3wysaFvf7kpSZVrWMeEMM5CTAwPw70VtzkleU4X
        1A2W9LqUsFopN82LHv3dFDu4HAx3Nyf2c4sUPNI88eXD9lKzIBFtiA/cTyoRvhZU
        Ydc6MKcKlmTzf+/+3/eSys/mpa/fVZcBYbaIf8l+rMiIuEhwcH6JvfQnN1JWZUU=
Received: (qmail 1058357 invoked from network); 7 May 2020 13:16:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 May 2020 13:16:18 +0200
X-UD-Smtp-Session: l3s3148p1@OVl+Ag2lANIgAwDPXwlDAElIrGE6fTK4
Date:   Thu, 7 May 2020 13:16:10 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: tmio: undo PM autosuspend when removing the host
Message-ID: <20200507111610.GA1598@ninjato>
References: <20190109223452.11184-1-niklas.soderlund+renesas@ragnatech.se>
 <20190109223452.11184-2-niklas.soderlund+renesas@ragnatech.se>
 <alpine.DEB.2.21.2004291630090.4052@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004291630090.4052@ramsan.of.borg>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> When unbinding the sdhi driver on e.g. Koelsch or Salvator-XS:
>=20
>     echo ee100000.sd > /sys/bus/platform/drivers/sh_mobile_sdhi/unbind
>     echo ee100000.sd > /sys/bus/platform/drivers/renesas_sdhi_internal_dm=
ac/unbind

Confirmed. Happens on my Lager and M3-N Salvator-XS, too.

> Removing the call to pm_runtime_dont_use_autosuspend() fixes that
> symptom.  But that is definitely not the right fix, as doing so causes
> genpd_stop_dev() to no longer being called on unbind.

Yes. So, we agree that this commit seems correct but it just makes
another problem visisble?

I'll have a look. Thanks for the initial pointers!


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6z7fcACgkQFA3kzBSg
KbYVaRAAm8fXa9GaBX2NPB0I6G45ymZZT/kgApfipevacUCny2wjrNoYTpWYE+2C
WQaSruyIA7iwmrfpAVB3lCkYDQQQrGpDpUv9fxBjSIylSHc9PjrauqFvuweinRR2
Y72UY0/S2OtPK8j1gYjmuRI/5LyTjw7gg0XUUJPDR7+2bEYUTQFhUNk/5YOZBMy9
LZhsSjJZBoHZ+0sch2qMLnRRnctPn35d5yUwGu0IwwhqzLWRIWDr/bFIb87roF6g
8/A6gjSdQfDcJcn2zGxdBFnpP2KT03EQg9v/4umlVj5jS2hNM3sV/hrnHBE92qcf
LDgnfGKNjRsg1DhVkTtjaQzNl1bRcMnHqTtBSrgpsPaS+2UtZq9FI18fiztc4ed7
KI3ip8okWGd8JiL0R0tbTfqAhDsU+PrFiiTS8jXmhW3qGNt+WY9cWyj+Vk1lNlAI
OvukkYklhOhBefKlRXEeYLWb8oi1vV351w9s4+4S8sR1tmbB25wOtd0MUW/s+dU+
VCKvqotlCuFNSdA48AY3Dr/qBG3tTVKGYllVY7HbWBxKA7fwerqXXqlyxxfwKa2P
L+JK3T/v9wEhaXbwecwHd4PsnM37rfjfBxact+P2cZVNRxeuKJlMUB7MsjwAtRCK
QoeV/HWLnDumezA7yX7wm0BvrYdOmx7leN3/29Xp5kvaWHwGjq4=
=axug
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
