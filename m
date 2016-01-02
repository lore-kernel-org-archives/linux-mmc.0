From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Sat, 02 Jan 2016 23:57:47 +0100
Message-ID: <9361696.ohU1ACX8N1@wuerfel>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <4500962.b9ypZOL9bV@wuerfel> <201601021622.03763@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201601021622.03763@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Saturday 02 January 2016 16:22:03 Pali Roh=E1r wrote:
> On Monday 28 December 2015 15:55:28 Arnd Bergmann wrote:
> > On Monday 28 December 2015 15:54:35 Pali Roh=E1r wrote:
> > > >=20
> > > > I mean you can add the platform data to the omap_auxdata_lookup=
[]
> > > > table for this board.
> > >=20
> > > But can I mix data from omap3-n900.dts and omap_auxdata_lookup[]?
> >=20
> Hm... looks like it is not possible. omap_hsmmc driver ignores any=20
> supplied platform data if there are device tree data. So array=20
> omap_auxdata_lookup[] does not help.

Obviously you need to the driver to work with that setting. Maybe
something as simple as

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index e06b1881b6a1..4fa35fc84b8b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2006,7 +2006,7 @@ static int omap_hsmmc_probe(struct platform_devic=
e *pdev)
 	void __iomem *base;
=20
 	match =3D of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev=
);
-	if (match) {
+	if (!pdata && match) {
 		pdata =3D of_get_hsmmc_pdata(&pdev->dev);
=20
 		if (IS_ERR(pdata))


	Arnd
