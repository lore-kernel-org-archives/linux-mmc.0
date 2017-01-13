From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 04/15] MIPS: Alchemy: Don't rely on public mmc header to include interrupt.h
Date: Fri, 13 Jan 2017 14:14:05 +0100
Message-ID: <1484313256-25993-5-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35391 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdAMNOs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 08:14:48 -0500
Received: by mail-lf0-f52.google.com with SMTP id m78so37126586lfg.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 05:14:48 -0800 (PST)
In-Reply-To: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org

The MIPS Alchemy db1300 dev board depends on interrupt.h. Explicitly
include it instead of relying on the public mmc header host.h.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

I am seeking an ack for this change as following changes for mmc in the
series, has build-dependencies to it.

---
 arch/mips/alchemy/devboards/db1300.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index d3c087f..a5504f5 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/leds.h>
+#include <linux/interrupt.h>
 #include <linux/ata_platform.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
-- 
1.9.1

