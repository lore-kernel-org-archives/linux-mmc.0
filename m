From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] tmio: add support for eMMC with 8 bit bus width
Date: Mon, 19 Sep 2016 10:00:45 +0200
Message-ID: <20160919080045.GA1409@katana>
References: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdX7GygtuA43=+HFFOyMGt=x1b2UTQBUojqedSfcRmSxjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35819 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbcISIAz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Sep 2016 04:00:55 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdX7GygtuA43=+HFFOyMGt=x1b2UTQBUojqedSfcRmSxjQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2016 at 01:52:26PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Sep 14, 2016 at 7:05 PM, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > The DTS changes for R-Car Gen3 will come via a seperate series. Note th=
at
> > 'non-removable' is not supported yet because of Runtime PM issues. It s=
eems we
> > need to overhaul Runtime PM handling for other reasons as well, so I su=
ggest
> > the basic support goes in like this and DTS do not use 'non-removable' =
for now.
>=20
> DT describes the hardware, not current limitations of the software.
> Hence IMHO you should add the "non-removable" property to the DTS, and
> work around its non-functioning in software.

@Ulf: Would you accept such a workaround for a while?

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pi=
o.c
index f21c92ec7121cc..5ab8af294f7c40 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1154,6 +1154,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 				  !mmc_card_is_removable(mmc) ||
 				  mmc->slot.cd_irq >=3D 0);
=20
+	/* Workaround for NONREMOVABLE until we fix RuntimePM handling */
+	if (pdata->flags & TMIO_MMC_MIN_RCAR2)
+		_host->native_hotplug =3D true;
+
 	if (tmio_mmc_clk_enable(_host) < 0) {
 		mmc->f_max =3D pdata->hclk;
 		mmc->f_min =3D mmc->f_max / 512;


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX35stAAoJEBQN5MwUoCm2cyYP/j7OK/U9g4YkOTKzFtbesEAS
4EUBVvd0ciSOw/j3EP7CqIBEd4hbgAGuZ9x4atHgNdLLz6z6Q+uJ3VED7gazpPv5
Yfln8BmTICYVZfCMCgAAecyh9oiWZk7nUfK0lREhHgHBwq+XY84fC+TWd/83CXem
pt/JNHOGE025bhjs6t6XOzM+cAlqpL/1Mvg1tvnNOOxEi7WqX3W4EuAnlmr9WWfc
kcUhrM15dqb8LZtJy+sDE21oOau7XUpmMzxuQQN9Mj3XxeBVbRBboXiuOCaIlf6g
sUzXCbVngT1zGwC/WCaA9UYQ5bl6kC9+6aANl3BY4ad/lexFHHU3kPcd1cujPVTt
0bsPgJDzvqMSXMPGYSKKdFSzMMbv+VnQ+hMM20F3bUSWEA32DSOB2uZMUSx3bRM/
a++3TB1KLzWSlVNuJYCkG6QZBXUaISmfrSsemtPAqN3/GN3/759OILCYjTAAIAUW
SDfXqGBbHFQGmOKRAkIdnaQSLQHJYzFjeTliNcF2oFYkpieOO5S73aWXrL9YynfC
4Q8XLPobrXq+46xiq8SyBny2VEVELPgVrbaj4jkWmzhQggbP+uM8pwyPS/WrhQD0
wBwWAJHTtx27ahWw1D2/0mxDjxalPq7XiL/8aqwc0B9+TtqQ05c+ZohxbwslajCg
vRZBSk/LRnBRiebik7sX
=ansV
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
