From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/5] mmc: sdhci: Indicate that regulators may be absent
Date: Tue, 30 Jul 2013 12:46:15 +0100
Message-ID: <1375184777-25404-3-git-send-email-broonie@kernel.org>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375184777-25404-1-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

Use regulator_get_optional() to tell the core that requests for regulators
can fail in a real system.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..dd2c083 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2966,7 +2966,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
-	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
+	host->vqmmc = regulator_get_optional(mmc_dev(mmc), "vqmmc");
 	if (IS_ERR_OR_NULL(host->vqmmc)) {
 		if (PTR_ERR(host->vqmmc) < 0) {
 			pr_info("%s: no vqmmc regulator found\n",
@@ -3042,7 +3042,7 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	ocr_avail = 0;
 
-	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
+	host->vmmc = regulator_get_optional(mmc_dev(mmc), "vmmc");
 	if (IS_ERR_OR_NULL(host->vmmc)) {
 		if (PTR_ERR(host->vmmc) < 0) {
 			pr_info("%s: no vmmc regulator found\n",
-- 
1.8.3.2
