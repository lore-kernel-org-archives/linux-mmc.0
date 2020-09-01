Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BFC433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F57206FA
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="rUbAbGYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIAPDD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:03:03 -0400
Received: from www.zeus03.de ([194.117.254.33]:44204 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgIAPC5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 11:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=XvBbRu+MEKOQyD
        jLxrh7WBj3o92qluZhg+YEWmbsB5s=; b=rUbAbGYcixtvAriSGCdjFPdFXL3ohq
        pFk3CmkBmHjFsgf/963ihO/VuXUF1mLRH7WWb0TWk4uhogMoFvRsAfKOuJ2eGJSh
        T5s+7J0imp8XZFldLOAoVaLkTv1oDahf/pCOm71wjznGwZFxm53s8zuIHJpUkopp
        EXa9ClzU7lCnc=
Received: (qmail 2554178 invoked from network); 1 Sep 2020 17:02:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2020 17:02:55 +0200
X-UD-Smtp-Session: l3s3148p1@BSJf0EGuXIwgAwDPXxBIAL7SzoTwUEK2
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 1/4] mmc: core: when downgrading HS400, callback into drivers earlier
Date:   Tue,  1 Sep 2020 17:02:47 +0200
Message-Id: <20200901150250.26236-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
References: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver specific downgrade function makes more sense if we run it
before we set the timing to something lower, not after. Otherwise some
non-HS400 communication has already happened.

No need to convert users. There is only one currently which needs this
change in a following patch.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b3fa193de846..ba2852b684b1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1168,13 +1168,13 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
-	/* Set host controller to HS timing */
-	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
-
 	/* Prepare host to downgrade to HS timing */
 	if (host->ops->hs400_downgrade)
 		host->ops->hs400_downgrade(host);
 
+	/* Set host controller to HS timing */
+	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+
 	/* Reduce frequency to HS frequency */
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
@@ -1253,6 +1253,9 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	if (err)
 		goto out_err;
 
+	if (host->ops->hs400_downgrade)
+		host->ops->hs400_downgrade(host);
+
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
 	err = mmc_switch_status(card, true);
@@ -1268,9 +1271,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
 
-	if (host->ops->hs400_downgrade)
-		host->ops->hs400_downgrade(host);
-
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
-- 
2.20.1

