Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1122C4320A
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2D660E0B
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhHTJbB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:31:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62293 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhHTJbB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 05:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629451824; x=1660987824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nvPVSBB3/HXIc6A8s1TwSP8IKFC5JSli53f2nV415nk=;
  b=WB16cTQf0NwHVlyVUrdTMEiXDhNNwJDWOgumg2FMaciifwRckBP7IJSQ
   HdSclUt4554rq4eyqBmx2LwtKlWTnqmJxC261QFNGi4fzHXc/AlZlPWZA
   8DTYpnDfq6LfCBeCSpHnC42YCZ2SQFVimY99aWwnUH1hzlNyICIVNfmwz
   fMj8T6W1rPHKQEe+uUNsTzzb/jWycVZmvsNrKjFeSS2y2SGUWaYK0Mj+J
   R31ZZV1v08xKruzJQLxiKh2zC2btnYwIjYRLuX5si4tixptxXMt5+9V1h
   +VPy4XPJor7yQrOnkMdy79eP+SVhrCtCqC5+TQv9Nwz+q6UudrjNd8k2U
   g==;
IronPort-SDR: IUbTvMJ/fy72Ol5jFHVaFfqq3Ig1rep97fpMsAyg3EPyoKqPnxlTfWhqd/B2k0q7s1vMTtJBgA
 3HHpr/Zq+iwa7WrWDR+of+zUAOXyYaD2VnTykxvJzGxwfQD+yuj4WnS6vPsuvxUcWsqAaL4CFi
 pgLPZtKC2iLydAiuze1OaZ3FaL+brdP21Vy7FuDNJyQE0D5zaOOV0wi1HnDuzOYjVGrSe1Nfwg
 qLT9VMy2fLOEz9dxjvub6ghm8452ebVBlRas9so+pJyxy6QsLySzCqqMPxvUBQos9HoFObpP7/
 hxUVpzTEME6H8gKKe9fEtAVs
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="128997094"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2021 02:30:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 02:30:22 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 02:30:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/4] mmc: pwrseq: sd8787: add support wilc1000 devices
Date:   Fri, 20 Aug 2021 12:27:59 +0300
Message-ID: <20210820092803.78523-1-claudiu.beznea@microchip.com>
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

Changes in v3:
- fixed dt binding compilation

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

