From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 2/4] mmc: sdhci: remove #indef CONFIG_PM around function declarations
Date: Thu,  3 Aug 2017 10:44:14 +0900
Message-ID: <1501724656-12435-3-git-send-email-yamada.masahiro@socionext.com>
References: <1501724656-12435-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501724656-12435-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

We need not surround declarations with #ifdef.  Besides, drivers may
want to call these from PM callbacks marked with __maybe_unused.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/sdhci.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0469fa191493..773b38127da2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -709,15 +709,11 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
-
-#ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 void sdhci_enable_irq_wakeups(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
 int sdhci_runtime_resume_host(struct sdhci_host *host);
-#endif
-
 void sdhci_cqe_enable(struct mmc_host *mmc);
 void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);
 bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
-- 
2.7.4
