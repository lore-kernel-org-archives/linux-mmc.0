Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C51C43219
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Mar 2022 12:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245079AbiCTMcG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Mar 2022 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245063AbiCTMcD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2022 08:32:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAC9F1AC6
        for <linux-mmc@vger.kernel.org>; Sun, 20 Mar 2022 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=CpPIRqr8gndaTP
        6t0o+1oKydJPMTlRMR+zG2rKu+0kA=; b=ceMl71rMmfkF8HSXVL8VyVY5V4A6sN
        G8VKGlVVfRMS6YbxEoHPKI48ZcNzu4Nlz1w6DfEI5gZ2We/Y4okQMeps64Cbc2Z+
        A0BcbbG9DIw+HLO/YHwkBrLf+4C4BdNZdpyew7jYK/RdTOPBw4MJOXq6Z5gIDwYg
        skZuBLGC+sxE8=
Received: (qmail 461161 invoked from network); 20 Mar 2022 13:30:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2022 13:30:36 +0100
X-UD-Smtp-Session: l3s3148p1@8bj7i6XagLkgAQnoAFbkANnMMFqLOUjD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/6] mmc: renesas_sdhi: make setup selection more understandable
Date:   Sun, 20 Mar 2022 13:30:13 +0100
Message-Id: <20220320123016.57991-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
References: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When I read 'no_fallback', I forgot what fallback even though I was the
author of this change. Name it better to make the code easier to
understand.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 1c9217f99a0b..243174c63772 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -128,7 +128,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 };
 
-static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_fallback = {
+static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
@@ -231,7 +231,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77965_compatible = {
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77970_compatible = {
-	.of_data = &of_data_rcar_gen3_no_fallback,
+	.of_data = &of_data_rcar_gen3_no_sdh_fallback,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
-- 
2.30.2

