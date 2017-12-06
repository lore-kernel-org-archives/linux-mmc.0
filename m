From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 12/45] drivers: mmc: remove duplicate includes
Date: Wed,  6 Dec 2017 22:27:03 +0530
Message-ID: <1512579423-5405-1-git-send-email-pravin.shedge4linux@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38734 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdLFQ5M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Dec 2017 11:57:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, hkallweit1@gmail.com
Cc: linux-kernel@vger.kernel.org, pravin.shedge4linux@gmail.com

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/mmc/host/android-goldfish.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 63fe509..63d2758 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -42,13 +42,11 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/clk.h>
-#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
 
 #include <asm/types.h>
-#include <asm/io.h>
 #include <linux/uaccess.h>
 
 #define DRIVER_NAME "goldfish_mmc"
-- 
2.7.4

