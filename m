From: "Paul Parsons" <lost.distance@yahoo.com>
Subject: [PATCH v2] mmc: tmio: Fix build errors
Date: Tue, 17 May 2011 10:39:11 +0000
Message-ID: <E1QMHgG-0005TP-JM@outmx04.plus.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:13867 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232Ab1EQKjO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2011 06:39:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ian@mnementh.co.uk, g.liakhovetski@gmx.de

Only compile tmio_mmc_dma.o when CONFIG_MMC_SDHI is selected (as y or m).

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
--- clean-2.6.39-rc7/drivers/mmc/host/Makefile	2011-05-17 01:53:37.280446658 +0100
+++ linux-2.6.39-rc7/drivers/mmc/host/Makefile	2011-05-17 02:15:56.959621818 +0100
@@ -31,9 +31,7 @@ obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
-ifneq ($(CONFIG_MMC_SDHI),n)
-tmio_mmc_core-y			+= tmio_mmc_dma.o
-endif
+tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))	+= tmio_mmc_dma.o
 obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o

