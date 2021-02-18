Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1096BC433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Feb 2021 12:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D143764E6F
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Feb 2021 12:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhBRL5f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Feb 2021 06:57:35 -0500
Received: from www.zeus03.de ([194.117.254.33]:44462 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhBRLDt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 18 Feb 2021 06:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=kD82ygGvqHgE5hga7QTnygYLBxS
        EovlyZDwZAqroviA=; b=TEdeXcF6LQtrjVcEhG+fh4VYi+FuGPFJdhTebPYKMyl
        luNHZ/Vh3F+8z39ntRW/++ovq7VqTox+/83gpWLQEmx3qaiFfpl+Mw7M9Sitw61f
        zEwAxFc2bOJlTkBsOQEKOm5XBizxpUPyCXDvENwPBxB8WzngBvrJR/C5Hq0G2sZs
        =
Received: (qmail 897720 invoked from network); 18 Feb 2021 12:02:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Feb 2021 12:02:36 +0100
X-UD-Smtp-Session: l3s3148p1@y9TsRZq7jKYgAwDPXxApAAF3+sXyxkl6
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] mmc: tmio: remove workaround for NON_REMOVABLE
Date:   Thu, 18 Feb 2021 12:02:24 +0100
Message-Id: <20210218110224.6910-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RPM handling has been improved twice since this comment, and also SCC
handling has been improved a lot. All the testing we did (Geert's and
Niklas' and Wolfram's board farms) with the workaround removed did not
lead to problems, so it is time to get rid of it to the best of our
knowledge.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/mmc/host/tmio_mmc_core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 49c2d406c48e..2478a91e84b2 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1160,15 +1160,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
 
-	/*
-	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
-	 * hotplug gets disabled. It seems RuntimePM related yet we need further
-	 * research. Since we are planning a PM overhaul anyway, let's enforce
-	 * for now the device being active by enabling native hotplug always.
-	 */
-	if (pdata->flags & TMIO_MMC_MIN_RCAR2)
-		_host->native_hotplug = true;
-
 	/*
 	 * While using internal tmio hardware logic for card detection, we need
 	 * to ensure it stays powered for it to work.
-- 
2.30.0

