From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: [PATCH v8] mmc: Export host capabilities to debugfs.
Date: Fri, 9 Mar 2018 10:30:41 +0530
Message-ID: <1520571641-5741-1-git-send-email-harish_kandiga@mentor.com>
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

Changes in v8
- Changes to use for_each_set_bit as suggested by Andy Shevchenko.

Changes in v7
- Moved additional capabilities also to caps file as mentioned by Ulf Hansson
- compacting the code with macros

Changes in v6:
- Used DEFINE_SHOW_ATTRIBUTE

Changes in v5:
- Added parser logic in kernel by using debugfs_create_file  for caps and caps2 instead of debugfs_create_x32
- Changed Author

Changes in v4:
- Moved the creation of nodes to mmc_add_host_debugfs
- Exported caps2
- Renamed host_caps to caps

Changes in v3:
- Removed typecasting of &host->caps to (u32 *)

Changes in v2:
- Changed Author

 drivers/mmc/core/debugfs.c | 111 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c51e0c0..a16846b 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -225,6 +225,114 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");

+static int mmc_caps_show(struct seq_file *s, void *unused)
+{
+	static const char * const mmc_host_capabilities[] = {
+		"4-bit transfers allowed",/* MMC_CAP_4_BIT_DATA (1 << 0) */
+		/* MMC_CAP_MMC_HIGHSPEED (1 << 1)*/
+		"Supports MMC high-speed timing",
+		/* MMC_CAP_SD_HIGHSPEED (1 << 2)*/
+		"Supports SD high-speed timing",
+		"Can signal pending SDIO IRQs",/* MMC_CAP_SDIO_IRQ (1 << 3) */
+		"Talks only SPI protocols",/* MMC_CAP_SPI (1 << 4) */
+		/* MMC_CAP_NEEDS_POLL (1 << 5)*/
+		"Needs polling for card-detection",
+		"8 bit transfers allowed",/* MMC_CAP_8_BIT_DATA (1 << 6) */
+		"Suspends (e)MMC/SD at idle",/*MMC_CAP_AGGRESSIVE_PM (1 << 7)*/
+		"Nonremovable",/* MMC_CAP_NONREMOVABLE (1 << 8) */
+		"Waits while card is busy",/*MMC_CAP_WAIT_WHILE_BUSY (1 << 9)*/
+		"Allows erase/trim commands",/* MMC_CAP_ERASE (1 << 10) */
+		"Supports DDR mode at 3.3V",/* MMC_CAP_3_3V_DDR	(1 << 11) */
+		"Supports DDR mode at 1.8V",/* MMC_CAP_1_8V_DDR (1 << 12) */
+		"Supports DDR mode at 1.2V",/* MMC_CAP_1_2V_DDR (1 << 13) */
+		"Can power off after boot",/*MMC_CAP_POWER_OFF_CARD (1 << 14)*/
+		"CMD14/CMD19 bus width ok",/*MMC_CAP_BUS_WIDTH_TEST (1 << 15)*/
+		"Supports UHS SDR12 mode",/* MMC_CAP_UHS_SDR12 (1 << 16) */
+		"Supports UHS SDR25 mode",/* MMC_CAP_UHS_SDR25 (1 << 17) */
+		"Supports UHS SDR50 mode",/* MMC_CAP_UHS_SDR50 (1 << 18) */
+		"Supports UHS SDR104 mode",/* MMC_CAP_UHS_SDR104 (1 << 19) */
+		"Supports UHS DDR50 mode",/* MMC_CAP_UHS_DDR50 (1 << 20) */
+		"",/* (1 << 21) is free for reuse*/
+		"",/* (1 << 22) */
+		"Supports Driver Type A",/* MMC_CAP_DRIVER_TYPE_A (1 << 23) */
+		"Supports Driver Type C",/* MMC_CAP_DRIVER_TYPE_C (1 << 24) */
+		"Supports Driver Type D",/* MMC_CAP_DRIVER_TYPE_D (1 << 25) */
+		"",/* (1 << 26) */
+		/* MMC_CAP_DONE_COMPLETE (1 << 27) */
+		"RW reqs can be completed within mmc_request_done()",
+		"Supports Enable card detect wake",/*MMC_CAP_CD_WAKE (1 << 28)*/
+		/* MMC_CAP_CMD_DURING_TFR (1 << 29) */
+		"Can send commands during data transfer",
+		"CMD23 supported",/* MMC_CAP_CMD23 (1 << 30) */
+		"Supports Hardware reset"/* MMC_CAP_HW_RESET	(1 << 31) */
+	};
+
+	static const char * const mmc_host_capabilities2[] = {
+		/* MMC_CAP2_BOOTPART_NOACC (1 << 0) */
+		"No access to Boot partition",
+		"",/* (1 << 1) */
+		"Can do full power cycle",/* MMC_CAP2_FULL_PWR_CYCLE (1 << 2) */
+		"",/* (1 << 3) */
+		"",/* (1 << 4) */
+		"Supports HS200 1.8V SDR",/* MMC_CAP2_HS200_1_8V_SDR (1 << 5) */
+		"Supports HS200 1.2V SDR",/* MMC_CAP2_HS200_1_2V_SDR (1 << 6) */
+		"",/* (1 << 7) */
+		"",/* (1 << 8) */
+		"",/* (1 << 9) */
+		/* MMC_CAP2_CD_ACTIVE_HIGH (1 << 10) */
+		"Card-detect signal active high",
+		/* MMC_CAP2_RO_ACTIVE_HIGH (1 << 11) */
+		"Write-protect signal active high",
+		"",/* (1 << 12) */
+		"",/* (1 << 13) */
+		/* MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14) */
+		"Can do complete power cycle of the card",
+		"Supports HS400 1.8V",/* MMC_CAP2_HS400_1_8V	(1 << 15) */
+		"Support HS400 1.2V",/* MMC_CAP2_HS400_1_2V	(1 << 16) */
+		"SDIO IRQ - Nothread",/* MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17) */
+		/* MMC_CAP2_NO_WRITE_PROTECT (1 << 18) */
+		"No physical write protect pin, assume always read-write",
+		/* MMC_CAP2_NO_SDIO (1 << 19) */
+		"Do not send SDIO commands during initialization",
+		"Supports enhanced strobe",/* MMC_CAP2_HS400_ES (1 << 20) */
+		/* MMC_CAP2_NO_SD (1 << 21) */
+		"Do not send SD commands during initialization",
+		/* MMC_CAP2_NO_MMC (1 << 22) */
+		"Do not send (e)MMC commands during initialization",
+		"Has eMMC command queue engine",/* MMC_CAP2_CQE	 (1 << 23) */
+		"CQE can issue a direct command",/*MMC_CAP2_CQE_DCMD (1 << 24)*/
+		"",/* (1 << 25) */
+		"",/* (1 << 26) */
+		"",/* (1 << 27) */
+		"",/* (1 << 28) */
+		"",/* (1 << 29) */
+		"",/* (1 << 30) */
+		""/* (1 << 31) */
+	};
+
+	struct mmc_host *host = s->private;
+	u32 caps = host->caps;
+	u32 caps2 = host->caps2;
+	int bit;
+	int size = sizeof(u32) * BITS_PER_BYTE;
+
+	seq_puts(s, "MMC Host capabilities are:\n");
+	seq_puts(s, "=============================================\n");
+
+	for_each_set_bit(bit, (const unsigned long *)&caps, size)
+		seq_printf(s, "%s\n", mmc_host_capabilities[bit]);
+
+	seq_puts(s, "=============================================\n");
+	seq_puts(s, "MMC Host additional capabilities are:\n");
+	seq_puts(s, "=============================================\n");
+
+	for_each_set_bit(bit, (const unsigned long *)&caps2, size)
+		seq_printf(s, "%s\n", mmc_host_capabilities2[bit]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(mmc_caps);
+
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
 	struct dentry *root;
@@ -243,6 +351,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
 		goto err_node;

+	if (!debugfs_create_file("caps", S_IRUSR, root, host, &mmc_caps_fops))
+		goto err_node;
+
 	if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
 			&mmc_clock_fops))
 		goto err_node;
--
1.9.1
