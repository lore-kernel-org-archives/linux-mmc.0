Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F7C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FDC2072D
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 10:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VlGF8Dyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHaKXf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:23:35 -0400
Received: from www.zeus03.de ([194.117.254.33]:52018 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaKXe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Aug 2020 06:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=x7BLqfeBv4SVfp/Z3lCdLtNBlM9
        KlpCVEwpWsY/Z1bM=; b=VlGF8Dyfb6w3101nYq228QatW4dE6O/gJFNRxgcqz/W
        sIuiIeAF7DR9UnvlQefDubd+G3ekylDnwds1Mj8esZ1dwHDMJ6BnMJ9cOf/jhwYg
        5Gr9BbFD4WG3x99Pbv63Re9BDBPkpErqYIja5HAYb7l+6QpqLquBpqZOeIIwG7LU
        =
Received: (qmail 2082363 invoked from network); 31 Aug 2020 12:23:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 Aug 2020 12:23:31 +0200
X-UD-Smtp-Session: l3s3148p1@6ABXyymuhM8gAwDPXwczAOmbI0TU8LCu
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: meson-gx: use wrapper to avoid accessing internal vars
Date:   Mon, 31 Aug 2020 12:23:24 +0200
Message-Id: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only buildtested. Found while analyzing retune-handling in the core.

 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 08a3b1c05acb..a1db8685e30e 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -521,7 +521,7 @@ static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
 	val |= ADJUST_ADJ_EN;
 	writel(val, host->regs + host->data->adjust);
 
-	if (mmc->doing_retune)
+	if (mmc_doing_retune(mmc))
 		dly = FIELD_GET(ADJUST_ADJ_DELAY_MASK, val) + 1;
 	else
 		dly = 0;
-- 
2.20.1

