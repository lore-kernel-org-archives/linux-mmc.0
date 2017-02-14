From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: core: use eMMC lifetime info to warn user
Date: Tue, 14 Feb 2017 21:53:21 +0100
Message-ID: <b3f67c2a-fbf7-b2fb-c05e-138fbdd77e39@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35858 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdBNUxb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:53:31 -0500
Received: by mail-wr0-f194.google.com with SMTP id k90so28891548wrc.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:53:30 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Jungseung Lee <js07.lee@samsung.com>

Now that the new lifetime parameters are available in struct mmc_ext_csd
we can use this information to warn the user if card is close to or
beyond end of its lifetime.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/bus.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 30124651..ab20d242 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -345,6 +345,22 @@ int mmc_add_card(struct mmc_card *card)
 			uhs_bus_speed_mode, type, card->rca);
 	}
 
+	if (card->ext_csd.device_life_time_est_typ_a == 0xb ||
+	    card->ext_csd.device_life_time_est_typ_b == 0xb)
+		pr_err("%s: memory has exceeded its life time",
+			mmc_hostname(card->host));
+	else if (card->ext_csd.device_life_time_est_typ_a == 0xa ||
+		 card->ext_csd.device_life_time_est_typ_b == 0xa)
+		pr_warn("%s: memory has used more than 90%% of its life time\n",
+			mmc_hostname(card->host));
+
+	if (card->ext_csd.pre_eol_info == 3)
+		pr_err("%s: out of reserved blocks\n",
+			mmc_hostname(card->host));
+	else if (card->ext_csd.pre_eol_info == 2)
+		pr_warn("%s: more than 80%% of reserved blocks consumed\n",
+			mmc_hostname(card->host));
+
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
 #endif
-- 
2.11.1

