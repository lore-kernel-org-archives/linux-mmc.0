Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B43C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Nov 2022 08:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiKVIGK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiKVIGJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2022 03:06:09 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8A43E097
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 00:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=o0fa1HEr9vZ107vfHlc1Gai8454
        sHlcyCcDHT0d5hRY=; b=1eqsbELF0c3bqiItB637rZjgU8IWUECkmy/GE5DboXr
        +FKceuS9XFOP5pebwe6vulAKOHabNaJfH4o1BLLivCDzd3Ljv5ttvHUmpbTgCOai
        +e5Fcgy6vbNb1oivMW/Zl35kc7nghg9iRGBeoOl0t2zC6Xq52dF7aNDYsxl7pyZ8
        =
Received: (qmail 162135 invoked from network); 22 Nov 2022 09:06:03 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Nov 2022 09:06:03 +0100
X-UD-Smtp-Session: l3s3148p1@vKp6pAruzshehh99
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] mmc: renesas_sdhi: use plain numbers for end_flags
Date:   Tue, 22 Nov 2022 09:05:54 +0100
Message-Id: <20221122080554.4468-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Linux *_bit accessors take plain bit numbers, no need for BIT().

Fixes: 8d901e2ba566 ("mmc: renesas_sdhi: take DMA end interrupts into account")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index ea2a85174a09..68da3da9e2e5 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -57,8 +57,8 @@ struct renesas_sdhi_of_data_with_quirks {
 };
 
 /* We want both end_flags to be set before we mark DMA as finished */
-#define SDHI_DMA_END_FLAG_DMA		BIT(0)
-#define SDHI_DMA_END_FLAG_ACCESS	BIT(1)
+#define SDHI_DMA_END_FLAG_DMA		0
+#define SDHI_DMA_END_FLAG_ACCESS	1
 
 struct renesas_sdhi_dma {
 	unsigned long end_flags;
-- 
2.30.2

