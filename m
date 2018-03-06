From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: [PATCH v5] mmc: Export host capabilities to debugfs.
Date: Tue, 6 Mar 2018 19:23:45 +0530
Message-ID: <1520344425-13131-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, avri.altman@wdc.com, andriy.shevchenko@linux.intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, harish_kandiga@mentor.com, Vladimir_Zapolskiy@mentor.com
List-Id: linux-mmc@vger.kernel.org

This patch exports the host capabilities to debugfs

This idea of sharing host capabilities over debugfs
came up from Abbas Raza <Abbas_Raza@mentor.com>
Earlier discussions:
https://lkml.org/lkml/2018/3/5/357
https://www.spinics.net/lists/linux-mmc/msg48219.html

Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---

Changes in v5:
- Added parser logic in kernel by using debugfs_create_file
 for caps and caps2 instead of debugfs_create_x32
- Changed Author

Changes in v4:
- Moved the creation of nodes to mmc_add_host_debugfs
- Exported caps2
- Renamed host_caps to caps

Changes in v3:
- Removed typecasting of &host->caps to (u32 *)

Changes in v2:
- Changed Author

 drivers/mmc/core/debugfs.c | 142 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c51e0c0..6990859 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -225,6 +225,142 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");

+static int mmc_caps_show(struct seq_file *s, void *unused)
+{
+	struct mmc_host *host = s->private;
+	u32 caps = host->caps;
+
+	seq_puts(s, "\nMMC Host capabilities are:\n");
+	seq_puts(s, "=============================================\n");
+	seq_printf(s, "Can the host do 4 bit transfers :\t%s\n",
+		   ((caps & MMC_CAP_4_BIT_DATA) ? "Yes" : "No"));
+	seq_printf(s, "Can do MMC high-speed timing :\t%s\n",
+		   ((caps & MMC_CAP_MMC_HIGHSPEED) ? "Yes" : "No"));
+	seq_printf(s, "Can do SD high-speed timing :\t%s\n",
+		   ((caps & MMC_CAP_SD_HIGHSPEED) ? "Yes" : "No"));
+	seq_printf(s, "Can signal pending SDIO IRQs :\t%s\n",
+		   ((caps & MMC_CAP_SDIO_IRQ) ? "Yes" : "No"));
+	seq_printf(s, "Talks only SPI protocols :\t%s\n",
+		   ((caps & MMC_CAP_SPI) ? "Yes" : "No"));
+	seq_printf(s, "Needs polling for card-detection :\t%s\n",
+		   ((caps & MMC_CAP_NEEDS_POLL) ? "Yes" : "No"));
+	seq_printf(s, "Can the host do 8 bit transfers :\t%s\n",
+		   ((caps & MMC_CAP_8_BIT_DATA) ? "Yes" : "No"));
+	seq_printf(s, "Suspend (e)MMC/SD at idle :\t%s\n",
+		   ((caps & MMC_CAP_AGGRESSIVE_PM) ? "Yes" : "No"));
+	seq_printf(s, "Nonremovable e.g. eMMC :\t%s\n",
+		   ((caps & MMC_CAP_NONREMOVABLE) ? "Yes" : "No"));
+	seq_printf(s, "Waits while card is busy :\t%s\n",
+		   ((caps & MMC_CAP_WAIT_WHILE_BUSY) ? "Yes" : "No"));
+	seq_printf(s, "Allow erase/trim commands :\t%s\n",
+		   ((caps & MMC_CAP_ERASE) ? "Yes" : "No"));
+	seq_printf(s, "Can support DDR mode at 3.3V :\t%s\n",
+		   ((caps & MMC_CAP_3_3V_DDR) ? "Yes" : "No"));
+	seq_printf(s, "Can support DDR mode at 1.8V :\t%s\n",
+		   ((caps & MMC_CAP_1_8V_DDR) ? "Yes" : "No"));
+	seq_printf(s, "Can support DDR mode at 1.2V :\t%s\n",
+		   ((caps & MMC_CAP_1_2V_DDR) ? "Yes" : "No"));
+	seq_printf(s, "Can power off after boot :\t%s\n",
+		   ((caps & MMC_CAP_POWER_OFF_CARD) ? "Yes" : "No"));
+	seq_printf(s, "CMD14/CMD19 bus width ok :\t%s\n",
+		   ((caps & MMC_CAP_BUS_WIDTH_TEST) ? "Yes" : "No"));
+	seq_printf(s, "Host supports UHS SDR12 mode :\t%s\n",
+		   ((caps & MMC_CAP_UHS_SDR12) ? "Yes" : "No"));
+	seq_printf(s, "Host supports UHS SDR25 mode :\t%s\n",
+		   ((caps & MMC_CAP_UHS_SDR25) ? "Yes" : "No"));
+	seq_printf(s, "Host supports UHS SDR50 mode :\t%s\n",
+		   ((caps & MMC_CAP_UHS_SDR50) ? "Yes" : "No"));
+	seq_printf(s, "Host supports UHS SDR104 mode :\t%s\n",
+		   ((caps & MMC_CAP_UHS_SDR104) ? "Yes" : "No"));
+	seq_printf(s, "Host supports UHS DDR50 mode :\t%s\n",
+		   ((caps & MMC_CAP_UHS_DDR50) ? "Yes" : "No"));
+	seq_printf(s, "Host supports Driver Type A :\t%s\n",
+		   ((caps & MMC_CAP_DRIVER_TYPE_A) ? "Yes" : "No"));
+	seq_printf(s, "Host supports Driver Type C :\t%s\n",
+		   ((caps & MMC_CAP_DRIVER_TYPE_C) ? "Yes" : "No"));
+	seq_printf(s, "Host supports Driver Type D :\t%s\n",
+		   ((caps & MMC_CAP_DRIVER_TYPE_D) ? "Yes" : "No"));
+	seq_printf(s, "RW reqs can be completed within mmc_request_done() :\t%s\n",
+		   ((caps & MMC_CAP_DONE_COMPLETE) ? "Yes" : "No"));
+	seq_printf(s, "Enable card detect wake :\t%s\n",
+		   ((caps & MMC_CAP_CD_WAKE) ? "Yes" : "No"));
+	seq_printf(s, "Commands during data transfer :\t%s\n",
+		   ((caps & MMC_CAP_CMD_DURING_TFR) ? "Yes" : "No"));
+	seq_printf(s, "CMD23 supported. :\t%s\n",
+		   ((caps & MMC_CAP_CMD23) ? "Yes" : "No"));
+	seq_printf(s, "Hardware reset :\t%s\n",
+		   ((caps & MMC_CAP_HW_RESET) ? "Yes" : "No"));
+	return 0;
+}
+
+static int mmc_caps_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mmc_caps_show, inode->i_private);
+}
+
+static const struct file_operations mmc_caps_fops = {
+	.open           = mmc_caps_debug_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static int mmc_caps2_show(struct seq_file *s, void *unused)
+{
+	struct mmc_host *host = s->private;
+	u32 caps2 = host->caps2;
+
+	seq_puts(s, "\nMMC Host additional capabilities are:\n");
+	seq_puts(s, "=============================================\n");
+	seq_printf(s, "Boot partition no access :\t%s\n",
+		   ((caps2 & MMC_CAP2_BOOTPART_NOACC) ? "Yes" : "No"));
+	seq_printf(s, "Can do full power cycle :\t%s\n",
+		   ((caps2 & MMC_CAP2_FULL_PWR_CYCLE) ? "Yes" : "No"));
+	seq_printf(s, "Can support HS200 1.8V SDR :\t%s\n",
+		   ((caps2 & MMC_CAP2_HS200_1_8V_SDR) ? "Yes" : "No"));
+	seq_printf(s, "Can support HS200 1.2V SDR :\t%s\n",
+		   ((caps2 & MMC_CAP2_HS200_1_2V_SDR) ? "Yes" : "No"));
+	seq_printf(s, "Card-detect signal active high :\t%s\n",
+		   ((caps2 & MMC_CAP2_CD_ACTIVE_HIGH) ? "Yes" : "No"));
+	seq_printf(s, "Write-protect signal active high :\t%s\n",
+		   ((caps2 & MMC_CAP2_RO_ACTIVE_HIGH) ? "Yes" : "No"));
+	seq_printf(s, "Don't power up before scan :\t%s\n",
+		   ((caps2 & MMC_CAP2_NO_PRESCAN_POWERUP) ? "Yes" : "No"));
+	seq_printf(s, "Can support HS400 1.8V :\t%s\n",
+		   ((caps2 & MMC_CAP2_HS400_1_8V) ? "Yes" : "No"));
+	seq_printf(s, "Can support HS400 1.2V :\t%s\n",
+		   ((caps2 & MMC_CAP2_HS400_1_2V) ? "Yes" : "No"));
+	seq_printf(s, "SDIO IRQ Nothread :\t%s\n",
+		   ((caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD) ? "Yes" : "No"));
+	seq_printf(s, "No physical write protect pin, assume always read-write :\t%s\n",
+		   ((caps2 & MMC_CAP2_NO_WRITE_PROTECT) ? "Yes" : "No"));
+	seq_printf(s, "Do not send SDIO commands during initialization :\t%s\n",
+		   ((caps2 & MMC_CAP2_NO_SDIO) ? "Yes" : "No"));
+	seq_printf(s, "Host supports enhanced strobe :\t%s\n",
+		   ((caps2 & MMC_CAP2_HS400_ES) ? "Yes" : "No"));
+	seq_printf(s, "Do not send SD commands during initialization :\t%s\n",
+		   ((caps2 & MMC_CAP2_NO_SD) ? "Yes" : "No"));
+	seq_printf(s, "Do not send (e)MMC commands during initialization :\t%s\n",
+		   ((caps2 & MMC_CAP2_NO_MMC) ? "Yes" : "No"));
+	seq_printf(s, "Has eMMC command queue engine :\t%s\n",
+		   ((caps2 & MMC_CAP2_CQE) ? "Yes" : "No"));
+	seq_printf(s, "CQE can issue a direct command :\t%s\n",
+		   ((caps2 & MMC_CAP2_CQE_DCMD) ? "Yes" : "No"));
+	return 0;
+}
+
+static int mmc_caps2_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mmc_caps2_show, inode->i_private);
+}
+
+static const struct file_operations mmc_caps2_fops = {
+	.open           = mmc_caps2_debug_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
 	struct dentry *root;
@@ -243,6 +379,12 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
 		goto err_node;

+	if (!debugfs_create_file("caps", S_IRUSR, root, host, &mmc_caps_fops))
+		goto err_node;
+
+	if (!debugfs_create_file("caps2", S_IRUSR, root, host, &mmc_caps2_fops))
+		goto err_node;
+
 	if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
 			&mmc_clock_fops))
 		goto err_node;
--
1.9.1
