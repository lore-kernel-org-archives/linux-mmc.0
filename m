From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 07/12] mmc: core: export the alive operation
Date: Thu,  9 Jun 2016 09:10:13 +0200
Message-ID: <1465456218-28354-8-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46287 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162055AbcFIHLa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 03:11:30 -0400
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

Depending of the type of card there is a different operation to know
if the  car is alive. However, the access to this operation are private.
This patch introduce a new function allowing to know if the card is alive
by using the appropriate operation.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/core/core.c  | 7 +++++++
 include/linux/mmc/card.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8b4dfd45433b..3dce095c5f89 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2464,6 +2464,13 @@ int mmc_hw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_hw_reset);
 
+
+int card_alive(struct mmc_card *card)
+{
+	return card->host->bus_ops->alive(card->host);
+}
+EXPORT_SYMBOL(card_alive);
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151bac50c..287a0b12d8ba 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -526,6 +526,7 @@ struct mmc_driver {
 	void (*shutdown)(struct mmc_card *);
 };
 
+extern int card_alive(struct mmc_card *);
 extern int mmc_register_driver(struct mmc_driver *);
 extern void mmc_unregister_driver(struct mmc_driver *);
 
-- 
2.5.0

