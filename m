Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47415C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Apr 2021 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169C761105
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Apr 2021 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhDHSAL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:00:11 -0400
Received: from saphodev.broadcom.com ([192.19.232.172]:45896 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhDHSAL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Apr 2021 14:00:11 -0400
Received: from lbrmn-lnxub113.ric.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 51E807DA6;
        Thu,  8 Apr 2021 10:59:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 51E807DA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1617904799;
        bh=uwkHFhiBA2U8qW7q38E/cHJRJKngyCGEFl2zH23ECf4=;
        h=From:To:Cc:Subject:Date:From;
        b=ChSYc/X132iiE3npAticRo9dlpun05u6/1CSprcVHi3Ha0htJgTC6IHyp5DnlvSfD
         8fwMu/JhlYEXVhCMhK4ak2ZcrfT9ovUeLnTgTdlD0Ug7FK2islQ9uzJYA4QE7cYLM6
         ryVyc+F5DhtUnJDSnQaAPn0e1GA4YIhCVtTxfa5U=
From:   Scott Branden <scott.branden@broadcom.com>
To:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] mmc: add quirk to disable eMMC cache for Micron eMMC v5.0 cards
Date:   Thu,  8 Apr 2021 10:59:51 -0700
Message-Id: <20210408175951.22450-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>

In certain rare combination of operations, Micron eMMC v5.0 cards
may experience data errors if internal cache is enabled.
This may lead to eMMC related data errors.
Introduce a quirk to disable cache on these eMMC cards.

Signed-off-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mmc/core/card.h   | 5 +++++
 drivers/mmc/core/mmc.c    | 4 ++--
 drivers/mmc/core/quirks.h | 8 ++++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 7bd392d55cfa..22cea63ac359 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -222,4 +222,9 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_HPI;
 }
 
+static inline int mmc_card_broken_cache(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_CACHE;
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8741271d3971..cd83b7f0e59c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1820,12 +1820,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * sudden power failure tests. Let's extend the timeout to a minimum of
 	 * DEFAULT_CACHE_EN_TIMEOUT_MS and do it for all cards.
 	 */
-	if (card->ext_csd.cache_size > 0) {
+	if (!mmc_card_broken_cache(card) && card->ext_csd.cache_size > 0) {
 		unsigned int timeout_ms = MIN_CACHE_EN_TIMEOUT_MS;
 
 		timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1, timeout_ms);
+				 EXT_CSD_CACHE_CTRL, 1, timeout_ms);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index d68e6e513a4f..23972d87c82a 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -116,6 +116,14 @@ static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
 	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
 			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
 
+	/*
+	 * In certain rare combination of operations, Micron eMMC v5.0 cards
+	 * may experience data errors if internal cache is enabled.
+	 * Disabling cache for these cards eliminates the issue.
+	 */
+	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_MICRON,
+			      0x014e, add_quirk, MMC_QUIRK_BROKEN_CACHE, 7),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9ad35dd6012..22f256a4e54e 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -270,6 +270,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_BROKEN_CACHE	(1<<14)		/* Disable broken cache */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.17.1

