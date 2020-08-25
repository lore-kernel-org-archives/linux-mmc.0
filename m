Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C375BC433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB7B2074D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 08:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eU6bzw/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHYIOM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:14:12 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:10977 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYIOM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 04:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598343251; x=1629879251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g0oeSZlVpkf2Kzf0aWXXwlGNTwXvDpPW9GbL9juy12M=;
  b=eU6bzw/L480AjZueaHDRy+xI0PLXTFsIloiV9KY0I6gObO+Zj/4IEdok
   jKVUClfX799xuA3zoIBJWUBd884rH9Q4odWcTpfybBajDbflA3LKlLXEf
   K50SA2BstfhDuXOC01qOCTHoUJTPlQ+dUptLXEQYWLAw5xiseNAtUMj9U
   /6747HrvFpUHzwXSrefimG/QKw57wERU8W4H6TxaBjq6qfl+mfZDxpuZH
   GKqlhisggP0bchccOdA6LPZ891GEnftBxNY7O7D2r4uF/A4LfgWywRviP
   urcDlzUAeD2BH66fWUPg0kFcxfCrz3VACXiqVONU8uccmENZ8L0PmSG2Q
   Q==;
IronPort-SDR: /wZRFZLMaC+FjjwakJmXc7gnUIOu6foIdLH8Cp825Cq/gPdvA98qu5moD2NNYiQzpp3w6tX0GN
 VS0U7j05HD+k9rfXdYWnfK+AIpca/dmjnDuQPWkc8r4eZK7cuFzkNuqY+Jr4pWiKNY+ePMp28/
 rdph1RlRy0fi2fn70mFrYroAB1gOPIw59ZpAbhblYirvohScFia4oNxfz4JKxrI0Q8i6UOXOdS
 eGnte/DjDGrUfd9vGguVA0CdJGVkYzMnrZnfhfCYDdxlTip/h5fB7YletARsvCxyzEYFQ5TZ+0
 MAk=
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="86802294"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2020 01:14:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 01:14:05 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 25 Aug 2020 01:13:23 -0700
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
Subject: [PATCH v5 0/3] mmc: Adding support for Microchip Sparx5 SoC
Date:   Tue, 25 Aug 2020 10:13:54 +0200
Message-ID: <20200825081357.32354-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The patch adds eMMC support for Sparx5, by adding a driver for the SoC
SDHCI controller, DT configuration and DT binding documentation.

Changes in v5:
- DT+yaml: Change (mmc|sdhci)@600800000 to mmc0@600800000
- Add missing "static" attribute to probe function
- Drop MMC_SDHCI_IO_ACCESSORS, as it is not required (anymore)

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
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-sparx5.c            | 269 ++++++++++++++++++
 8 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c

-- 
2.27.0

