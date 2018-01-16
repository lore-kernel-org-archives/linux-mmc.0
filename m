From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 18/22] mmc: tmio: remove useless TMIO_MASK_CMD
 handling in tmio_mmc_host_probe()
Date: Tue, 16 Jan 2018 10:44:09 +0100
Message-ID: <20180116094409.3zb3igxqf36vqype@tetsubishi>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-19-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w66ffc7p5kmmzqyx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44701 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeAPJoN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Jan 2018 04:44:13 -0500
Content-Disposition: inline
In-Reply-To: <1511540697-27387-19-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--w66ffc7p5kmmzqyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:53AM +0900, Masahiro Yamada wrote:
> TMIO_MASK_CMD is properly enabled in tmio_mmc_start_command().
>=20
> We have no reason to set it up in tmio_mmc_host_probe().  (If we
> really wanted to set it in the probe, we would have to do likewise
> when resuming.)
>=20
> Even worse, the following code is extremely confusing:
>=20
>   _host->sdcard_irq_mask &=3D ~irq_mask;
>=20
> The logic is opposite between "->sdcard_irq_mask" and "irq_mask".
> The intention is not clear at a glance.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

In general, I like it a lot. It just depends on the previous patches
which are still subject to discussion.


--w66ffc7p5kmmzqyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpdyWkACgkQFA3kzBSg
KbbPZg//THuCQ5KQm8pgYtSAt7zDChzdUAN1f9ozK1oBQQy5/jnmdpbmMw3aVitM
QUOwGX9vN/8V+IP5n37wFhec/sMw8FDHQb/lprCdgQtZPYA936/wPhsc8046Kqbj
siWeVKJKOxqxx45nOWdrYyVicwC0g7b8tN29kMbS+Qv+Dd9XmTATrISUpKNk8OAj
6pfa1afT/XVsrekw2wpG8e08whVCBYbnixgHD2p9NDNVtM03GtxLhbuUGDAklakI
cJS1xmGmER34q4sYJ9rRn+s7hnbF+0f/CwWzEpI9HDoOjRtetpfu3EbTk63p9wju
6gcfUtDfkrFrbAZtrRGmNuc9mM9DUxxKkob04mHqPbdTZA4yVtmxpjP49hm30IKP
xGqtbH4h1CNdnhRFw/RrTqU2u+J4TS4tqhNnJM1wdta67isWR8K/UYkCpog50Tf3
GhSD1OeSeDe2HmL0UZodmj1yM6dkLmAe9aLsviX+qJhS3QRYHEuX+cqOZ+IPTVxH
3xrj9tEGoyJI/YvaoKhj1QPYola3smckMqWdnKXpUjlVwj6nBKi9A82Xd7UB1lzB
SYtLcpSlJjrANY5um8/BgQRAmZMPQb6g0Wyv1xtFXcaNSrC4+tzagiL1U6OVA7sX
WgCIggMWA5ZJ8xpH0+rQ7ePX2R3xqeOnlxULdPtsNLYGEsdqdZU=
=3h90
-----END PGP SIGNATURE-----

--w66ffc7p5kmmzqyx--
