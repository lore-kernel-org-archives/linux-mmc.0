From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 1/2] mmc: sdhci: Export sdhci_finish_command()
Date: Tue, 26 Mar 2019 16:30:56 +0530
Message-ID: <20190326110057.7055-2-faiz_abbas@ti.com>
References: <20190326110057.7055-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326110057.7055-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Make sdhci_finish_command() public so that it can be called from platform
drivers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8141ff9be03..76d36e13a011 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1445,7 +1445,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
-static void sdhci_finish_command(struct sdhci_host *host)
+void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
 
@@ -1495,6 +1495,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 			sdhci_finish_mrq(host, cmd->mrq);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_command);
 
 static u16 sdhci_get_preset_value(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 01002cba1359..49b133babf47 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -798,5 +798,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_finish_command(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.19.2
