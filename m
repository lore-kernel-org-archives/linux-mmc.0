From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/10] mmc: mmci: Handle CMD irq before DATA irq
Date: Wed, 22 Jan 2014 16:00:23 +0100
Message-ID: <1390402824-9850-10-git-send-email-ulf.hansson@linaro.org>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:53606 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaAVPAo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:00:44 -0500
Received: by mail-we0-f179.google.com with SMTP id w62so394452wes.24
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 07:00:43 -0800 (PST)
In-Reply-To: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Johan Rudholm <jrudholm@gmail.com>

In case of a read operation both MCI_CMDRESPEND and MCI_DATAEND can be
set in the status register when entering the interrupt handler. This is
due to that the card start sending data before the host has
acknowledged the command response.

To resolve the issue for this scenario, we must start by handling the
CMD irq instead of the DATA irq. The reason is beacuse the completion
of the DATA irq will not respect the current command and then causing
it to be garbled.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Johan Rudholm <jrudholm@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f320579..1a4b153 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1144,16 +1144,17 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 
 		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
 
+		cmd = host->cmd;
+		if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|
+			      MCI_CMDRESPEND) && cmd)
+			mmci_cmd_irq(host, cmd, status);
+
 		data = host->data;
 		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
 			      MCI_TXUNDERRUN|MCI_RXOVERRUN|MCI_DATAEND|
 			      MCI_DATABLOCKEND) && data)
 			mmci_data_irq(host, data, status);
 
-		cmd = host->cmd;
-		if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND) && cmd)
-			mmci_cmd_irq(host, cmd, status);
-
 		ret = 1;
 	} while (status);
 
-- 
1.7.9.5

