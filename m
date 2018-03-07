From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 07/11] mmc: sdhci: Program a relatively accurate SW timeout value
Date: Wed, 7 Mar 2018 18:50:16 +0530
Message-ID: <20180307132020.30951-8-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307132020.30951-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

sdhci has a 10 second timeout to catch devices that stop responding.
Instead of programming 10 second arbitrary value, calculate the total time
it would take for the entire transfer to happen and program the timeout
value accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h | 10 ++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dd117cbeb6e..baab67bfa39b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,6 +709,36 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
+static void sdhci_calc_sw_timeout(struct sdhci_host *host,
+				  struct mmc_command *cmd,
+				  unsigned int target_timeout)
+{
+	struct mmc_data *data = cmd->data;
+	struct mmc_host *mmc = host->mmc;
+	u64 transfer_time;
+	struct mmc_ios *ios = &mmc->ios;
+	unsigned char bus_width = 1 << ios->bus_width;
+	unsigned int blksz;
+	unsigned int freq;
+
+	if (data) {
+		blksz = data->blksz;
+		freq = host->mmc->actual_clock ? : host->clock;
+		transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
+		do_div(transfer_time, freq);
+		/* multiply by '2' to account for any unknowns */
+		transfer_time = transfer_time * 2;
+		/* calculate timeout for the entire data */
+		host->data_timeout = (data->blocks * ((target_timeout *
+						       NSEC_PER_USEC) +
+						       transfer_time));
+	} else {
+		host->data_timeout = (u64)target_timeout * NSEC_PER_USEC;
+	}
+
+	host->data_timeout += MMC_CMD_TRANSFER_TIME;
+}
+
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
@@ -766,6 +796,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		if (count >= 0xF)
 			break;
 	}
+	sdhci_calc_sw_timeout(host, cmd, target_timeout);
 
 	return count;
 }
@@ -1175,13 +1206,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	timeout = jiffies;
-	if (!cmd->data && cmd->busy_timeout > 9000)
-		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
-	else
-		timeout += 10 * HZ;
-	sdhci_mod_timer(host, cmd->mrq, timeout);
-
 	host->cmd = cmd;
 	if (sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
@@ -1221,6 +1245,15 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
 
+	timeout = jiffies;
+	if (host->data_timeout > 0) {
+		timeout += nsecs_to_jiffies(host->data_timeout);
+		host->data_timeout = 0;
+	} else {
+		timeout += 10 * HZ;
+	}
+	sdhci_mod_timer(host, cmd->mrq, timeout);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ff283ee08854..29b242fd17de 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -332,6 +332,14 @@ struct sdhci_adma2_64_desc {
 /* Allow for a a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
+/*
+ * 48bit command and 136 bit response in 100KHz clock could take upto 2.48ms.
+ * However since the start time of the command, the time between
+ * command and response, and the time between response and start of data is
+ * not known, set the command transfer time to 10ms.
+ */
+#define MMC_CMD_TRANSFER_TIME	(10 * NSEC_PER_MSEC) /* max 10 ms */
+
 enum sdhci_cookie {
 	COOKIE_UNMAPPED,
 	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
@@ -555,6 +563,8 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	u64			data_timeout;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
-- 
2.11.0
