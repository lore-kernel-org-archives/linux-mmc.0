From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 8/9] mmc: msm: Cleanup mmc-msm_sdcc.h header
Date: Wed, 15 Jan 2014 11:25:12 +0530
Message-ID: <1389765313-16744-8-git-send-email-sachin.kamat@linaro.org>
References: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42508 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaAOF7n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:43 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so689068pab.17
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:43 -0800 (PST)
In-Reply-To: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, sachin.kamat@linaro.org, patches@linaro.org

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

