From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 08/21] mmc: sdhci-sirf: check sdhci_get_of_property return value
Date: Wed, 27 Jan 2016 13:07:44 +0800
Message-ID: <1453871264-3640-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Barry Song <baohua@kernel.org>, Weijun Yang <york.yang@csr.com>
List-Id: linux-mmc@vger.kernel.org

sdhci_get_of_property may failed while probing, so we check
the return value here.

Cc: Barry Song <baohua@kernel.org>
Cc: Weijun Yang <york.yang@csr.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-sirf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 34866f6..3f8499f 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -195,7 +195,9 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	priv = sdhci_pltfm_priv(pltfm_host);
 	priv->gpio_cd = gpio_cd;
 
-	sdhci_get_of_property(pdev);
+	ret = sdhci_get_of_property(pdev);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
 	if (ret)
-- 
2.3.7
