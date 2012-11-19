From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: sdhci-dove: remove duplicate inclusion of linux/err.h
Date: Mon, 19 Nov 2012 17:25:13 +0530
Message-ID: <1353326113-9615-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63270 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab2KSMBU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 07:01:20 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so406885pad.19
        for <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 04:01:20 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sebastian.hesselbarth@googlemail.com, sachin.kamat@linaro.org, patches@linaro.org

linux/err.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-dove.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 8fd50a2..2a03f30 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -22,7 +22,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
 #include <linux/of.h>
-- 
1.7.4.1

