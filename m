Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CEC4321E
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Mar 2022 12:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbiCTMcH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Mar 2022 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245069AbiCTMcE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2022 08:32:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7401AF1EAE
        for <linux-mmc@vger.kernel.org>; Sun, 20 Mar 2022 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=pOttCv5ljSJ+uS
        GFnCfxw8sAZLDAFVLYTAHM39SPW78=; b=ie50KvXg3WYaWwnLTs/oTpqWqV7+J2
        zwndliyGt/fie1dfvIFRweT3zXOTrcZnTS2TB+Uh/LSyXjYWJnLNa3geyOhAH9B0
        FNUCQ3GU9l04SnHGtu5Of9URX0PFwDeIBCTKu++gvUDrqIiA7CBU8dzAzi6f4mQd
        io62NfbhFa1k0=
Received: (qmail 461187 invoked from network); 20 Mar 2022 13:30:37 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2022 13:30:37 +0100
X-UD-Smtp-Session: l3s3148p1@5N8BjKXagrkgAQnoAFbkANnMMFqLOUjD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/6] mmc: renesas_sdhi: remove a stale comment
Date:   Sun, 20 Mar 2022 13:30:14 +0100
Message-Id: <20220320123016.57991-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
References: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The whitelist has been refactored away with a0fb3fc8af01 ("mmc:
renesas_sdhi: remove whitelist for internal DMAC") so the comment
doesn't make any sense anymore.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 243174c63772..06204ff94b4f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -521,10 +521,6 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
 	.end = renesas_sdhi_internal_dmac_end_dma,
 };
 
-/*
- * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
- * implementation as others may use a different implementation.
- */
 static const struct soc_device_attribute soc_dma_quirks[] = {
 	{ .soc_id = "r7s9210",
 	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY) },
-- 
2.30.2

