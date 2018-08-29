From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/6] mmc: renesas_sdhi: merge clk_{start,stop}
 functions to set_clock
Date: Wed, 29 Aug 2018 10:40:27 +0200
Message-ID: <20180829084027.6bymirtwvb4oiye2@ninjato>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-6-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5hvbzvoscyba3qyo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534999460-15111-6-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--5hvbzvoscyba3qyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 01:44:19PM +0900, Masahiro Yamada wrote:
> renesas_sdhi_clk_start() and renesas_sdhi_clk_stop() are now only
> called from renesas_sdhi_set_clock().  Merge them.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Nice cleanup, works fine, and I don't see any issues with the
datasheets. Thanks!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--5hvbzvoscyba3qyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluGW/sACgkQFA3kzBSg
Kbb1jg//Y3mpILZagitNh8Wly47dk54Leo3sO4RFOWHTHtPYH5Wf+NEb+9AG9B8s
yXE11YuK0+UN+PBIibCnCw7b/HnUbMF70sBtx+8BmU/Bxonan1qljAvDOA8Mj6RG
VHrLu9o1AbNkNGkThbv3Jz6JGXiqxXdIRhpHd2kKJaMA+FYsFgpjXRoUeia6xJyk
HlEQWiBb5X1EH5zppXX+zQt1DyKf1eQkN0w8HudJcGRsIju2KQtVgt1I7go8ZWki
5R4O2RiM6JPLyHSuHWPdhf6mdtBDVxAPaIOl65NlfSQrEkKJq6jaYe+NS3pi05nN
rbcywEEhOcFMYwoGhzRbKeDuFGoqCOMVDED4uHTxiDoYcd/kDa8xgwoRcuKxPT58
bGUNF1G1yoOwXh0nXMNg2AgPwq6ijJfrSHNmb0u4RSx2C0mDCUiJENvPredx/k3y
Ndo3B3R7hYZJHBw5fOEkt695bdx43HLG9y7fIKDbwf+rpP+ch/caKZAyaRsWJmxS
3hyYUxoIDcIGNmew+vLChbJlophTcuYkWp2Gy5cTGfFl6xf6KgOLFLieOil3u4oF
/iYcBeNwRc/zpA9QBihC+xTGCwabn9419ZHOa+1+I1v57t88ZBELmJIBtuJVq7EG
VIeKg085sFhrDWL1xAkdMDvlkWUUiZ4D5bjI9gk3v4N1saVNWYo=
=MxpU
-----END PGP SIGNATURE-----

--5hvbzvoscyba3qyo--
