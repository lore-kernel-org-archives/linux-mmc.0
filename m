From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mmc: mmci: add missing include of mmci_qcom_dml.h
Date: Wed,  8 Jun 2016 19:15:38 +0100
Message-ID: <1465409738-23113-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:53730 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161561AbcFHSPq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2016 14:15:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infadead.org

Fix the missing declarations of dml_start_xfer() and
dml_hw_init() by including mmci_qcom_dml.h to fix the
following warnings:

drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infadead.org
---
 drivers/mmc/host/mmci_qcom_dml.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 2b7fc37..54fd58b 100644
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
2.8.1

