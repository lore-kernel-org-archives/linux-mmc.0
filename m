From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: MMC: SD-combo (IO+mem) card support
Date: Thu, 20 May 2010 00:28:43 +0200
Message-ID: <20100519222843.GA31141@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:42085 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab0ESW2o (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 May 2010 18:28:44 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This is a rough patch to support SD Combo cards. Based on simplified
SDIO spec v.2.0 and some experimentation. Real changes are in sdio.c.
Most of sd.c diff is moving code around to factor out some common
functions.

Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>

diff -urN linux-2.6.34-br1/drivers/mmc/core/bus.c linux-2.6.34-br1-sd1/=
drivers/mmc/core/bus.c
--- linux-2.6.34-br1/drivers/mmc/core/bus.c	2010-05-16 23:17:36.0000000=
00 +0200
+++ linux-2.6.34-br1-sd1/drivers/mmc/core/bus.c	2010-05-19 02:44:15.000=
000000 +0200
@@ -36,6 +36,7 @@
 	case MMC_TYPE_SD:
 		return sprintf(buf, "SD\n");
 	case MMC_TYPE_SDIO:
+	case MMC_TYPE_SD_COMBO:
 		return sprintf(buf, "SDIO\n");
 	default:
 		return -EFAULT;
@@ -72,6 +73,7 @@
 		type =3D "SD";
 		break;
 	case MMC_TYPE_SDIO:
+	case MMC_TYPE_SD_COMBO:
 		type =3D "SDIO";
 		break;
 	default:
@@ -239,6 +241,10 @@
 	case MMC_TYPE_SDIO:
 		type =3D "SDIO";
 		break;
+	case MMC_TYPE_SD_COMBO:
+		type =3D "SD-combo";
+		if (mmc_card_blockaddr(card))
+			type =3D "SDHC-combo";
 	default:
 		type =3D "?";
 		break;
diff -urN linux-2.6.34-br1/drivers/mmc/core/core.c linux-2.6.34-br1-sd1=
/drivers/mmc/core/core.c
--- linux-2.6.34-br1/drivers/mmc/core/core.c	2010-05-16 23:17:36.000000=
000 +0200
+++ linux-2.6.34-br1-sd1/drivers/mmc/core/core.c	2010-05-19 02:44:18.00=
0000000 +0200
@@ -1099,8 +1099,15 @@
 	 */
 	err =3D mmc_send_io_op_cond(host, 0, &ocr);
 	if (!err) {
-		if (mmc_attach_sdio(host, ocr))
-			mmc_power_off(host);
+		if (mmc_attach_sdio(host, ocr)) {
+			mmc_claim_host(host);
+			/* try SDMEM (but not MMC) even if SDIO is broken */
+			if (mmc_send_app_op_cond(host, 0, &ocr))
+				goto out_fail;
+
+			if (mmc_attach_sd(host, ocr))
+				mmc_power_off(host);
+		}
 		goto out;
 	}
=20
@@ -1124,6 +1137,7 @@
 		goto out;
 	}
=20
+out_fail:
 	mmc_release_host(host);
 	mmc_power_off(host);
=20
diff -urN linux-2.6.34-br1/drivers/mmc/core/sd.c linux-2.6.34-br1-sd1/d=
rivers/mmc/core/sd.c
--- linux-2.6.34-br1/drivers/mmc/core/sd.c	2010-05-16 23:17:36.00000000=
0 +0200
+++ linux-2.6.34-br1-sd1/drivers/mmc/core/sd.c	2010-05-19 02:44:18.0000=
00000 +0200
@@ -238,22 +238,22 @@
 /*
  * Test if the card supports high-speed mode and, if so, switch to it.
  */
-static int mmc_switch_hs(struct mmc_card *card)
+int mmc_switch_hs(struct mmc_card *card)
 {
 	int err;
 	u8 *status;
=20
 	if (card->scr.sda_vsn < SCR_SPEC_VER_1)
-		return 0;
+		return -EOPNOTSUPP;
=20
 	if (!(card->csd.cmdclass & CCC_SWITCH))
-		return 0;
+		return -EOPNOTSUPP;
=20
 	if (!(card->host->caps & MMC_CAP_SD_HIGHSPEED))
-		return 0;
+		return -EOPNOTSUPP;
=20
 	if (card->sw_caps.hs_max_dtr =3D=3D 0)
-		return 0;
+		return -EOPNOTSUPP;
=20
 	err =3D -EIO;
=20
@@ -272,9 +272,7 @@
 		printk(KERN_WARNING "%s: Problem switching card "
 			"into high-speed mode!\n",
 			mmc_hostname(card->host));
-	} else {
-		mmc_card_set_highspeed(card);
-		mmc_set_timing(card->host, MMC_TIMING_SD_HS);
+		err =3D -EOPNOTSUPP;
 	}
