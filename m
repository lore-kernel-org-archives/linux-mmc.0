Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22351C43219
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Oct 2022 19:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiJFTFe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiJFTFR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Oct 2022 15:05:17 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8618362
        for <linux-mmc@vger.kernel.org>; Thu,  6 Oct 2022 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=NKjbC/eQaz8mvW
        NQScEGqtT2FITFZRr5xYVMokTHG8k=; b=srhJjoCBCLnlwkjXJ/dCUKnr8YI2Lv
        mxgcLo9kgksyfjYm+qATFmFdaSwipIbgGUjA/aKF398FxKyU4GbAqKWTiyjI6nBo
        WCjcyZw/7j0hkAdlX3XqjitUbnlX1VkpYWtOSew/Nnv8NLdTgUOWEnt3JbYN87LM
        6IMMXDZtQy8TA=
Received: (qmail 1467624 invoked from network); 6 Oct 2022 21:05:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Oct 2022 21:05:05 +0200
X-UD-Smtp-Session: l3s3148p1@4Qv8XmLq6coucrRL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFC 4/6] mmc: renesas_sdhi: add quirk for broken register layout
Date:   Thu,  6 Oct 2022 21:04:50 +0200
Message-Id: <20221006190452.5316-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
References: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some early Gen3 SoCs have the DTRANEND1 bit at a different location than
all later SoCs. Because we need the bit soon, add a quirk so we know
which bit to use.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index b661892847f6..fa88b721364c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -44,6 +44,7 @@ struct renesas_sdhi_quirks {
 	bool fixed_addr_mode;
 	bool dma_one_rx_only;
 	bool manual_tap_correction;
+	bool old_info1_layout;
 	u32 hs400_bad_taps;
 	const u8 (*hs400_calib_table)[SDHI_CALIB_TABLE_MAX];
 };
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 48bea0bd75e8..630ec1e785d6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -49,7 +49,8 @@
 /* DM_CM_INFO1 and DM_CM_INFO1_MASK */
 #define INFO1_CLEAR		0
 #define INFO1_MASK_CLEAR	GENMASK_ULL(31, 0)
-#define INFO1_DTRANEND1		BIT(17)
+#define INFO1_DTRANEND1		BIT(20)
+#define INFO1_DTRANEND1_OLD	BIT(17)
 #define INFO1_DTRANEND0		BIT(16)
 
 /* DM_CM_INFO2 and DM_CM_INFO2_MASK */
@@ -165,6 +166,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_4tap_nohs400_one_rx = {
 	.hs400_disabled = true,
 	.hs400_4taps = true,
 	.dma_one_rx_only = true,
+	.old_info1_layout = true,
 };
 
 static const struct renesas_sdhi_quirks sdhi_quirks_4tap = {
-- 
2.35.1

