Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD5CCA47F
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jun 2022 20:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351289AbiFMUrZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244364AbiFMUqe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2022 16:46:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253330F49
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 15so6670930pfy.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8i7pxRlATiJaJBMzj2+HHtob8Vj/qK6ZZPtSwIgoXA=;
        b=4qrarwpvCbsYDA44xLBUmDZl3kMBPWrb+F1ZrdAepjnpLQDfe+RK2X+Qb1qy2HapQj
         4451teUpU/58Miy4Ynx46DefK0t5OD4nXXCM25B11//M6G0FmbHeFYSzhL9MJuF6Zd83
         UGxn9A6rgvd1Wj1l+x0C4pKUcBryFEJIHgp62bC/EKjCI9hr1mxOjIN/zggt56yOIu1L
         sanCt6I/aOxlK/r1yTsCMVKWZYtDSeCE67NyH42occfi4WX9xoGOB5b5X/UxVbc/NtFu
         1apJZ9JVsNYbZunD+od5wCTrHxE9G2NblKyZknT/uhu1qv1qW6L/3DnXsFrwncbu7gu9
         zInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8i7pxRlATiJaJBMzj2+HHtob8Vj/qK6ZZPtSwIgoXA=;
        b=f0x9OhKFByNZ905NcH7UUzLM847/IwacA+OFiSCCMedxkMQuh5calyUfIk8JCKA/Nt
         4Fucem1HxbIPswhW6ecyHJBsdeRXbR8a088HHm+n7PWKCrlzLQGhElMlrWSbUZGnwXPj
         VFf2u5jYCvx4JD3QZozsCN82fsUSZF0i+Z5YMewRTSdp/0c5O+JfScLENgGraf5/GX0J
         TSwPQBOihmoUdef72c4BZhHJNyckc4YTNMhPRoDcdFKpWOLit44goQQ4OypQkQME99ju
         DIC/VbGuKwUb/rvf45ThAljNqPQtYtGPrIrQcTP8E//iCviVWCoMVp83z3vTp428JdrF
         2Kxw==
X-Gm-Message-State: AOAM533LR1sDxd6m0i3Y4tvpiVc0PNYJ3klbXo/5+aKAm5xMzO0Wf4Mw
        FkSONNH4Wb+HnLU2NLrliLIhpQ==
X-Google-Smtp-Source: ABdhPJyVrR6Wo8rj+rowp622HlFPPwHbw9lplrBcYIho2FBEyOY5wXti9Sz89w7Ii5CZaDeZigAAEw==
X-Received: by 2002:a62:a50c:0:b0:510:6b52:cd87 with SMTP id v12-20020a62a50c000000b005106b52cd87mr985088pfm.30.1655150268035;
        Mon, 13 Jun 2022 12:57:48 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:47 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 12/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Mon, 13 Jun 2022 12:56:55 -0700
Message-Id: <20220613195658.5607-13-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
with device specific chip-select control.  The Elba SoC
provides four chip-selects where the native DW IP supports
two chip-selects.  The Elba DW_SPI instance has two native
CS signals that are always overridden.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/spi/spi-dw-mmio.c | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 5101c4c6017b..6b7a557759bd 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -53,6 +53,24 @@ struct dw_spi_mscc {
 	void __iomem        *spi_mst; /* Not sparx5 */
 };
 
+struct dw_spi_elba {
+	struct regmap *syscon;
+};
+
+/*
+ * Elba SoC does not use ssi, pin override is used for cs 0,1 and
+ * gpios for cs 2,3 as defined in the device tree.
+ *
+ * cs:  |       1               0
+ * bit: |---3-------2-------1-------0
+ *      |  cs1   cs1_ovr   cs0   cs0_ovr
+ */
+#define ELBA_SPICS_REG			0x2468
+#define ELBA_SPICS_SHIFT(cs)		(2 * (cs))
+#define ELBA_SPICS_MASK(cs)		(0x3 << ELBA_SPICS_SHIFT(cs))
+#define ELBA_SPICS_SET(cs, val)	\
+			((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))
+
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
@@ -238,6 +256,53 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 	return 0;
 }
 
+static void dw_spi_elba_override_cs(struct dw_spi_elba *dwselba, int cs, int enable)
+{
+	regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
+			   ELBA_SPICS_SET(cs, enable));
+}
+
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_elba *dwselba = dwsmmio->priv;
+	u8 cs;
+
+	cs = spi->chip_select;
+	if (cs < 2)
+		dw_spi_elba_override_cs(dwselba, spi->chip_select, enable);
+
+	/*
+	 * The DW SPI controller needs a native CS bit selected to start
+	 * the serial engine.
+	 */
+	spi->chip_select = 0;
+	dw_spi_set_cs(spi, enable);
+	spi->chip_select = cs;
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	struct dw_spi_elba *dwselba;
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_compatible("amd,pensando-elba-syscon");
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
+	if (!dwselba)
+		return -ENOMEM;
+	dwselba->syscon = regmap;
+
+	dwsmmio->priv = dwselba;
+	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -352,6 +417,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

