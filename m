From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD CMD_TIMING
Date: Fri, 1 Mar 2019 21:20:21 -0800
Message-ID: <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds a quirk for setting CMD_TIMING to 1 in descriptor
for DCMD with R1B response type to allow the command to be sent to
device during data activity or busy time.

Tegra186 CQHCI host has bug where it selects DATA_PRESENT_SELECT
to 1 by CQHCI controller for DCMDs with R1B response type and
since DCMD does not trigger any data transfer, DCMD task complete
happens leaving the DATA FSM of host controller in wait state for
data.

This effects the data transfer task issued after R1B DCMD task
and no interrupt is generated for the data transfer task.

SW WAR for this issue is to set CMD_TIMING bit to 1 in DCMD task
descriptor and as DCMD task descriptor preparation is done by
cqhci driver, this patch adds cqequirk to handle this.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 5 ++++-
 drivers/mmc/host/cqhci.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index a8af682a9182..b34c07125f32 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -521,7 +521,10 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
 	} else {
 		if (mrq->cmd->flags & MMC_RSP_R1B) {
 			resp_type = 0x3;
-			timing = 0x0;
+			if (cq_host->quirks & CQHCI_QUIRK_CMD_TIMING_R1B_DCMD)
+				timing = 0x1;
+			else
+				timing = 0x0;
 		} else {
 			resp_type = 0x2;
 			timing = 0x1;
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 9e68286a07b4..f96d8565cc07 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -170,6 +170,7 @@ struct cqhci_host {
 
 	u32 quirks;
 #define CQHCI_QUIRK_SHORT_TXFR_DESC_SZ	0x1
+#define CQHCI_QUIRK_CMD_TIMING_R1B_DCMD	0x2
 
 	bool enabled;
 	bool halted;
-- 
2.7.4
