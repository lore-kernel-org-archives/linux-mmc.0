Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90E2EB64DC
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjFTKrx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjFTKrr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:47 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB091A5
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:46 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 781CC8634C;
        Tue, 20 Jun 2023 12:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258064;
        bh=bHiG/wByeL7J08YAL18goM+iHMaAtIDWsEG+k+ffIT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sgle1zu5M75/40KhCfyKggoAsghKQ75Jlyr9u5TQ7uB0jazCOfPjCPAFgxsjYCakF
         s4/7eOO0QLFcDMRTT5oDmoS4iJmzkY2B+QKWPpVViI2VJJx8QGLxBHGWufYooRusif
         AWf05oqgkBWB+jFqc1LQise+bBzUdc9oRzfaKcKI7xCYcxTNU15taG+WSA58R9Zgz3
         /I4TQbA3xeNyp2KHdtQR0O3Aoymn+fJA3VFTjY/RNoE63eblixR2FZW8Uq2ockePpH
         nCRe2nefR8gchfugKaP+nNZrJQHuoy5J225hYRW1DOmipdvSl5ckwsLjzvT5Uv7J5O
         iNmeCkA39pH2Q==
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
Subject: [PATCH 08/11] mmc: pxav3: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:19 +0200
Message-Id: <20230620104722.16465-8-marex@denx.de>
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
 drivers/mmc/host/sdhci-pxav3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e39dcc998772d..12c342a231dfc 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -35,7 +35,7 @@
 #define SDCLK_DELAY_MASK	0x1f
 
 #define SD_CFG_FIFO_PARAM       0x100
-#define SDCFG_GEN_PAD_CLK_ON	(1<<6)
+#define SDCFG_GEN_PAD_CLK_ON	BIT(6)
 #define SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
 #define SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
 
@@ -43,8 +43,8 @@
 #define SD_CE_ATA_1          0x10C
 
 #define SD_CE_ATA_2          0x10E
-#define SDCE_MISC_INT		(1<<2)
-#define SDCE_MISC_INT_EN	(1<<1)
+#define SDCE_MISC_INT		BIT(2)
+#define SDCE_MISC_INT_EN	BIT(1)
 
 struct sdhci_pxa {
 	struct clk *clk_core;
-- 
2.39.2

