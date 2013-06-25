From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/4] mmc: sdhci-s3c: remove the duplicated calling sequence
Date: Tue, 25 Jun 2013 10:20:59 +0900
Message-ID: <51C8F07B.5080205@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12306 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3FYBU5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jun 2013 21:20:57 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOX00KHID295570@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Jun 2013 10:20:55 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>

Didn't need to call the sdhci_s3c_notify_change in setup_card_detect_gpio().

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index f1d5965..64defad 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -409,20 +409,18 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 	if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT CD") == 0) {
 		sc->ext_cd_gpio = pdata->ext_cd_gpio;
 		sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
-		if (sc->ext_cd_irq &&
-		    request_threaded_irq(sc->ext_cd_irq, NULL,
-					 sdhci_s3c_gpio_card_detect_thread,
-					 IRQF_TRIGGER_RISING |
-					 IRQF_TRIGGER_FALLING |
-					 IRQF_ONESHOT,
-					 dev_name(dev), sc) == 0) {
-			int status = gpio_get_value(sc->ext_cd_gpio);
-			if (pdata->ext_cd_gpio_invert)
-				status = !status;
-			sdhci_s3c_notify_change(sc->pdev, status);
-		} else {
-			dev_warn(dev, "cannot request irq for card detect\n");
-			sc->ext_cd_irq = 0;
+		if (sc->ext_cd_irq) {
+			ret = request_threaded_irq(sc->ext_cd_irq, NULL,
+					sdhci_s3c_gpio_card_detect_thread,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					dev_name(dev), sc);
+			if (ret) {
+				dev_warn(dev,
+					"cannot request irq for card detect\n");
+				sc->ext_cd_irq = 0;
+			}
 		}
 	} else {
 		dev_err(dev, "cannot request gpio for card detect\n");
-- 
1.7.9.5
