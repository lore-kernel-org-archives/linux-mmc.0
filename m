Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979FBEB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFTKro (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjFTKrn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:43 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E681A5
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:42 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B4B4E846BD;
        Tue, 20 Jun 2023 12:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258060;
        bh=/sHLEbE7TyUMspBVRM8y93P6st+POg0YXIyqwixdl2w=;
        h=From:To:Cc:Subject:Date:From;
        b=fGrqY25BgQWRtR9troA1XNeyvnYdH7ExO5HfmHxGffo6d5RLVaUE+zP4G4dcn0t30
         Q+9gDpZFuXl+MjxZpkm5npg0KCurau+HT9BAXV2DgAXyU1q+NFUYyjijey6eYEBhxq
         OOEtvIsmkBNLDWybYU4LAGXlYyRPPKaNgD+nxEGI+jOCImUMDXSPZFOqSYlC6WieTC
         tqropYJ72GqTccjT92JeOt5j5K3C/wGZBbZmVNKoVAjytmiyQMmLI5E9rBaBL4gvOp
         9RBuGdKZa+V+IYOiETopX9/OZ3uqyEPNeLPyXwAyKxp0uIIx/UXNWjlS+bIA1tkjnu
         w0/FZi40tqxlQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 01/11] mmc: core: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:12 +0200
Message-Id: <20230620104722.16465-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the BIT(n) macro instead of (1<<n), no functional change.
Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Bo Liu <liubo03@inspur.com>
Cc: Deren Wu <deren.wu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mmc@vger.kernel.org
---
 include/linux/mmc/core.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 6efec0b9820c1..23db84630ae8a 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -26,16 +26,16 @@ enum mmc_blk_status {
 struct mmc_command {
 	u32			opcode;
 	u32			arg;
-#define MMC_CMD23_ARG_REL_WR	(1 << 31)
+#define MMC_CMD23_ARG_REL_WR	BIT(31)
 #define MMC_CMD23_ARG_PACKED	((0 << 31) | (1 << 30))
-#define MMC_CMD23_ARG_TAG_REQ	(1 << 29)
+#define MMC_CMD23_ARG_TAG_REQ	BIT(29)
 	u32			resp[4];
 	unsigned int		flags;		/* expected response type */
-#define MMC_RSP_PRESENT	(1 << 0)
-#define MMC_RSP_136	(1 << 1)		/* 136 bit response */
-#define MMC_RSP_CRC	(1 << 2)		/* expect valid crc */
-#define MMC_RSP_BUSY	(1 << 3)		/* card may send busy */
-#define MMC_RSP_OPCODE	(1 << 4)		/* response contains opcode */
+#define MMC_RSP_PRESENT	BIT(0)
+#define MMC_RSP_136	BIT(1)		/* 136 bit response */
+#define MMC_RSP_CRC	BIT(2)		/* expect valid crc */
+#define MMC_RSP_BUSY	BIT(3)		/* card may send busy */
+#define MMC_RSP_OPCODE	BIT(4)		/* response contains opcode */
 
 #define MMC_CMD_MASK	(3 << 5)		/* non-SPI command type */
 #define MMC_CMD_AC	(0 << 5)
@@ -43,10 +43,10 @@ struct mmc_command {
 #define MMC_CMD_BC	(2 << 5)
 #define MMC_CMD_BCR	(3 << 5)
 
-#define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
-#define MMC_RSP_SPI_S2	(1 << 8)		/* second byte */
-#define MMC_RSP_SPI_B4	(1 << 9)		/* four data bytes */
-#define MMC_RSP_SPI_BUSY (1 << 10)		/* card may send busy */
+#define MMC_RSP_SPI_S1	BIT(7)		/* one status byte */
+#define MMC_RSP_SPI_S2	BIT(8)		/* second byte */
+#define MMC_RSP_SPI_B4	BIT(9)		/* four data bytes */
+#define MMC_RSP_SPI_BUSY BIT(10)		/* card may send busy */
 
 /*
  * These are the native response types, and correspond to valid bit
-- 
2.39.2

