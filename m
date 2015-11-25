From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 3/3] mmc: core: Introduce MMC_CAP2_NO_SDIO cap
Date: Wed, 25 Nov 2015 12:28:47 +0100
Message-ID: <1448450927-13682-4-git-send-email-carlo@caione.org>
References: <1448450927-13682-1-git-send-email-carlo@caione.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36761 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbKYL3W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 06:29:22 -0500
Received: by wmww144 with SMTP id w144so175952114wmw.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 03:29:20 -0800 (PST)
In-Reply-To: <1448450927-13682-1-git-send-email-carlo@caione.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, hdegoede@redhat.com, linux-mmc@vger.kernel.org, drake@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>

From: Carlo Caione <carlo@endlessm.com>

This patch introduce a new MMC_CAP2_NO_SDIO cap used to tell the mmc
core to not send SDIO specific commands.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/mmc/core/core.c  | 7 +++++++
 include/linux/mmc/host.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2e8b24d..90b028e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -204,6 +204,13 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		return;
 	}
 
+	/* We do not support SDIO commands */
+	if (mmc_is_io_op(mrq->cmd->opcode) && host->caps2 & MMC_CAP2_NO_SDIO) {
+		mrq->cmd->error = -EINVAL;
+		mmc_request_done(host, mrq);
+		return;
+	}
+
 	/*
 	 * For sdio rw commands we must wait for card busy otherwise some
 	 * sdio devices won't work properly.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8673ffe..cf6d0bb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -289,6 +289,7 @@ struct mmc_host {
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
+#define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.5.0

