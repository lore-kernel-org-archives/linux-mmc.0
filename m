From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: dw_mmc-pltfm: include 'dw_mmc-pltfm.h'
Date: Tue, 06 Aug 2013 10:54:07 +0900
Message-ID: <000e01ce9247$d6063f30$8212bd90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53077 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab3HFByI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Aug 2013 21:54:08 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR300J8G6M5XVI0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Aug 2013 10:54:07 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Dinh Nguyen' <dinguyen@altera.com>Jingoo Han <jg1.han@samsung.com>

Include 'dw_mmc-pltfm.h' header file in order to fix
the following sparse warnings:

drivers/mmc/host/dw_mmc-pltfm.c:36:5: warning: symbol 'dw_mci_pltfm_register' was not declared. Should it be static?
drivers/mmc/host/dw_mmc-pltfm.c:94:1: warning: symbol 'dw_mci_pltfm_pmops' was not declared. Should it be static?
drivers/mmc/host/dw_mmc-pltfm.c:118:5: warning: symbol 'dw_mci_pltfm_remove' was not declared. Should it be static?

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index ee52556..2089752 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 
 #include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
 
 static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
-- 
1.7.10.4


