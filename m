From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] [V2] mmc: mmci: add missing include of mmci_qcom_dml.h
Date: Thu, 16 Jun 2016 19:32:45 +0100
Message-ID: <1466101965-25568-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:56724 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752512AbcFPScv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2016 14:32:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infadead.org

Fix the missing declarations of dml_start_xfer() and
dml_hw_init() by including mmci_qcom_dml.h to fix the
following warnings:

drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?

Since the module build doesn't export symbols, also
export the symbols from the mmci_qcom_dml.c file as
otherwise the module link process won't work.

Note, since this is a very small addition to the mmci
module, it would better to build it into the main mmci
driver (either by direct copy, or multiple linked
module)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
V1..V2:
  - deal with module build errors
---
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infadead.org
---
 drivers/mmc/host/mmci_qcom_dml.c | 3 +++
 drivers/mmc/host/mmci_qcom_dml.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 2b7fc37..06858bd 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -18,6 +18,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include "mmci.h"
+#include "mmci_qcom_dml.h"
 
 /* Registers */
 #define DML_CONFIG			0x00
@@ -97,6 +98,7 @@ void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
 	/* make sure the dml is configured before dma is triggered */
 	wmb();
 }
+EXPORT_SYMBOL_GPL(dml_start_xfer);
 
 static int of_get_dml_pipe_index(struct device_node *np, const char *name)
 {
@@ -175,3 +177,4 @@ int dml_hw_init(struct mmci_host *host, struct device_node *np)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dml_hw_init);
diff --git a/drivers/mmc/host/mmci_qcom_dml.h b/drivers/mmc/host/mmci_qcom_dml.h
index 6e405d0..d77873d 100644
--- a/drivers/mmc/host/mmci_qcom_dml.h
+++ b/drivers/mmc/host/mmci_qcom_dml.h
@@ -15,7 +15,7 @@
 #ifndef __MMC_QCOM_DML_H__
 #define __MMC_QCOM_DML_H__
 
-#ifdef CONFIG_MMC_QCOM_DML
+#if defined(CONFIG_MMC_QCOM_DML) || defined(CONFIG_MMC_QCOM_DML_MODULE)
 int dml_hw_init(struct mmci_host *host, struct device_node *np);
 void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
 #else
-- 
2.8.1

