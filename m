Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22DEC4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Jul 2021 07:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCED60FD7
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Jul 2021 07:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhG2H3o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhG2H3n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2021 03:29:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B379C061757
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jul 2021 00:29:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U7-0000u8-F0; Thu, 29 Jul 2021 09:29:39 +0200
Received: from [2a0a:edc0:0:900:2e4d:54ff:fe67:bfa5] (helo=ginster)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U6-0002Iy-F7; Thu, 29 Jul 2021 09:29:38 +0200
Received: from jbe by ginster with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U6-0002gi-EC; Thu, 29 Jul 2021 09:29:38 +0200
From:   Juergen Borleis <jbe@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, festevam@gmail.com,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        ulf.hansson@linaro.org, kernel@pengutronix.de
Subject: [PATCH 1/2] mmc: mxcmmc: really configure the DMA on demand
Date:   Thu, 29 Jul 2021 09:29:28 +0200
Message-Id: <20210729072929.10267-2-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729072929.10267-1-jbe@pengutronix.de>
References: <20210729072929.10267-1-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Calling mxcmci_use_dma(host) is intended for the next transfer only, not
for generic detection if DMA is possible. Without this change, the DMA gets
never configured and thus, never used.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/mmc/host/mxcmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 2fe6fcd..611f827 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -834,7 +834,8 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		burstlen = 4;
 
-	if (mxcmci_use_dma(host) && burstlen != host->burstlen) {
+	if (host->dma != NULL && burstlen != host->burstlen) {
+		/* reconfigure DMA on changes only */
 		host->burstlen = burstlen;
 		ret = mxcmci_setup_dma(mmc);
 		if (ret) {
-- 
2.20.1

