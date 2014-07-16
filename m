From: Markus Niebel <list-09_linux_arm@tqsc.de>
Subject: [PATCH 1/2] mmc: implement driver stage register handling
Date: Wed, 16 Jul 2014 16:19:48 +0200
Message-ID: <1405520389-32649-2-git-send-email-list-09_linux_arm@tqsc.de>
References: <1405520389-32649-1-git-send-email-list-09_linux_arm@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405520389-32649-1-git-send-email-list-09_linux_arm@tqsc.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

From: Markus Niebel <Markus.Niebel@tq-group.com>

The eMMC and the SD-Card specifications describe the optional SET_DSR command.
During measurements at our lab we found that some cards implementing this feature
having really strong driver strengts per default. This can lead to voltage peaks
above the specification of the host on signal edges for data sent from a card to
the host.

Since availability of a given card type may be shorter than the time a certain
hardware will be produced it is useful to have support for this command (Alternative
would be changing termination resistors and adapting the driver strength of the
host to the used card.)

As the value of the dsr register is board specific this adds a 'dsr' devicetree
property which is handled in mmc_of_parse.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>

---
 Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++++
 drivers/mmc/core/host.c                       |    8 ++++++++
 drivers/mmc/core/mmc.c                        |    8 ++++++++
 drivers/mmc/core/mmc_ops.c                    |   17 +++++++++++++++++
 drivers/mmc/core/mmc_ops.h                    |    1 +
 drivers/mmc/core/sd.c                         |    8 ++++++++
 include/linux/mmc/card.h                      |    3 ++-
 include/linux/mmc/host.h                      |    3 +++
 8 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 3c18001..94da6ec 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -40,6 +40,13 @@ Optional properties:
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
 - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
+- dsr: Content of the optional driver stage register (DSR) as described
+  in JEDEC Standard No. 84-A44, 12.4: Programmable card output driver, SDIO
+  simplified specification 2.00 4.10.5: DSR Register and SD Card Physical Layer
+  Specification 2.00 5.5 DSR Register. For SD and MMC cards this is an optional
+  feature. SDIO cards do not have this feature.
+  SD Card Physical Layer Specification 2.00 Table 6-1 defines the DSR register
+  layout.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 95cceae..52e83f3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -452,6 +452,14 @@ int mmc_of_parse(struct mmc_host *host)
 	if (of_find_property(np, "mmc-hs400-1_2v", &len))
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
 
+	if (of_find_property(np, "dsr", &len)) {
+		u32 tmp;
+
+		of_property_read_u32(np, "dsr", &tmp);
+		host->dsr_req = 1;
+		host->dsr = (u16)tmp;
+	}
+
 	return 0;
 
 out:
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..fdc1ac1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -162,6 +162,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 	csd->read_partial = UNSTUFF_BITS(resp, 79, 1);
 	csd->write_misalign = UNSTUFF_BITS(resp, 78, 1);
 	csd->read_misalign = UNSTUFF_BITS(resp, 77, 1);
+	csd->dsr_imp = UNSTUFF_BITS(resp, 76, 1);
 	csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
 	csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
 	csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
@@ -1273,6 +1274,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * handling only for cards supporting DSR and hosts requesting
+	 * DSR configuration
+	 */
+	if (card->csd.dsr_imp && host->dsr_req)
+		mmc_set_dsr(host);
+
+	/*
 	 * Select card, as all following commands rely on that.
 	 */
 	if (!mmc_host_is_spi(host)) {
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index f51b5ba..f2a06da 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -93,6 +93,23 @@ int mmc_deselect_cards(struct mmc_host *host)
 	return _mmc_select_card(host, NULL);
 }
 
+int mmc_set_dsr(struct mmc_host *host)
+{
+	int err;
+	struct mmc_command cmd = {0};
+
+	cmd.opcode = MMC_SET_DSR;
+
+	cmd.arg = ((u32)host->dsr << 16) | 0xffff;
+	cmd.flags = MMC_RSP_NONE | MMC_CMD_AC;
+
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 80ae9f4..390dac6 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -14,6 +14,7 @@
 
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
+int mmc_set_dsr(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0c44510..2591388 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -127,6 +127,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 		csd->read_partial = UNSTUFF_BITS(resp, 79, 1);
 		csd->write_misalign = UNSTUFF_BITS(resp, 78, 1);
 		csd->read_misalign = UNSTUFF_BITS(resp, 77, 1);
+		csd->dsr_imp = UNSTUFF_BITS(resp, 76, 1);
 		csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
 		csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
 		csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
@@ -954,6 +955,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * handling only for cards supporting DSR and hosts requesting
+	 * DSR configuration
+	 */
+	if (card->csd.dsr_imp && host->dsr_req)
+		mmc_set_dsr(host);
+
+	/*
 	 * Select card, as all following commands rely on that.
 	 */
 	if (!mmc_host_is_spi(host)) {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d424b9d..680a7f0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -42,7 +42,8 @@ struct mmc_csd {
 	unsigned int		read_partial:1,
 				read_misalign:1,
 				write_partial:1,
-				write_misalign:1;
+				write_misalign:1,
+				dsr_imp:1;
 };
 
 struct mmc_ext_csd {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7960424..9e9ad7b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -319,6 +319,7 @@ struct mmc_host {
 #ifdef CONFIG_MMC_DEBUG
 	unsigned int		removed:1;	/* host is being removed */
 #endif
+	unsigned int		dsr_req:1;	/* DSR is requested for Host */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
@@ -365,6 +366,8 @@ struct mmc_host {
 
 	unsigned int		slotno;	/* used for sdio acpi binding */
 
+	u16			dsr;	/* optional driver stage (dsr) value */
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
1.7.9.5
