From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v2 4/6] arm: davinci: DA850: Add MMC/SD1 pinmux configuration
Date: Sun, 10 Jul 2011 16:14:37 +0300
Message-ID: <1310303679-17936-5-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:37916 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1GJNPB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jul 2011 09:15:01 -0400
Received: by wwg11 with SMTP id 11so1595481wwg.1
        for <linux-mmc@vger.kernel.org>; Sun, 10 Jul 2011 06:14:59 -0700 (PDT)
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

AM18x has two MMC slots. Add the required pinmux configuration for the
second slot.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/da850.c            |    7 +++++++
 arch/arm/mach-davinci/include/mach/mux.h |    8 ++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 133aac4..f6eafb4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -525,6 +525,13 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, MMCSD0_DAT_3,	10,	20,	15,	2,	false)
 	MUX_CFG(DA850, MMCSD0_CLK,	10,	0,	15,	2,	false)
 	MUX_CFG(DA850, MMCSD0_CMD,	10,	4,	15,	2,	false)
+	/* MMC/SD1 function */
+	MUX_CFG(DA850, MMCSD1_DAT_0,	18,	8,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_1,	19,	16,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_2,	19,	12,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_3,	19,	8,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_CLK,	18,	12,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_CMD,	18,	16,	15,	2,	false)
 	/* EMIF2.5/EMIFA function */
 	MUX_CFG(DA850, EMA_D_7,		9,	0,	15,	1,	false)
 	MUX_CFG(DA850, EMA_D_6,		9,	4,	15,	1,	false)
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 5d4e0fe..7fb7f1e 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -857,6 +857,14 @@ enum davinci_da850_index {
 	DA850_MMCSD0_CLK,
 	DA850_MMCSD0_CMD,
 
+	/* MMC/SD1 function */
+	DA850_MMCSD1_DAT_0,
+	DA850_MMCSD1_DAT_1,
+	DA850_MMCSD1_DAT_2,
+	DA850_MMCSD1_DAT_3,
+	DA850_MMCSD1_CLK,
+	DA850_MMCSD1_CMD,
+
 	/* EMIF2.5/EMIFA function */
 	DA850_EMA_D_7,
 	DA850_EMA_D_6,
-- 
1.7.4.1

