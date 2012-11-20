From: Jing Wang <windsdaemon@gmail.com>
Subject: [PATCH 2/2] mmc/host/s3cmci: remove the excess "goto irq_out"
Date: Tue, 20 Nov 2012 14:07:14 +0800
Message-ID: <1353391635-7691-1-git-send-email-windsdaemon@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45516 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab2KTGHg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Nov 2012 01:07:36 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4027079pbc.19
        for <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 22:07:36 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Jing Wang <windsdaemon@gmail.com>

From: Jing Wang <windsdaemon@gmail.com>

This patch delete excess "goto irq_out", because the function can run as normal without this.

Signed-off-by: Jing Wang <windsdaemon@gmail.com>
---
 drivers/mmc/host/s3cmci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 4638dda..e488e60 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -733,8 +733,6 @@ close_transfer:
 	clear_imask(host);
 	tasklet_schedule(&host->pio_tasklet);
 
-	goto irq_out;
-
 irq_out:
 	dbg(host, dbg_irq,
 	    "csta:0x%08x dsta:0x%08x fsta:0x%08x dcnt:0x%08x status:%s.\n",
-- 
1.7.9.5

