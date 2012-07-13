From: y@pengutronix.de
Subject: [PATCH 09/11] mmc/omap_hsmmc: add a const qualifier
Date: Fri, 13 Jul 2012 14:32:12 +0200
Message-ID: <46831.7579165616$1342182836@news.gmane.org>
References: <1342182734-321-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1342182734-321-1-git-send-email-y>
Sender: linux-omap-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
	drivers/mmc/host/omap_hsmmc.c:1808: warning: initialization discards q=
ualifiers from pointer target type

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index 389a3ee..5bcd043 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1805,7 +1805,7 @@ static int __devinit omap_hsmmc_probe(struct plat=
form_device *pdev)
 	if (match) {
 		pdata =3D of_get_hsmmc_pdata(&pdev->dev);
 		if (match->data) {
-			u16 *offsetp =3D match->data;
+			const u16 *offsetp =3D match->data;
 			pdata->reg_offset =3D *offsetp;
 		}
 	}
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
