From: arieslee <arieslee@jmicron.com>
Subject: [PATCH 1/1] Add support for JMicron chip with UHS-I function
Date: Mon,  8 Aug 2011 22:18:01 +0800
Message-ID: <1312813081-3212-1-git-send-email-arieslee@jmicron.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from spamfilter.jmicron.com ([220.130.51.235]:37404 "EHLO
	jmsspam.jmicron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752250Ab1HHGbG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2011 02:31:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aries Lee <arieslee@jmicron.com>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Andrei Warkentin <andreiw@motorola.com>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Ohad Ben-Cohen <ohad@wizery.com>, Philip Rakity <prakity@marvell.com>

1. Force to assign some property at sdhci_add_host() function.

2. Jmicron doesn't support CMD19, install of tuning command, Jmicron run a
procedure to tune the clock delay, command delay and data delay. Actually I
want to define a quirks such like "SDHCI_QUIRK_NONSTANDARD_TUNE", but it run
out the quirks defination. so I share SDHCI_QUIRK_UNSTABLE_RO_DETECT
temporarily, looking for anyone provide any suggestion :-)

The tuning procddure is very simple -- try to get card status and read data
under totally 32 different clock delay setting, and record the result those
operations, then choose a proper delay setting from this result.

3. Jmicron using an nonstandard clock setting. this patch implement a
function to set host clock by this nonstandard way.

4. The tuning procedure is put in host/sdhci.c temporarily, I am not sure it
is a proper location or not, any suggestion?

