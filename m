From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH] mmc: tmio: use ioread* for repeated access to a
 register
Date: Tue, 19 Dec 2017 14:20:24 +0100
Message-ID: <20171219132024.wa3vbqqbwwrmrb2m@ninjato>
References: <20171218000021.16655-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFr5A7Qma_Ef5JMjvG1f_Er+f9K-tnj39_q0Wg2aQ7nY5w@mail.gmail.com>
 <CAK7LNAS_rRp0RDbmEhahKPkcYJ=Yopj7WGRcuhQLz5WP+FFE1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zmhyfsy72dpmylqo"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44135 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965422AbdLSNU0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 Dec 2017 08:20:26 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNAS_rRp0RDbmEhahKPkcYJ=Yopj7WGRcuhQLz5WP+FFE1w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>


--zmhyfsy72dpmylqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yamada-san,

> BTW, is ioread* preferred to read*?

Technically, yes. In reality, mostly not.

> We need to eliminate the root cause.
> Other drivers using reads* cannot enable COMPILE_TEST for the same reason.

Sure, I understand this. There are not many left, however. I'd assume
most switched to io*_rep. The sparc64 issue is known for at least two
years.

> Wolfram,
> Can you send a patch for sparc64?

As I wrote here already [1], this is too much of a side task for me. But
if you like, please have a go...

But I'll send the consistency patch for tmio in a second.

Kind regards,

   Wolfram


[1] https://lkml.org/lkml/2017/12/15/816

--zmhyfsy72dpmylqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlo5EhQACgkQFA3kzBSg
KbaaZBAAhD3QQQhq5VcY9J3VcbM8HWOZC0HoPAtav5qtKII0HsG4ubnlLbsg2wXM
ga2cLvZKjxIkuTgGh57A7d7ksL2vJAupiEECNc3GVZEr5HsbFD4+pdOJAwxGbyZ0
7iRMOLBuR53+JshUSqDYc0lKQkgsUedcn9bbbRBxBBx2uJ2Oy2qxi0PgUyG6lmB6
xp0qhryxZxLPQmOXA69jNoZ1nf68RE64aX2ScLIKCvol8ZhVbJmfkrn2Vv93qepq
fcyIdHTMYNVLNI3BHevpwi+uPhbLOrQshEEUMU7ijpvWQRW8KK/MQuO30+00nIn9
CQA4MPP/3NA/p+KAx1ITdHViOMZzwOnm0X0pkYwZiHV+0Pw+YqIBXtubJZh/bFVX
l/lLaROLagC3aH1wKQia5QieXdrTIzufxbQ+2vcFAcUE/wB3GtuqPGJnLSlbYefl
eUP/WLQW1nx7zI4OmBQddYNxdou6on/DbIN4Psc1XCLX6fa1weWzQx54Hke1AsAm
H4D69Gwa6MIMwSahGf9dR+9Tw9oX59j0kUKXY05lQmVCEAVFlnyAy+3Zg45ZAzZN
DzitoqUHPYkNuoA1tvdXrTQnHKJAG2/mdKdUe9503oydStrIIwweEAkxkYaZSsB3
EptAO4jIzZBrioskybEV4XPFddTJjQOWhSdmCjeYQmZqyLTVM+4=
=ygn7
-----END PGP SIGNATURE-----

--zmhyfsy72dpmylqo--