=20
 out:
@@ -320,26 +318,13 @@
 	NULL,
 };
=20
-static struct device_type sd_type =3D {
+struct device_type sd_type =3D {
 	.groups =3D sd_attr_groups,
 };
=20
-/*
- * Handle the detection and initialisation of a card.
- *
- * In the case of a resume, "oldcard" will contain the card
- * we're trying to reinitialise.
- */
-static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
-	struct mmc_card *oldcard)
+int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
 {
-	struct mmc_card *card;
 	int err;
-	u32 cid[4];
-	unsigned int max_dtr;
-
-	BUG_ON(!host);
-	WARN_ON(!host->claimed);
=20
 	/*
 	 * Since we're changing the OCR value, we seem to
@@ -361,7 +346,7 @@
=20
 	err =3D mmc_send_app_op_cond(host, ocr, NULL);
 	if (err)
-		goto err;
+		return err;
=20
 	/*
 	 * Fetch CID from card.
@@ -370,14 +355,132 @@
 		err =3D mmc_send_cid(host, cid);
 	else
 		err =3D mmc_all_send_cid(host, cid);
+=09
+	return err;
+}
+
+int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
+{
+	int err;
+
+	/*
+	 * Fetch CSD from card.
+	 */
+	err =3D mmc_send_csd(card, card->raw_csd);
 	if (err)
-		goto err;
+		return err;
=20
-	if (oldcard) {
-		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) {
-			err =3D -ENOENT;
-			goto err;
+	err =3D mmc_decode_csd(card);
+	if (err)
+		return err;
+
+	mmc_decode_cid(card);
+	return 0;
+}
+
+int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
+	bool reinit)
+{
+	int err;
+
+	if (!reinit) {
+		/*
+		 * Fetch SCR from card.
+		 */
+		err =3D mmc_app_send_scr(card, card->raw_scr);
+		if (err)
+			return err;
+
+		err =3D mmc_decode_scr(card);
+		if (err)
+			return err;
+
+		/*
+		 * Fetch switch information from card.
+		 */
+		err =3D mmc_read_switch(card);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * For SPI, enable CRC as appropriate.
+	 * This CRC enable is located AFTER the reading of the
+	 * card registers because some SDHC cards are not able
+	 * to provide valid CRCs for non-512-byte blocks.
+	 */
+	if (mmc_host_is_spi(host)) {
+		err =3D mmc_spi_set_crc(host, use_spi_crc);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Check if read-only switch is active.
+	 */
+	if (!reinit) {
+		int ro =3D -1;
+
+		if (host->ops->get_ro)
+			ro =3D host->ops->get_ro(host);
+
+		if (ro < 0) {
+			printk(KERN_WARNING "%s: host does not "
+				"support reading read-only "
+				"switch. assuming write-enable.\n",
+				mmc_hostname(host));
+		} else if (ro > 0) {
+			mmc_card_set_readonly(card);
 		}
+	}
+
+	return 0;
+}
+
+unsigned mmc_sd_get_max_clock(struct mmc_card *card)
+{
+	unsigned max_dtr =3D (unsigned int)-1;
+
+	if (mmc_card_highspeed(card)) {
+		if (max_dtr > card->sw_caps.hs_max_dtr)
+			max_dtr =3D card->sw_caps.hs_max_dtr;
+	} else if (max_dtr > card->csd.max_dtr) {
+		max_dtr =3D card->csd.max_dtr;
+	}
+
+	return max_dtr;
+}
+
+void mmc_sd_go_highspeed(struct mmc_card *card)
+{
+	mmc_card_set_highspeed(card);
+	mmc_set_timing(card->host, MMC_TIMING_SD_HS);
+}
+
+/*
+ * Handle the detection and initialisation of a card.
+ *
+ * In the case of a resume, "oldcard" will contain the card
+ * we're trying to reinitialise.
+ */
+static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
+	struct mmc_card *oldcard)
+{
+	struct mmc_card *card;
+	int err;
+	u32 cid[4];
+	unsigned int max_dtr;
+
+	BUG_ON(!host);
+	WARN_ON(!host->claimed);
+
+	err =3D mmc_sd_get_cid(host, ocr, cid);
+	if (err)
+		return err;
+
+	if (oldcard) {
+		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0)
+			return -ENOENT;
=20
 		card =3D oldcard;
 	} else {
@@ -385,10 +488,8 @@
 		 * Allocate card structure.
 		 */
 		card =3D mmc_alloc_card(host, &sd_type);
-		if (IS_ERR(card)) {
-			err =3D PTR_ERR(card);
-			goto err;
-		}
+		if (IS_ERR(card))
+			return PTR_ERR(card);
=20
 		card->type =3D MMC_TYPE_SD;
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
@@ -400,24 +501,15 @@
 	if (!mmc_host_is_spi(host)) {
 		err =3D mmc_send_relative_addr(host, &card->rca);
 		if (err)
-			goto free_card;
+			return err;
=20
 		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
 	}
=20
-	if (!oldcard) {
-		/*
-		 * Fetch CSD from card.
-		 */
-		err =3D mmc_send_csd(card, card->raw_csd);
+	if (oldcard =3D=3D NULL) {
+		err =3D mmc_sd_get_csd(host, card);
 		if (err)
-			goto free_card;
-
-		err =3D mmc_decode_csd(card);
-		if (err)
-			goto free_card;
-
-		mmc_decode_cid(card);
+			return err;
 	}
=20
 	/*
@@ -426,60 +518,26 @@
 	if (!mmc_host_is_spi(host)) {
 		err =3D mmc_select_card(card);
 		if (err)
-			goto free_card;
+			return err;
 	}
=20
-	if (!oldcard) {
-		/*
-		 * Fetch SCR from card.
-		 */
-		err =3D mmc_app_send_scr(card, card->raw_scr);
-		if (err)
-			goto free_card;
-
-		err =3D mmc_decode_scr(card);
-		if (err < 0)
-			goto free_card;
-
-		/*
-		 * Fetch switch information from card.
-		 */
-		err =3D mmc_read_switch(card);
-		if (err)
-			goto free_card;
-	}
-
-	/*
-	 * For SPI, enable CRC as appropriate.
-	 * This CRC enable is located AFTER the reading of the
-	 * card registers because some SDHC cards are not able
-	 * to provide valid CRCs for non-512-byte blocks.
-	 */
-	if (mmc_host_is_spi(host)) {
-		err =3D mmc_spi_set_crc(host, use_spi_crc);
-		if (err)
-			goto free_card;
-	}
+	err =3D mmc_sd_setup_card(host, card, oldcard !=3D NULL);
+	if (err)
+		goto free_card;
=20
 	/*
 	 * Attempt to change to high-speed (if supported)
 	 */
 	err =3D mmc_switch_hs(card);
-	if (err)
+	if (err && err !=3D -EOPNOTSUPP)
 		goto free_card;
+	if (!err)=09
+		mmc_sd_go_highspeed(card);
=20
 	/*
 	 * Compute bus speed.
 	 */
-	max_dtr =3D (unsigned int)-1;
-
-	if (mmc_card_highspeed(card)) {
-		if (max_dtr > card->sw_caps.hs_max_dtr)
-			max_dtr =3D card->sw_caps.hs_max_dtr;
-	} else if (max_dtr > card->csd.max_dtr) {
-		max_dtr =3D card->csd.max_dtr;
-	}
-
+	max_dtr =3D mmc_sd_get_max_clock(card);
 	mmc_set_clock(host, max_dtr);
=20
 	/*
@@ -494,30 +552,12 @@
 		mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
 	}
=20
-	/*
-	 * Check if read-only switch is active.
-	 */
-	if (!oldcard) {
-		if (!host->ops->get_ro || host->ops->get_ro(host) < 0) {
-			printk(KERN_WARNING "%s: host does not "
-				"support reading read-only "
-				"switch. assuming write-enable.\n",
-				mmc_hostname(host));
-		} else {
-			if (host->ops->get_ro(host) > 0)
-				mmc_card_set_readonly(card);
-		}
-	}
-
-	if (!oldcard)
-		host->card =3D card;
-
+	host->card =3D card;
 	return 0;
=20
 free_card:
 	if (!oldcard)
 		mmc_remove_card(card);
-err:
=20
 	return err;
 }
diff -urN linux-2.6.34-br1/drivers/mmc/core/sd.h linux-2.6.34-br1-sd1/d=
rivers/mmc/core/sd.h
--- linux-2.6.34-br1/drivers/mmc/core/sd.h	1970-01-01 01:00:00.00000000=
0 +0100
+++ linux-2.6.34-br1-sd1/drivers/mmc/core/sd.h	2010-05-19 04:40:56.0000=
00000 +0200
@@ -0,0 +1,16 @@
+#ifndef _MMC_CORE_SD_H
+#define _MMC_CORE_SD_H
+
+#include <linux/mmc/card.h>
+
+extern struct device_type sd_type;
+
+int mmc_switch_hs(struct mmc_card *card);
+int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid);
+int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
+int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
+	bool reinit);
+unsigned mmc_sd_get_max_clock(struct mmc_card *card);
+void mmc_sd_go_highspeed(struct mmc_card *card);
+
+#endif
diff -urN linux-2.6.34-br1/drivers/mmc/core/sdio.c linux-2.6.34-br1-sd1=
/drivers/mmc/core/sdio.c
--- linux-2.6.34-br1/drivers/mmc/core/sdio.c	2010-05-16 23:17:36.000000=
000 +0200
+++ linux-2.6.34-br1-sd1/drivers/mmc/core/sdio.c	2010-05-19 02:44:18.00=
0000000 +0200
@@ -18,6 +18,7 @@
=20
 #include "core.h"
 #include "bus.h"
