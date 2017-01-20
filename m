From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: s3cmci: include linux/interrupt.h for tasklet_struct
Date: Fri, 20 Jan 2017 21:08:12 +0100
Message-ID: <20170120200822.3349092-1-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52638 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdATUJN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 15:09:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ben Dooks <ben-linux@fluff.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

I got this new build error on today's linux-next

drivers/mmc/host/s3cmci.h:69:24: error: field 'pio_tasklet' has incomplete type
  struct tasklet_struct pio_tasklet;
drivers/mmc/host/s3cmci.c: In function 's3cmci_enable_irq':
drivers/mmc/host/s3cmci.c:390:4: error: implicit declaration of function 'enable_irq';did you mean 'enable_imask'? [-Werror=implicit-function-declaration]

While I haven't found out why this happened now and not earlier, the
solution is obvious, we should include the header that defines
the structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/s3cmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 932a4b1fed33..7a173f8c455b 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -21,6 +21,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 
-- 
2.9.0

