From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] sh-mobile: enable both edges GPIO interrupts on sh7372
Date: Fri, 15 Jul 2011 12:58:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107151256380.22613@axis700.grange>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
 <Pine.LNX.4.64.1107151254300.22613@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787Ab1GOK65 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2011 06:58:57 -0400
In-Reply-To: <Pine.LNX.4.64.1107151254300.22613@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

From: Magnus Damm <damm@opensource.se>

IRQ-capable GPIOs on sh7372 can be configured to produce interrupts on
both edges.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <damm@opensource.se>
---
 drivers/sh/intc/chip.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
index f33e2dd..33b2ed4 100644
--- a/drivers/sh/intc/chip.c
+++ b/drivers/sh/intc/chip.c
@@ -186,6 +186,9 @@ static unsigned char intc_irq_sense_table[IRQ_TYPE_SENSE_MASK + 1] = {
     !defined(CONFIG_CPU_SUBTYPE_SH7709)
 	[IRQ_TYPE_LEVEL_HIGH] = VALID(3),
 #endif
+#if defined(CONFIG_ARCH_SH7372)
+	[IRQ_TYPE_EDGE_BOTH] = VALID(4),
+#endif
 };
 
 static int intc_set_type(struct irq_data *data, unsigned int type)
-- 
1.7.2.5

