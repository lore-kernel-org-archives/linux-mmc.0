From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] mmc: msm: Cleanup mmc-msm_sdcc.h header
Date: Fri,  3 Jan 2014 15:42:37 +0530
Message-ID: <1388743958-19487-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36649 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaACKQY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jan 2014 05:16:24 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so15138790pdj.17
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jan 2014 02:16:24 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, trivial@kernel.org

Commit 1ef21f6343ff ("ARM: msm: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/mmc-msm_sdcc.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/mmc-msm_sdcc.h b/include/linux/platform_data/mmc-msm_sdcc.h
index ffcd9e3a6a7e..55aa873c9396 100644
--- a/include/linux/platform_data/mmc-msm_sdcc.h
+++ b/include/linux/platform_data/mmc-msm_sdcc.h
@@ -1,8 +1,5 @@
-/*
- *  arch/arm/include/asm/mach/mmc.h
- */
-#ifndef ASMARM_MACH_MMC_H
-#define ASMARM_MACH_MMC_H
+#ifndef __MMC_MSM_SDCC_H
+#define __MMC_MSM_SDCC_H
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
-- 
1.7.9.5

