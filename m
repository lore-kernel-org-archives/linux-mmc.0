Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB71AC7EE2A
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjEVVtL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjEVVtB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 17:49:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C277103
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 14:49:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOk-0001Et-Gs; Mon, 22 May 2023 23:48:58 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOj-0026AM-Ge; Mon, 22 May 2023 23:48:57 +0200
Received: from ejo by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOi-008YGK-JP; Mon, 22 May 2023 23:48:56 +0200
From:   Enrico Jorns <ejo@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, ejo@pengutronix.de
Subject: [PATCH 3/3] mmc-utils: do not hide CID manufacturer information
Date:   Mon, 22 May 2023 23:48:18 +0200
Message-Id: <20230522214818.2038252-3-ejo@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522214818.2038252-1-ejo@pengutronix.de>
References: <20230522214818.2038252-1-ejo@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ejo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Reading the MID just to convert it to 'Unlisted' is quite unhelpful for
an info command.
Due to the (constantly increasing) amount of valid MIDs it is quite
unlikely to we have it in the database already anyway.

Thus simply always print the manufacturer ID as 0xNN and understand the
manufacturer name as an additional information held in parenthesis.

Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
---
 lsmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index cea43af..54c3167 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -636,10 +636,10 @@ void print_mmc_cid(struct config *config, char *cid)
 		printf("\tCRC: 0x%02x\n", crc);
 	} else {
 		if (config->mmc_ids[mid])
-			printf("manufacturer: '%s' 0x%01x\n",
-			       config->mmc_ids[mid], oid);
+			printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
+			       mid, config->mmc_ids[mid], oid);
 		else
-			printf("manufacturer: 'Unlisted' 0x%01x\n", oid);
+			printf("manufacturer: 0x%02x (Unlisted) oid: 0x%01x\n", mid, oid);
 
 		printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
 		printf("serial: 0x%08x\n", psn);
-- 
2.39.2

