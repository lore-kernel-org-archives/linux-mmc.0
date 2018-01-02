From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 16/22] mmc: tmio: fix never-detected card insertion bug
Date: Tue, 2 Jan 2018 14:15:55 +0100
Message-ID: <20180102131555.z6amjfqtadkh2w77@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-17-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jcy3zqaq2z6nqblr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42237 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbeABNP5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jan 2018 08:15:57 -0500
Content-Disposition: inline
In-Reply-To: <1511540697-27387-17-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--jcy3zqaq2z6nqblr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yamada-san,

> The TMIO mmc cannot detect the card insertion in native_hotplug mode
> if the driver is probed without a card inserted.

Hmm, it works for me without your patch just fine. Iam currently
researching it...

Happy new year, by the way! :)

Regards,

   Wolfram


--jcy3zqaq2z6nqblr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpLhgsACgkQFA3kzBSg
KbaDcBAAouqc6tOdEeWmKxoVOKP/PS1xRl79B+0Btgx20v8taNxoLXhIaGj5kq6F
Nzygzx3a5OzksOyZhHlVPm4JZZNsnUaGirnEMf+ly1gh3ZwOUTjmWRMZoMawPFfk
sLPV3xI5Kj2O/EI0OWOUxM6sXM6cdDadCnNchaDrnwRgSGClz5igabb203uZxnhy
uJJ5b97sqwEvaLZeAYHdz0YB9CBKU3vvjvbCfKB5TrYWKy/6DTiQaX4t11F5NfeC
EuCwNIly0hSeeVPXbZrY4WE9ZJy1enEXtTvmp01z2H/xqYaDOkOuvil9ITwq/e6e
h6nnOKdFCQzcsPm/WU76NpT9fiPb+nBKCr5o57VMHbEj5bz2fTnvHAZUWUoO8YBS
KZvm+OhGSFPs7qY94hgvbV7KR3hpOPn72bdHDl/BtySSFDQvJpIQ0z82CiMEJIMD
dHmj0+/kfmkdzv2QH6hozziAeuHn8zNf/0xrVyy5Tpj3DzDlU6HH3P5yqSyiRNlq
xAWVtnKLa0IKYJOoWjJRfEg0MzWbkRGgslwK6atXmNyx8XOvLsIjfm0GaS4FMSCi
Bp41xKckq4V+DWHqJTKdA1ehOL82PhVxqKNB+1ZNQmkF47/znvlUExHIOqexAZP+
+LI/XocxhED6K2f4dqqPSsLdcC8js1C+d4/fHPGkkyZ8z0f1GK0=
=gP2v
-----END PGP SIGNATURE-----

--jcy3zqaq2z6nqblr--
