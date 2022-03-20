Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127BEC41535
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Mar 2022 12:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbiCTMcH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Mar 2022 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbiCTMcE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2022 08:32:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDBEEA7D
        for <linux-mmc@vger.kernel.org>; Sun, 20 Mar 2022 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=9ZSWPA2cv2i7Vg
        mdUfNOnUmG37V+gsKWDCZfvsPy/cU=; b=vPlljN9D0Dgs+IDNQALMFMUmGUh5T/
        BHAzpEGJl1f2Z0MVH1bVDQemiVugUqI3fTf1VMK8uhZZVHi2GfJKpLWS6SpqYQAe
        dcMm2/3pFD/VIrRbC+wvN17xoeC6a6S87jFh75mErsDGU5ng2wZz8vH3gAt28fsD
        f26pRQoKDPYFo=
Received: (qmail 461135 invoked from network); 20 Mar 2022 13:30:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2022 13:30:36 +0100
X-UD-Smtp-Session: l3s3148p1@Dvj0i6XafrkgAQnoAFbkANnMMFqLOUjD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/6] mmc: renesas_sdhi: R-Car D3 also has no HS400
Date:   Sun, 20 Mar 2022 13:30:12 +0100
Message-Id: <20220320123016.57991-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
References: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It is not explicitly expressed in the docs, but the needed data strobe
pin is indeed missing for D3. The BSP disables HS400 as well. This means
a little refactoring to reuse an already existing setup.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 1685df00863b..1c9217f99a0b 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -234,11 +234,6 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77970_compatible = {
 	.of_data = &of_data_rcar_gen3_no_fallback,
 };
 
-static const struct renesas_sdhi_of_data_with_quirks of_r8a77980_compatible = {
-	.of_data = &of_data_rcar_gen3,
-	.quirks = &sdhi_quirks_nohs400,
-};
-
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_r8a77990,
@@ -248,6 +243,11 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
 	.of_data = &of_data_rcar_gen3,
 };
 
+static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compatible = {
+	.of_data = &of_data_rcar_gen3,
+	.quirks = &sdhi_quirks_nohs400,
+};
+
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
@@ -256,8 +256,9 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77965", .data = &of_r8a77965_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
-	{ .compatible = "renesas,sdhi-r8a77980", .data = &of_r8a77980_compatible, },
+	{ .compatible = "renesas,sdhi-r8a77980", .data = &of_rcar_gen3_nohs400_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
+	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
 };
-- 
2.30.2

