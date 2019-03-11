From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 06/10] mmc: cqhci: allow hosts to specify dcmd cmd timing parameter
Date: Mon, 11 Mar 2019 11:02:35 -0700
Message-ID: <1552327359-8036-6-git-send-email-skomatineni@nvidia.com>
References: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch adds get_dcmd_cmd_timing interface to cqhci_host_ops to
allow hosts to specify CMD_TIMING bit of the DCMD task descriptor
command parameter.

This helps host driver to control whether the command can be issued
during data transfer or only during idle time.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 2 ++
 drivers/mmc/host/cqhci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index a8af682a9182..9a02f9c82aeb 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -528,6 +528,8 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
 		}
 	}
 
+	if (cq_host->ops->get_dcmd_cmd_timing)
+		timing = cq_host->ops->get_dcmd_cmd_timing(mmc, mrq);
 	task_desc = (__le64 __force *)get_desc(cq_host, cq_host->dcmd_slot);
 	memset(task_desc, 0, cq_host->task_desc_len);
 	data |= (CQHCI_VALID(1) |
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 9e68286a07b4..981158da3326 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -210,6 +210,8 @@ struct cqhci_host_ops {
 	u32 (*read_l)(struct cqhci_host *host, int reg);
 	void (*enable)(struct mmc_host *mmc);
 	void (*disable)(struct mmc_host *mmc, bool recovery);
+	u8 (*get_dcmd_cmd_timing)(struct mmc_host *mmc,
+				  struct mmc_request *mrq);
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
-- 
2.7.4