Signed-off-by: arieslee <arieslee@jmicron.com>
---
 drivers/mmc/core/bus.c       |    2 +
 drivers/mmc/core/core.c      |   95 ++++++++++++-
 drivers/mmc/core/core.h      |    2 +-
 drivers/mmc/core/mmc_ops.c   |   14 ++
 drivers/mmc/core/mmc_ops.h   |    1 +
 drivers/mmc/core/sd.c        |   17 ++-
 drivers/mmc/host/sdhci-pci.c |  301 +++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.c     |  337 +++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h     |   48 ++++++
 include/linux/mmc/host.h     |    7 +-
 10 files changed, 779 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 393d817..258e75e 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -333,6 +333,8 @@ void mmc_remove_card(struct mmc_card *card)
 #endif
 
 	if (mmc_card_present(card)) {
+		if (mmc_card_sd(card) && (card->host->ops->set_default_delay))
+			card->host->ops->set_default_delay(card->host);
 		if (mmc_host_is_spi(card->host)) {
 			printk(KERN_INFO "%s: SPI card removed\n",
 				mmc_hostname(card->host));
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f091b43..01d1259 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -23,7 +23,7 @@
 #include <linux/log2.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
-
+#include <linux/slab.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -1918,6 +1918,94 @@ int mmc_card_can_sleep(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_card_can_sleep);
 
+int mmc_stop_status_cmd(struct mmc_host *host, u32 opcode, u32 *buf)
+{
+	int ret;
+
+	mmc_claim_host(host);
+	if (opcode == MMC_SEND_STATUS)
+		ret = mmc_send_status(host->card, buf);
+	else
+		ret = mmc_send_stop(host);
+	mmc_release_host(host);
+	return ret;
+}
+EXPORT_SYMBOL(mmc_stop_status_cmd);
+
+#define OFFSET_DATA_ERROR					-1000
+#define OFFSET_CMD_ERROR					-2000
+int mmc_read_data(struct mmc_host *host, u8 *buffer)
+{
+	struct mmc_request mrq;
+	struct mmc_command cmd, stop;
+	struct mmc_data data;
+	struct scatterlist sg;
+	int	ret, count_loop = 0;
+	u32	response;
+	u8	*sg_buffer;
+
+	sg_buffer = kzalloc(TEST_BUFFER_SIZE, GFP_KERNEL);
+	if (!sg_buffer)
+		return -ENOMEM;
+
+	mmc_claim_host(host);
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = 512;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	ret = mmc_wait_for_cmd(host, &cmd, 1);
+
+	if (ret)
+		goto exit_readdata;
+	sg_init_one(&sg, sg_buffer, TEST_BUFFER_SIZE);
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	memset(&data, 0, sizeof(struct mmc_data));
+	memset(&stop, 0, sizeof(struct mmc_command));
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	mrq.stop = &stop;
+
+	cmd.opcode = MMC_READ_MULTIPLE_BLOCK;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	stop.opcode = MMC_STOP_TRANSMISSION;
+	stop.arg = 0;
+	stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	data.blksz = 512;
+	data.blocks = TEST_BUFFER_SIZE / 512;
+	data.flags = MMC_DATA_READ;
+	data.sg = &sg;
+	data.sg_len = 1;
+	cmd.data = &data;
+
+	mmc_set_data_timeout(mrq.data, host->card);
+	mmc_wait_for_req(host, &mrq);
+	do {
+		mmc_stop_status_cmd(host, MMC_SEND_STATUS, &response);
+		mdelay(5);
+	} while ((!(response & R1_READY_FOR_DATA)) && (++count_loop < 10));
+	if (!(count_loop < 10)) {
+		ret = -ETIME;
+		goto exit_readdata;
+	}
+	if (cmd.error)
+		ret = OFFSET_CMD_ERROR + cmd.error;
+	if (cmd.data->error)
+		ret = OFFSET_DATA_ERROR + cmd.data->error;
+	if (cmd.data->bytes_xfered != (cmd.data->blocks * cmd.data->blksz))
+		ret = -EIO;
+	if (ret == -EINVAL)
+		goto exit_readdata;
+
+	sg_copy_to_buffer(&sg, 1, buffer, TEST_BUFFER_SIZE);
+exit_readdata:
+	kfree(sg_buffer);
+	mmc_release_host(host);
+	return ret;
+}
+EXPORT_SYMBOL(mmc_read_data);
 #ifdef CONFIG_PM
 
 /**
@@ -2003,6 +2091,11 @@ int mmc_resume_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_resume_host);
 
+void mmc_reinit_card(struct mmc_host *host)
+{
+	mmc_sd_resume(host);
+}
+EXPORT_SYMBOL(mmc_reinit_card);
 /* Do the card removal on suspend if card is assumed removeable
  * Do that in pm notifier while userspace isn't yet frozen, so we will be able
    to sync the card.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index d9411ed..0e289b1 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -61,7 +61,7 @@ void mmc_stop_host(struct mmc_host *host);
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
-
+int mmc_sd_resume(struct mmc_host *host);
 /* Module parameters */
 extern int use_spi_crc;
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 845ce7c..af0690b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -450,6 +450,20 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 	return 0;
 }
 
+int mmc_send_stop(struct mmc_host *host)
+{
+	int err;
+	struct mmc_command cmd = {0};
+
+	BUG_ON(!host);
+
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	return err;
+}
+
 static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 9276946..fa8fbb1 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -21,6 +21,7 @@ int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 int mmc_send_status(struct mmc_card *card, u32 *status);
+int mmc_send_stop(struct mmc_host *host);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 633975f..7e4f741 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -17,6 +17,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
+#include <linux/mmc/sdhci.h>
 
 #include "core.h"
 #include "bus.h"
@@ -473,6 +474,7 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 {
 	unsigned int bus_speed = 0, timing = 0;
 	int err;
+	struct sdhci_host *sdhost = NULL;
 
 	/*
 	 * If the host doesn't support any of the UHS-I modes, fallback on
@@ -523,6 +525,10 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 			mmc_hostname(card->host));
 	else {
 		mmc_set_timing(card->host, timing);
+		sdhost = mmc_priv(card->host);
+		if (sdhost != NULL)
+			if (sdhost->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT)
+				return 0;
 		mmc_set_clock(card->host, card->sw_caps.uhs_max_dtr);
 	}
 
@@ -1045,7 +1051,7 @@ static int mmc_sd_suspend(struct mmc_host *host)
  * This function tries to determine if the same card is still present
  * and, if so, restore all state to it.
  */
-static int mmc_sd_resume(struct mmc_host *host)
+int mmc_sd_resume(struct mmc_host *host)
 {
 	int err;
 
@@ -1174,6 +1180,15 @@ int mmc_attach_sd(struct mmc_host *host)
 		goto err;
 
 	mmc_release_host(host);
+	if (host->ops->tune_delay) {
+		if (host->card->state & MMC_STATE_ULTRAHIGHSPEED)
+			host->ops->tune_delay(host, min(host->f_max,
+				host->card->sw_caps.uhs_max_dtr));
+		else
+			host->ops->tune_delay(host, host->ios.clock);
+	}
+
+
 	err = mmc_add_card(host->card);
 	mmc_claim_host(host);
 	if (err)
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 26c5286..9bc41b4 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -36,40 +36,6 @@
 #define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
 #define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
 
-#define MAX_SLOTS			8
-
-struct sdhci_pci_chip;
-struct sdhci_pci_slot;
-
-struct sdhci_pci_fixes {
-	unsigned int		quirks;
-
-	int			(*probe) (struct sdhci_pci_chip *);
-
-	int			(*probe_slot) (struct sdhci_pci_slot *);
-	void			(*remove_slot) (struct sdhci_pci_slot *, int);
-
-	int			(*suspend) (struct sdhci_pci_chip *,
-					pm_message_t);
-	int			(*resume) (struct sdhci_pci_chip *);
-};
-
-struct sdhci_pci_slot {
-	struct sdhci_pci_chip	*chip;
-	struct sdhci_host	*host;
-
-	int			pci_bar;
-};
-
-struct sdhci_pci_chip {
-	struct pci_dev		*pdev;
-
-	unsigned int		quirks;
-	const struct sdhci_pci_fixes *fixes;
-
-	int			num_slots;	/* Slots on controller */
-	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
-};
 
 
 /*****************************************************************************\
@@ -260,6 +226,262 @@ static int o2_probe(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
+
+#define JM_DEFAULT_IC_DRIVING_380B			0x03053333
+#define JM_MAX_IC_DRIVING_380B				0x07077777
+#define JM_IC_DRIVING_B8_MASK_380B			0x00700000
+#define JM_IC_DRIVING_E4_MASK_380B			0x7FFF0000
+
+#define JMCR_PCICNFG_PAGESEL_OFFSET			0xBF
+#define JMCR_CFGPAGE_MASK				0xE0
+#define JMCR_CFGPAGE_SHIFT				5
+#define JMCR_CFGPAGE_CHIPID				0x01
+#define JMCR_CFGPAGE_ASPM				0x03
+#define JMCR_CFGPAGE_SCRATCH				0x05
+#define JMCR_CFGPAGE_PAD_DELAY_CTRL			0x06
+#define JMCR_CFGPAGE_PAD_DELAY_CTRL2			0x07
+
+#define JMCR_PCICNFG_PAGE_DATA0_OFFSET			0xE8
+#define JMCR_PCICNFG_PAGE_DATA1_OFFSET			0xEC
+#define JMCR_PCICNFG_PAGE_DATA2_OFFSET			0xE4
+#define PCICNFG_REG_TIMING_DELAY			0xB0
+#define TIMING_DELAY_BIT_MASK_SLOTA			0x0f00
+#define TIMING_DELAY_SLOTA_SHIFT			8
+#define JMCR_TIMING_DELAY_COUNT				8
+#define JMCR_EXTEND_DELAY_COUNT				6
+
+void jmicron_set_clock_delay(struct sdhci_pci_chip *chip, const u16 i)
+{
+	u8 page;
+	u16 delay, cfg_b0;
+	u32 cfg_ec;
+	struct pci_dev *pdev = chip->pdev;
+
+	delay = (i & 0x1F);
+	pci_read_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, &page);
+	page &= ~JMCR_CFGPAGE_MASK;
+	page |= (JMCR_CFGPAGE_PAD_DELAY_CTRL2 << JMCR_CFGPAGE_SHIFT);
+	pci_write_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, page);
+
+	/* ClkDelay[4] = reg_ec_p7[0]		*/
+	pci_read_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA1_OFFSET, &cfg_ec);
+	if (delay & 0x10)
+		cfg_ec |= 0x01;
+	else
+		cfg_ec &= ~(0x01);
+	pci_write_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA1_OFFSET, cfg_ec);
+
+	pci_read_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, &page);
+	page &= ~JMCR_CFGPAGE_MASK;
+	pci_write_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, page);
+
+	pci_read_config_word(pdev, PCICNFG_REG_TIMING_DELAY, &cfg_b0);
+	delay &= 0x0F;
+	delay <<= TIMING_DELAY_SLOTA_SHIFT;
+	cfg_b0 &= ~(TIMING_DELAY_BIT_MASK_SLOTA);
+	cfg_b0 |= delay;
+	pci_write_config_word(pdev, PCICNFG_REG_TIMING_DELAY, cfg_b0);
+	return;
+}
+
+void jmicron_set_cmddata_delay(struct sdhci_pci_chip *chip, const u16 i)
+{
+	u8 page;
+	u16 delay;
+	u32 cfg_ec, cfg_e8;
+	struct pci_dev *pdev = chip->pdev;
+
+	delay = i & 0x1F;
+
+	pci_read_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, &page);
+	page &= ~JMCR_CFGPAGE_MASK;
+	page |= (JMCR_CFGPAGE_PAD_DELAY_CTRL << JMCR_CFGPAGE_SHIFT);
+	pci_write_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, page);
+
+	pci_read_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA0_OFFSET, &cfg_e8);
+	cfg_e8 &= ~0x1F1F1F1F;
+	cfg_e8 |= delay;
+	cfg_e8 |= delay << 8;
+	cfg_e8 |= delay << 16;
+	cfg_e8 |= delay << 24;
+	pci_write_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA0_OFFSET, cfg_e8);
+
+	page &= ~JMCR_CFGPAGE_MASK;
+	page |= (JMCR_CFGPAGE_PAD_DELAY_CTRL2 << JMCR_CFGPAGE_SHIFT);
+	pci_write_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, page);
+
+	pci_read_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA0_OFFSET, &cfg_e8);
+	cfg_e8 &= ~0x1F1F1F1F;
+	cfg_e8 |= delay;
+	cfg_e8 |= delay << 8;
+	cfg_e8 |= delay << 16;
+	cfg_e8 |= delay << 24;
+	pci_write_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA0_OFFSET, cfg_e8);
+
+
+	page &= ~JMCR_CFGPAGE_MASK;
+	page |= (JMCR_CFGPAGE_PAD_DELAY_CTRL << JMCR_CFGPAGE_SHIFT);
+	pci_write_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, page);
+
+	/* CmdDelay[3:0] = reg_ec_p6[3:0]	*/
+	pci_read_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA1_OFFSET, &cfg_ec);
+	cfg_ec &= ~0x0000000F;
+	cfg_ec |= i & 0x0F;
+	pci_write_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA1_OFFSET, cfg_ec);
+
+	page &= ~JMCR_CFGPAGE_MASK;
+	page |= (JMCR_CFGPAGE_PAD_DELAY_CTRL2 << JMCR_CFGPAGE_SHIFT);
+	pci_write_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, page);
+
+	/* CmdDelay[4] = reg_ec_p7[1]		*/
+	pci_read_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA1_OFFSET, &cfg_ec);
+	if (i & 0x10)
+		cfg_ec |= 0x02;
+	else
+		cfg_ec &= ~(0x02);
+	pci_write_config_dword(pdev, JMCR_PCICNFG_PAGE_DATA1_OFFSET, cfg_ec);
+
+	pci_read_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, &page);
+	page &= ~JMCR_CFGPAGE_MASK;
+	pci_write_config_byte(pdev, JMCR_PCICNFG_PAGESEL_OFFSET, page);
+
+	return;
+}
+
+void jmicron_set_ic_driving(struct sdhci_pci_chip *chip, const u32 driving)
+{
+	u32 val, tmp;
+	struct pci_dev *pdev = chip->pdev;
+
+	if (pdev == NULL) {
+		printk(KERN_ERR "pdev == NULL\n");
+		return;
+	}
+	pci_read_config_dword(pdev, 0xE4, &val);
+	val &= ~JM_IC_DRIVING_E4_MASK_380B;
+	tmp  = ((driving >> 24) & 0x07) << 28; /* CMD/BS*/
+	val |= tmp;
+	tmp  = ((driving >> 12) & 0x07) << 16; /* Data[0]*/
+	val |= tmp;
+	tmp  = ((driving >>  8) & 0x07) << 19; /* Data[1]*/
+	val |= tmp;
+	tmp  = ((driving >>  4) & 0x07) << 22; /* Data[2]*/
+	val |= tmp;
+	tmp  = (driving & 0x07) << 25;         /* Data[3]*/
+	val |= tmp;
+	dev_dbg(&pdev->dev, "%s - Set E4h to 0x%08x\n", __func__, val);
+	pci_write_config_dword(pdev, 0xE4, val);
+
+	pci_read_config_dword(pdev, 0xB8, &val);
+	val &= ~JM_IC_DRIVING_B8_MASK_380B;
+	tmp  = ((driving >> 16) & 0x07) << 20;
+	val |= tmp;
+	dev_dbg(&pdev->dev, "%s - Set B8h to 0x%08x\n", __func__, val);
+	pci_write_config_dword(pdev, 0xB8, val);
+}
+/* JMicron Clock Mux Control Register  D4h
+	D[31:4] Reserved
+	D[3]    Force MMIO Control.  0: Control by PCI CNFG, 1: Control by MMIO.
+	D[2:0]  Clock MUX Select
+*/
+#define SDHCI_CLOCK_MUX_CONTROL		0xD4
+#define SDHCI_EXTERN_OE			0xE4
+#define  SDHCI_CLKMUX_CONTROL_BY_MMIO	0x00000008
+#define  SDHCI_CLKMUX_CLK_40MHZ		0x00000001
+#define  SDHCI_CLKMUX_CLK_50MHZ		0x00000002
+#define  SDHCI_CLKMUX_CLK_62_5MHZ	0x00000004
+#define  SDHCI_CLKMUX_CLK_OFF		0x00000000
+#define  SDHCI_CLKMUX_CLK_MASK		0x00000007
+/* For Host which supports SD 3.0	*/
+#define  SDHCI_CLKMUX_CLK_83MHZ		0x00000010
+#define  SDHCI_CLKMUX_CLK_100MHZ	0x00000020
+#define  SDHCI_CLKMUX_CLK_125MHZ	0x00000040
+#define  SDHCI_CLKMUX_CLK_156MHZ	0x00000080
+#define  SDHCI_CLKMUX_CLK_178MHZ	0x00000100
+#define  SDHCI_CLKMUX_CLK_208MHZ	0x00000200
+#define  SDHCI_CLKMUX_CLK_MASK2		0x000003F7
+void jmicron_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk, wTmp;
+	u32 muxclk, div;
+	u32 reg_extern_oe = 0;
+	unsigned long timeout;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (clock == 0)
+		goto out;
+
+	reg_extern_oe = sdhci_readl(host ,  SDHCI_EXTERN_OE);
+	if (clock >= CLK_100MHZ) {
+		jmicron_set_ic_driving(slot->chip, JM_MAX_IC_DRIVING_380B);
+		reg_extern_oe |= 1<<23;
+		reg_extern_oe |= 1<<22;
+	} else {
+		jmicron_set_ic_driving(slot->chip, JM_DEFAULT_IC_DRIVING_380B);
+		reg_extern_oe &= ~(1<<23);
+		reg_extern_oe &= ~(1<<22);
+	}
+	sdhci_writel(host , reg_extern_oe , SDHCI_EXTERN_OE);
+
+	/* Disable Clock First for safe		*/
+	sdhci_writew(host, SDHCI_CLKMUX_CONTROL_BY_MMIO,
+		SDHCI_CLOCK_MUX_CONTROL);
+	div = 0;
+	switch (clock) {
+	case 208000000:
+		wTmp = SDHCI_CLKMUX_CONTROL_BY_MMIO | SDHCI_CLKMUX_CLK_208MHZ;
+		break;
+	case  178000000:
+		wTmp = SDHCI_CLKMUX_CONTROL_BY_MMIO | SDHCI_CLKMUX_CLK_178MHZ;
+		break;
+	case 156000000:
+		wTmp = SDHCI_CLKMUX_CONTROL_BY_MMIO | SDHCI_CLKMUX_CLK_156MHZ;
+		break;
+	case  125000000:
+		wTmp = SDHCI_CLKMUX_CONTROL_BY_MMIO | SDHCI_CLKMUX_CLK_125MHZ;
+		break;
+	case  100000000:
+		wTmp = SDHCI_CLKMUX_CONTROL_BY_MMIO | SDHCI_CLKMUX_CLK_100MHZ;
+		break;
+	case  83000000:
+		wTmp = SDHCI_CLKMUX_CONTROL_BY_MMIO | SDHCI_CLKMUX_CLK_83MHZ;
+		break;
+	default:
+		wTmp = SDHCI_CLKMUX_CONTROL_BY_MMIO | SDHCI_CLKMUX_CLK_50MHZ;
+		muxclk = 50000000;
+	}
+
+	for (div = 1; div < 256; div *= 2) {
+		if ((muxclk / div) <= clock)
+			break;
+	}
+	div >>= 1;
+
+	sdhci_writew(host, wTmp, SDHCI_CLOCK_MUX_CONTROL);
+
+	clk = div << SDHCI_DIVIDER_SHIFT;
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
+		SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			printk(KERN_ERR "%s: Internal clock never "
+				"stabilised.\n", mmc_hostname(host->mmc));
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+out:
+	host->clock = clock;
+}
+
 static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 {
 	u8 scratch;
@@ -285,6 +507,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 	return 0;
 }
 
