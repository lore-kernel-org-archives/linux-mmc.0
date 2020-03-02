Return-Path: <SRS0=XGfH=4T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD882C3F2D2
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Mar 2020 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE04246B4
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Mar 2020 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgCBJfi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:35:38 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:35334 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCBJfi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Mar 2020 04:35:38 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id 9Mbb2200N5USYZQ01Mbbxs; Mon, 02 Mar 2020 10:35:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j8hU7-0008PX-Ap; Mon, 02 Mar 2020 10:35:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j8hU7-0002Ms-8H; Mon, 02 Mar 2020 10:35:35 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: renesas_sdhi: Use BITS_PER_LONG helper
Date:   Mon,  2 Mar 2020 10:35:34 +0100
Message-Id: <20200302093534.9055-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the existing BITS_PER_LONG helper definition instead of calculating
this value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 7a1a741547f25de5..2a4c83a5f32ef8e2 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -60,7 +60,7 @@ struct renesas_sdhi {
 	bool doing_tune;
 
 	/* Tuning values: 1 for success, 0 for failure */
-	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
+	DECLARE_BITMAP(taps, BITS_PER_LONG);
 	unsigned int tap_num;
 	unsigned long tap_set;
 };
-- 
2.17.1

