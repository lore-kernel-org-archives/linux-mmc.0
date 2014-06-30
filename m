From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] mmc:sdhci:handle busy-end interrupt during command
Date: Mon, 30 Jun 2014 11:15:42 -0700
Message-ID: <1404152142-12714-1-git-send-email-gwendal@chromium.org>
References: <DAE3A3C9CBA1B14593D953926111E0E10150CDA540FC@SAFEX1MAIL1.st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:42938 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaF3SPq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jun 2014 14:15:46 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so841321qcv.5
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2014 11:15:45 -0700 (PDT)
In-Reply-To: <DAE3A3C9CBA1B14593D953926111E0E10150CDA540FC@SAFEX1MAIL1.st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chanho.min@lge.com, youssef.triki@st.com, cjb@laptop.org, chris@printf.net
Cc: linux-mmc@vger.kernel.org, hankyung.yu@lge.com, shawn.guo@linaro.org, b29396@freescale.com, kliu5@marvell.com, Gwendal Grignou <gwendal@chromium.org>

From: Chanho Min <chanho.min@lge.com>

When controller supports busy-end interrupts, they may send it
before commands complete. If the host sends a new command too early,
it will result in CRC errors.

CMD  : CMD | ,,,, |   RESPONSE   |
DATA :     |    busy    |
                        .        .
                        .        . sdhci_cmd_irq (command interupt)
                        .
                        . sdhci_data_irq ("busy end" interrupt)

Before this patch, if the CPU is very fast, when sdhci_data_irq is
executed, it would complete the command and issue a new one while
CMD line is still driven by the device, resulting in a CRC error.

With this patch, we wait for both interrupts to be received before
completing the command.

Change-Id: I43b7467d59eb133d8c545115b48a5acbc450c2dd
Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---

I reformated your patch. I also fix an issue when SDHCI_QUIRK_NO_BUSY_IRQ
is enabled.

On fast chromebooks with Tohisba eMMC, check the error messages:
 mmc0: Got command interrupt 0x00000001 even though no command operation was in progress.
and
 mmc0: unexpected status 0x800800 after switch
are gone.

 drivers/mmc/host/sdhci.c  | 29 ++++++++++++++++++++++++-----
 include/linux/mmc/sdhci.h |  1 +
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 04f0314..acfb2aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1007,6 +1007,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	mod_timer(&host->timer, jiffies + 10 * HZ);
 
 	host->cmd = cmd;
+	host->busy_handle = 0;
 
 	sdhci_prepare_data(host, cmd);
 
@@ -2282,11 +2283,21 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		if (host->cmd->data)
 			DBG("Cannot wait for busy signal when also "
 				"doing a data transfer");
-		else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ))
+		else if (host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) {
+			/*
+			 * The controller does not support the end-of-busy IRQ,
+			 * fall through and take the SDHCI_INT_RESPONSE
+			 */
+		} else if (host->busy_handle == 0) {
+			/* Mark that command complete before busy is ended */
+			host->busy_handle = 1;
 			return;
-
-		/* The controller does not support the end-of-busy IRQ,
-		 * fall through and take the SDHCI_INT_RESPONSE */
+		} else {
+			/*
+			 * We already received end-of-busy IRQ,
+			 * process commnad now.
+			 */
+		}
 	}
 
 	if (intmask & SDHCI_INT_RESPONSE)
@@ -2346,7 +2357,15 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 */
 		if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
 			if (intmask & SDHCI_INT_DATA_END) {
-				sdhci_finish_command(host);
+				/*
+				 * Some cards handle busy-end interrupt
+				 * before the command completed, so make
+				 * sure we do things in the proper order.
+				 */
+				if (host->busy_handle)
+					sdhci_finish_command(host);
+				else
+					host->busy_handle = 1;
 				return;
 			}
 		}
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 796216c..7fa83aa 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -150,6 +150,7 @@ struct sdhci_host {
 	struct mmc_command *cmd;	/* Current command */
 	struct mmc_data *data;	/* Current data request */
 	unsigned int data_early:1;	/* Data finished before cmd */
+	unsigned int busy_handle:1;	/* Handling the order of Busy-end */
 
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
-- 
2.0.0.526.g5318336

