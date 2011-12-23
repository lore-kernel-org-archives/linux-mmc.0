From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] mmc: add a card hotplug handler context
Date: Sat, 24 Dec 2011 00:00:15 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112232351250.1911@axis700.grange>
References: <Pine.LNX.4.64.1112232346180.1911@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61401 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914Ab1LWXAW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Dec 2011 18:00:22 -0500
In-Reply-To: <Pine.LNX.4.64.1112232346180.1911@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

SD/MMC controllers provide different card insertion and removal detection
methods. On some of them the controller itself issues an interrupt, on
others polling is used, on yet others auxiliary means are used for this
purpose, e.g., a GPIO IRQ. Further, on some systems one of those methods
can be chosen at driver probing time and configured in software. E.g., on
some systems the SD/MMC controller card hot-plug detection pin can be
configured either as a respective controller functions, or an IRQ-capable
GPIO. To support such flexible configurations a card hot-plug context
is added by this patch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/host.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index edf1f45..e43b808 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -168,6 +168,11 @@ struct mmc_async_req {
 	int (*err_check) (struct mmc_card *, struct mmc_async_req *);
 };
 
+struct mmc_hotplug {
+	unsigned int irq;
+	void *handler_priv;
+};
+
 struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
@@ -299,6 +304,7 @@ struct mmc_host {
 	int			claim_cnt;	/* "claim" nesting count */
 
 	struct delayed_work	detect;
+	struct mmc_hotplug	hotplug;
 
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
 	unsigned int		bus_refs;	/* reference counter */
-- 
1.7.2.5

