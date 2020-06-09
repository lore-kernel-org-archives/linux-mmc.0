Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF435C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F38207ED
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s+wfFT6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgFIKUh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:20:37 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36372 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgFIKUf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 06:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591698036; x=1623234036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jog8U1hg1Jb0yOPntlrXCpHzhFdDi4nx+A8hEzkfpIc=;
  b=s+wfFT6T4QWxS5bq8yxTT0Co2z5aDLAunK4vm3qRizlZQ4rqyafhZboy
   cwa+yQ/lu1ZlnEKSlcAR7JYxejO1Q8NlvD6mxABrwjesJnIdwXFfBSM2+
   IZNX6c0zI7M3ikx3UGLQAWQUIY59PjmlSkPX/f6/dUi86b4D+vebxXjWc
   CZa6Z+34+AnT9vQGWA8katR00yWcP7TXgYEHLa2keMHF2XLfQikaNYF9f
   l1g0wab5Kugc2S1TUBKlRAD/ZA0P7sEgEJsBRvxfz4v+ynt8VewMTh9yA
   r2UmAsgYVcR45HvKw8cejm0VVY88yj2fxs80Uj917Q1S+S9UU147kxgcD
   Q==;
IronPort-SDR: GsUomaDlsyMFGql6N5vKCKqggAS8YTeM8rMEysweN7jreEtYgmsUT9SR7LCgT5iWJHn6yq+KBr
 JcYdSIakI6+vBex31IJhOeiKfHKihHDKm5ZCOwUH9fhXnWy/KxRxYbqgxwXcGeAWeTj3Y+odJK
 WRJUbXsCdmC398dPnffw8iYmYxC69HKWzjaaP1porxdM6EcDPHCYk+l9UA4wNtGvaF0mszvqg1
 LF4sySzldi0r2v3DJPvEH+Uwo+SxpKpKRZ/BwGM8uILdf+uSuYToyvvj9qTX+bn1nswG3MFKYk
 6/g=
X-IronPort-AV: E=Sophos;i="5.73,491,1583218800"; 
   d="scan'208";a="78723000"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 03:20:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 03:20:34 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 9 Jun 2020 03:20:32 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] mmc: Adding support for Microchip Sparx5 SoC
Date:   Tue, 9 Jun 2020 12:20:05 +0200
Message-ID: <20200609102008.10530-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200608123024.5330-1-lars.povlsen@microchip.com>)

It adds eMMC support for Sparx5, by adding a driver for the SoC SDHCI
controller, DT configuration and DT binding documentation.

Changes in v2:
- Changes in driver as per review comments
 - Drop debug code
 - Drop sysfs code
 - Minor cosmetics

Lars Povlsen (3):
  dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
  sdhci: sparx5: Add Sparx5 SoC eMMC driver
  arm64: dts: sparx5: Add Sparx5 eMMC support

 .../mmc/microchip,dw-sparx5-sdhci.yaml        |  57 ++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  24 ++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  23 ++
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts |  23 ++
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts |  23 ++
 drivers/mmc/host/Kconfig                      |  13 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-sparx5.c            | 274 ++++++++++++++++++
 8 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c

--
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
