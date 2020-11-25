Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F932C63777
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 20:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F908207BB
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 20:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JS+TClP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgKYUuK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 15:50:10 -0500
Received: from www.zeus03.de ([194.117.254.33]:38604 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730384AbgKYUuK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Nov 2020 15:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=WM6neK/9XhvhdQtc0CGjtDZWub4
        s7ZwL8dvi/3S+mmc=; b=JS+TClP8E4OBpTJ0735+k88JlDtl2040c/ph9+BpkWY
        zhM98PW415XsVbZckWmyPDxFIku+jRliIyZQR7oVGdsO62eCCgTmZ63OUZkiGia4
        KQfdqc6VDvjVwEVftXc6wBSY5GuiZSluacDTSRO6fNo5gVGgf88D6MSvX0NCXBVo
        =
Received: (qmail 3433286 invoked from network); 25 Nov 2020 21:50:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2020 21:50:06 +0100
X-UD-Smtp-Session: l3s3148p1@0K7ykfS0Eo0gAwDPXwZjAFYQ5uAAs3hj
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: tmio: improve bringing HW to a sane state with MMC_POWER_OFF
Date:   Wed, 25 Nov 2020 21:49:53 +0100
Message-Id: <20201125204953.3344-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Further testing of error cases revealed that downgrade is not enough, so
we need to reset the SCC which is done by calling the custom reset
function. This reset function can distinguish between the various SDHI
variants, so protecting the call with MIN_RCAR2 is enough here.

Fixes: 24ce2d7b8bea ("mmc: tmio: bring tuning HW to a sane state with MMC_POWER_OFF")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I was also evaluating if tmio_mmc_reset() would be better than
host->reset. I finally decided against it. This is the minimal change
that we need and which fixes an actual issue. I can't see why we would
want to terminate DMA because either everything went smooth and DMA
completed or the DMA error has already been handled. I think. Please
speak up if you disagree.

 drivers/mmc/host/tmio_mmc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 7f4a28125010..a89547f5d733 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -929,9 +929,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
-		/* Downgrade ensures a sane state for tuning HW (e.g. SCC) */
-		if (host->mmc->ops->hs400_downgrade)
-			host->mmc->ops->hs400_downgrade(host->mmc);
+		/* For R-Car Gen2+, we need to reset SDHI specific SCC */
+		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+			host->reset(host);
 		host->set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
-- 
2.28.0

