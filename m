From: David Miller <davem@davemloft.net>
Subject: [PATCH] of_mmc_spi: Need to include irq.h and of_irq.h
Date: Fri, 18 Mar 2011 15:00:23 -0700 (PDT)
Message-ID: <20110318.150023.27819221.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


Since these are the headers that provide irq_of_parse_and_map()
and NO_IRQ.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 5530def..e2aecb7 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -15,9 +15,11 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/mmc_spi.h>
 #include <linux/mmc/core.h>
