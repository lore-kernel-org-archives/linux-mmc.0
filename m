Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142DC4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69D761B48
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhHPI6K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 04:58:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48652 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhHPI6J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 04:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629104258; x=1660640258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kDfDdf720Lw4cE03NwUXgTqylizJCbBg1dQhcEVXHd4=;
  b=JUZPrPM4yGQE6S1Dr4b3T9nyavnTy2TduC365TT5cb/TLo6yBlDeQy3U
   f7nzeCzKzRHhyaaVRP8Fo9MutrVzQ3AyMNTjydHoUCIxIUzENrPiDWJsT
   uJXZOzhmj35Pz4q3D2AlEGj3/79XUBWRaf6qLAFN3PMzub8YhK+693OZ5
   PQAGb1EhNS2YhGPmonGs8EfrI1Bl80vzmJROCG3LEzsqKGgKrHgrZL05p
   oanFLlTOk2XDHphzZnLPQtzGxqq8uDft+He2y+ef14fBd0dvjG5h4zKU9
   flRcO8s4FxwNXFDnazSEp+6ZNiuKSNb1SUilr0Kt5PTBPOYrr0i9Ophwp
   g==;
IronPort-SDR: WWI1Uyx6+4+coBKi80K2oNe/PNI/mOuWyCriBFo27YSNg8M4IHR8Z0yv6at47sm44Nfc0/pd/6
 Jah9ZbPMVQdPLzx42BGo107Yeds/u5iev0wN9rN2R9S4O+PI249u3ZLodM1kgaR3mf/5JAEoRn
 VzkAxZnK/iZIyUgvEd0v962ETp5Gu2KIFxvOeTPplqW6s4rqF0LuW3Thk9uSAlw2j+4YAAI5wx
 TBoSWTjpwMEyEUIznZ5RByxwETw6/QnJ+r5qZOG1ja2PKxY9XblqYIdMFsH5jynyN8tyH/AnA8
 +fRLbDjt3fywo2DOIJD/482P
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="125916694"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2021 01:57:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 Aug 2021 01:57:37 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 Aug 2021 01:57:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/4] mmc: pwrseq: sd8787: add support wilc1000 devices
Date:   Mon, 16 Aug 2021 11:55:26 +0300
Message-ID: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

This series adds support for WILC1000 devices on pwrseq-sd8787 driver.
WILC1000 devices needs a minimum delay of 5ms b/w reset and power lines.
Adapt the sd8787 driver for this by adding a new compatible for WILC1000
devices and specify the delay on .data field of struct of_device_id.

Thank you,
Claudiu Beznea

Changes in v2:
- changed cover letter title (it was: mmc: pwrseq: sd8787: add support
  for selectable)
- use new compatible in pwrseq-sd8787 driver instead of adding a new
  binding for specifying the delay; with this, the patch 1/1 from v1 is
  not necessary
- adapt patch 3/3 from this version with the new compatible

Claudiu Beznea (3):
  dt-bindings: pwrseq-sd8787: add binding for wilc1000
  mmc: pwrseq: sd8787: add support for wilc1000
  mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787

Eugen Hristev (1):
  ARM: dts: at91: sama5d27_wlsom1: add wifi device

 .../bindings/mmc/mmc-pwrseq-sd8787.yaml       |  4 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 71 +++++++++++++++++++
 drivers/mmc/core/Kconfig                      |  2 +-
 drivers/mmc/core/pwrseq_sd8787.c              | 11 ++-
 4 files changed, 84 insertions(+), 4 deletions(-)

-- 
2.25.1

