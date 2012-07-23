From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 12/25] mmc/omap_hsmmc: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:17 +0200
Message-ID: <1343034810-3386-13-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
	drivers/mmc/host/omap_hsmmc.c:1808: warning: initialization discards q=
ualifiers from pointer target type

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
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