+static struct sdhci_ops sdhci_pci_ops;
 static int jmicron_probe(struct sdhci_pci_chip *chip)
 {
 	int ret;
@@ -347,9 +570,13 @@ static int jmicron_probe(struct sdhci_pci_chip *chip)
 
 	/* quirk for unsable RO-detection on JM388 chips */
 	if (chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_SD ||
-	    chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_ESD)
-		chip->quirks |= SDHCI_QUIRK_UNSTABLE_RO_DETECT;
+	    chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_ESD){
+		chip->quirks |= SDHCI_QUIRK_UNSTABLE_RO_DETECT | \
+			SDHCI_QUIRK_NONSTANDARD_CLOCK | \
+			SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+		sdhci_pci_ops.set_clock = jmicron_set_clock;
+	}
 	return 0;
 }
 
@@ -461,6 +688,8 @@ static const struct sdhci_pci_fixes sdhci_jmicron = {
 
 	.suspend	= jmicron_suspend,
 	.resume		= jmicron_resume,
+	.set_clock_delay	= jmicron_set_clock_delay,
+	.set_cmddata_delay	= jmicron_set_cmddata_delay,
 };
 
 /* SysKonnect CardBus2SDIO extra registers */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..f754f17 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1595,6 +1595,314 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		return 0;
 }
 
