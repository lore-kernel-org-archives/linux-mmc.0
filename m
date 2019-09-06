From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/4] mmc: host: cqhci: Move the struct cqhci_slot into header file
Date: Fri,  6 Sep 2019 11:51:59 +0800
Message-ID: <e57e2c75a48a8e2d3f9df54cd43c08c7e5f1cc64.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The struct cqhci_slot will be used by virtual command queue introducing
by following patches, thus move it to the header file.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/cqhci.c |   10 ----------
 drivers/mmc/host/cqhci.h |   11 ++++++++++-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index f7bdae5..57ff1cc 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -21,16 +21,6 @@
 #define DCMD_SLOT 31
 #define NUM_SLOTS 32
 
-struct cqhci_slot {
-	struct mmc_request *mrq;
-	unsigned int flags;
-#define CQHCI_EXTERNAL_TIMEOUT	BIT(0)
-#define CQHCI_COMPLETED		BIT(1)
-#define CQHCI_HOST_CRC		BIT(2)
-#define CQHCI_HOST_TIMEOUT	BIT(3)
-#define CQHCI_HOST_OTHER	BIT(4)
-};
-
 static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag)
 {
 	return cq_host->desc_base + (tag * cq_host->slot_sz);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index def76e9..7b07bf24f 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -141,7 +141,16 @@
 struct cqhci_host_ops;
 struct mmc_host;
 struct mmc_request;
-struct cqhci_slot;
+
+struct cqhci_slot {
+	struct mmc_request *mrq;
+	unsigned int flags;
+#define CQHCI_EXTERNAL_TIMEOUT	BIT(0)
+#define CQHCI_COMPLETED		BIT(1)
+#define CQHCI_HOST_CRC		BIT(2)
+#define CQHCI_HOST_TIMEOUT	BIT(3)
+#define CQHCI_HOST_OTHER	BIT(4)
+};
 
 struct cqhci_host {
 	const struct cqhci_host_ops *ops;
-- 
1.7.9.5
