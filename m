Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5742C433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5D2206CD
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="3D10v/wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIAOUe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:20:34 -0400
Received: from www.zeus03.de ([194.117.254.33]:60670 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgIAOTj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 10:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=VPrLFKONLizrTcy8SwQKaluVrDN
        G6FFHnaccsuoDN5c=; b=3D10v/wjr2O4p9lGD7AoEc6tM4/fzYTNxcSnQCdayh0
        p7sAHVLWwyn0jg3uXPshHy70d9kNy93Si55dbO85pZWv56sQF98KP4HVWcB1064P
        dAYvcnY4tMfMyaCVakndgndmUlWQXuJP5G1fPm9LnBHSifL2a7BU5KcYokDC46Ks
        =
Received: (qmail 2543495 invoked from network); 1 Sep 2020 16:19:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2020 16:19:37 +0200
X-UD-Smtp-Session: l3s3148p1@YJyDNUGuLowgAwDPXxBIAL7SzoTwUEK2
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: core: simplify an expression
Date:   Tue,  1 Sep 2020 16:19:31 +0200
Message-Id: <20200901141931.25357-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We already have 'host' as a variable, so use it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6b3056437b37..6794eb142f05 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1173,7 +1173,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 		host->ops->hs400_downgrade(host);
 
 	/* Set host controller to HS timing */
-	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+	mmc_set_timing(host, MMC_TIMING_MMC_HS);
 
 	/* Reduce frequency to HS frequency */
 	max_dtr = card->ext_csd.hs_max_dtr;
-- 
2.20.1