+void total_reset_host(struct sdhci_host *host)
+{
+	u32  clock;
+
+	DBG("Enter total_reset_host()\n");
+	clock = host->mmc->ios.clock;
+	/*	mmc_power_off()		*/
+	host->mmc->ios.clock = 0;
+	host->mmc->ios.vdd = 0;
+	host->mmc->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	host->mmc->ios.chip_select = MMC_CS_DONTCARE;
+	host->mmc->ios.power_mode = MMC_POWER_OFF;
+	host->mmc->ios.bus_width = MMC_BUS_WIDTH_1;
+	host->mmc->ios.timing = MMC_TIMING_LEGACY;
+	sdhci_set_ios(host->mmc, &host->mmc->ios);
+	mdelay(10);
+	/*	mmc_power_up()		*/
+	if (host->mmc->ocr)
+		host->mmc->ios.vdd = ffs(host->mmc->ocr) - 1;
+	else
+		host->mmc->ios.vdd = fls(host->mmc->ocr_avail) - 1;
+	host->mmc->ios.power_mode = MMC_POWER_UP;
+	sdhci_set_ios(host->mmc, &host->mmc->ios);
+	mdelay(10);
+	host->mmc->ios.clock = host->mmc->f_init;
+	host->mmc->ios.power_mode = MMC_POWER_ON;
+	sdhci_set_ios(host->mmc, &host->mmc->ios);
+	mdelay(10);
+
+	sdhci_reinit(host);
+	sdhci_writeb(host, SDHCI_POWER_330|SDHCI_POWER_ON,
+		SDHCI_POWER_CONTROL);
+	msleep(600);
+	mmc_reinit_card(host->mmc);
+	mdelay(10);
+	host->mmc->ios.clock = clock;
+	sdhci_set_clock(host, clock);
+
+	return ;
+}
+
+/*	test if the HW work in this delay setting	*/
+int delay_testing(struct sdhci_host *host, u8 *buffer, u8 *sec_buffer)
+{
+	int ret;
+	u16 card_status;
+	u32 response;
+	struct sdhci_pci_slot *slot = NULL;
+
+	slot = sdhci_priv(host);
+	sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
+
+	/*	test by CMD 13	*/
+	ret = mmc_stop_status_cmd(host->mmc, MMC_SEND_STATUS, &response);
+	card_status = R1_CURRENT_STATE(response);
+	if (!ret) {
+		mmc_stop_status_cmd(host->mmc, MMC_STOP_TRANSMISSION, NULL);
+		mmc_stop_status_cmd(host->mmc, MMC_SEND_STATUS, &response);
+		if ((card_status == 5) || (card_status == 6)) {
+			DBG("Totally Reset Host!\n");
+			total_reset_host(host);
+			return -EIO;
+		}
+	} else
+		return -EIO;
+	/*	test by CMD18	*/
+	ret = mmc_read_data(host->mmc, buffer);
+	if (!ret) {
+		/* Read Twice for Safe	*/
+		ret = mmc_read_data(host->mmc, sec_buffer);
+		if (!ret && memcmp(sec_buffer, buffer, TEST_BUFFER_SIZE))
+			return -ENODATA;
+	}
+	return ret;
+}
+
+/* Find Largest Range of Successful Timing Delay Setting	*/
+void find_largest_range(u32 test_result, u8 *max_cont_start,
+	 u8 *max_cont_count)
+{
+	int i;
+	u8 cont_start = 0, cont_count = 0;
+	u8 lock_range = false;
+	u32 test_bit;
+
+	if (test_result == 0)
+		*max_cont_count = 0;
+	else if (test_result == 0xFFFFFFFF)
+		*max_cont_count = 31;
+	else {
+		for (i = 0, test_bit = 1 ; i < 32 ; i++, test_bit <<= 1) {
+			if (test_result & test_bit) {
+				if (!lock_range) {
+					cont_start = i;
+					cont_count = 1;
+					lock_range = true;
+				} else {
+					cont_count++;
+					if (cont_count > *max_cont_count) {
+						*max_cont_start = cont_start;
+						*max_cont_count = cont_count;
+					}
+				}
+			} else
+				lock_range = false;
+		}
+	}
+	return;
+}
+
+u8 calculate_cmd_delay(u32 test_result_cmd, u8 clk_delay, u8 *max_cont_start,
+	u8 *max_cont_count)
+{
+	int i;
+	u8 cmd_delay = 0;
+	u8 cont_start = 0;
+	u32 test_bit;
+
+	if (test_result_cmd == 0)
+		*max_cont_count = 0;
+	else if (test_result_cmd == 0xFFFFFFFF)
+		*max_cont_count = 31;
+	else {
+		if (*max_cont_start > 0) {
+			cont_start = *max_cont_start - 1;
+			test_bit = 1 << cont_start;
+			for (i = cont_start; i > 0; i--, test_bit >>= 1) {
+				if ((test_result_cmd & test_bit) == 0)
+					break;
+			}
+			test_bit = 1 << i;
+			if ((test_result_cmd & test_bit) == 0)
+				i++;
+			cont_start = i;
+		} else
+			cont_start = 0;
+		i = *max_cont_start + *max_cont_count;
+		test_bit = 1 << i;
+		for ( ; i < 32 ; i++, test_bit <<= 1) {
+			if ((test_result_cmd & test_bit) == 0)
+				break;
+		}
+		*max_cont_start = cont_start;
+		*max_cont_count = i - *max_cont_start;
+	}
+
+	if (*max_cont_count == 0) {
+		DBG("Cannot Find Succeed Cmd Delay Setting!?\n");
+		cmd_delay = 0;
+	} else {
+		cmd_delay = *max_cont_start + ((*max_cont_count-1) / 2);
+		if (cmd_delay > clk_delay)
+			cmd_delay -= clk_delay;
+		else
+			cmd_delay = 0;
+		DBG("Modified Cmd Delay = %02xh.\n", cmd_delay);
+	}
+
+	return cmd_delay;
+}
+
+int test_tuning_result(struct mmc_host *mmc, u8 *buffer)
+{
+	int ret;
+	u32 response;
+
+	ret = mmc_stop_status_cmd(mmc, MMC_SEND_STATUS, &response);
+	if (ret)
+		return ret;
+	ret = mmc_read_data(mmc, buffer);
+	return ret;
+}
+
+#define OFFSET_DATA_ERROR				-1000
+#define OFFSET_CMD_ERROR				-2000
+int tuning_in_clock(struct sdhci_host *host, const u32 clock)
+{
+	u8 max_cont_start, max_cont_count;
+	u8 clk_delay = (u8)-1 , cmd_delay = (u8)-1, i;
+	u32 test_result, test_bit, test_result_cmd;
+	u8 *sec_buffer, *buffer;
+	u32 ret = 0;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+
+	sec_buffer = kzalloc(TEST_BUFFER_SIZE, GFP_KERNEL);
+	buffer = kzalloc(TEST_BUFFER_SIZE, GFP_KERNEL);
+	host->mmc->ios.clock = clock;
+	sdhci_set_clock(host, clock);
+	if (clock == CLK_25MHZ)
+		goto err_exit;
+
+	test_result = 0;
+	test_bit = 1;
+	test_result_cmd = 0;
+	/*	testing the delay from 0x00 to 0x1F and save the result	*/
+	slot->chip->fixes->set_cmddata_delay(slot->chip, 0);
+	for (i = 0 ; i < 0x20 ; i++, test_bit <<= 1) {
+		memset(buffer, 0, TEST_BUFFER_SIZE);
+		memset(sec_buffer, 0xFF, TEST_BUFFER_SIZE);
+		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+			SDHCI_CARD_PRESENT)){
+			DBG("Found Card Removed during tuning!\n");
+			test_result = 0;
+			ret = -ENODEV;
+			goto err_exit;
+		}
+
+		slot->chip->fixes->set_clock_delay(slot->chip, i);
+		ret = delay_testing(host, buffer, sec_buffer);
+		if (!ret) {
+			test_result |= test_bit;
+			test_result_cmd |= test_bit;
+		} else if ((ret > OFFSET_CMD_ERROR) &&
+			(ret < OFFSET_DATA_ERROR)) {
+			test_result_cmd |= test_bit;
+		} else if (ret == -ENODATA) {
+			total_reset_host(host);
+			ret = -ENODATA;
+			goto err_exit;
+		}
+	}
+
+	DBG("Clock Test Result: 0x%08x,  Cmd Test Result: 0x%08x\n",
+		test_result, test_result_cmd);
+	max_cont_start = 0;
+	max_cont_count = 0;
+	find_largest_range(test_result, &max_cont_start, &max_cont_count);
+	if (max_cont_count == 0) {
+		DBG("Cannot Find Succeed Clock Delay Setting!?\n");
+		ret = -ERANGE;
+		goto err_exit;
+	}
+	total_reset_host(host);
+	clk_delay = max_cont_start + ((max_cont_count-1) / 2);
+	slot->chip->fixes->set_clock_delay(slot->chip, clk_delay);
+	cmd_delay = calculate_cmd_delay(test_result_cmd, clk_delay,
+		&max_cont_start, &max_cont_count);
+	slot->chip->fixes->set_cmddata_delay(slot->chip, cmd_delay);
+	memset(buffer, 0, TEST_BUFFER_SIZE);
+
+	ret = test_tuning_result(host->mmc, buffer);
+err_exit:
+	kfree(buffer);
+	kfree(sec_buffer);
+	return ret;
+}
+
+u32 get_proper_clock(const u32 max_clock)
+{
+	if (max_clock < CLK_50MHZ)
+		return CLK_25MHZ;
+	else if (max_clock < CLK_60MHZ)
+		return CLK_50MHZ;
+	else if (max_clock < CLK_62_5MHZ)
+		return CLK_60MHZ;
+	else if (max_clock < CLK_83MHZ)
+		return CLK_62_5MHZ;
+	else if (max_clock < CLK_100MHZ)
+		return CLK_83MHZ;
+	else if (max_clock < CLK_125MHZ)
+		return CLK_100MHZ;
+	else if (max_clock < CLK_156MHZ)
+		return CLK_125MHZ;
+	else if (max_clock < CLK_178MHZ)
+		return CLK_156MHZ;
+	else if (max_clock < CLK_208MHZ)
+		return CLK_178MHZ;
+	else
+		return CLK_208MHZ;
+}
+
+/*	tune a proper clock, command delay and data delay  */
+static int jmicron_tuning(struct mmc_host *mmc, const u32 max_clock)
+{
+	struct sdhci_host *host = NULL;
+	u32 response, clk;
+
+	host = mmc_priv(mmc);
+	clk = max_clock;
+	for (;;) {
+		clk = get_proper_clock(clk);
+		if (tuning_in_clock(host, clk)) {
+			msleep(20);
+			mmc_stop_status_cmd(mmc, MMC_STOP_TRANSMISSION, NULL);
+			mmc_stop_status_cmd(mmc, MMC_SEND_STATUS, &response);
+			DBG("tuning in [%d]HZ is fail, try slower\n", clk);
+			clk--;
+		} else {
+			printk(KERN_INFO DRIVER_NAME
+				":tuning delay in [%d]HZ is OK\n", clk);
+			break;
+		}
+		if (clk == CLK_25MHZ)
+			break;
+	}
+	return 0;
+}
+
+void jmicron_set_default_delay(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+
+	slot->chip->fixes->set_clock_delay(slot->chip, 3);
+	slot->chip->fixes->set_cmddata_delay(slot->chip, 3);
+}
+
+
 static int sdhci_execute_tuning(struct mmc_host *mmc)
 {
 	struct sdhci_host *host;
@@ -1801,7 +2109,7 @@ static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static const struct mmc_host_ops sdhci_ops = {
+static struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
@@ -1944,7 +2252,8 @@ static void sdhci_tuning_timer(unsigned long data)
 	unsigned long flags;
 
 	host = (struct sdhci_host *)data;
-
+	if (host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT)
+		return ;
 	spin_lock_irqsave(&host->lock, flags);
 
 	host->flags |= SDHCI_NEEDS_RETUNING;
@@ -2293,6 +2602,8 @@ int sdhci_resume_host(struct sdhci_host *host)
 	sdhci_enable_card_detection(host);
 
 	/* Set the re-tuning expiration flag */
+	if (host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT)
+		return ret;
 	if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
 	    (host->tuning_mode == SDHCI_TUNING_MODE_1))
 		host->flags |= SDHCI_NEEDS_RETUNING;
@@ -2368,6 +2679,9 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->version);
 	}
 
