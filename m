Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CACDC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69414207C3
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x+ENPzML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgFPOAe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:00:34 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:46763 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPOAe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 10:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592316034; x=1623852034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=unQ0smonLVJdukLZdKp67AJLTTij5kY3nS4sy5MJHsY=;
  b=x+ENPzMLtnQyqMWtu8KZVLE2hHJ+NmLbOuZ4nr/Ld0qS2W1ToxAJPS5f
   qnsJTZXdkrzHgmWVSceIZIXXU8M3IvkExg0exy53A7G+doRtjn+6D9oCs
   xnQCcadIyxtbjbO6oPHl1vKphjY/9YaDh5FRMPjMyYt98iRnKGhEn8SWE
   1s6K1bKEwrgATbjCI7wkhiRcoOyA+fXbDo+CwBn7l3xDO/dmraF9c9vJM
   LLCDe489LSOKyzSfnf4nSBHPpsQcqCaFGRbjLSSe/GZMS1nX8Kpih/o4L
   8QUnMkHJfIa7zL0wfA/eVeAiB3/6wOTnWgPxKCismbzhWkIsoUhHr2sdl
   Q==;
IronPort-SDR: YS7CfaPxcZ7Eqli+xu8y6DhdDKr/sFi6fKYNs7GCDf/f/ArlySlb6tgXpUTH0LMNdPtH1LN6rr
 ZcR8Z1QXNnbS8VAgRP/CUdO+GpPDUk5E7bD/+FXDwaaDeyos8UFc5OJWyfq+3AFwvUeAIVbRyT
 jQT1/BwXzj120JPWUZhvZi2E5uybmrVP0KQb9fjPIuUAA3nWekIlUdR+D4esATpchRcv0vDdJV
 TB/OpHL+Nq+ssG4wNpc2bqWSiQjUFQ8jtJumesalNdZzmcjJbdAm1SoE8gFQyD8Ux/q+YqU82u
 hZc=
X-IronPort-AV: E=Sophos;i="5.73,518,1583218800"; 
   d="scan'208";a="79657991"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2020 07:00:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 07:00:33 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 16 Jun 2020 07:00:26 -0700
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
Subject: [PATCH v3 0/3] mmc: Adding support for Microchip Sparx5 SoC
Date:   Tue, 16 Jun 2020 16:00:24 +0200
Message-ID: <20200616140027.4949-1-lars.povlsen@microchip.com>
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

