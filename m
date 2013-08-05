From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH v3 05/12] ARM: edma: Add function to enable interrupt for a PaRAM slot
Date: Mon, 5 Aug 2013 11:14:50 -0500
Message-ID: <1375719297-12871-6-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Joel Fernandes <joelf@ti.com>
List-Id: linux-mmc@vger.kernel.org

To prevent common programming errors, add a function to enable
interrupts correctly. Also keeps calling code more readable.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/common/edma.c             |   15 +++++++++++++++
 include/linux/platform_data/edma.h |    1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 6433b6c..aa43c49 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1095,6 +1095,21 @@ void edma_set_transfer_params(unsigned slot,
 EXPORT_SYMBOL(edma_set_transfer_params);
 
 /**
+ * edma_enable_interrupt - enable interrupt on parameter RAM slot
+ * @slot: parameter RAM slot which is the link target
+ *
+ * The originating slot should not be part of any active DMA transfer.
+ */
+void edma_enable_interrupt(unsigned slot)
+{
+	pr_debug("Enabling interrupt on slot %d\n", slot);
+
+	edma_parm_modify(EDMA_CTLR(slot), PARM_OPT, EDMA_CHAN_SLOT(slot),
+			 ~TCINTEN, TCINTEN);
+}
+EXPORT_SYMBOL(edma_enable_interrupt);
+
+/**
  * edma_link - link one parameter RAM slot to another
  * @from: parameter RAM slot originating the link
  * @to: parameter RAM slot which is the link target
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 57300fd..184ff5f 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -136,6 +136,7 @@ void edma_set_dest_index(unsigned slot, s16 dest_bidx, s16 dest_cidx);
 void edma_set_transfer_params(unsigned slot, u16 acnt, u16 bcnt, u16 ccnt,
 		u16 bcnt_rld, enum sync_dimension sync_mode);
 void edma_link(unsigned from, unsigned to);
+void edma_enable_interrupt(unsigned slot);
 void edma_unlink(unsigned from);
 
 /* calls that operate on an entire parameter RAM slot */
-- 
1.7.9.5
