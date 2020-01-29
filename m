Return-Path: <SRS0=tWKp=3S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EA4C47409
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Jan 2020 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3062071E
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Jan 2020 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgA2Uh0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:37:26 -0500
Received: from sauhun.de ([88.99.104.3]:41370 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgA2Uh0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Jan 2020 15:37:26 -0500
Received: from localhost (p5486CF2C.dip0.t-ipconnect.de [84.134.207.44])
        by pokefinder.org (Postfix) with ESMTPSA id 427C62C28B0;
        Wed, 29 Jan 2020 21:37:24 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/6] mmc: renesas_sdhi: complain loudly if driver needs update
Date:   Wed, 29 Jan 2020 21:37:05 +0100
Message-Id: <20200129203709.30493-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
References: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When the tap array in the driver is too low, this is not a warning but
an error. Also _once is not helpful, we should make sure it is
prominently in the logs. It is safe to do this because this will only
show up during SoC enablement when we a new SoCs needs more taps (if
that ever will happen).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Note: 'unsigned long' seems big enough for a while. But, famous last
words(tm). We could handle this at runtime by reallocating a bigger
buffer. Very unsure if it is worth it, though.

 drivers/mmc/host/renesas_sdhi_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index b3ab66f963f8..d63aeb35bd0b 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -499,9 +499,9 @@ static int renesas_sdhi_execute_tuning(struct tmio_mmc_host *host, u32 opcode)
 		return 0; /* Tuning is not supported */
 
 	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
-		dev_warn_once(&host->pdev->dev,
-			"Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
-		return 0;
+		dev_err(&host->pdev->dev,
+			"Too many taps, please update 'taps' in tmio_mmc_host!\n");
+		return -EINVAL;
 	}
 
 	priv->doing_tune = true;
-- 
2.20.1

