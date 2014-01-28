From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 8/8] mmc: core: use the broken-cd for non-removable card
Date: Tue, 28 Jan 2014 17:24:59 +0900
Message-ID: <52E7695B.2050504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:61891 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbaA1IY3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 03:24:29 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0300LUGRCT6320@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jan 2014 17:24:29 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Some SoC is used the broken card-detection.
And it should be also used the "non-removable".
Even if card is "non-removable", it didn't always use the cd-gpio.

If it's used only broken-cd, then card-detect interrupt is polling.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/core.c |    4 ++--
 drivers/mmc/core/host.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 098374b..df732aa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2460,8 +2460,8 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
-	if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
-			host->ops->get_cd(host) == 0) {
+	if (host->ops->get_cd && host->ops->get_cd(host) == 0 &&
+			!(host->caps & MMC_CAP_NONREMOVABLE)) {
 		mmc_claim_host(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 4b81c93..52a64fe 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -356,6 +356,9 @@ int mmc_of_parse(struct mmc_host *host)
 	 * configuration is performed.
 	 */
 
+	if (of_find_property(np, "broken-cd", &len))
+		host->caps |= MMC_CAP_NEEDS_POLL;
+
 	/* Parse Card Detection */
 	if (of_find_property(np, "non-removable", &len)) {
 		host->caps |= MMC_CAP_NONREMOVABLE;
@@ -364,9 +367,6 @@ int mmc_of_parse(struct mmc_host *host)
 
 		explicit_inv_cd = of_property_read_bool(np, "cd-inverted");
 
-		if (of_find_property(np, "broken-cd", &len))
-			host->caps |= MMC_CAP_NEEDS_POLL;
-
 		gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
 		if (gpio == -EPROBE_DEFER)
 			return gpio;
-- 
1.7.9.5
