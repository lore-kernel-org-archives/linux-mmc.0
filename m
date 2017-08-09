From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Revert "mmc: sdhi: use maximum width for the sdbuf
 register"
Date: Wed, 9 Aug 2017 20:22:04 +0200
Message-ID: <20170809182204.qqswh6isep7eze5t@ninjato>
References: <20170803094947.1490-1-wsa+renesas@sang-engineering.com>
 <20170803095355.GA3251@katana>
 <CAPDyKFrpiXz0PM9uZZS8mC3ULBs2VNqfhpqwFM2QH+MZp6uG+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i2bblc7bsivaybxs"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33238 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbdHISWJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Aug 2017 14:22:09 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrpiXz0PM9uZZS8mC3ULBs2VNqfhpqwFM2QH+MZp6uG+A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Biju Das <biju.das@bp.renesas.com>


--i2bblc7bsivaybxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Instead of applying this revert, I decided to just drop the original
> commit from my next branch.

Hmmmm, yes, rebasing creates a clean history for occasions like this,
but makes working on your next-branch kinda complicated if the base I
merged has gone.

> While working on new version of how to deal with the 32/16 bit
> register correctly, please try to include Biju Das in the changelog as
> to give him cred from his help with testing.

Will do. If you had kept the revert, he would have got a tag for
Reported-by even ;)


--i2bblc7bsivaybxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmLUsgACgkQFA3kzBSg
KbbDqg/+OQ21AGiOHVw1ZYQjLDged1tDjjZgi+7ztzlCoNbs7NK6PfJAhqVrNdCL
lv7AEEICFsO+Y3tBe9FuUIaxlVmq6C0NRn4ywb5714to3jQNXruESL03U+JLfk3d
WgPm8PlIECaAGzC8JTL5NZ0dkXcPoQN0wWA4w06TN4Ss3NCHvBibPSifS3hxfgot
qbWZjYLT6sRo/fLXtokB0dWYWLsQKfyjydc98EvZdix2hVqsPHFUMj7mJK/AUHvD
aXJ0bphRLF0gOFTjvuRujnPCPz6XsD1l2QtsY+ohzaBLyL3I+32IPiGbTkEdlY25
Xmyk51Lpn7qqkwLlmXqc14TFXB/8bX7dB2tiyjrEpiPD4jpy0Uk82xpRLFBK0T7l
lfceuPdj9cLhqar5ZWlT9XKt/uQaTO/AkvZFVMiIy3L7WVr/ZXeZTfkCEnBc0EKJ
FY4HLjxxNtgwb2NdpzqsbAKp5Gs9poDt0oQhV5jB2SUfaGosrjJYBA72C2oKsgAT
nBjKBfzAnTm/BeRZXBR+KrJfGaE/gYqjkDxdo7MDqRspllGXPL7NVJMEM0VRImUy
aocMz3zIXNQcSj0+cITmGdoXf62vVJU/D+Cs1aCuRCBgJspmIYWESKVnngcZygdA
WIbyfs5BfUmezTH2Vl3UASG0iNvnTesQUDJmKuXQHCWli8ge55w=
=ZN77
-----END PGP SIGNATURE-----

--i2bblc7bsivaybxs--
