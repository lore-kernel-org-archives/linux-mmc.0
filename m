Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAFCC433E7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 09:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DBC21548
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 09:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403925AbgJMJ2t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 05:28:49 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:23005 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404002AbgJMJ2t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 05:28:49 -0400
X-IronPort-AV: E=Sophos;i="5.77,369,1596466800"; 
   d="scan'208";a="59439373"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Oct 2020 18:28:48 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 310EE4228453;
        Tue, 13 Oct 2020 18:28:48 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC] mmc: core: disable power off notification when host is removed
Date:   Tue, 13 Oct 2020 18:28:32 +0900
Message-Id: <1602581312-23607-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

User is possible to turn the power off after a host was removed.
So, disable the power off notification when a host is removed.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This topic was discussed in a few month ago [1], and now I could make
 a patch for unbinding the mmc host. I'm not sure this is a correct way
 so that I marked RFC.

 [1]
  https://patchwork.kernel.org/patch/11557505/#23408537

 drivers/mmc/core/mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ff3063c..abc4cac 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1988,6 +1988,15 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
  */
 static void mmc_remove(struct mmc_host *host)
 {
+	/*
+	 * Disable power_off_notification byte in the ext_csd register
+	 */
+	if (host->card->ext_csd.rev >= 6) {
+		mmc_claim_host(host);
+		mmc_poweroff_notify(host->card, EXT_CSD_NO_POWER_NOTIFICATION);
+		mmc_release_host(host);
+	}
+
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
-- 
2.7.4

