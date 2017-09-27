From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] mmc: dw_mmc: cancel the CTO timer after a voltage switch
Date: Wed, 27 Sep 2017 13:56:29 -0700
Message-ID: <20170927205631.31559-2-dianders@chromium.org>
References: <20170927205631.31559-1-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:45226 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdI0U5A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2017 16:57:00 -0400
Received: by mail-pg0-f43.google.com with SMTP id 188so8430052pgb.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2017 13:56:59 -0700 (PDT)
In-Reply-To: <20170927205631.31559-1-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com
Cc: briannorris@chromium.org, amstan@chromium.org, xzy.xu@rock-chips.com, Douglas Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

When running with the commit 03de19212ea3 ("mmc: dw_mmc: introduce
timer for broken command transfer over scheme") I found this message
in the log:
  Unexpected command timeout, state 7

It turns out that we weren't properly cancelling the new CTO timer in
the case that a voltage switch was done.  Let's promote the cancel
into the dw_mci_cmd_interrupt() function to fix this.

Fixes: 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken command transfer over scheme")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 860313bd952a..f5b2bb4b4d98 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2570,6 +2570,8 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
 
 static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 {
+	del_timer(&host->cto_timer);
+
 	if (!host->cmd_status)
 		host->cmd_status = status;
 
@@ -2662,7 +2664,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_CMD_DONE) {
-			del_timer(&host->cto_timer);
 			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
 			dw_mci_cmd_interrupt(host, pending);
 		}
-- 
2.14.2.822.g60be5d43e6-goog

