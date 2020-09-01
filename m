Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF4EC28E83
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0352A20767
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DesbFH+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIAPDC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:03:02 -0400
Received: from www.zeus03.de ([194.117.254.33]:44240 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgIAPC6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 11:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=uQfNnKJgBNZTg3
        0cQae7dcsnKSrgnD9Najh7atT2IUQ=; b=DesbFH+2YFuy0HOBonR/WRXdlGQoh/
        3EQrD8DYvd3kT4mlxyE1MBG0tGJ26p3/i+kW2qEnIw1SXp1tuAA2LyrQTqKZvDiI
        5wJ+XUxm7nQb0iFy5w1CbeppkLAYar2bK96D4hxNdL1+4NC+MsEJsUxyxU9UOC6x
        mNOpMlcwuJidQ=
Received: (qmail 2554263 invoked from network); 1 Sep 2020 17:02:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2020 17:02:56 +0200
X-UD-Smtp-Session: l3s3148p1@lzhu0EGuYowgAwDPXxBIAL7SzoTwUEK2
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 4/4] mmc: core: simplify an expression
Date:   Tue,  1 Sep 2020 17:02:50 +0200
Message-Id: <20200901150250.26236-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
References: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
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
index 216bd1aed373..67e95eba0e82 100644
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

