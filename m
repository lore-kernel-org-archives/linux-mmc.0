Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A2FC2BC0E
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D2E20767
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UGj5DWNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIAPDC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:03:02 -0400
Received: from www.zeus03.de ([194.117.254.33]:44222 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbgIAPC6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 11:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=J/ymO1yaQKxdj0
        HncqywHOg41cmUybmna02aPnRHvuc=; b=UGj5DWNCcbftWN10Opc4Rc0n5RPkrC
        W3ht7YUedoLilQD3PJaYxGjTvfmk8Bp0TejFVXtLVimcztWFsobB9sO9ls/VMCDc
        oFx2/88NExLimv3djokMhUxZI9VI5rHm4W0aSFPljg6YkLiJ2gWCiMmVRk8LU1FB
        WTonVS7tXMelU=
Received: (qmail 2554233 invoked from network); 1 Sep 2020 17:02:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2020 17:02:56 +0200
X-UD-Smtp-Session: l3s3148p1@NRRp0EGuYIwgAwDPXxBIAL7SzoTwUEK2
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 3/4] mmc: renesas_sdhi: keep SCC clock active when tuning
Date:   Tue,  1 Sep 2020 17:02:49 +0200
Message-Id: <20200901150250.26236-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
References: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tuning procedure switches to lower frequencies but that will turn the
SCC off and accessing its register then will hang. So, check when we are
tuning and keep the current setup of the external clock if we are doing
so. Note that we still switch to the lower frequency because of the
internal divider. We just make sure to not modify the external clock.
This patch depends on a MMC core patch calling the downgrade function
earlier.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 29148fa25d82..c5cba0a1b112 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -117,8 +117,12 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
 	int i;
 
-	/* tested only on R-Car Gen2+ currently; may work for others */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+	/*
+	 * We simply return the current rate if a) we are not on a R-Car Gen2+
+	 * SoC (may work for others, but untested) or b) if the SCC needs its
+	 * clock during tuning, so we don't change the external clock setup.
+	 */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2) || mmc_doing_tune(host->mmc))
 		return clk_get_rate(priv->clk);
 
 	/*
-- 
2.20.1

