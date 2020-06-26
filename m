Return-Path: <SRS0=oKGY=AH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C88C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF39E212CC
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFZJcf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:32:35 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:17253 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbgFZJcb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2020 05:32:31 -0400
X-IronPort-AV: E=Sophos;i="5.75,283,1589209200"; 
   d="scan'208";a="50446472"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jun 2020 18:32:28 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7EC6E420331D;
        Fri, 26 Jun 2020 18:32:28 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC v4 3/4] mmc: core: Call mmc_poweroff_nofity() if regulators are disabled
Date:   Fri, 26 Jun 2020 18:32:21 +0900
Message-Id: <1593163942-5087-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If regulator_is_enabled() of both vmmc and vqmmc returns false,
_mmc_suspend() should call mmc_poweroff_nofity() instead of
mmc_sleep().

Note that this is possible to happen when the regulator-fixed driver
turns the vmmc and vqmmc off by firmware like PSCI while the system
is suspended.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/core/mmc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4203303..75df5f8 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -2022,6 +2023,18 @@ static void mmc_detect(struct mmc_host *host)
 	}
 }
 
+static bool mmc_regulators_are_disabled(struct mmc_host *host)
+{
+	if (IS_ERR(host->supply.vmmc) ||
+	    regulator_is_enabled(host->supply.vmmc))
+		return false;
+	if (IS_ERR(host->supply.vqmmc) ||
+	    regulator_is_enabled(host->supply.vqmmc))
+		return false;
+
+	return true;
+}
+
 static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 {
 	int err = 0;
@@ -2038,7 +2051,8 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card) &&
-		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
+	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
+	     mmc_regulators_are_disabled(host)))
 		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
-- 
2.7.4

