From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] mmc: atmel-mci: remove useless include
Date: Mon, 10 Aug 2015 16:26:48 +0200
Message-ID: <1439216808-11826-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36851 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751917AbbHJO0z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2015 10:26:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Definitions from linux/platform_data/atmel.h are not used, remove the
include.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/mmc/host/atmel-mci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9a39e0b7e583..bf62e429f7fc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/types.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/platform_data/mmc-atmel-mci.h>
 
 #include <linux/mmc/host.h>
-- 
2.1.4

