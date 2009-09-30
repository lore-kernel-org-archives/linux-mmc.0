From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Wed, 30 Sep 2009 18:59:15 +0200
Message-ID: <1254329955.32349.1.camel@flow>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41776 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbZI3Q7D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2009 12:59:03 -0400
Received: by fxm18 with SMTP id 18so5488765fxm.17
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2009 09:59:05 -0700 (PDT)
In-Reply-To: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, magnus.damm@gmail.com, sameo@openedhand.com, pb@handhelds.org

Am Dienstag, den 29.09.2009, 13:52 +0100 schrieb Ian Molton: 
> Hi guys,
> 
> This is the full TMIO MMC patchset, compiled, tested, checkpatch passed.

With bus shift support dropped from the SD_CONFIG register accessors, I
can't use this as-is on ASIC3. What do you think about the following
(sketch of a) patch to add it back?

regards
Philipp 

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index a206a8d..89042d6 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -40,14 +40,38 @@
 
 #define   SDCREN 0x2   /* Enable access to MMC CTL regs. (flag in COMMAND_REG)*/
 
-#define sd_config_write8(a, b)  tmio_iowrite8((b), (a))
-#define sd_config_write16(a, b) tmio_iowrite16((b), (a))
-#define sd_config_write32(a, b) tmio_iowrite32((b), (a))
-
-int tmio_core_mmc_enable(void __iomem *cnf, unsigned long base);
-int tmio_core_mmc_resume(void __iomem *cnf, unsigned long base);
-void tmio_core_mmc_pwr(void __iomem *cnf, int state);
-void tmio_core_mmc_clk_div(void __iomem *cnf, int state);
+/*
+ * data for the tmio_core_mmc functions (CONFIG regs)
+ */
+struct tmio_core_mmc {
+	void __iomem *cnf;
+	int           bus_shift;
+	unsigned long base;
+};
+
+static inline void sd_config_write8(struct tmio_core_mmc *sd_config, int addr,
+		u8 val)
+{
+	writeb(val, sd_config->cnf + (addr << sd_config->bus_shift));
+}
+
+static inline void sd_config_write16(struct tmio_core_mmc *sd_config, int addr,
+		u16 val)
+{
+	writew(val, sd_config->cnf + (addr << sd_config->bus_shift));
+}
+
+static inline void sd_config_write32(struct tmio_core_mmc *sd_config, int addr,
+		u32 val)
+{
+	writew(val, sd_config->cnf + (addr << sd_config->bus_shift));
+	writew(val >> 16, sd_config->cnf + ((addr + 2) << sd_config->bus_shift));
+}
+
+int tmio_core_mmc_enable(struct tmio_core_mmc *sd_config);
+int tmio_core_mmc_resume(struct tmio_core_mmc *sd_config);
+void tmio_core_mmc_pwr(struct tmio_core_mmc *sd_config, int state);
+void tmio_core_mmc_clk_div(struct tmio_core_mmc *sd_config, int state);
 
 /*
  * data for the MMC controller
diff --git a/drivers/mfd/tmio_core.c b/drivers/mfd/tmio_core.c
index 483fbbb..7abb997 100644
--- a/drivers/mfd/tmio_core.c
+++ b/drivers/mfd/tmio_core.c
@@ -10,45 +10,45 @@
 
 #include <linux/mfd/tmio.h>
 
-int tmio_core_mmc_enable(void __iomem *cnf, unsigned long base)
+int tmio_core_mmc_enable(struct tmio_core_mmc *sd_config, unsigned long base)
 {
 	/* Enable the MMC/SD Control registers */
-	sd_config_write16(cnf + CNF_CMD, SDCREN);
-	sd_config_write32(cnf + CNF_CTL_BASE, base & 0xfffe);
+	sd_config_write16(sd_config, CNF_CMD, SDCREN);
+	sd_config_write32(sd_config, CNF_CTL_BASE, base & 0xfffe);
 
 	/* Disable SD power during suspend */
-	sd_config_write8(cnf + CNF_PWR_CTL_3, 0x01);
+	sd_config_write8(sd_config, CNF_PWR_CTL_3, 0x01);
 
 	/* The below is required but why? FIXME */
-	sd_config_write8(cnf + CNF_STOP_CLK_CTL, 0x1f);
+	sd_config_write8(sd_config, CNF_STOP_CLK_CTL, 0x1f);
 
 	/* Power down SD bus*/
