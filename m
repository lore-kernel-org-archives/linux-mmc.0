From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 10/16] mmc: sdhci: Fix to use data_timer only for data line commands
Date: Mon, 5 Feb 2018 18:20:23 +0530
Message-ID: <20180205125029.21570-11-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:11515 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeBEMvp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Feb 2018 07:51:45 -0500
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
command and data requests") while separating timer timeout for
command and data requests, passed cmd->mrq to sdhci_mod_timer (cmd is an
argument to sdhci_send_command) and in sdhci_mod_timer used mrq->cmd
to check if it is a data line command. This results in using
data timer for commands like MMC_SET_BLOCK_COUNT (CMD23) though it is
not a data line command. Fix it here.

Fixes: commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
command and data requests")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1aa74b4682f3..0489572d1892 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1073,10 +1073,10 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	}
 }
 
-static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
+static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_command *cmd,
 			    unsigned long timeout)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (sdhci_data_line_cmd(cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
@@ -1135,7 +1135,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
 	else
 		timeout += 10 * HZ;
-	sdhci_mod_timer(host, cmd->mrq, timeout);
+	sdhci_mod_timer(host, cmd, timeout);
 
 	host->cmd = cmd;
 	if (sdhci_data_line_cmd(cmd)) {
-- 
2.11.0

