From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3] mmc: implement Driver Stage Register handling
Date: Wed, 13 Aug 2014 17:44:16 +0200
Message-ID: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36323 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbaHMPok (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 11:44:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, Markus Niebel <Markus.Niebel@tq-group.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>

=46rom: Sascha Hauer <s.hauer@pengutronix.de>

Some (e)MMC and SD cards implement a DSR register that allows to tune
raise/fall times and drive strength of the CMD and DATA outputs.
The values to use depend on the card in use and the host.
It might be needed to reduce the drive strength to prevent voltage peak=
s
above the host's specification.

Implement a 'dsr' devicetree property that allows to specify the value
to set the DSR to. For non-dt setups the new members of mmc_host can be
set by board code.

This patch was initially authored by Sascha Hauer. It contains
improvements authored by Markus Niebel and Uwe Kleine-K=C3=B6nig.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

earlier incarnations of this patch can be found at

	http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272983=
=2Ehtml
	http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259281.=
html

I need this functionallity on a machine where the default driver streng=
th of
the eMMC chip is too big for the SoC. It seems to work without adapting=
 the
drive strength, but the vendor reports that the DSR should be set to a =
certain
value to prevent poor signal integrity and increased wearout.

Best regards
Uwe

 Documentation/devicetree/bindings/mmc/mmc.txt |  2 ++
 drivers/mmc/core/host.c                       |  8 ++++++++
 drivers/mmc/core/mmc.c                        |  8 ++++++++
 drivers/mmc/core/mmc_ops.c                    | 21 +++++++++++++++++++=
++
 drivers/mmc/core/mmc_ops.h                    |  1 +
 drivers/mmc/core/sd.c                         |  8 ++++++++
 include/linux/mmc/card.h                      |  3 ++-
 include/linux/mmc/host.h                      |  3 +++
 8 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentat=
ion/devicetree/bindings/mmc/mmc.txt
index 3c18001dfd5d..05bac770b4d0 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -40,6 +40,8 @@ Optional properties:
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
 - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
+- dsr: Value the card's (optional) Driver Stage Register (DSR) should =
be
+  programmed with.
=20
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host contro=
llers line
 polarity properties, we have to fix the meaning of the "normal" and "i=
nverted"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 95cceae96944..52e83f389428 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -452,6 +452,14 @@ int mmc_of_parse(struct mmc_host *host)
 	if (of_find_property(np, "mmc-hs400-1_2v", &len))
 		host->caps2 |=3D MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
=20
+	if (of_find_property(np, "dsr", &len)) {
+		u32 tmp;
+
+		of_property_read_u32(np, "dsr", &tmp);
+		host->dsr_req =3D 1;
+		host->dsr =3D (u16)tmp;
+	}
+
 	return 0;
=20
 out:
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7ddb04..fdc1ac1360c4 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -162,6 +162,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 	csd->read_partial =3D UNSTUFF_BITS(resp, 79, 1);
 	csd->write_misalign =3D UNSTUFF_BITS(resp, 78, 1);
 	csd->read_misalign =3D UNSTUFF_BITS(resp, 77, 1);
+	csd->dsr_imp =3D UNSTUFF_BITS(resp, 76, 1);
 	csd->r2w_factor =3D UNSTUFF_BITS(resp, 26, 3);
 	csd->write_blkbits =3D UNSTUFF_BITS(resp, 22, 4);
 	csd->write_partial =3D UNSTUFF_BITS(resp, 21, 1);
@@ -1273,6 +1274,13 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
 	}
=20
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
index f51b5ba3bbea..37ed493d8030 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -93,6 +93,27 @@ int mmc_deselect_cards(struct mmc_host *host)
 	return _mmc_select_card(host, NULL);
 }
=20
+/*
+ * Write the value specified in the device tree or board code into the=
 optional
+ * 16 bit Driver Stage Register. This can be used to tune raise/fall t=
imes and
+ * drive strength of the DAT and CMD outputs. The actual meaning of a =
given
+ * value is hardware dependant.
+ * The presence of the DSR register can be determined from the CSD reg=
ister,
+ * bit 76.
+ */
+int mmc_set_dsr(struct mmc_host *host)
+{
+	int err;
+	struct mmc_command cmd =3D {0};
+
+	cmd.opcode =3D MMC_SET_DSR;
+
+	cmd.arg =3D ((u32)host->dsr << 16) | 0xffff;
+	cmd.flags =3D MMC_RSP_NONE | MMC_CMD_AC;
+
+	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+}
+
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 80ae9f4e0293..390dac665b2a 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -14,6 +14,7 @@
=20
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
+int mmc_set_dsr(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0c44510bf717..25913889cbaa 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -127,6 +127,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 		csd->read_partial =3D UNSTUFF_BITS(resp, 79, 1);
 		csd->write_misalign =3D UNSTUFF_BITS(resp, 78, 1);
 		csd->read_misalign =3D UNSTUFF_BITS(resp, 77, 1);
+		csd->dsr_imp =3D UNSTUFF_BITS(resp, 76, 1);
 		csd->r2w_factor =3D UNSTUFF_BITS(resp, 26, 3);
 		csd->write_blkbits =3D UNSTUFF_BITS(resp, 22, 4);
 		csd->write_partial =3D UNSTUFF_BITS(resp, 21, 1);
@@ -954,6 +955,13 @@ static int mmc_sd_init_card(struct mmc_host *host,=
 u32 ocr,
 	}
=20
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
index d424b9de3aff..680a7f0188bb 100644
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
=20
 struct mmc_ext_csd {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7960424d0bc0..9e9ad7b31bb9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -319,6 +319,7 @@ struct mmc_host {
 #ifdef CONFIG_MMC_DEBUG
 	unsigned int		removed:1;	/* host is being removed */
 #endif
+	unsigned int		dsr_req:1;	/* DSR is requested for Host */
=20
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
@@ -365,6 +366,8 @@ struct mmc_host {
=20
 	unsigned int		slotno;	/* used for sdio acpi binding */
=20
+	u16			dsr;	/* optional driver stage (dsr) value */
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
=20
--=20
2.0.1

