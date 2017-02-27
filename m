From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 4/4] mmc: sdhci-cadence: fix the return value of sdhci_cdns_get_timeout_clock
Date: Mon, 27 Feb 2017 16:29:04 +0800
Message-ID: <1488184144-122285-5-git-send-email-shawn.lin@rock-chips.com>
References: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:52151 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdB0IeM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 03:34:12 -0500
In-Reply-To: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>, Shawn Lin <shawn.lin@rock-chips.com>

Return the timeout clock rate in Hz for sdhci core.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci-cadence.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 316cfec..bb3951a 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -103,9 +103,10 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 {
 	/*
 	 * Cadence's spec says the Timeout Clock Frequency is the same as the
-	 * Base Clock Frequency.  Divide it by 1000 to return a value in kHz.
+	 * Base Clock Frequency. Return a value in Hz per the requirement of
+	 * .get_timeout_clock callback.
 	 */
-	return host->max_clk / 1000;
+	return DIV_ROUND_UP(DIV_ROUND_UP(host->max_clk, 1000), 1000);
 }
 
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
-- 
1.9.1


