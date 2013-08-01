From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: add specified capabilities2 of the controller
Date: Fri, 02 Aug 2013 00:12:59 +0900
Message-ID: <51FA7AFB.9040703@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31717 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab3HAPNA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 11:13:00 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQU009B2Y9M0P40@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Aug 2013 00:12:58 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>

Add the capabilities2 of controller to use MMC_CAP2_*
In future, we can use the capability like packed command with caps2.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    3 +++
 drivers/mmc/host/dw_mmc.h |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ee5f167..17fe90c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1951,6 +1951,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
+	if (drv_data && drv_data->caps2)
+		mmc->caps2 |= drv_data->caps[ctrl_id];
+
 	if (host->pdata->get_bus_wd)
 		bus_width = host->pdata->get_bus_wd(slot->id);
 	else if (host->dev->of_node)
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 81b2994..1f0a9ad 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -186,6 +186,7 @@ extern int dw_mci_resume(struct dw_mci *host);
 /**
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
+ * @caps2: mmc subsystem specified capabilities2 of the controller(s).
  * @init: early implementation specific initialization.
  * @setup_clock: implementation specific clock configuration.
  * @prepare_command: handle CMD register extensions.
@@ -198,6 +199,7 @@ extern int dw_mci_resume(struct dw_mci *host);
  */
 struct dw_mci_drv_data {
 	unsigned long	*caps;
+	unsigned long	*caps2;
 	int		(*init)(struct dw_mci *host);
 	int		(*setup_clock)(struct dw_mci *host);
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
-- 
1.7.9.5
