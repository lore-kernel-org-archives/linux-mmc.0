From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 06/12] mmc: sdhci: add delay adjust feature including phy reset
Date: Thu,  9 Jun 2016 09:10:12 +0200
Message-ID: <1465456218-28354-7-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46281 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162054AbcFIHLa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 03:11:30 -0400
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

From: Victor Gu <xigu@marvell.com>

Tuning is only available in HS200 mode. However, some host controllers,
such as the Xenon one, need to adjust delay for other modes and even
adjust the delay before tuning.

This commit adds a callback routine "delay_adj" in the struct sdhci_ops.

[gregory.clement@free-electrons.com: split the initial commit and
reformulate the log]

Signed-off-by: Victor Gu <xigu@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cad03ffa9d9b..2acae2b3b2d3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1606,6 +1606,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->ops->delay_adj)
+		host->ops->delay_adj(host, ios);
 }
 
 static int sdhci_get_cd(struct mmc_host *mmc)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6bec1b0368d2..f88f72782a8d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -551,6 +551,7 @@ struct sdhci_ops {
 					 int card_drv, int *drv_type);
 	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
 	void	(*voltage_switch_pre)(struct sdhci_host *host);
+	int	(*delay_adj)(struct sdhci_host *host, struct mmc_ios *ios);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.5.0

