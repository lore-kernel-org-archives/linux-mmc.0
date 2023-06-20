Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4120EB64DB
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFTKrv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjFTKrq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:46 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3081A7
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:45 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1CED486341;
        Tue, 20 Jun 2023 12:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258063;
        bh=11XhSg/rtQyxOo5HjQ0ol7zrrG68C5e/Ya70YCnybPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBi8XfVssuwc3iFUgrgHXaZkyVjKpGkPb7bGqOLUb2tvlwFhjJomp6WD5vTOas25y
         ceCp90NfVL8uzsoPlDfOFnBUv/VDoH6TgBaXTvENbIPDbOAfSsu8rDZjSw5GQIXya1
         CyxWSAlXmcYUVG40+TniiB2NRSlzUaDEGdL+M/ImSgWIlNJCP5r04a/KyTa3mcEoKO
         opZGj9KoYFK5R7gyyYV1JIv+g4+EvogpjanmaevWxc2ptea2x8HbJ5oAVKDWDj4CKS
         POrkkSJ1FE/1KlT1JmbFwBGqej6A9iL6PI+6rGsGeaCvoR885WpibHqhoeaCf/Wt5u
         iqGi/a8FGMz+A==
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
Subject: [PATCH 06/11] mmc: sdio: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:17 +0200
Message-Id: <20230620104722.16465-6-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620104722.16465-1-marex@denx.de>
References: <20230620104722.16465-1-marex@denx.de>
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
 include/linux/mmc/sdio.h      | 24 ++++++++++++------------
 include/linux/mmc/sdio_func.h |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 1ef400f28642e..e43806e9dd138 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -34,8 +34,8 @@
  *      [8:0] Byte/block count
  */
 
-#define R4_18V_PRESENT (1<<24)
-#define R4_MEMORY_PRESENT (1 << 27)
+#define R4_18V_PRESENT BIT(24)
+#define R4_MEMORY_PRESENT BIT(27)
 
 /*
   SDIO status in R5
@@ -52,11 +52,11 @@
 	c : clear by read
  */
 
-#define R5_COM_CRC_ERROR	(1 << 15)	/* er, b */
-#define R5_ILLEGAL_COMMAND	(1 << 14)	/* er, b */
-#define R5_ERROR		(1 << 11)	/* erx, c */
-#define R5_FUNCTION_NUMBER	(1 << 9)	/* er, c */
-#define R5_OUT_OF_RANGE		(1 << 8)	/* er, c */
+#define R5_COM_CRC_ERROR	BIT(15)	/* er, b */
+#define R5_ILLEGAL_COMMAND	BIT(14)	/* er, b */
+#define R5_ERROR		BIT(11)	/* erx, c */
+#define R5_FUNCTION_NUMBER	BIT(9)	/* er, c */
+#define R5_OUT_OF_RANGE		BIT(8)	/* er, c */
 #define R5_STATUS(x)		(x & 0xCB00)
 #define R5_IO_CURRENT_STATE(x)	((x & 0x3000) >> 12) /* s, b */
 
@@ -150,9 +150,9 @@
 
 #define SDIO_CCCR_DRIVE_STRENGTH 0x15
 #define  SDIO_SDTx_MASK		0x07
-#define  SDIO_DRIVE_SDTA	(1<<0)
-#define  SDIO_DRIVE_SDTC	(1<<1)
-#define  SDIO_DRIVE_SDTD	(1<<2)
+#define  SDIO_DRIVE_SDTA	BIT(0)
+#define  SDIO_DRIVE_SDTC	BIT(1)
+#define  SDIO_DRIVE_SDTD	BIT(2)
 #define  SDIO_DRIVE_DTSx_MASK	0x03
 #define  SDIO_DRIVE_DTSx_SHIFT	4
 #define  SDIO_DTSx_SET_TYPE_B	(0 << SDIO_DRIVE_DTSx_SHIFT)
@@ -161,8 +161,8 @@
 #define  SDIO_DTSx_SET_TYPE_D	(3 << SDIO_DRIVE_DTSx_SHIFT)
 
 #define SDIO_CCCR_INTERRUPT_EXT	0x16
-#define SDIO_INTERRUPT_EXT_SAI	(1 << 0)
-#define SDIO_INTERRUPT_EXT_EAI	(1 << 1)
+#define SDIO_INTERRUPT_EXT_SAI	BIT(0)
+#define SDIO_INTERRUPT_EXT_EAI	BIT(1)
 
 /*
  * Function Basic Registers (FBR)
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 478855b8e406f..ce8ffddd5bd3b 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -47,7 +47,7 @@ struct sdio_func {
 	unsigned		enable_timeout;	/* max enable timeout in msec */
 
 	unsigned int		state;		/* function state */
-#define SDIO_STATE_PRESENT	(1<<0)		/* present in sysfs */
+#define SDIO_STATE_PRESENT	BIT(0)		/* present in sysfs */
 
 	u8			*tmpbuf;	/* DMA:able scratch buffer */
 
-- 
2.39.2

