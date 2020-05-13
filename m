Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88553C2D0FC
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C243207BB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 13:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="scf8V5ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgEMNbg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 09:31:36 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:59452 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgEMNbg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2020 09:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589376696; x=1620912696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t4aCbU2kHB3bhhe/yGQIKD1b0a2xuEV7ZDV6usSs6jg=;
  b=scf8V5lnIxQqpR5p4kT4/gU8Gxowx9AZ5/Gg7LYsYqwHoJwzbQ68gerR
   Npw6dHkIzDaPfuaCHbLsnyEgenbqE23oi28es23WnYZ6uxdPCMg+frDKe
   eIh7Di8HCJRZmNWHohArH3HffBOlvNo1iKIRRWzThbAn0begCOI7AHKd3
   n1krZ1DZAuVUyagXeXvpUVnZ+LeI1Uzhpvy594A3eh9z+C7EddIb+Di4U
   7QTvOXdLQiWRV/NTR8is9iGZ6WUf6ue4pthe/oNzuIcpNZ/+3aqgwr6w9
   02vnlVGLlgrr7rdRQ3N+3C57g4D8Am5XcI3rt60y/nJlQWKF4kDle8omD
   Q==;
IronPort-SDR: bUWPzFdWKX2/k51R9GST6UyKSuQiwjQpNUP4sqAL0kaIvI/PVupWW5wInfBl3DCG/OalO0JfXs
 xplVwZwEwkQsQKeqND3sE0Gzq9C8M6o2QgCm4wNj36JW/bDwvDJLifefNkpBRrnszpXEtmrS53
 upstPfDAcPqWqFlxCHwC2ma66TRhknZvnmdzHQOQvw1YTFywC8rFsOri6R/cUs+ghKQSXUduVU
 MrrUW+Qd2MO1823QRxdvuzSfpo4IgMuQSGtFcV4RImTP3doQjndbb5j0ZcI6WTH6ZQtehDatRs
 evg=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="75770577"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:31:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:31:35 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:31:33 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] mmc: Adding support for Microchip Sparx5 SoC
Date:   Wed, 13 May 2020 15:31:19 +0200
Message-ID: <20200513133122.25121-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).

It adds eMMC support for Sparx5, by adding a driver for the SoC SDHCI
controller, DT configuration and DT binding documentation.

Lars Povlsen (3):
  dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
  sdhci: sparx5: Add Sparx5 SoC eMMC driver
  arm64: dts: sparx5: Add Sparx5 eMMC support

 .../mmc/microchip,dw-sparx5-sdhci.yaml        |  57 +++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  24 ++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  23 ++
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts |  23 ++
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts |  23 ++
 drivers/mmc/host/Kconfig                      |  13 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-sparx5.c            | 348 ++++++++++++++++++
 8 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c

--
2.26.2
