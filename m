From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] mmc: mmci_qcom_dml: include mmci_qcom_dml.h and fix #ifdef
Date: Fri,  4 Aug 2017 22:34:23 +0900
Message-ID: <1501853664-10752-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-10.nifty.com ([210.131.2.77]:45329 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdHDNfB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2017 09:35:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Include mmci_qcom_dml.h from mmci_qcom_dml.c to fix the following
sparse warnings:

  CHECK   drivers/mmc/host/mmci_qcom_dml.c
drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?

Fixing them causes redefintion of dml_start_xfer error, revealing another
problem in the header.  #ifdef CONFIG_MMC_QCOM_DML is wrong because this
driver is tristate.  (CONFIG_MMC_QCOM_DML_MODULE is defined when it is
built as a module)

Since dml_hw_init() is called from mmci.c, IS_REACHABLE() is needed to
cater to all the combinations.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix error reported by kbuild test robot
   (this patch is intended to replace commit 64f0aacb in linux-mmc/fixes

 drivers/mmc/host/mmci_qcom_dml.c | 1 +
 drivers/mmc/host/mmci_qcom_dml.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 00750c9d3514..95de699853d2 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -18,6 +18,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include "mmci.h"
+#include "mmci_qcom_dml.h"
 
 /* Registers */
 #define DML_CONFIG			0x00
diff --git a/drivers/mmc/host/mmci_qcom_dml.h b/drivers/mmc/host/mmci_qcom_dml.h
index 6e405d09d534..d5e88f102ba3 100644
--- a/drivers/mmc/host/mmci_qcom_dml.h
+++ b/drivers/mmc/host/mmci_qcom_dml.h
@@ -15,7 +15,7 @@
 #ifndef __MMC_QCOM_DML_H__
 #define __MMC_QCOM_DML_H__
 
-#ifdef CONFIG_MMC_QCOM_DML
+#if IS_REACHABLE(CONFIG_MMC_QCOM_DML)
 int dml_hw_init(struct mmci_host *host, struct device_node *np);
 void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
 #else
-- 
2.7.4

