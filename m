From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 04/22] mmc: dw_mmc: Set timeout to max upon resume
Date: Sat, 31 Aug 2013 00:11:49 +0900
Message-ID: <000701cea593$4044a860$c0cdf920$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47157 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3H3PLu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:11:50 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00GC2NJMHW40@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:11:50 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Doug Anderson <dianders@chromium.org>

The TMOUT register is set to 0xffffffff at probe time but isn't
set after suspend/resume.  Add an init of this value.

No problems were observed without this (it will also be set in
__dw_mci_start_request if there is data to send), but it makes the
register dump before and after suspend cleaner.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3ad0fd8..b5bf6eb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2510,6 +2510,9 @@ int dw_mci_resume(struct dw_mci *host)
 	/* Restore the old value at FIFOTH register */
 	mci_writel(host, FIFOTH, host->fifoth_val);
 
+	/* Put in max timeout */
+	mci_writel(host, TMOUT, 0xFFFFFFFF);
+
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
 		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
-- 
1.7.0.4