-	sd_config_write8(cnf + CNF_PWR_CTL_2, 0x00);
+	sd_config_write8(sd_config, CNF_PWR_CTL_2, 0x00);
 
 	return 0;
 }
 EXPORT_SYMBOL(tmio_core_mmc_enable);
 
-int tmio_core_mmc_resume(void __iomem *cnf, unsigned long base)
+int tmio_core_mmc_resume(struct tmio_core_mmc *sd_config, unsigned long base)
 {
 
 	/* Enable the MMC/SD Control registers */
-	sd_config_write16(cnf + CNF_CMD, SDCREN);
-	sd_config_write32(cnf + CNF_CTL_BASE, base & 0xfffe);
+	sd_config_write16(sd_config, CNF_CMD, SDCREN);
+	sd_config_write32(sd_config, CNF_CTL_BASE, base & 0xfffe);
 
 	return 0;
 }
 EXPORT_SYMBOL(tmio_core_mmc_resume);
 
-void tmio_core_mmc_pwr(void __iomem *cnf, int state)
+void tmio_core_mmc_pwr(struct tmio_core_mmc *sd_config, int state)
 {
-	sd_config_write8(cnf + CNF_PWR_CTL_2, state ? 0x02 : 0x00);
+	sd_config_write8(sd_config, CNF_PWR_CTL_2, state ? 0x02 : 0x00);
 }
 EXPORT_SYMBOL(tmio_core_mmc_pwr);
 
-void tmio_core_mmc_clk_div(void __iomem *cnf, int state)
+void tmio_core_mmc_clk_div(struct tmio_core_mmc *sd_config, int state)
 {
-	sd_config_write8(cnf + CNF_SD_CLK_MODE, state ? 1 : 0);
+	sd_config_write8(sd_config, CNF_SD_CLK_MODE, state ? 1 : 0);
 }
 EXPORT_SYMBOL(tmio_core_mmc_clk_div);
 
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index fa8da02..520effe 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -26,10 +26,9 @@ struct tc6387xb {
 	void __iomem *scr;
 	struct clk *clk32k;
 	struct resource rscr;
+	struct tmio_core_mmc sd_config;
 };
 
-static struct resource tc6387xb_mmc_resources[];
-
 /*--------------------------------------------------------------------------*/
 
 #ifdef CONFIG_PM
@@ -54,8 +53,7 @@ static int tc6387xb_resume(struct platform_device *dev)
 	if (pdata && pdata->resume)
 		pdata->resume(dev);
 
-	tmio_core_mmc_resume(tc6387xb->scr + 0x200,
-		tc6387xb_mmc_resources[0].start & 0xfffe);
+	tmio_core_mmc_resume(&tc6387xb->sd_config);
 
 	return 0;
 }
@@ -71,7 +69,7 @@ static void tc6387xb_mmc_pwr(struct platform_device *mmc, int state)
 	struct platform_device *dev = to_platform_device(mmc->dev.parent);
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
 
-	tmio_core_mmc_pwr(tc6387xb->scr + 0x200, state);
+	tmio_core_mmc_pwr(&tc6387xb->sd_config, state);
 }
 
 static void tc6387xb_mmc_clk_div(struct platform_device *mmc, int state)
@@ -79,7 +77,7 @@ static void tc6387xb_mmc_clk_div(struct platform_device *mmc, int state)
 	struct platform_device *dev = to_platform_device(mmc->dev.parent);
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
 
-	tmio_core_mmc_clk_div(tc6387xb->scr + 0x200, state);
+	tmio_core_mmc_clk_div(&tc6387xb->sd_config, state);
 }
 

@@ -90,8 +88,7 @@ static int tc6387xb_mmc_enable(struct platform_device *mmc)
 
 	clk_enable(tc6387xb->clk32k);
 
-	tmio_core_mmc_enable(tc6387xb->scr + 0x200,
-		tc6387xb_mmc_resources[0].start & 0xfffe);
+	tmio_core_mmc_enable(&tc6387xb->sd_config);
 
 	return 0;
 }
@@ -196,6 +193,9 @@ static int tc6387xb_probe(struct platform_device *dev)
 	tc6387xb_cells[TC6387XB_CELL_MMC].data_size =
 		sizeof(tc6387xb_cells[TC6387XB_CELL_MMC]);
 
+	tc6387xb->sd_config.cnf = tc6387xb->scr + 0x200;
+	tc6387xb->sd_config.base = tc6387xb_mmc_resources[0].start & 0xfffe;
+
 	ret = mfd_add_devices(&dev->dev, dev->id, tc6387xb_cells,
 			      ARRAY_SIZE(tc6387xb_cells), iomem, irq);
 



