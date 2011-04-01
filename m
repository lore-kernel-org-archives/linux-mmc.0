From: Russ Knize <Russ.Knize@motorola.com>
Subject: [PATCH] mmc: power class support
Date: Fri, 1 Apr 2011 10:58:26 -0500
Message-ID: <AANLkTin_=jScYXaXNStx-RfmBopbY43fuV8ZdhcS4M3K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:49537 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1DAQPa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 12:15:30 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p31Fx7mT016032
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 11:59:07 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p31FtfJS014325
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 11:59:07 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so4055123wyb.15
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2011 08:58:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I've been propagating this patch around internally, so I thought I'd
post it here too in case someone might be interested.  Basically, I've
been testing recent samples of new eMMC cards from our vendors.  These
cards have support for "card power class".  Cards are becoming more
powerful and as such are drawing more current.  This feature provides
a means to limit the maximum current consumption of a particular card.
 We need to support this because these new cards start off in power
class 0, which leads to dismal performance.  At present, this only
seems to impact 8-bit buses.

The patch is simple, but the card firmware implementations for this
feature have been a bit buggy.   Though recent samples from two of our
vendors are much more promising.  Also, the JEDEC spec is littered
with vagueness on many of the details of how this is supposed to work.
 This led to some of the firmware issues.  I've done my best to
interpret the spec and got at least one of our vendors to agree on the
interpretation.  :)  So far it has been validated on Sandisk and
Toshiba parts.

Some caveats with this patch:

1) This patch doesn't quite apply as nicely to mmc-next as it does our
older kernels.  One of the details that ended being tricky for the
card firmware was the sequence.  The spec indicates that the power
class switch command should be sent after the host has determined the
bus width, but *before* sending the bus width switch command.  I see a
new "trial and error" loop in mmc_init_card() that we don't have in
our older kernel.  For this to work and if my interpretation of the
spec is right, we need to send the power class command each time we
try one of the bus widths.

2) The point of the feature is to allow the host/platform to limit the
maximum current draw of the card.  As such, I have added a
"max_power_class" to the main host structure that the host driver
should populate.  The caveat here is that the value will be left as 0
by current host drivers, but 0 is a valid power class.  The net effect
of this patch will be nil for those hosts.  So either we can kludge
the power class value and interpret a zero here to mean "maximum
performance", or we can just leave it alone and let the various host
drivers figure out how they want to deal with it.  I opted for the
latter because it meant I could be lazier.  ;)

I left out the change in our host driver (an SDHCI-based one), since
it is a very old version and doesn't really apply here.  In our case,
the value will come from a platform_data structure.  Also, I haven't
back-ported mmc-next to our older kernel so that I can retest this
version of the patch.  It should be fine and it does compile on
linux-next, but I thought I should mention that little fact.  The only
part that had to be tweaked was for caveat #1 above.

Obviously I'm looking for comments.  Let me know what you think.

Thanks,
Russ
---