+	if (host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT)
+		host->version = SDHCI_SPEC_300;
+
 	caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
 		sdhci_readl(host, SDHCI_CAPABILITIES);
 
@@ -2476,6 +2790,16 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
+	if (host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT) {
+		((struct mmc_host_ops *)mmc->ops)->tune_delay = jmicron_tuning;
+		((struct mmc_host_ops *)mmc->ops)->set_default_delay =
+			jmicron_set_default_delay;
+		((struct mmc_host_ops *)mmc->ops)->execute_tuning = NULL;
+	} else {
+		((struct mmc_host_ops *)mmc->ops)->tune_delay = NULL;
+		((struct mmc_host_ops *)mmc->ops)->set_default_delay = NULL;
+	}
+
 	mmc->f_max = host->max_clk;
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
@@ -2503,7 +2827,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
-
+	if (host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT)
+		mmc->f_max = CLK_208MHZ;
 	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
 		host->timeout_clk = mmc->f_max / 1000;
 
@@ -2534,7 +2859,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
-	if (caps[0] & SDHCI_CAN_DO_HISPD)
+	if (caps[0] & SDHCI_CAN_DO_HISPD ||
+	(host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
@@ -2590,7 +2916,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * value.
 	 */
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
-
+	if (host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT)
+		max_current_caps = 0x800000;
 	if (caps[0] & SDHCI_CAN_VDD_330) {
 		int max_current_330;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 745c42f..ac60ee9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -168,6 +168,17 @@
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
+#define CLK_208MHZ			208000000
+#define CLK_178MHZ			178000000
+#define CLK_156MHZ			156000000
+#define CLK_125MHZ			125000000
+#define CLK_100MHZ			100000000
+#define CLK_83MHZ			83000000
+#define CLK_62_5MHZ			62500000
+#define CLK_60MHZ			60000000
+#define CLK_50MHZ			50000000
+#define CLK_25MHZ			25000000
+
 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
 #define  SDHCI_TIMEOUT_CLK_SHIFT 0
@@ -276,6 +287,43 @@ struct sdhci_ops {
 
 };
 
+#define MAX_SLOTS			8
+struct sdhci_pci_chip;
+struct sdhci_pci_slot;
+struct sdhci_pci_fixes {
+	unsigned int		quirks;
+
+	int			(*probe) (struct sdhci_pci_chip *);
+
+	int			(*probe_slot) (struct sdhci_pci_slot *);
+	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+
+	int			(*suspend) (struct sdhci_pci_chip *,
+					pm_message_t);
+	int			(*resume) (struct sdhci_pci_chip *);
+	void			(*set_clock_delay)(struct sdhci_pci_chip *,
+					const u16);
+	void			(*set_cmddata_delay)(struct sdhci_pci_chip *,
+					const u16);
+};
+
+struct sdhci_pci_slot {
+	struct sdhci_pci_chip	*chip;
+	struct sdhci_host	*host;
+
+	int			pci_bar;
+};
+
+struct sdhci_pci_chip {
+	struct pci_dev		*pdev;
+
+	unsigned int		quirks;
+	const struct sdhci_pci_fixes *fixes;
+
+	int			num_slots;	/* Slots on controller */
+	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
+};
+
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
 
 static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0f83858..3011945 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -149,6 +149,8 @@ struct mmc_host_ops {
 	int	(*execute_tuning)(struct mmc_host *host);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
+	int	(*tune_delay)(struct mmc_host *host, const u32 max_clock);
+	void	(*set_default_delay)(struct mmc_host *mmc);
 };
 
 struct mmc_card;
@@ -328,7 +330,7 @@ extern int mmc_resume_host(struct mmc_host *);
 
 extern int mmc_power_save_host(struct mmc_host *host);
 extern int mmc_power_restore_host(struct mmc_host *host);
-
+extern void mmc_reinit_card(struct mmc_host *);
 extern void mmc_detect_change(struct mmc_host *, unsigned long delay);
 extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
 
@@ -367,6 +369,9 @@ int mmc_host_enable(struct mmc_host *host);
 int mmc_host_disable(struct mmc_host *host);
 int mmc_host_lazy_disable(struct mmc_host *host);
 int mmc_pm_notify(struct notifier_block *notify_block, unsigned long, void *);
+int mmc_stop_status_cmd(struct mmc_host *host, u32 opcode, u32 *buf);
+int mmc_read_data(struct mmc_host *host, u8 *buffer);
+#define TEST_BUFFER_SIZE	(32*512)
 
 static inline void mmc_set_disable_delay(struct mmc_host *host,
 					 unsigned int disable_delay)
-- 
1.7.3.4

