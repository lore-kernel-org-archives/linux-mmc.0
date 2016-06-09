From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 04/12] mmc: sdhci: call voltage_switch callback also for the 3.3V case
Date: Thu,  9 Jun 2016 09:10:10 +0200
Message-ID: <1465456218-28354-5-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46254 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162039AbcFIHL3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 03:11:29 -0400
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

From: Victor Gu <xigu@marvell.com>

Currently the voltage switch callback function is only called in the 1.8V
case. However, given the name this callback should be called in the 3.3V
case too. It is needed for the Xenon controller.

[gregory.clement@free-electrons.com: split the initial commit and
modify the log]

Signed-off-by: Victor Gu <xigu@marvell.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fd4e9a84f739..b07219426d39 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1749,6 +1749,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		/* Wait for 5ms */
 		usleep_range(5000, 5500);
 
+		/* Some controller need to do more when switching */
+		if (host->ops->voltage_switch)
+			host->ops->voltage_switch(host);
+
 		/* 3.3V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl & SDHCI_CTRL_VDD_180))
-- 
2.5.0

