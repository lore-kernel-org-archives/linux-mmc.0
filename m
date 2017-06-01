From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/9] mtd: nand: tmio_nand.c: take in account partition
 parser types
Date: Thu, 1 Jun 2017 10:37:49 +0200
Message-ID: <20170601083749.GC1477@katana>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-6-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39744 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdFAIhv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Jun 2017 04:37:51 -0400
Content-Disposition: inline
In-Reply-To: <1496270458-6479-6-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	retval = mtd_device_parse_register(mtd, NULL, NULL,
> +	retval = mtd_device_parse_register(mtd,
> +					   data->types ? data->types : NULL,

This is superfluous. You want to check against 'data' instead as it is
done below. Otherwis you might get a NULL pointer dereference.

> +					   NULL,
>  					   data ? data->partition : NULL,
>  					   data ? data->num_partitions : 0);


--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkv0l0ACgkQFA3kzBSg
KbZ3jQ//SMLSH7KRaP3ZgQfmpnqLUv6/xstDhcO1qz1+8ReMP+YL6fuTfyLQYjEJ
FLt0l1t5xFfZ0l/nn9T6vAkGW3VA6aqqftTs81PufJRuoqwALU2NBfqrM+Kd8BH/
YZOUilmBHK2jD+dHjQ1++bjFvri0ZLWShtZ50kh0WihlhhvOgndnDPSWt6QD1ZVL
0fsq2o1ygYz+TQgdflGuzUGhzUcaqAQmF3IQGTaswk+W1sGUls+elSWaau+R40uY
zHasxq3mEIef68HPf2mvzEkY7Y2z3Fjnp1cg+WpuUtJxxi+B3nvjjZxJIw94rx72
39uilSglZrpJH1WwVcr5Hm1MnvdkX8/3a7JLQh9PfVKp4e1Qd4A9VpUVqtpWPqy5
mzfd8RVjyLh5+Q67dzuqUHxQJ0VzsVbrwFFaPhPgMC8Xmb/drHKtsTXgCjhq3yz7
cCwu9pT4vhYJ2OC3l1DXedj0aTsORDvvyRTunp4F6ORXjHMIP9PAiXieY6WfOGGb
BN27KNxeTTO3y9Y1xnWRI0gf7/WWfKGsJ3kjl58HYe2VEw5kpEm9jha62UxWF7Xv
4ldwB9q2pPbSmvAtnTNeEJjtx9h82EVq74KNTKROqAoo0GIwTqyuB/9qQYyV1D1O
Z/oTut4Q7EoQNVqkoiRCJRiR3oJeTnA2xydXdFKnop/Afm3vo0I=
=KqAq
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
