From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] MAINTAINERS: mmc: Remove Seungwon Jeon from dw_mmc
Date: Fri,  6 Nov 2015 12:21:33 +0100
Message-ID: <1446808893-7638-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34834 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031997AbbKFLVi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 06:21:38 -0500
Received: by lfbn126 with SMTP id n126so70892868lfb.2
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2015 03:21:37 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>

Unfortunate, Seungwon's email has been bouncing for some time and it seems
like he has moved on to other duties. So, I would like to thank him for
his efforts, but it's now time to remove him as the co-maintainer for the
dw_mmc driver.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15c3896..08471e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9262,7 +9262,6 @@ F:	drivers/i2c/busses/i2c-designware-*
 F:	include/linux/platform_data/i2c-designware.h
 
 SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
-M:	Seungwon Jeon <tgih.jun@samsung.com>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
-- 
1.9.1

