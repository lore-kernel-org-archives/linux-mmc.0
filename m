Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4002C1B0E3
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5596523A57
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgLHGTp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 01:19:45 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:40580 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgLHGTp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 01:19:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D102320009E8;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3AlbFmPBYbYZ; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 99D542000B4E;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 762BBC01FB7;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 2BB1A200D1C; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jack <jack.lo@gtsys.com.hk>
Subject: [PATCH 5/6] mmc: core: simplify hs200 tuning
Date:   Tue,  8 Dec 2020 14:18:38 +0800
Message-Id: <20201208061839.21163-6-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since the host->ops->prepare_hs400_tuning had been moved to
mmc_select_hs400() the tuning for hs200 can simplify and
the function mmc_hs200_tuning() can be removed.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/mmc/core/mmc.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f11562b58e89..6ef6029b6948 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1485,26 +1485,6 @@ static int mmc_select_timing(struct mmc_card *card)
 	return 0;
 }
 
-/*
- * Execute tuning sequence to seek the proper bus operating
- * conditions for HS200 and HS400, which sends CMD21 to the device.
- */
-static int mmc_hs200_tuning(struct mmc_card *card)
-{
-	struct mmc_host *host = card->host;
-
-	/*
-	 * Timing should be adjusted to the HS400 target
-	 * operation frequency for tuning process
-	 */
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
-	    host->ios.bus_width == MMC_BUS_WIDTH_8)
-		if (host->ops->prepare_hs400_tuning)
-			host->ops->prepare_hs400_tuning(host, &host->ios);
-
-	return mmc_execute_tuning(card);
-}
-
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -1726,7 +1706,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (mmc_card_hs200(card)) {
 		host->doing_init_tune = 1;
 
-		err = mmc_hs200_tuning(card);
+		err = mmc_execute_tuning(card);
 
 		host->doing_init_tune = 0;
 
-- 
2.20.1