commit da15e2374677be57f9a5bb4d3fa3548fca2f7067
Author: Russ W. Knize <russ@knizefamily.net>
Date:   Fri Apr 1 10:24:48 2011 -0500

    mmc: power class support

    Add power class support for v4 cards.  Power classes are provided as a
    means to control the maximum amount of current consumption of an MMC/SD
    device.  Each class defines a maximum current draw for a particular
    voltage, bus width, and bus speed.  Higher classes offer better
    performance potential.  Cards that support power classes seem to start
    up in their lowest class and will therefore have poor relative
    performance until they recieve the switch command.

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f453ac..a9a6658 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -954,6 +954,63 @@ void mmc_set_timing(struct mmc_host *host,
unsigned int timing)
 }

 /*
+ * Try to upgrade the power class to the maximum supported.  The maximum power
+ * class supported by a card is stored as 8 values in 4 EXT_CSD bytes.  The
+ * value that applies depends on the operating voltage, bus speed, and bus
+ * width.
+ */
+int mmc_set_power_class(struct mmc_host *host, unsigned int hz,
+                         unsigned int width)
+{
+	struct mmc_card *card = host->card;
+	int class_index = MMC_EXT_CSD_PWR_CL(EXT_CSD_PWR_CL_52_195);
+	u8 power_class = 0;
+	int err = 0;
+
+	/*
+	 * The spec is vague about what voltage threshold is used to determine
+	 * which class value to use, but they probably intend it for "low"
+	 * (1.7V-1.95V) versus "high" (2.7V-3.6V) voltage cards.
+	 */
+	if (host->ocr >= MMC_VDD_27_28)
+		class_index = MMC_EXT_CSD_PWR_CL(EXT_CSD_PWR_CL_52_360);
+
+	/*
+	 * More vagueness here.  Assume that the threshold is at 26MHz.
+	 */
+	if (hz <= 26000000)
+		class_index++;
+
+	power_class = card->ext_csd.power_class[class_index];
+	if (width == MMC_BUS_WIDTH_4)
+		power_class &= 0xF;
+	else if (width == MMC_BUS_WIDTH_8)
+		power_class = (power_class & 0xF0) >> 4;
+
+	if (power_class > host->max_power_class)
+		power_class = host->max_power_class;
+
+	if (power_class > 0) {
+		pr_debug("%s: power class %d (max %d), %u HZ, width %d, OCR=0x%08X\n",
+			mmc_hostname(card->host),
+			power_class,
+			host->max_power_class,
+			hz,
+			width,
+			card->host->ocr);
+
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_POWER_CLASS, power_class);
+		if (err) {
+			pr_warning("%s: switch power class failed (%d)\n",
+				mmc_hostname(card->host), err);
+		}
+	}
+
+	return err;
+}
+
+/*
  * Apply power to the MMC stack.  This is a two-stage process.
  * First, we enable power to the card without the clock running.
  * We then wait a bit for the power to stabilise.  Finally,
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 20b1c08..8e5847d 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -42,6 +42,8 @@ void mmc_set_bus_width_ddr(struct mmc_host *host,
unsigned int width,
 			   unsigned int ddr);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
+int mmc_set_power_class(struct mmc_host *host, unsigned int hz,
+                        unsigned int width);

 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2d48800..47f779d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -304,6 +304,14 @@ static int mmc_read_ext_csd(struct mmc_card *card)

 	if (card->ext_csd.rev >= 4) {
 		/*
+		 * Read power class table.
+		 */
+		int i;
+		for (i = EXT_CSD_PWR_CL_52_195;
+		     i <= EXT_CSD_PWR_CL_26_360; i++)
+			card->ext_csd.power_class[MMC_EXT_CSD_PWR_CL(i)] =
+			                                           ext_csd[i];
+		/*
 		 * Enhanced area feature support -- check whether the eMMC
 		 * card has the Enhanced area enabled.  If so, export enhanced
 		 * area offset and size to user by adding sysfs interface.
@@ -648,6 +656,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			bus_width = bus_widths[idx];
 			if (bus_width == MMC_BUS_WIDTH_1)
 				ddr = 0; /* no DDR for 1-bit width */
+
+			/*
+			 * Ignore switch errors from buggy cards that actually
+			 * do switch successfully.
+			 */
+			err = mmc_set_power_class(host, max_dtr, bus_width);
+			if (err && err != -EBADMSG)
+				goto free_card;
+
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][0]);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..12740d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1981,6 +1981,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;

+	mmc->max_power_class = host->max_power_class;
+
 	/*
 	 * Init tasklets.
 	 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 557b732..e18dff0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -46,6 +46,8 @@ struct mmc_ext_csd {
 	u8			erase_group_def;
 	u8			sec_feature_support;
 	u8			bootconfig;
+	u8			power_class[4];
+#define MMC_EXT_CSD_PWR_CL(b)	(b - EXT_CSD_PWR_CL_52_195)
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..7509e39 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -227,6 +227,8 @@ struct mmc_host {
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
 	unsigned int		bus_refs;	/* reference counter */

+	unsigned int		max_power_class;
+
 	unsigned int		sdio_irqs;
 	struct task_struct	*sdio_irq_thread;
 	atomic_t		sdio_irq_thread_abort;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index b5ec88f..2e3a7fd 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -260,9 +260,14 @@ struct _mmc_csd {
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
+#define EXT_CSD_POWER_CLASS		187	/* R/W */
 #define EXT_CSD_REV			192	/* RO */
 #define EXT_CSD_STRUCTURE		194	/* RO */
 #define EXT_CSD_CARD_TYPE		196	/* RO */
+#define EXT_CSD_PWR_CL_52_195		200	/* RO */
+#define EXT_CSD_PWR_CL_26_195		201	/* RO */
+#define EXT_CSD_PWR_CL_52_360		202	/* RO */
+#define EXT_CSD_PWR_CL_26_360		203	/* RO */
 #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..b1c30f3 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -145,6 +145,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;

+	unsigned int		max_power_class;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 #endif /* __SDHCI_H */
