From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v3 8/8] mmc: sdhci: remove unneeded call when have preset value quirk
Date: Fri, 18 Oct 2013 19:48:50 +0800
Message-ID: <1382096930-7964-9-git-send-email-b29396@freescale.com>
References: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:3614 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753018Ab3JRMFi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 08:05:38 -0400
In-Reply-To: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

Remove unneeded call of call sdhci_enable_preset_value when having
SDHCI_QUIRK2_PRESET_VALUE_BROKEN.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cbde17d..a21a710 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1435,7 +1435,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	}
 
 	if (host->version >= SDHCI_SPEC_300 &&
-		(ios->power_mode == MMC_POWER_UP))
+		(ios->power_mode == MMC_POWER_UP) &&
+		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
 		sdhci_enable_preset_value(host, false);
 
 	sdhci_set_clock(host, ios->clock);
-- 
1.7.2.rc3


