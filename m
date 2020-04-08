Return-Path: <SRS0=F8Hu=5Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA72C2BB54
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EE12083E
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgDHJqx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:46:53 -0400
Received: from sauhun.de ([88.99.104.3]:39658 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgDHJqw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Apr 2020 05:46:52 -0400
Received: from localhost (p54B334FE.dip0.t-ipconnect.de [84.179.52.254])
        by pokefinder.org (Postfix) with ESMTPSA id 420FF2C1FDD;
        Wed,  8 Apr 2020 11:46:51 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>
Subject: [PATCH v2 3/3] mmc: renesas_sdhi: improve TAP selection if all TAPs are good
Date:   Wed,  8 Apr 2020 11:46:38 +0200
Message-Id: <20200408094638.10375-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408094638.10375-1-wsa+renesas@sang-engineering.com>
References: <20200408094638.10375-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When tuning HS400, if all TAPS are good, we can utilize the SMPCMP
register to select the optimal TAP. For that, we populate a second
bitmap with SMPCMP results and query it in case the regular bitmap is
full (= all good).

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 2a4c83a5f32e..12d8016672b0 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -61,6 +61,8 @@ struct renesas_sdhi {
 
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_LONG);
+	/* Sampling data comparison: 1 for match, 0 for mismatch */
+	DECLARE_BITMAP(smpcmp, BITS_PER_LONG);
 	unsigned int tap_num;
 	unsigned long tap_set;
 };
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 0dbee47eafa1..796b5eb50415 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -428,7 +428,8 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int tap_start = 0, tap_end = 0, tap_cnt = 0, rs, re, i;
-	unsigned int taps_size = priv->tap_num * 2;
+	unsigned int taps_size = priv->tap_num * 2, min_tap_row;
+	unsigned long *bitmap;
 
 	priv->doing_tune = false;
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
@@ -443,6 +444,21 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 
 		if (!test_bit(i, priv->taps))
 			clear_bit(i + offset, priv->taps);
+
+		if (!test_bit(i, priv->smpcmp))
+			clear_bit(i + offset, priv->smpcmp);
+	}
+
+	/*
+	 * If all TAP are OK, the sampling clock position is selected by
+	 * identifying the change point of data.
+	 */
+	if (bitmap_full(priv->taps, taps_size)) {
+		bitmap = priv->smpcmp;
+		min_tap_row = 1;
+	} else {
+		bitmap = priv->taps;
+		min_tap_row = SH_MOBILE_SDHI_MIN_TAP_ROW;
 	}
 
 	/*
@@ -450,7 +466,7 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	 * is at least SH_MOBILE_SDHI_MIN_TAP_ROW probes long then use the
 	 * center index as the tap, otherwise bail out.
 	 */
-	bitmap_for_each_set_region(priv->taps, rs, re, 0, taps_size) {
+	bitmap_for_each_set_region(bitmap, rs, re, 0, taps_size) {
 		if (re - rs > tap_cnt) {
 			tap_end = re;
 			tap_start = rs;
@@ -458,7 +474,7 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 		}
 	}
 
-	if (tap_cnt >= SH_MOBILE_SDHI_MIN_TAP_ROW)
+	if (tap_cnt >= min_tap_row)
 		priv->tap_set = (tap_start + tap_end) / 2 % priv->tap_num;
 	else
 		return -EIO;
@@ -491,6 +507,7 @@ static int renesas_sdhi_execute_tuning(struct tmio_mmc_host *host, u32 opcode)
 
 	priv->doing_tune = true;
 	bitmap_zero(priv->taps, priv->tap_num * 2);
+	bitmap_zero(priv->smpcmp, priv->tap_num * 2);
 
 	/* Issue CMD19 twice for each tap */
 	for (i = 0; i < 2 * priv->tap_num; i++) {
@@ -499,6 +516,9 @@ static int renesas_sdhi_execute_tuning(struct tmio_mmc_host *host, u32 opcode)
 
 		if (mmc_send_tuning(host->mmc, opcode, NULL) == 0)
 			set_bit(i, priv->taps);
+
+		if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
+			set_bit(i, priv->smpcmp);
 	}
 
 	return renesas_sdhi_select_tuning(host);
-- 
2.20.1

