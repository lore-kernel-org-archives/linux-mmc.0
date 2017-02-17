From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 3/4] mmc: sdhci-bcm-kona: reuse sdhci_pltfm_clk_get_timeout_clock
Date: Fri, 17 Feb 2017 11:56:19 +0800
Message-ID: <1487303780-234812-4-git-send-email-shawn.lin@rock-chips.com>
References: <1487303780-234812-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:55818 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbdBQEAI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 23:00:08 -0500
In-Reply-To: <1487303780-234812-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Shawn Lin <shawn.lin@rock-chips.com>

sdhci-bcm-kona is using the wrong callback to return the timeout
clock rate to sdhci core, which return it in Hz unit. BUt what we
need actually is to return it in KHz unit. So we could reuse the
helper of sdhci_pltfm_clk_get_timeout_clock to fix this.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 51dd2fd..4baf709 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -189,7 +189,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 static struct sdhci_ops sdhci_bcm_kona_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
-	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_timeout_clock,
 	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
-- 
1.9.1


