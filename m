From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: mmci_qcom_dml: include mmci_qcom_dml.h to fix sparse warnings
Date: Mon, 31 Jul 2017 20:59:54 +0900
Message-ID: <1501502394-13843-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This fixes the following sparse warnings:

  CHECK   drivers/mmc/host/mmci_qcom_dml.c
drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/mmci_qcom_dml.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.7.4
