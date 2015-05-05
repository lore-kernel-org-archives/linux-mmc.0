From: Eliad Peller <eliad@wizery.com>
Subject: [PATCH] mmc: core: don't call bus_ops->power_restore if already on
Date: Tue,  5 May 2015 19:03:47 +0300
Message-ID: <1430841827-7834-1-git-send-email-eliad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37554 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbbEEQJF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 12:09:05 -0400
Received: by widdi4 with SMTP id di4so152903926wid.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 09:09:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ido Yariv <ido@wizery.com>

mmc_power_restore_host() calls mmc_power_up(), which
returns immediately if power is already on.

However, it still calls host->bus_ops->power_restore,
which might result in various errors if the bus_ops
doesn't handle it well (e.g. failing to run init
sequence twice)

Simply bail out in this case, without further calling
bus_ops->power_restore.

Specifically, this solves issue with wl18xx sdio card,
where the mmc core powers on the card on resume (while
MMC_PM_KEEP_POWER is not set), and the wl18xx device
driver calls mmc_power_restore_host() once more.

Signed-off-by: Eliad Peller <eliad@wizery.com>
Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/mmc/core/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c296bc0..797b574 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2604,6 +2604,11 @@ int mmc_power_restore_host(struct mmc_host *host)
 		return -EINVAL;
 	}
 
+	if (host->ios.power_mode == MMC_POWER_ON) {
+		mmc_bus_put(host);
+		return 0;
+	}
+
 	mmc_power_up(host, host->card->ocr);
 	ret = host->bus_ops->power_restore(host);
 
-- 
1.8.5.2.229.g4448466.dirty

