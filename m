Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C97FC77B73
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjEVVtK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 17:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjEVVtA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 17:49:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D745196
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 14:49:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOk-0001Es-Gq; Mon, 22 May 2023 23:48:58 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOj-0026AJ-At; Mon, 22 May 2023 23:48:57 +0200
Received: from ejo by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOi-008YGD-IY; Mon, 22 May 2023 23:48:56 +0200
From:   Enrico Jorns <ejo@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, ejo@pengutronix.de
Subject: [PATCH 1/3] mmc-utils: add SanDisk to manufacturer database
Date:   Mon, 22 May 2023 23:48:16 +0200
Message-Id: <20230522214818.2038252-1-ejo@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ejo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
---
 lsmmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lsmmc.c b/lsmmc.c
index 55da3aa..da9d69e 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -239,6 +239,11 @@ struct ids_database database[] = {
 		.id = 0x44,
 		.manufacturer = "ATP",
 	},
+	{
+		.type = "mmc",
+		.id = 0x45,
+		.manufacturer = "SanDisk Corporation",
+	},
 	{
 		.type = "mmc",
 		.id = 0x2c,
-- 
2.39.2

