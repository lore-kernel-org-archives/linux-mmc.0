From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 13/16] mmc: tmio: fix never-detected card insertion bug
Date: Wed, 7 Feb 2018 20:38:35 +0100
Message-ID: <20180207193835.ildbw2wt2zeha6eo@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-14-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zw4qzvuln4pkl6sg"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44402 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754108AbeBGTih (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Feb 2018 14:38:37 -0500
Content-Disposition: inline
In-Reply-To: <1516206496-16612-14-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--zw4qzvuln4pkl6sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:13AM +0900, Masahiro Yamada wrote:
> The TMIO mmc cannot detect the card insertion in native_hotplug mode
> if the driver is probed without a card inserted.
>=20
> The reason is obvious; all IRQs are disabled by tmio_mmc_host_probe(),
> as follows:
>=20
>   tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
>=20
> The card event IRQs are first enabled by tmio_mmc_start_command() as
> follows:
>=20
>   if (!host->native_hotplug)
>           irq_mask &=3D ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
>   tmio_mmc_enable_mmc_irqs(host, irq_mask);
>=20
> If the driver is probed without a card, tmio_mmc_start_command() is
> never called in the first place.  So, the card is never detected.
>=20
> The card event IRQs must be enabled in probe/resume functions.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--zw4qzvuln4pkl6sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7VbcACgkQFA3kzBSg
KbZafRAAp6E7dIQ958qKwfAz1I19l5Xq8APvj/XH6l0YDqVWKOn30/OxM1zOmsZ1
qZz8pg28z6VFKOsIFyoBoAHvpOi3XofdHI5F9vLpWkGiw6PhpziL3LKKbTBEYatl
Va/pbvfLc2d2LOLbrYcyOvrsrBdKibSyMhHhhvitvuYwux2haEsnEEKAlerYYil3
gg2FsEtldw/zUN1lolwxy3mBRQruGACnY3JMwHmQxM76ud62ERbBRPP7Ec8jdf4n
e1G/MletvlfauvvJh4TVcJTDZhHmnfzprGss1PNbDp+AieNKbJm6yZFw/MDq0cNA
l50YsHtyH7PS+NyVqefi9hMmJjI3oznTGItfabX3C9Sqpv5iAEpkmpUI0OiO6T5D
LwTzOtZxprDUFINKm1BfS7/jlB9bms9qHpM9QJyMC0vP+jwpy83jp8VMD8izcV9U
o38HqCcBmVP4UdSoROjFqiEsi9N7ahZnJS99dIvVWXUKbW/HdyWSuau1KfuwDGAL
MLjL5a5GDZVoT7ubahZF5VHpIQpllf3VweVhvbyZTy/CKotGWEcl/TUBGmoQnZAT
0J4VaRVp4yU79rD+oAPnAQLxiMrsEhaxx1J5H7ETgfOCTtf1f9w27GC+YvNfP+Hc
6K6vPvRVg7Okjo3/WmYcBGKAPwICayVK24ZJ52TSybjzuCg/7hk=
=HLDO
-----END PGP SIGNATURE-----

--zw4qzvuln4pkl6sg--
