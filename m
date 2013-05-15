From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [RESEND PATCH v2 3/3] mmc: omap_hsmmc: add PSTATE to debugfs regs_show.
Date: Wed, 15 May 2013 10:45:16 +0200
Message-ID: <1368607516-2789-4-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:64921 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932193Ab3EOIpz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 May 2013 04:45:55 -0400
Received: from mailout-de.gmx.net ([10.1.76.30]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Ls67d-1UWJAr0zWx-013vCI for
 <linux-mmc@vger.kernel.org>; Wed, 15 May 2013 10:45:54 +0200
In-Reply-To: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

PSTATE shows current state of data lines.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2b2ec09..61c0254 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -53,6 +53,7 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -1809,6 +1810,8 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	seq_printf(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
+	seq_printf(s, "PSTATE:\t\t0x%08x\n",
+		   OMAP_HSMMC_READ(host->base, PSTATE));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, HCTL));
 	seq_printf(s, "SYSCTL:\t\t0x%08x\n",
-- 
1.7.10.4

