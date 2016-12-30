From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/21] mmc: Removed the unused public mmc boot.h header
Date: Fri, 30 Dec 2016 13:47:15 +0100
Message-ID: <1483102054-1752-3-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33779 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3Mry (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:47:54 -0500
Received: by mail-lf0-f45.google.com with SMTP id c13so236664161lfg.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:47:53 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/boot.h | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 include/linux/mmc/boot.h

diff --git a/include/linux/mmc/boot.h b/include/linux/mmc/boot.h
deleted file mode 100644
index 23acc3b..0000000
--- a/include/linux/mmc/boot.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef LINUX_MMC_BOOT_H
-#define LINUX_MMC_BOOT_H
-
-enum { MMC_PROGRESS_ENTER, MMC_PROGRESS_INIT,
-       MMC_PROGRESS_LOAD, MMC_PROGRESS_DONE };
-
-#endif /* LINUX_MMC_BOOT_H */
-- 
1.9.1

