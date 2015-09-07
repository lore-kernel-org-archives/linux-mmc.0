From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v2 7/7] mmc: sdhci: enable SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for pxa1928
Date: Mon,  7 Sep 2015 16:48:41 +0530
Message-ID: <1441624721-15612-8-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Card power is dependent on bus power, without that card
wouldn't respond (No CARD_INT). So this patch enables the
quirk SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 5788a8c..057190c 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -102,7 +102,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	if (of_device_is_compatible(np, "marvell,pxav3-1928-sdhci"))
-		host->quirks2 |= SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER;
+		host->quirks2 |= SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER |
+				SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON;
 
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
-- 
1.9.1
