Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE3C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 10:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC3161BE5
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 10:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhKPLAJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:00:09 -0500
Received: from smtp.220.in.ua ([89.184.67.205]:51945 "EHLO smtp.220.in.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234409AbhKPLAE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Nov 2021 06:00:04 -0500
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 06:00:04 EST
Received: from oleh-pc.lan (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id 67FB51A204B3;
        Tue, 16 Nov 2021 12:51:21 +0200 (EET)
From:   Oleh Kravchenko <oleg@kaa.org.ua>
To:     linux-mmc@vger.kernel.org, Chris Ball <chrisball@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH] Fix strncpy() usage
Date:   Tue, 16 Nov 2021 12:51:09 +0200
Message-Id: <20211116105109.3830-1-oleg@kaa.org.ua>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Manpage of strncpy() says:
If there is no null byte among the first n bytes of src,
the string placed in dest will not be null-terminated.

Put \0 to the end of the buffer to ensure that
the destination string is NULL-terminated.

This patch also fixes a compile error with a newer version of GCC.

Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>
---
 mmc_cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 73bd32a..016fe70 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1834,8 +1834,8 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
-                memset(lbuf, 0, sizeof(lbuf));
-		strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
+		strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], sizeof(lbuf) - 1);
+		lbuf[sizeof(lbuf) - 1] = 0;
 		printf("eMMC Firmware Version: %s\n", lbuf);
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
-- 
2.32.0

