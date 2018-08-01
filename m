From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 11/40] mmc: sdhci: Add a quirk to skip clearing the transfer mode register on tuning
Date: Wed, 1 Aug 2018 19:32:01 +0300
Message-ID: <1533141150-10511-12-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add SDHCI_QUIRK2_TUNE_SKIP_XFERRMODE_REG_PROG to skip programming the
SDHCI_TRANSFER_MODE in sdhci_set_transfer_mode() if tuning command is
being sent.

On Tegra210 and Tegra186 the tuning sequence hangs if the SDHCI
transfer mode register is touched.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7b5602..04dc443 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1028,6 +1028,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	if (data == NULL) {
 		if (host->quirks2 &
+			SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG &&
+				(cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+				 cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)) {
+			return;
+		}
+		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
 			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..0a99008 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -450,6 +450,8 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/* Don't clear the SDHCI_TRANSFER_MODE register on tuning commands */
+#define SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG	(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4
