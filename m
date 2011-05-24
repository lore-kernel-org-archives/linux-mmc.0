From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH] drivers:mmc:add the NO_IRQ define to of_mmc_spi.c
Date: Tue, 24 May 2011 21:03:22 +0800
Message-ID: <1306242202-9252-1-git-send-email-wanlong.gao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:64766 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112Ab1EXNDm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 09:03:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Wanlong Gao <wanlong.gao@gmail.com>

For archs that don't support NO_IRQ (such as mips),
provide a dummy value. Fix the build error for mips.

Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
---
 drivers/mmc/host/of_mmc_spi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index e2aecb7..ab66f24 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -25,6 +25,11 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 
+/* For archs that don't support NO_IRQ (such as mips), provide a dummy value */
+#ifndef NO_IRQ
+#define NO_IRQ 0
+#endif
+
 MODULE_LICENSE("GPL");
 
 enum {
-- 
1.7.4.1

