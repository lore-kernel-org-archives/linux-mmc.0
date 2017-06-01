From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 4/9] mtd: nand: sharpsl.c: take in account partition
 parser types
Date: Thu, 1 Jun 2017 10:35:19 +0200
Message-ID: <20170601083519.GB1477@katana>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-5-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39110 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbdFAIfY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Jun 2017 04:35:24 -0400
Content-Disposition: inline
In-Reply-To: <1496270458-6479-5-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +					data->types ? data->types : NULL,

This is equal to just 'data_types'.

> +					NULL,
> +					data->partitions ?
> +					data->partitions : NULL,
> +					data->nr_partitions ?
> +					data->nr_partitions : 0);

All the ternary operators are superfluous.


--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkv0ccACgkQFA3kzBSg
KbYlcw//cNNLZ28mviDeCyFiPIh8xMdcjUqMHY6grqJMMQhwnQWfoKGTeLuuwPQR
zsSIZ1qg9n1EXXh2TljsV+Tehll1KzLRbu3KEYdCHsQKV9D1KXKu4Aup2VbFbpSx
fTTDDYgKJn9Br8lpjK8YrFOAXhejG9RFiFa2Tj4RMNUSzSMohBkrxrLdtCFOcsky
/N9cDF9vflM1HuZC3M0n2Y+SspiWxaUQVi1I1T/+H0f5BcGT2oVeB7UIAwxyOaC6
FGVsEWsi3oYbmBjEBug2YCOdlRn4rLEPzx97kIB+e2uUigGgSVC+nXC1JuHvB0CT
PUIKGOvHF27KVCgZCU98dGrVKviQq+cs8eMYTelYn66bijAiO4n+PDvx3k0KQRB2
yef7WS5JFUhAnCyDyo2/fpenSsJW0bDDOBqughl8uBEKmqXWmd0rgqcyUyQ5eHWd
vb9wVmPvFpCKOL1/xmCP78RpdVZHtPubxJuDUuac+kOLjWhcAZ/73cw1gpfjgEfe
5GYGpWXV2Ju26dZ440yauhCpVCimwnPVsLeGm4JN64gga/9L0XoO0X3zcapVqFyu
fMisSStOrRf/mZnp+2cN1g1AkbkXkbOLN3Sn/JskAXuFrgiZJ4FFYI+qt2fbhFI2
KemHC9jwfcg+2kHTCBACIznVaz/fRKuqwx/YPo2nqSrlL/fozgA=
=PgUW
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
