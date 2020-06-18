Return-Path: <SRS0=gCHa=77=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E99C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Jun 2020 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241092083B
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Jun 2020 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AuGN0BOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgFRONm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:13:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53734 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgFRONl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2020 10:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592489621; x=1624025621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qaISx7kIwjmQW7aDNabN0pTA9+hEP2G3tl7DISJo728=;
  b=AuGN0BOqidAlr6vjtTbEFzzLwuUotrHbTqosO7VQTHomX3oApgis+p+m
   h/71UlNGmkQMLRmgoM8mlkkFBA1vTkEWx4m4Fw8+z2keeYP/UTLDL/xZG
   HRpayoX0t2c/ibaj7yMcpRsFo8p4xgy/R/jdKTwvdWCDIlGm2fjWnlypm
   mqwa4klGObkemVf3CNuTGhnUylMX1y5pqdQp9D+RaAqH+D79xbgx5gRzM
   1iuvBsb2QwG46/+r9WK4lUN2tjsCee5naG4EapmQSVi7Ue2ASOYwnmmxS
   EVRyCWizb1QSLHXVXMPMgl2N1DT+Q/HFDzW40gUCEW1xOzudAJ0qLB35b
   g==;
IronPort-SDR: sEbG+n7Y5rb+0x5y9CdXAzEWIdWjG5Kma7Ynmj+Zj2Qu/3OMszzWTPCAqqs+E8WTvCRW/mqsJj
 3vHrK5iA/79+6/evapQR0z6lceHxts0aQJOcwYCwnO721lpEFaCNgG6FemyVlLw0yUf2Gu2Ha8
 V7VQgFxE4buHu2moCLZUrhfaswWwZ9gI7iuox+ju/+BpoEByh0+KUUwv+GyX8IU2wqc1X+mOJ7
 kw5geagDknZPZxMjAXy4urmVs8eEc0HulzPp8gr5wTDTA6wq8CbC9hsrjqNymps5V3bfsHmLEn
 7ms=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="78953791"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 07:13:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 07:13:33 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 07:13:31 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 0/3] mmc: Adding support for Microchip Sparx5 SoC
Date:   Thu, 18 Jun 2020 16:13:23 +0200
Message-ID: <20200618141326.25723-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200615133242.24911-1-lars.povlsen@microchip.com>

It adds eMMC support for Sparx5, by adding a driver for the SoC SDHCI
controller, DT configuration and DT binding documentation.

Changes in v4:
- Disable clock if sdhci_add_host() fails
- Remove dev_err if sdhci_add_host() fails

Changes in v3:
- Add dt-bindings for property "microchip,clock-delay"
- Enforce "microchip,clock-delay" valid range in driver
- Removed a noisy pr_debug() in sdhci_sparx5_adma_write_desc()

Changes in v2:
- Changes in driver as per review comments
 - Drop debug code
 - Drop sysfs code
 - use usleep_range()
 - use mmc_hostname() in pr_debug()
 - Remove deactivated code
 - Minor cosmetics

Lars Povlsen (3):
  dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
  sdhci: sparx5: Add Sparx5 SoC eMMC driver
  arm64: dts: sparx5: Add Sparx5 eMMC support

 .../mmc/microchip,dw-sparx5-sdhci.yaml        |  65 +++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  24 ++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  23 ++
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts |  23 ++
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts |  23 ++
 drivers/mmc/host/Kconfig                      |  13 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-sparx5.c            | 269 ++++++++++++++++++
 8 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c

--
2.27.0
