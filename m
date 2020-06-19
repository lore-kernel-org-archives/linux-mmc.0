Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26AC433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAE22083B
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 11:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgFSL3U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:29:20 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:20537 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731102AbgFSL3R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 07:29:17 -0400
X-IronPort-AV: E=Sophos;i="5.75,255,1589209200"; 
   d="scan'208";a="49894103"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jun 2020 20:29:14 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C93224007531;
        Fri, 19 Jun 2020 20:29:14 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC v2 2/2] mmc: core: Call mmc_power_off_nofity() if pm_suspend_via_firmware()
Date:   Fri, 19 Jun 2020 20:29:03 +0900
Message-Id: <1592566143-4546-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592566143-4546-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1592566143-4546-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If pm_suspend_via_firmware() returns true, the system will be able
to cut both vcc and vccq in the suspend. So, call
mmc_power_off_nofity() if pm_suspend_via_firmware() returns true.

Note that we should not update the MMC_CAP2_FULL_PWR_CYCLE caps
because the mmc_select_voltage() checks the caps when attaches
a mmc/sd.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/core/mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4203303..81941fd 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/suspend.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
@@ -2038,7 +2039,8 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card) &&
-		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
+	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
+	     pm_suspend_via_firmware()))
 		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
-- 
2.7.4

