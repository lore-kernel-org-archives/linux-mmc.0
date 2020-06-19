Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB475C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F1F20CC7
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 11:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgFSL3T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:29:19 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:18233 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731002AbgFSL3Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 07:29:16 -0400
X-IronPort-AV: E=Sophos;i="5.75,255,1589209200"; 
   d="scan'208";a="50104241"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jun 2020 20:29:14 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A04154007531;
        Fri, 19 Jun 2020 20:29:14 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC v2 1/2] firmware: psci: call pm_set_suspend_via_firmware()
Date:   Fri, 19 Jun 2020 20:29:02 +0900
Message-Id: <1592566143-4546-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592566143-4546-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1592566143-4546-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Call pm_set_suspend_via_firmware() in .begin() of psci_suspend_ops
to use pm_suspend_via_firmware() on PSCI environment.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/firmware/psci/psci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 92013ec..1c22b01 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -309,6 +309,13 @@ static int psci_system_suspend(unsigned long unused)
 			      __pa_symbol(cpu_resume), 0, 0);
 }
 
+static int psci_system_suspend_begin(suspend_state_t state)
+{
+	pm_set_suspend_via_firmware();
+
+	return 0;
+}
+
 static int psci_system_suspend_enter(suspend_state_t state)
 {
 	return cpu_suspend(0, psci_system_suspend);
@@ -316,6 +323,7 @@ static int psci_system_suspend_enter(suspend_state_t state)
 
 static const struct platform_suspend_ops psci_suspend_ops = {
 	.valid          = suspend_valid_only_mem,
+	.begin          = psci_system_suspend_begin,
 	.enter          = psci_system_suspend_enter,
 };
 
-- 
2.7.4

