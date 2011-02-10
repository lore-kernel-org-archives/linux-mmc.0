From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mmc: Ensure prototypes for SD API are visible in sd.c
Date: Thu, 10 Feb 2011 10:58:37 +0000
Message-ID: <1297335517-26248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52025 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752431Ab1BJK6l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 05:58:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

So we know the implementation and prototypes agree with each other.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/core/sd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d18c32b..6dac89f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -21,6 +21,7 @@
 #include "core.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "sd.h"
 #include "sd_ops.h"
 
 static const unsigned int tran_exp[] = {
-- 
1.7.2.3

