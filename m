From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v4 4/4] mmc: dw_mmc: Set timeout to max upon resume
Date: Tue,  6 Aug 2013 14:37:51 -0700
Message-ID: <1375825071-20922-5-git-send-email-dianders@chromium.org>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
 <1375825071-20922-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f73.google.com ([209.85.216.73]:40442 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab3HFViE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Aug 2013 17:38:04 -0400
Received: by mail-qa0-f73.google.com with SMTP id f14so134409qak.4
        for <linux-mmc@vger.kernel.org>; Tue, 06 Aug 2013 14:38:01 -0700 (PDT)
In-Reply-To: <1375825071-20922-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The TMOUT register is initted to 0xffffffff at probe time but isn't
initted after suspend/resume.  Add an init of this value.

No problems were observed without this (it will also get initted in
__dw_mci_start_request if there is data to send), but it makes the
register dump before and after suspend clean.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0fa3135..1abcb36 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2505,6 +2505,9 @@ int dw_mci_resume(struct dw_mci *host)
 	/* Restore the old value at FIFOTH register */
 	mci_writel(host, FIFOTH, host->fifoth_val);
 
+	/* Put in max timeout */
+	mci_writel(host, TMOUT, 0xFFFFFFFF);
+
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
 		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
-- 
1.8.3

