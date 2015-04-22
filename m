From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH] mmc-utils: remove obsolete do_write_extcsd function declaration
Date: Wed, 22 Apr 2015 20:42:23 +0300
Message-ID: <1429724545-3174-1-git-send-email-leon@leon.nu>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37959 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbDVRma (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 13:42:30 -0400
Received: by wiun10 with SMTP id n10so65955576wiu.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2015 10:42:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: linux-mmc@vger.kernel.org, Leon Romanovsky <leon@leon.nu>

The do_write_extcsd() function was removed from the C-file in
commit"b9c7a17 Rename extcsd read/write to writeprotect get/set".

This patch removes this function definition from H-file too.

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 mmc_cmds.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9e625c9..7a79e87 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -16,7 +16,6 @@
 
 /* mmc_cmds.c */
 int do_read_extcsd(int nargs, char **argv);
-int do_write_extcsd(int nargs, char **argv);
 int do_writeprotect_get(int nargs, char **argv);
 int do_writeprotect_set(int nargs, char **argv);
 int do_disable_512B_emulation(int nargs, char **argv);
-- 
1.7.9.5

