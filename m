Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B5CC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 15:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118352177B
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lE/eGTLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHXPLF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:11:05 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35255 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgHXPKw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 11:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598281851; x=1629817851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t4cBW0KJQ9oAF55ARnk4BDNoEvlWUJYtIpys/EI51Sk=;
  b=lE/eGTLPwFEif79xf1Z7tXMMpPgRo5Oi4BNWgrRdtledyr6S1Yt+Bg9t
   kW0PK4HED5QTL0BJ/18Et9AmuoXXOCFNQ785uGfJx3RxAHfxflxxDygz6
   nUCCFj/TMZSlWgRjCuEXBSmRWQzKeYejBfu9go1YaE8RafH22LGNzVxTF
   qIulAf81X+nNHipU61IJKbRIrz+9RfY4J/BWJ7v55U9yZdeHG3Oop38MG
   iPG0Uqm+CWca00XWvQZDgmT0Nu6QQoDaFnbaZ72MD4RguyOm8zjQbkCcs
   M4RIZG79XbKgnKRIfdJNCMK1NADv8iySnLbVdjenWLP2ED+gTw1b2fUof
   g==;
IronPort-SDR: CmC1ij+6/53nmSXaamACFN8afuFA/IfnsSnlrU2LnWEc8NDuLI5yZndWLtG05i5hGusMZjmBVR
 4qNEhEfNNSVCZ3TT7lRgyeKwsZT18f0b9IH4YMrsX/5hP8tr3Uw39qoJcutJtr9KzXfxjFsFjQ
 hdXRF7xYun1ohCnkKmGv/6Aod217wafBLHeU7z5mQTPzmvN5Jd99jUSxSvsu4FOBNcmH0AAtNC
 m2APQ6MARLNgG54zTSGm3s4DrFrGoA1x5n3agrHpj9P5yoCq+a7JRvvjdSnjdIgUk2MfljIjVz
 9C0=
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="92912510"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 08:10:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 08:10:10 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 08:10:40 -0700
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
Date:   Mon, 24 Aug 2020 17:10:32 +0200
Message-ID: <20200824151035.31093-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

(This is a resend of an identical patch set, sent at a time where
Sparx5 support was not integrated yet. With the Sparx5 clock driver
and associated header now in place in the v5.9rc series, the driver is
now resubmitted for inclusion).

The patch adds eMMC support for Sparx5, by adding a driver for the SoC
SDHCI controller, DT configuration and DT binding documentation.

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
