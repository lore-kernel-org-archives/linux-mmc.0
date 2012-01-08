From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V9 0/2] HS200 Mode support for device and host
Date: Sun, 08 Jan 2012 15:17:52 -0500
Message-ID: <m27h12vthr.fsf@bob.laptop.org>
References: <1325823999-21770-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1325823999-21770-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Fri, 6 Jan 2012 09:56:37 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

On Thu, Jan 05 2012, Girish K S wrote:
> Girish K S (2):
>   mmc: core: HS200 mode support for eMMC 4.5
>   mmc: host: Adds support for eMMC 4.5 HS200 mode

Thanks, pushed to mmc-next with the following corrections to 2/2:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4be50ea..64febf2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1014,8 +1014,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		flags |= SDHCI_CMD_INDEX;
 
 	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
-	    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
+	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
@@ -1710,10 +1710,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * If the Host Controller supports the HS200 mode then tuning
 	 * function has to be executed.
 	 */
-	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
-	    (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
-	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
-	    (host->flags & SDHCI_HS200_NEEDS_TUNING))
+	if ((ctrl & SDHCI_CTRL_UHS_MASK == SDHCI_CTRL_UHS_SDR104) ||
+	    ((ctrl & SDHCI_CTRL_UHS_MASK == SDHCI_CTRL_UHS_SDR50) &&
+	     host->flags & SDHCI_SDR50_NEEDS_TUNING ||
+	     host->flags & SDHCI_HS200_NEEDS_TUNING))
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	else {
 		spin_unlock(&host->lock);
@@ -2163,8 +2163,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	/* CMD19 generates _only_ Buffer Read Ready interrupt */
 	if (intmask & SDHCI_INT_DATA_AVAIL) {
 		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
-		if ((command == MMC_SEND_TUNING_BLOCK) ||
-		    (command == MMC_SEND_TUNING_BLOCK_HS200)) {
+		if (command == MMC_SEND_TUNING_BLOCK) ||
+		    command == MMC_SEND_TUNING_BLOCK_HS200) {
 			host->tuning_done = 1;
 			wake_up(&host->buf_ready_int);
 			return;
@@ -2765,11 +2765,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_SUPPORT_DDR50)
 		mmc->caps |= MMC_CAP_UHS_DDR50;
 
-	/* Does the host needs tuning for SDR50? */
+	/* Does the host need tuning for SDR50? */
 	if (caps[1] & SDHCI_USE_SDR50_TUNING)
 		host->flags |= SDHCI_SDR50_NEEDS_TUNING;
 
-	/* Does the host needs tuning for HS200? */
+	/* Does the host need tuning for HS200? */
 	if (mmc->caps2 & MMC_CAP2_HS200)
 		host->flags |= SDHCI_HS200_NEEDS_TUNING;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 46fd2ac..ad265b9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -158,7 +158,7 @@
 #define   SDHCI_CTRL_UHS_SDR50		0x0002
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
-#define   SDHCI_CTRL_HS_SDR200		0x0005 /*reserved value in SDIO spec */
+#define   SDHCI_CTRL_HS_SDR200		0x0005 /* reserved value in SDIO spec */
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
