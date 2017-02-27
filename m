From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 2/4] mmc: sdhci: get the timeout_clk from callback in Hz
Date: Mon, 27 Feb 2017 16:29:02 +0800
Message-ID: <1488184144-122285-3-git-send-email-shawn.lin@rock-chips.com>
References: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:41741 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdB0Id1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 03:33:27 -0500
In-Reply-To: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>, Shawn Lin <shawn.lin@rock-chips.com>

We expect all the variant host drivers to return the timeout
clk rate in Hz unit so that it's more easy for us to work through
all cases in one place.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a7..9707f11 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3101,6 +3101,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	unsigned int override_timeout_clk;
 	u32 max_clk;
 	int ret;
+	bool skip_div;
 
 	WARN_ON(host == NULL);
 	if (host == NULL)
@@ -3292,7 +3293,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (host->timeout_clk == 0) {
 			if (host->ops->get_timeout_clock) {
 				host->timeout_clk =
-					host->ops->get_timeout_clock(host);
+					DIV_ROUND_UP(host->ops->get_timeout_clock(host), 1000);
+				if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
+					skip_div = true;
 			} else {
 				pr_err("%s: Hardware doesn't specify timeout clock frequency.\n",
 					mmc_hostname(mmc));
@@ -3301,7 +3304,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 			}
 		}
 
-		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
+		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT && !skip_div)
 			host->timeout_clk *= 1000;
 
 		if (override_timeout_clk)
-- 
1.9.1


