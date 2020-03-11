Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3701C10F25
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8302192A
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgCKFIa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:08:30 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:42474 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728189AbgCKFHM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 01:07:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 69F6618224519;
        Wed, 11 Mar 2020 05:07:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream52_212c176dc7e35
X-Filterd-Recvd-Size: 5395
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:07 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org
Subject: [PATCH -next 013/491] INGENIC JZ47xx SoCs: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:27 -0700
Message-Id: <ad408ff8dc4e5fae0884312cb0aa618664e546e5.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c           | 2 +-
 drivers/mmc/host/jz4740_mmc.c                   | 6 ++----
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c      | 4 ++--
 drivers/mtd/nand/raw/ingenic/jz4780_bch.c       | 4 ++--
 sound/soc/codecs/jz4770.c                       | 2 +-
 6 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 9dfe7c..8eefe7 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -305,7 +305,7 @@ static void ingenic_drm_crtc_update_ctrl(struct ingenic_drm *priv,
 	switch (finfo->format) {
 	case DRM_FORMAT_XRGB1555:
 		ctrl |= JZ_LCD_CTRL_RGB555;
-		/* fall-through */
+		fallthrough;
 	case DRM_FORMAT_RGB565:
 		ctrl |= JZ_LCD_CTRL_BPP_15_16;
 		break;
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index fbae87..9026af6 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -737,8 +737,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			break;
 
 		jz_mmc_prepare_data_transfer(host);
-		/* fall through */
-
+		fallthrough;
 	case JZ4740_MMC_STATE_TRANSFER_DATA:
 		if (host->use_dma) {
 			/* Use DMA if enabled.
@@ -772,8 +771,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			break;
 		}
 		jz4740_mmc_write_irq_reg(host, JZ_MMC_IRQ_DATA_TRAN_DONE);
-		/* fall through */
-
+		fallthrough;
 	case JZ4740_MMC_STATE_SEND_STOP:
 		if (!req->stop)
 			break;
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
index 49afeb..935c49 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -253,7 +253,7 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
 		chip->ecc.hwctl = ingenic_nand_ecc_hwctl;
 		chip->ecc.calculate = ingenic_nand_ecc_calculate;
 		chip->ecc.correct = ingenic_nand_ecc_correct;
-		/* fall through */
+		fallthrough;
 	case NAND_ECC_SOFT:
 		dev_info(nfc->dev, "using %s (strength %d, size %d, bytes %d)\n",
 			 (nfc->ecc) ? "hardware ECC" : "software ECC",
diff --git a/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
index 6c852ea..2d0e0a 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
@@ -145,10 +145,10 @@ static void jz4725b_bch_read_parity(struct ingenic_ecc *bch, u8 *buf,
 	switch (size8) {
 	case 3:
 		dest8[2] = (val >> 16) & 0xff;
-		/* fall-through */
+		fallthrough;
 	case 2:
 		dest8[1] = (val >> 8) & 0xff;
-		/* fall-through */
+		fallthrough;
 	case 1:
 		dest8[0] = val & 0xff;
 		break;
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
index 079266a..d67dbf 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
@@ -123,10 +123,10 @@ static void jz4780_bch_read_parity(struct ingenic_ecc *bch, void *buf,
 	switch (size8) {
 	case 3:
 		dest8[2] = (val >> 16) & 0xff;
-		/* fall through */
+		fallthrough;
 	case 2:
 		dest8[1] = (val >> 8) & 0xff;
-		/* fall through */
+		fallthrough;
 	case 1:
 		dest8[0] = val & 0xff;
 		break;
diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index e7cf2c..6e2a91 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -202,7 +202,7 @@ static int jz4770_codec_set_bias_level(struct snd_soc_component *codec,
 				   REG_CR_VIC_SB_SLEEP, REG_CR_VIC_SB_SLEEP);
 		regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
 				   REG_CR_VIC_SB, REG_CR_VIC_SB);
-	/* fall-through */
+		fallthrough;
 	default:
 		break;
 	}
-- 
2.24.0

