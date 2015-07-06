From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Mon,  6 Jul 2015 14:53:38 +0300
Message-ID: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Ensure SDCC is working with maximum clock otherwise card
detection could be extremely slow, up to 7 seconds.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v0:
- s/falied/failed in warning message.

 drivers/mmc/host/sdhci-msm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4a09f76..4bcee03 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto pclk_disable;
 	}

+	/* Vote for maximum clock rate for maximum performance */
+	ret = clk_set_rate(msm_host->clk, INT_MAX);
+	if (ret)
+		dev_warn(&pdev->dev, "core clock boost failed\n");
+
 	ret = clk_prepare_enable(msm_host->clk);
 	if (ret)
 		goto pclk_disable;
--
1.9.1
