From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 2/7] mmc: dw_mmc: exynos: don't use if clock isn't available
Date: Wed, 26 Mar 2014 20:31:06 +0900
Message-ID: <000201cf48e6$e05f8cb0$a11ea610$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Add checking whether the clock is valid.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index a67e784..a2d06c5 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -117,9 +117,9 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
-	unsigned long rate = clk_get_rate(host->ciu_clk);
 
-	host->bus_hz = rate / (priv->ciu_div + 1);
+	host->bus_hz /= (priv->ciu_div + 1);
+
 	return 0;
 }
 
@@ -196,8 +196,11 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		mci_writel(host, CLKSEL, priv->sdr_timing);
 	}
 
-	/* Don't care if wanted clock is zero */
-	if (!wanted)
+	/*
+	 * Don't care if wanted clock is zero or
+	 * ciu clock is unavailable
+	 */
+	if (!wanted || IS_ERR(host->ciu_clk))
 		return;
 
 	/* Guaranteed minimum frequency for cclkin */
-- 
1.7.4.1
