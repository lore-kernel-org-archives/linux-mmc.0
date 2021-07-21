Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA7C636C9
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0073E6120C
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhGUPIH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 11:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhGUPIG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Jul 2021 11:08:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 699DC6120C;
        Wed, 21 Jul 2021 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626882523;
        bh=mrPjsA0yCAegR3ChJLMs51IGaXnxCJWanSvEqImq3Ow=;
        h=From:To:Cc:Subject:Date:From;
        b=IAnUlgzw2Kjf9X6uIsNSbtgm5qHiXHI2doykRpYDPZ0dwaiNW3riOX0YVejp6xEOV
         mfiIeM/u3JI7Fiz7ElTqdRAXt4a9dNmD63ZwzVhnA4tA+ShXdC6X11gfMhpSEMwCZg
         2+V8fE4zQGAcJnfnduViyyblkR9eRxRSINWksZh44ldcISpEC/wyp/hZgEK46Y4f6u
         S2aKRLdAKi5r8bafQGFINTaY2xVu19gU7teLcZbvhlHRAHNZaPM7LSjvbuZLmmkefa
         L8364R1fp15mXsBZ0DuBRmyATIkyRSYbqqmPD0qahCezaDbr6CDynxBH8fxE7PRDLQ
         vrP4luJYHqrgQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-mmc@vger.kernel.org
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>
Subject: [PATCH] mmc: store pointer to bio_crypt_ctx in mmc_request
Date:   Wed, 21 Jul 2021 08:47:38 -0700
Message-Id: <20210721154738.3966463-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make 'struct mmc_request' contain a pointer to the request's
'struct bio_crypt_ctx' directly, instead of extracting a 32-bit DUN from
it which is a cqhci-crypto specific detail.

This keeps the cqhci crypto specific details in the cqhci module, and it
makes mmc_core and mmc_block ready for MMC crypto hardware that accepts
the DUN and/or key in a way that is more flexible than that which will
be specified by the eMMC v5.2 standard.  Exynos SoCs are an example of
such hardware, as their inline encryption hardware takes keys directly
(it has no concept of keyslots) and supports 128-bit DUNs.

Note that the 32-bit DUN length specified by the standard is very
restrictive, so it is likely that more hardware will support longer DUNs
despite it not following the standard.  Thus, limiting the scope of the
32-bit DUN assumption to the place that actually needs it is warranted.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

This patch is already being carried in the Android Common Kernels, due
to it being needed by Exynos SoCs.  Unfortunately I have no way to
upstream Exynos eMMC inline encryption support at the moment, so this
patch isn't strictly required upstream at the moment.  But it may be
worthwhile as a cleanup regardless; it arguably fixes a layering
violation (mmc_core knowing about the details of cqhci crypto).

 drivers/mmc/core/crypto.c       | 15 ++++-----------
 drivers/mmc/host/cqhci-crypto.h |  7 +++++--
 include/linux/mmc/core.h        |  3 +--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
index 419a368f8402..67557808cada 100644
--- a/drivers/mmc/core/crypto.c
+++ b/drivers/mmc/core/crypto.c
@@ -31,18 +31,11 @@ void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 
-	if (!req->crypt_keyslot)
+	if (!req->crypt_ctx)
 		return;
 
-	mrq->crypto_enabled = true;
-	mrq->crypto_key_slot = blk_ksm_get_slot_idx(req->crypt_keyslot);
-
-	/*
-	 * For now we assume that all MMC drivers set max_dun_bytes_supported=4,
-	 * which is the limit for CQHCI crypto.  So all DUNs should be 32-bit.
-	 */
-	WARN_ON_ONCE(req->crypt_ctx->bc_dun[0] > U32_MAX);
-
-	mrq->data_unit_num = req->crypt_ctx->bc_dun[0];
+	mrq->crypto_ctx = req->crypt_ctx;
+	if (req->crypt_keyslot)
+		mrq->crypto_key_slot = blk_ksm_get_slot_idx(req->crypt_keyslot);
 }
 EXPORT_SYMBOL_GPL(mmc_crypto_prepare_req);
diff --git a/drivers/mmc/host/cqhci-crypto.h b/drivers/mmc/host/cqhci-crypto.h
index 60b58ee0e625..d7fb084f563b 100644
--- a/drivers/mmc/host/cqhci-crypto.h
+++ b/drivers/mmc/host/cqhci-crypto.h
@@ -22,12 +22,15 @@ int cqhci_crypto_init(struct cqhci_host *host);
  */
 static inline u64 cqhci_crypto_prep_task_desc(struct mmc_request *mrq)
 {
-	if (!mrq->crypto_enabled)
+	if (!mrq->crypto_ctx)
 		return 0;
 
+	/* We set max_dun_bytes_supported=4, so all DUNs should be 32-bit. */
+	WARN_ON_ONCE(mrq->crypto_ctx->bc_dun[0] > U32_MAX);
+
 	return CQHCI_CRYPTO_ENABLE_BIT |
 	       CQHCI_CRYPTO_KEYSLOT(mrq->crypto_key_slot) |
-	       mrq->data_unit_num;
+	       mrq->crypto_ctx->bc_dun[0];
 }
 
 #else /* CONFIG_MMC_CRYPTO */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index ab19245e9945..71101d1ec825 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -164,9 +164,8 @@ struct mmc_request {
 	int			tag;
 
 #ifdef CONFIG_MMC_CRYPTO
-	bool			crypto_enabled;
+	const struct bio_crypt_ctx *crypto_ctx;
 	int			crypto_key_slot;
-	u32			data_unit_num;
 #endif
 };
 
-- 
2.32.0.402.g57bb445576-goog

