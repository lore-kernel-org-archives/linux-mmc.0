Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E4C54EED
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 01:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjAYBC2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 20:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjAYBCY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 20:02:24 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C7572330B;
        Tue, 24 Jan 2023 17:02:17 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Jan 2023 10:02:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id AFF9D2058B4F;
        Wed, 25 Jan 2023 10:02:16 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 25 Jan 2023 10:02:19 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 118003D53;
        Wed, 25 Jan 2023 10:02:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/5] mmc: uniphier-sd: Add control to switch UHS speed
Date:   Wed, 25 Jan 2023 10:01:59 +0900
Message-Id: <20230125010201.28246-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SD interface logic has the register to switch UHS speed.
The default is up to SDR25 and to support SDR50 or faster,
add uniphier_sd_speed_switch() function to switch the speed mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/mmc/host/uniphier-sd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index c9766d6a690f..61acd69fac0e 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -54,6 +54,7 @@
 #define UNIPHIER_SDCTRL_CHOFFSET	0x200
 #define UNIPHIER_SDCTRL_MODE		0x30
 #define   UNIPHIER_SDCTRL_MODE_UHS1MOD		BIT(15)
+#define   UNIPHIER_SDCTRL_MODE_SDRSEL		BIT(14)
 
 /*
  * IP is extended to support various features: built-in DMA engine,
@@ -429,6 +430,25 @@ static void uniphier_sd_hw_reset(struct mmc_host *mmc)
 	usleep_range(300, 1000);
 }
 
+static void uniphier_sd_speed_switch(struct tmio_mmc_host *host)
+{
+	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
+	unsigned int offset;
+	u32 val = 0;
+
+	if (!(host->mmc->caps & MMC_CAP_UHS))
+		return;
+
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR50 ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS_SDR104)
+		val = UNIPHIER_SDCTRL_MODE_SDRSEL;
+
+	offset = UNIPHIER_SDCTRL_CHOFFSET * priv->sdctrl_ch
+		+ UNIPHIER_SDCTRL_MODE;
+	regmap_write_bits(priv->sdctrl_regmap, offset,
+			  UNIPHIER_SDCTRL_MODE_SDRSEL, val);
+}
+
 static void uniphier_sd_uhs_enable(struct tmio_mmc_host *host, bool uhs_en)
 {
 	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
@@ -459,6 +479,8 @@ static void uniphier_sd_set_clock(struct tmio_mmc_host *host,
 	tmp &= ~CLK_CTL_SCLKEN;
 	writel(tmp, host->ctl + (CTL_SD_CARD_CLK_CTL << 1));
 
+	uniphier_sd_speed_switch(host);
+
 	if (clock == 0)
 		return;
 
-- 
2.25.1

