Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B60C433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Mar 2022 12:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbiCTMrJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Mar 2022 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245105AbiCTMrG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2022 08:47:06 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA581AA8C1
        for <linux-mmc@vger.kernel.org>; Sun, 20 Mar 2022 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=R8KciZ3qNIz/QVNnRo5d9o/spu/
        OTLXFRP0SFGiJUBE=; b=Um+vSGxnGiynUZ1k7+nPgFVski1fbb5ACyUVw916REG
        dXWNLRDi92mPV0aPR8yW8O/PbFvlSlxF89OsvuAkr1331lkFc2dCYZjMujj2LCCf
        IML23FMuzbpIlPgbkgRZILpxf+w94FEuaw+7RZSPVyfDrpdFLO1OwlF5dgxZSb90
        =
Received: (qmail 464745 invoked from network); 20 Mar 2022 13:45:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2022 13:45:40 +0100
X-UD-Smtp-Session: l3s3148p1@/nrVwaXaqrkgAQnoAFbkANnMMFqLOUjD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: renesas_sdhi: style fix for proper function bodies
Date:   Sun, 20 Mar 2022 13:45:38 +0100
Message-Id: <20220320124538.62028-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Put the braces to the proper position to make reading the code easier.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Ideally, should have been in the series I sent out some minutes ago, but
I just found this now (hey, Murphy!). But not so bad, there is no
dependency and it can be applied independently.

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 1497a46260d4..0bf35fb8b293 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -296,7 +296,8 @@ renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool enable)
 }
 
 static void
-renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host) {
+renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host)
+{
 	u64 val = RST_DTRANRST1 | RST_DTRANRST0;
 
 	renesas_sdhi_internal_dmac_enable_dma(host, false);
@@ -312,7 +313,8 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host) {
 }
 
 static void
-renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host) {
+renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
+{
 	struct renesas_sdhi *priv = host_to_priv(host);
 
 	tasklet_schedule(&priv->dma_priv.dma_complete);
-- 
2.30.2