+#include "sd.h"
 #include "sdio_bus.h"
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -144,10 +145,10 @@
 	u8 ctrl;
=20
 	if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
-		return 0;
+		return -EOPNOTSUPP;
=20
 	if (card->cccr.low_speed && !card->cccr.wide_bus)
-		return 0;
+		return -EOPNOTSUPP;
=20
 	ret =3D mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_IF, 0, &ctrl);
 	if (ret)
@@ -159,8 +160,6 @@
 	if (ret)
 		return ret;
=20
-	mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
-
 	return 0;
 }
=20
@@ -230,10 +229,10 @@
 	u8 speed;
=20
 	if (!(card->host->caps & MMC_CAP_SD_HIGHSPEED))
-		return 0;
+		return -EOPNOTSUPP;
=20
 	if (!card->cccr.high_speed)
-		return 0;
+		return -EOPNOTSUPP;
=20
 	ret =3D mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_SPEED, 0, &speed);
 	if (ret)
@@ -245,9 +244,6 @@
 	if (ret)
 		return ret;
=20
-	mmc_card_set_highspeed(card);
-	mmc_set_timing(card->host, MMC_TIMING_SD_HS);
-
 	return 0;
 }
=20
@@ -261,7 +257,8 @@
 			      struct mmc_card *oldcard, int powered_resume)
 {
 	struct mmc_card *card;
-	int err;
+	int err, flag;
+	unsigned max_dtr;
=20
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -295,6 +292,31 @@
=20
 	card->type =3D MMC_TYPE_SDIO;
=20
+	if (!oldcard || oldcard->type =3D=3D MMC_TYPE_SDIO) {
+		u32 cid[4];
+
+		err =3D mmc_sd_get_cid(host, host->ocr & ocr, cid);
+		if (!err) {
+			if (oldcard && oldcard->type =3D=3D MMC_TYPE_SDIO) {
+				err =3D -ENOENT;
+				goto remove;
+			}
+			card->type =3D MMC_TYPE_SD_COMBO;
+			memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
+		}
+	} else if (oldcard->type =3D=3D MMC_TYPE_SD_COMBO) {
+		u32 cid[4];
+
+		err =3D mmc_sd_get_cid(host, host->ocr & ocr, cid);
+		if (err)
+			goto remove;
+
+		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) {
+			err =3D -ENOENT;
+			goto remove;
+		}
+	}
+
 	/*
 	 * For native busses:  set card RCA and quit open drain mode.
 	 */
