From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 2/5] mmc: tmio: rename tmio_mmc_{pio => core}.c
Date: Tue,  2 May 2017 13:15:40 +0200
Message-ID: <1493723743-22821-3-git-send-email-horms+renesas@verge.net.au>
References: <1493723743-22821-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54546 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdEBLQG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2017 07:16:06 -0400
In-Reply-To: <1493723743-22821-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>

Rename tmio_mmc_pio.c to tmio_mmc_core.c to more accurately reflect its
function: to provide core code for the tmio-mmc and sh-mobole-sdhi drivers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/Makefile                            | 1 -
 drivers/mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c} | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)
 rename drivers/mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c} (99%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index f11b3d4b121d..f9baa943b470 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
-tmio_mmc_core-y			:= tmio_mmc_pio.o
 obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o tmio_mmc_dma.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_core.c
similarity index 99%
rename from drivers/mmc/host/tmio_mmc_pio.c
rename to drivers/mmc/host/tmio_mmc_core.c
index 96905c7187f0..d5c23496c499 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/mmc/host/tmio_mmc_pio.c
+ * linux/drivers/mmc/host/tmio_mmc_core.c
  *
  * Copyright (C) 2016 Sang Engineering, Wolfram Sang
  * Copyright (C) 2015-16 Renesas Electronics Corporation
-- 
2.1.4

