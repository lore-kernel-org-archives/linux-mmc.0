From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/21] mmc: sdhci-cadence: Include mmc.h
Date: Fri, 30 Dec 2016 13:47:21 +0100
Message-ID: <1483102054-1752-9-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35653 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3MsL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:11 -0500
Received: by mail-lf0-f48.google.com with SMTP id b14so236437707lfg.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:10 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

Don't rely on host.h to include the mmc.h header, but instead include it
explicitly because the driver depends on it.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-cadence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 4b0ecb9..31e786d 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 
 #include "sdhci-pltfm.h"
 
-- 
1.9.1

