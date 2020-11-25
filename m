Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789F0C63777
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 03:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BADC20872
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 03:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgKYDgc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:36:32 -0500
Received: from foss.arm.com ([217.140.110.172]:45998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKYDgb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 22:36:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C1F106F;
        Tue, 24 Nov 2020 19:36:31 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 293723F718;
        Tue, 24 Nov 2020 19:36:31 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] mmc: sdhci: Use more concise device_property_read_u64
Date:   Tue, 24 Nov 2020 21:36:30 -0600
Message-Id: <20201125033630.603863-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since we only need a single u64 the _array form is
unnecessarily. Use device_property_read_u64 instead.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/mmc/host/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index feba64fbde16..ad4ae88a7f74 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	if (host->v4_mode)
 		sdhci_do_enable_v4_mode(host);
 
-	device_property_read_u64_array(mmc_dev(host->mmc),
-				       "sdhci-caps-mask", &dt_caps_mask, 1);
-	device_property_read_u64_array(mmc_dev(host->mmc),
-				       "sdhci-caps", &dt_caps, 1);
+	device_property_read_u64(mmc_dev(host->mmc),
+				 "sdhci-caps-mask", &dt_caps_mask);
+	device_property_read_u64(mmc_dev(host->mmc),
+				 "sdhci-caps", &dt_caps);
 
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
-- 
2.26.2

