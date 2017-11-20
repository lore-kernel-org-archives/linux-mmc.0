From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] mmc: tmio: use mmc_can_gpio_cd() instead of checking
 TMIO_MMC_USE_GPIO_CD
Date: Mon, 20 Nov 2017 21:54:16 +0100
Message-ID: <20171120205416.e2a7oqwqwxkddj5u@ninjato>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
 <1510136220-31853-3-git-send-email-yamada.masahiro@socionext.com>
 <20171119194719.v72z24ugpb2j2q32@tetsubishi>
 <CAK7LNARB17X701AXujOfT0kO-BouqiXxQxb2+fsJW=fw8CpejA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oulfr2rkzupd5qox"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNARB17X701AXujOfT0kO-BouqiXxQxb2+fsJW=fw8CpejA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--oulfr2rkzupd5qox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I am puzzled by this driver.

And now imagine that it is already cleaned up :)

I will check these CD patches tomorrow. I need a fresh brain for that.

Thanks for the work!


--oulfr2rkzupd5qox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTQPgACgkQFA3kzBSg
KbbUWBAAkUjVwsURCzhDw4lCpYSuOiToFmXIk+Ord9OfmIPOnAutcImEeTD8O3cM
IBTFVDLxtVUWcfaB8D75weU8Tns55x9vFmgOvlqvozp2ZQ9MiKgSpYSb9afEXvIe
xb2LQF3/0vXbgvQYXyZ56Ud2yilQitGMOqEPZOaSEBDvUz59XMnobHcW9r/CmBRq
8JLgFqdVc/7xto4+5CYFfmrpQWDJHX6QyCgJDWzSlbccLG89ifN96dVeNY3JmbJF
dHCTCg/To15O+Nmwh8fdRoGXv8KYGMA4lSzG2KFoet2nIddSQNIBi5Sld0xhuxA/
oTn9UQ0D8oxq+migECEEroysypVXNA1+4DF02qzzLWZ4SZGMKaRCBuAJf4zi+2AM
+Xpd56ovqM3LStgQ9OxpTXklzspuYMSu/DVaZ7wS4TFo6b3aPZ6p9CKYMRifCUPG
Pm9h+eScqWOcfsiZs61BtYELvDr0238nt83D7CtWlnUIAZE3SsCDQTLr+za6rbH4
RCsUsc3vmPWZgUlwmabLYBgiuKAt4OoYefkG2FcQjbd6Ck/OEVbbUyP3vsQaafga
oLybmwebfgGo79ynKOgaznH+IYUWuxmDgDlfQHWHdVJwHXcw73y2+mkfMVUpIZDJ
jb2r5d/le9T2UJwXv+cu9JbUGYR2+aOJ+xOgMaEgpssJCo+YHxc=
=dKsD
-----END PGP SIGNATURE-----

--oulfr2rkzupd5qox--
