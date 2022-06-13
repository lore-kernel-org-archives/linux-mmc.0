Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA08BCCA47D
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jun 2022 20:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350687AbiFMUrD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbiFMUqd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2022 16:46:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB9617A98
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t2so5977050pld.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ctYV5CtpweQWwhemRH689WvsToB4VjKXh88G2Mf0xQ=;
        b=KU4bwCyM432Sc7bUoksU95EBphe6ApddgD25OxO1uN7LgceYRVOSvwXLw2SxXYpDIn
         TCv9dD+ytgIhPrt1yUCgwwurS5WM5wy14NAeS5J71F83Blm3Y5S+kDuihn2JaYme1jug
         fSRv+qTWMz3yb6wcvxPz/UBxpUT/kpU4ScKYp1PARfEHAt6khFEBxavh/nXHM/slPzxk
         a4rYIjwN3vk+y328sZiAfBxb5ILwNpASm7Ssx0lQ9q2MxteA08/8G2ipKk91524cU4IL
         EI4kfJ6z2ANrjVhx6PKo0hed6/EEZcGkxE88A514wqlU9PRsciL0rY6her3vWu+e/rIK
         DTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ctYV5CtpweQWwhemRH689WvsToB4VjKXh88G2Mf0xQ=;
        b=D+QZ3RmN2DaN5fANxz7tC8+eqRIXZB4QL/x75wYzX940y4dmTLRlkvff1bwPZBiKU2
         E4z0rXl3kHWYQ3WXzRXngypjPBRX6cet1E6UgdP+K4PiwC/ya00Mz+RB3ZWopQ09nEBr
         YAh0i8u01D3MX3LiPhCw82lCnxGZhQXLVjXbDbNmJfExwAB/pa2B2Dvl7HZAqbZbbvHz
         n1wP2HaSrmc75DXxKaUuLovT61dbMUqFYiAMePnquq7O0AlZt96by8ba117WZqY9OIns
         9k53zwjFCfiPP/Tnb8fdAJZEbV3qNk5qepXCT8HyRDm/JEte28rh+8xRiR0swH86u0TC
         V7bg==
X-Gm-Message-State: AJIora/CT4Aaa0ru8kYvBCBDDg2TM9K80+fUpLxEKGwNRAjrWKJpUShu
        X73+W2x9Z/u+WlFEl//jSP39Yg==
X-Google-Smtp-Source: AGRyM1srdQbNwx41tXUnvYf3A9njwwFcL6cYLU2K1BmNaGiywHkukGrpzW0Jj2DIkNtoJHT5mf0eaQ==
X-Received: by 2002:a17:902:eccc:b0:167:5c6e:31e4 with SMTP id a12-20020a170902eccc00b001675c6e31e4mr753614plh.90.1655150265894;
        Mon, 13 Jun 2022 12:57:45 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:45 -0700 (PDT)
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
Subject: [PATCH v5 11/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 13 Jun 2022 12:56:54 -0700
Message-Id: <20220613195658.5607-12-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

The AMD Pensando Elba SoC has the Cadence QSPI controller integrated.

The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
a dummy readback from the controller is performed to ensure
synchronization.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72b1a5a2298c..ebb77ea8e6ba 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -39,6 +39,7 @@
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(4)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -87,6 +88,7 @@ struct cqspi_st {
 	bool			use_dma_read;
 	u32			pd_dev_id;
 	bool			wr_completion;
+	bool			apb_ahb_hazard;
 };
 
 struct cqspi_driver_platdata {
@@ -952,6 +954,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->wr_delay)
 		ndelay(cqspi->wr_delay);
 
+	/*
+	 * If a hazard exists between the APB and AHB interfaces, perform a
+	 * dummy readback from the controller to ensure synchronization.
+	 */
+	if (cqspi->apb_ahb_hazard)
+		(void)readl(reg_base + CQSPI_REG_INDIRECTWR);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1667,6 +1676,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->use_dma_read = true;
 		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
 			cqspi->wr_completion = false;
+		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
+			cqspi->apb_ahb_hazard = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1789,6 +1800,10 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
+static const struct cqspi_driver_platdata pen_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1814,6 +1829,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,socfpga-qspi",
 		.data = &socfpga_qspi,
 	},
+	{
+		.compatible = "amd,pensando-elba-qspi",
+		.data = &pen_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

