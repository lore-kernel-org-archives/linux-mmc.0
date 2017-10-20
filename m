From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] mmc: renesas_sdhi: fix kernel panic in
 _internal_dmac.c
Date: Fri, 20 Oct 2017 06:00:48 +0200
Message-ID: <20171020040048.earbuflcoeur2wo2@ninjato>
References: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1508469162-12322-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b3lbnabjfzkklvvc"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35371 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdJTEAu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Oct 2017 00:00:50 -0400
Content-Disposition: inline
In-Reply-To: <1508469162-12322-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--b3lbnabjfzkklvvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2017 at 12:12:42PM +0900, Yoshihiro Shimoda wrote:
> Since this driver checks if the return value of dma_map_sg() is minus
> or not and keeps to enable the DMAC, it may cause kernel panic when
> the dma_map_sg() returns 0. So, this patch fixes the issue.
>=20
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Fixes: 2a68ea7896e3 ("mmc: renesas-sdhi: add support for R-Car Gen3 SDHI =
DMAC")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--b3lbnabjfzkklvvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnpdPAACgkQFA3kzBSg
KbaynA/9GLbneaCd7U2CozMQH1LVW+o5GyWYOkaEl6LqUBebkAjJhcOPzuh8KOtR
ZVxHMRRccLbAdix1Z4/eWK9I109tttAzg5WFvUFXkfwp2qJWrSMQAzb4xEYnAdjm
yH88c6a8itdlZfd045AAG/dXy/9onl+7nXas+ppSnrqYDJA6cYB2q+xhxUuWHvXm
5W1Nkh/waUESNyZBUkPp0uzUJKTerFlN7Xnl1pDDZLuRckvuik2/2T2ptouHG3C6
eKuCfPUwqgNK/ZWzjWarthtNOKVzCFnTkqlxcSJBNfXJYahv1xl1jN5qY6IEz+yU
Qkd6VpYDNcqNRn9ywxNEqZJ0NN5hZsQg08+LCVXGL5KEvPUWSp1/3INiw+OSdTaZ
OwcuCcmseAvfyecBV2qQI7CIVDkM4NPiDL5sN+IOX7Z6iNWw4HKYqE4GC+MW1qtU
39Zrl1quIM4SWjsc/l6bMlQ83YPyThLvgSdK5Zb/HA8HMOT1xuuhz0qdFA6ZHCOc
H+RzmJyTeq273qXY4JuuceUANGuNsw39ZjlJy8oCcbNldfh1aTiuSf5sqx6pzNzf
eXXus1P87gSoF6oEVx5OncUnsy3IsJzVRTE8TUTleBiGZ+qfF5gAD/RiPJv9K0xv
mtuJ3e9Buano2OGPO/FaFhj86aZYps7sLclWsiTHJkyFhjxu9SU=
=3t0X
-----END PGP SIGNATURE-----

--b3lbnabjfzkklvvc--
