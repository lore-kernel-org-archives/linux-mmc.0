From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 12/12] mmc: core: Add DT-bindings for MMC_CAP2_FULL_PWR_CYCLE
Date: Mon, 10 Jun 2013 17:03:47 +0200
Message-ID: <1370876627-13439-13-git-send-email-ulf.hansson@stericsson.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:56148 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753777Ab3FJPEd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:33 -0400
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The DT-binding for MMC_CAP2_FULL_PWR_CYCLE, is used to indicate whether
it is possible to perform a full power cycle of the card.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    1 +
 drivers/mmc/core/host.c                       |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 85aada2..458b57f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -28,6 +28,7 @@ Optional properties:
 - cap-mmc-highspeed: MMC high-speed timing is supported
 - cap-power-off-card: powering off the card is safe
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
+- full-pwr-cycle: full power cycle of the card is supported
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 2a3593d..17d8b37 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -409,6 +409,8 @@ void mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_POWER_OFF_CARD;
 	if (of_find_property(np, "cap-sdio-irq", &len))
 		host->caps |= MMC_CAP_SDIO_IRQ;
+	if (of_find_property(np, "full-pwr-cycle", &len))
+		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (of_find_property(np, "keep-power-in-suspend", &len))
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (of_find_property(np, "enable-sdio-wakeup", &len))
-- 
1.7.10

