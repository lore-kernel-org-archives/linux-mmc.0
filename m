Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C3AC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Nov 2021 14:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbhKZOx3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Nov 2021 09:53:29 -0500
Received: from smtp.220.in.ua ([89.184.67.205]:32779 "EHLO smtp.220.in.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347485AbhKZOv2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Nov 2021 09:51:28 -0500
Received: from oleh-pc.lan (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id B37F11A21FBE;
        Fri, 26 Nov 2021 16:48:13 +0200 (EET)
From:   Oleh Kravchenko <oleg@kaa.org.ua>
To:     linux-mmc@vger.kernel.org, chrisball@gmail.com,
        ulf.hansson@linaro.org, patchwork-bot@kernel.org
Cc:     Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH v2] Replace strncpy() usage by printf()
Date:   Fri, 26 Nov 2021 16:47:51 +0200
Message-Id: <20211126144750.11537-1-oleg@kaa.org.ua>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211116105109.3830-1-oleg@kaa.org.ua>
References: <20211116105109.3830-1-oleg@kaa.org.ua>
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
 mmc_cmds.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 73bd32a..753fcd9 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1392,7 +1392,6 @@ int do_read_extcsd(int nargs, char **argv)
 	__u32 regl;
 	int fd, ret;
 	char *device;
-	char lbuf[10];
 	const char *str;
 
 	if (nargs != 2) {
@@ -1834,9 +1833,7 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
-                memset(lbuf, 0, sizeof(lbuf));
-		strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
-		printf("eMMC Firmware Version: %s\n", lbuf);
+		printf("eMMC Firmware Version: %.*s\n", 8, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
-- 
2.32.0