@@ -307,6 +329,15 @@
 	}
=20
 	/*
+	 * Read CSD, before selecting the card
+	 */
+	if (oldcard =3D=3D NULL && card->type =3D=3D MMC_TYPE_SD_COMBO) {
+		err =3D mmc_sd_get_csd(host, card);
+		if (err)
+			return err;
+	}
+
+	/*
 	 * Select card, as all following commands rely on that.
 	 */
 	if (!powered_resume && !mmc_host_is_spi(host)) {
@@ -333,21 +364,55 @@
 		int same =3D (card->cis.vendor =3D=3D oldcard->cis.vendor &&
 			    card->cis.device =3D=3D oldcard->cis.device);
 		mmc_remove_card(card);
-		if (!same) {
-			err =3D -ENOENT;
-			goto err;
-		}
+		if (!same)
+			return -ENOENT;
+
 		card =3D oldcard;
 		return 0;
 	}
=20
+	if (card->type =3D=3D MMC_TYPE_SD_COMBO) {
+		err =3D mmc_sd_setup_card(host, card, oldcard !=3D NULL);
+		/* handle as SDIO-only card if memory init failed */
+		if (err) {
+			mmc_go_idle(host);
+			if (mmc_host_is_spi(host))
+				/* should not fail, as it worked previously */
+				mmc_spi_set_crc(host, use_spi_crc);
+			card->type =3D MMC_TYPE_SDIO;
+		} else
+			card->dev.type =3D &sd_type;
+	}
+
+	/*
+	 * If needed, disconnect card detection pull-up resistor.
+	 */
+	err =3D sdio_disable_cd(card);
+	if (err)
+		goto remove;
+
 	/*
 	 * Switch to high-speed (if supported).
 	 */
