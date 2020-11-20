Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7323C2D0E4
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967DD223B0
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 23:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKTXjK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:39:10 -0500
Received: from foss.arm.com ([217.140.110.172]:56346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKTXjK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 18:39:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4740F1042;
        Fri, 20 Nov 2020 15:39:09 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 379FD3F719;
        Fri, 20 Nov 2020 15:39:09 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] mmc: sdhci: Update firmware interface API
Date:   Fri, 20 Nov 2020 17:38:31 -0600
Message-Id: <20201120233831.447365-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The device_* calls were added a few years ago to abstract
DT/ACPI/fwnode firmware interfaces. Lets convert the two
sdhci caps fields to use the generic calls rather than the OF
specific ones. This has the side effect of allowing
ACPI based devices to quirk themselves when the caps field
is broken.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/mmc/host/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 592a55a34b58..feba64fbde16 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	if (host->v4_mode)
 		sdhci_do_enable_v4_mode(host);
 
-	of_property_read_u64(mmc_dev(host->mmc)->of_node,
-			     "sdhci-caps-mask", &dt_caps_mask);
-	of_property_read_u64(mmc_dev(host->mmc)->of_node,
-			     "sdhci-caps", &dt_caps);
+	device_property_read_u64_array(mmc_dev(host->mmc),
+				       "sdhci-caps-mask", &dt_caps_mask, 1);
+	device_property_read_u64_array(mmc_dev(host->mmc),
+				       "sdhci-caps", &dt_caps, 1);
 
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
-- 
2.26.2

