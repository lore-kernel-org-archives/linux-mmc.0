From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v4 2/3] mmc: dw_mmc-pltfm: move probe and remove below dt match table
Date: Thu, 13 Jun 2013 10:57:01 +0200
Message-ID: <201306131057.01769.heiko@sntech.de>
References: <201306131055.49595.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:43265 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757492Ab3FMI5E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 04:57:04 -0400
In-Reply-To: <201306131055.49595.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

In a subsquent patch probe will need to do some handling of data from
the dt match table. So to prevent the need for forward declarations,
move probe and remove below the match table.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 0048da8..9b05381 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -63,20 +63,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
-static int dw_mci_pltfm_probe(struct platform_device *pdev)
-{
-	return dw_mci_pltfm_register(pdev, NULL);
-}
-
-int dw_mci_pltfm_remove(struct platform_device *pdev)
-{
-	struct dw_mci *host = platform_get_drvdata(pdev);
-
-	dw_mci_remove(host);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
-
 #ifdef CONFIG_PM_SLEEP
 /*
  * TODO: we should probably disable the clock to the card in the suspend path.
@@ -118,6 +104,20 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
 
+static int dw_mci_pltfm_probe(struct platform_device *pdev)
+{
+	return dw_mci_pltfm_register(pdev, NULL);
+}
+
+int dw_mci_pltfm_remove(struct platform_device *pdev)
+{
+	struct dw_mci *host = platform_get_drvdata(pdev);
+
+	dw_mci_remove(host);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
+
 static struct platform_driver dw_mci_pltfm_driver = {
 	.probe		= dw_mci_pltfm_probe,
 	.remove		= dw_mci_pltfm_remove,
-- 
1.7.10.4