+	flag =3D 1;
+
 	err =3D sdio_enable_hs(card);
-	if (err)
+	if (err =3D=3D -EOPNOTSUPP)
+		flag =3D 0;
+	else if (err)
 		goto remove;
=20
+	if (card->type =3D=3D MMC_TYPE_SD_COMBO) {
+		err =3D mmc_switch_hs(card);
+		if (err =3D=3D -EOPNOTSUPP)
+			flag =3D 0;
+		else if (err)
+			goto remove;
+	}
+
+	if (flag)
+		mmc_sd_go_highspeed(card);
+
 	/*
 	 * Change to the card's maximum speed.
 	 */
@@ -358,17 +423,44 @@
 		 * high-speed, but it seems that 50 MHz is
 		 * mandatory.
 		 */
-		mmc_set_clock(host, 50000000);
+		max_dtr =3D 50000000;
 	} else {
-		mmc_set_clock(host, card->cis.max_dtr);
+		max_dtr =3D card->cis.max_dtr;
 	}
=20
+	if (card->type =3D=3D MMC_TYPE_SD_COMBO)
+		max_dtr =3D min_t(unsigned, max_dtr, mmc_sd_get_max_clock(card));
+
+	mmc_set_clock(host, max_dtr);
+
 	/*
 	 * Switch to wider bus (if supported).
 	 */
-	err =3D sdio_enable_wide(card);
-	if (err)
-		goto remove;
+	flag =3D 1;
+
+	if (card->type =3D=3D MMC_TYPE_SD_COMBO) {
+		if ((host->caps & MMC_CAP_4_BIT_DATA) &&
+			(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+			err =3D mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
+			if (err)
+				goto remove;
+		} else
+			flag =3D 0;
+	}
+
+	if (flag) {
+		err =3D sdio_enable_wide(card);
+		if (err && err !=3D -EOPNOTSUPP)
+			goto remove;
+		if (err) {
+			if (card->type =3D=3D MMC_TYPE_SD_COMBO)
+				mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
+			flag =3D 0;
+		}
+	}
+
+	if (flag)
+		mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
=20
 	if (!oldcard)
 		host->card =3D card;
@@ -568,13 +660,6 @@
 	card->sdio_funcs =3D 0;
=20
 	/*
-	 * If needed, disconnect card detection pull-up resistor.
-	 */
-	err =3D sdio_disable_cd(card);
-	if (err)
-		goto remove;
-
-	/*
 	 * Initialize (but don't add) all present functions.
 	 */
 	for (i =3D 0; i < funcs; i++, card->sdio_funcs++) {
diff -urN linux-2.6.34-br1/include/linux/mmc/card.h linux-2.6.34-br1-sd=
1/include/linux/mmc/card.h
--- linux-2.6.34-br1/include/linux/mmc/card.h	2010-05-16 23:17:36.00000=
0000 +0200
+++ linux-2.6.34-br1-sd1/include/linux/mmc/card.h	2010-05-19 02:44:18.0=
00000000 +0200
@@ -92,6 +92,7 @@
 #define MMC_TYPE_MMC		0		/* MMC card */
 #define MMC_TYPE_SD		1		/* SD card */
 #define MMC_TYPE_SDIO		2		/* SDIO card */
+#define MMC_TYPE_SD_COMBO	3		/* SD combo (IO+mem) card */
 	unsigned int		state;		/* (our) card state */
 #define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
 #define MMC_STATE_READONLY	(1<<1)		/* card is read-only */

