From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 02/10] mmc: sdhci: allow host to specify maximum tuning loops
Date: Sat, 23 Mar 2019 21:45:19 -0700
Message-ID: <1553402727-23130-2-git-send-email-skomatineni@nvidia.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: skomatineni@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

As per the Host Controller Standard Specification Version 4.20,
limitation of tuning iteration count is removed as PLL locking
time can be longer than UHS-1 tuning due to larger PVT fluctuation
and it will result in increase of tuning iteration to complete the
tuning.

This patch creates sdhci_host member tuning_loop_count to allow
hosts to specify maximum tuning iterations and also updates
execute_tuning to use this specified maximum tuning iteration count.

Default tuning_loop_count is set to same as existing loop count of
MAX_TUNING_LOOP which is 40 iterations.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8141ff9be03..bbc0e0bb7128 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2369,9 +2369,9 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 	/*
 	 * Issue opcode repeatedly till Execute Tuning is set to 0 or the number
-	 * of loops reaches 40 times.
+	 * of loops reaches tuning loop count.
 	 */
-	for (i = 0; i < MAX_TUNING_LOOP; i++) {
+	for (i = 0; i < host->tuning_loop_count; i++) {
 		u16 ctrl;
 
 		sdhci_send_tuning(host, opcode);
@@ -3494,6 +3494,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	host->cqe_err_ier = SDHCI_CQE_INT_ERR_MASK;
 
 	host->tuning_delay = -1;
+	host->tuning_loop_count = MAX_TUNING_LOOP;
 
 	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 01002cba1359..57bb3e3dca89 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -596,6 +596,7 @@ struct sdhci_host {
 #define SDHCI_TUNING_MODE_3	2
 	/* Delay (ms) between tuning commands */
 	int			tuning_delay;
+	int			tuning_loop_count;
 
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
-- 
2.7.4
