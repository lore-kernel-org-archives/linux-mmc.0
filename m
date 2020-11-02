Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4094CC388F9
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E1F22275
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 10:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgKBKEm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:04:42 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:26292 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728004AbgKBKEm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 05:04:42 -0500
X-IronPort-AV: E=Sophos;i="5.77,444,1596466800"; 
   d="scan'208";a="61466543"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Nov 2020 19:04:40 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A0FEE4007539;
        Mon,  2 Nov 2020 19:04:40 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] mmc: core: issue power off notification when host is removed
Date:   Mon,  2 Nov 2020 19:04:35 +0900
Message-Id: <1604311475-15307-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

User is possible to turn the power off after a host was removed.
So, call _mmc_suspend() to issue the power off notification when
a host is removing. Note that, to prevent _mmc_resume() calling
in mmc_runtime_resume(), call mmc_card_clr_suspended() in
mmc_remove() before mmc_remove_card(). Otherwise, _mmc_resume()
call mmc_init_card() while removing the host.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v1:
 - Reuse _mmc_suspend() instead of direct mmc_poweroff_notify() calling
  to check suspended flag while removing.
  https://patchwork.kernel.org/project/linux-renesas-soc/patch/1602581312-23607-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/

 drivers/mmc/core/mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ff3063c..0f83466 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1983,11 +1983,16 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 	return err;
 }
 
+static int _mmc_suspend(struct mmc_host *host, bool is_suspend);
 /*
  * Host is being removed. Free up the current card.
  */
 static void mmc_remove(struct mmc_host *host)
 {
+	_mmc_suspend(host, false);
+	/* Prevent _mmc_resume() calling in mmc_runtime_resume() */
+	mmc_card_clr_suspended(host->card);
+
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
-- 
2.7.4

