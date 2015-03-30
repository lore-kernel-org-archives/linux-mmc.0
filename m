From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v2 2/2] mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c
Date: Mon, 30 Mar 2015 20:16:08 +0530
Message-ID: <1427726768-17233-3-git-send-email-stripathi@apm.com>
References: <1427726768-17233-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:53879 "EHLO
	denmail01.apm.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752839AbbC3Or1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 10:47:27 -0400
In-Reply-To: <1427726768-17233-1-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch adds some quirks support to be read from fdt.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bef250e..9f6a4b9 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 		if (of_get_property(np, "broken-cd", NULL))
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		
+		if (of_get_property(np, "delay-after-power", NULL))
+			host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
+
+		if (of_get_property(np, "no-hispd", NULL))
+			host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+
+		if (of_get_property(np, "broken-adma", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+		
+		if (of_get_property(np, "broken-dma", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
+		if (of_get_property(np, "no-cmd23", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 
 		if (of_get_property(np, "no-1-8-v", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
-- 
1.8.2.1

