From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 02/12] mmc: sdhci_f_sdh30: restrict voltage_switch() callback to the 1.8V case
Date: Thu,  9 Jun 2016 09:10:08 +0200
Message-ID: <1465456218-28354-3-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46231 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162019AbcFIHL2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 03:11:28 -0400
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Vincent Yang <vincent.yang@tw.fujitsu.com>

Given its name the voltage_switch() should be called for any
voltage. However currently it is only called for the 1.8V case.

That means that the current implementation of the callback could have
made this assumption. It seems the case for the f_sdh3 driver. In order
to not adding a regression when the voltage_switch() function will be
called for the other voltage targets, this patch ensure that the code of
the current callback won't be executed for the other case than 1.8V.

Cc: Vincent Yang <vincent.yang@tw.fujitsu.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 983b8b32ef96..09a341cbd572 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -54,6 +54,10 @@ static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 	struct f_sdhost_priv *priv = sdhci_priv(host);
 	u32 ctrl = 0;
 
+	/* Initially this function was called only for the 1.8V case */
+	if (host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180)
+		return;
+
 	usleep_range(2500, 3000);
 	ctrl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
 	ctrl |= F_SDH30_CRES_O_DN;
-- 
2.5.0

