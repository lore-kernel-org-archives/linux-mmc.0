From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Convert __mmc_switch() into an internal core function
Date: Tue, 15 Sep 2015 15:19:45 +0200
Message-ID: <1442323185-23928-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36654 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbIONUP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2015 09:20:15 -0400
Received: by lanb10 with SMTP id b10so106759960lan.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2015 06:20:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

As there are no users of the __mmc_switch() API, except for the mmc core
itself, let's convert it from an exported function into an internal.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 1 -
 drivers/mmc/core/mmc_ops.h | 3 +++
 include/linux/mmc/core.h   | 2 --
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0e9ae1c..57f3a21 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -579,7 +579,6 @@ out:
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(__mmc_switch);
 
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms)
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index f498f9a..f1b8e81 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -28,6 +28,9 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_switch_status_error(struct mmc_host *host, u32 status);
+int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
+		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
+		bool ignore_crc);
 
 #endif
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 258daf9..79a31d3 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -152,8 +152,6 @@ extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
 extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
-extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
-			bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_tuning(struct mmc_host *host);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-- 
1.9.1

