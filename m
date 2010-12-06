From: Simon Horman <horms@verge.net.au>
Subject: [patch 1/3] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Date: Mon, 06 Dec 2010 09:12:44 +0900
Message-ID: <20101206001310.658304531@vergenet.net>
References: <20101206001243.949375995@vergenet.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:59017 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0LFAP1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Dec 2010 19:15:27 -0500
Content-Disposition: inline; filename=MMCIF_PROGRESS-header.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Allow MMCIF_PROGRESS_* to be shared.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6-ap4/arch/sh/boot/romimage/mmcif-sh7724.c
===================================================================
--- linux-2.6-ap4.orig/arch/sh/boot/romimage/mmcif-sh7724.c	2010-12-06 08:59:11.000000000 +0900
+++ linux-2.6-ap4/arch/sh/boot/romimage/mmcif-sh7724.c	2010-12-06 08:59:16.000000000 +0900
@@ -21,9 +21,6 @@
 #define HIZCRC		0xa405015c
 #define DRVCRA		0xa405018a
 
-enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
-       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
-
 /* SH7724 specific MMCIF loader
  *
  * loads the romImage from an MMC card starting from block 512
Index: linux-2.6-ap4/include/linux/mmc/sh_mmcif.h
===================================================================
--- linux-2.6-ap4.orig/include/linux/mmc/sh_mmcif.h	2010-12-06 08:59:11.000000000 +0900
+++ linux-2.6-ap4/include/linux/mmc/sh_mmcif.h	2010-12-06 08:59:16.000000000 +0900
@@ -97,6 +97,9 @@ static inline void sh_mmcif_writel(void
 
 #define SH_MMCIF_BBS 512 /* boot block size */
 
+enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
+       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
+
 static inline void sh_mmcif_boot_cmd_send(void __iomem *base,
 					  unsigned long cmd, unsigned long arg)
 {

