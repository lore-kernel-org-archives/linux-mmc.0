From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
Date: Mon, 15 Oct 2018 00:33:11 +0200
Message-ID: <20181014223311.GE3260@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> In further testing in uniphier-sd.c,
> I found my stupid mistakes.

I don't have the uniphier HW but I still had a look at these patches.
You never know if there is something interesting for SDHI in there :)

> Can you squash this series into
> 3fd784f745dd
> "mmc: uniphier-sd: add UniPhier SD/eMMC controller driver"
> if you have a chance to do rebase?

Please don't rebase! We actually develop on top of mmc/next and rebasing
creates a lot of pain because we lose the base for that work.


--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDxCYACgkQFA3kzBSg
KbZz3w/8C+AjQKdK8RwipxwPj7yxXCIEz1arXMXn/FhWTo4KwFI0bwESKdFGDcrr
edcGkc7Eqj52t6Fs9onpc+mbOUfaMWhBIqHUJ5EJz4RMKhPVFFWgZDm+5nNCduJn
bCb+Z+g91ww6APySwxDxeE/PVUDbVa6X7inSDAaJUmdnWzl4EDjHPB9pKRLqNxEM
UMo8QQEyYFCvgfh5EDaQW5DYb8UpSHfcGQyCpDH9041V1E6ouQhVjuoMAzIU8Co0
qB2zV2+TcIDZXX5hHUfYoNwubWXQNJ8QPqhFzMutfZc9DItL3F92K4sht84HUZ2h
n0KHVvt0mkdsQ3rLKUuCatXdQONGxiMH5rTzmdK6+U5V6nb4F9cxL+eYs0C2mdDP
7Vdiuuh64D/d4nos5BQsrVrlDeMQ3vsIXTOOtaPa5PhmHp31JdrWn9ZbiiysdTaU
jaFcksIhMwWTV+EQ1bH5WEeNkUmKij40/5XFgboYrbNSobJdEqNo8P3qqhIfJrew
2nhhB03501bg0ph2Wh+rRBXLb+rWxqRRhXXJyFi0xO2qyjqtdA1UJjrofFKewbuv
Z3eIWKHfJ5yfibeJ5YKWdQ1LG9WIm4Gl37w3E5J6/jyAcZklTmEaTGOBaiT1uxlw
O/iLkAQQyZETT+dN5u3eC/6NW0MiXUNTO/1mZObCHC1surmEXo4=
=pbql
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
