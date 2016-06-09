From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 05/12] mmc: sdhci: add a pre voltage switch callback function
Date: Thu,  9 Jun 2016 09:10:11 +0200
Message-ID: <1465456218-28354-6-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46280 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161269AbcFIHLa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 03:11:30 -0400
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

From: Victor Gu <xigu@marvell.com>

Some host controller such as Xenon needs additional setting when
switching signal voltage in eMMC mode. They also need to re-enable
internal clock before a voltage switch.

This commit adds a callback routine "voltage_switch_pre" in the struct
sdhci_ops, which is used by some host controllers which need re-enable
the internal clock before a voltage switch.

[gregory.clement@free-electrons.com: split the initial commit and
reformulate the log]

Signed-off-by: Victor Gu <xigu@marvell.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b07219426d39..cad03ffa9d9b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1729,6 +1729,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
+	/* Some controller need to do more before switching */
+	if (host->ops->voltage_switch_pre)
+		host->ops->voltage_switch_pre(host);
+
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
 	switch (ios->signal_voltage) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 49c6c5b0e33b..6bec1b0368d2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -550,6 +550,7 @@ struct sdhci_ops {
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
 	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
+	void	(*voltage_switch_pre)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.5.0

