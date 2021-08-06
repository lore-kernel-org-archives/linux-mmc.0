Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E6C4320A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CF761050
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245447AbhHFLcm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:32:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12975 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbhHFLcm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 07:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628249546; x=1659785546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wSpr+L4PIq3lQzJXLHeaZmPWIk0/f3gyHFGgEdPg5/Y=;
  b=IOIZDQiseJVwGHMZaIPH0e7AVlk5YzCjCZqjktTczSj20Hz/5m21QfXo
   IZX1NXcQhdkXwRvSQLvkJ9vFex+ojjGclcZIU0HZAulN8EQqpE6u7okcH
   0w1kiuGcj00nHKEx/byw4Aci2cxpQp4rhZLHgHcUbH7ygPA4hNwglC8c8
   tkMW4Rr05dq/x8J/XNR3kddrbPIHIMWiH564iVEn4FFshNy7pZe7Yj7R6
   nHcpJms94gIaKUvq9ZUpcgNko7DinT/0OLydKcIkBh5wxiKcztyWHp+52
   x5MIpRWXVC6aiG+2RbshMmfiDn/eE0Z8LKuQ78m4TyQSib0Xpi+oeJB1i
   g==;
IronPort-SDR: u7gg7AsWTliVvdBXg4HISKZ7kvUo3VT5GHrnvX0Sq76blAkzCiUa+Fh7o5Dws6QtHn8jPWKIkt
 rr+X13V0CWWG1Tz3xMq/0Pfug6Mj8XHGL33hdCJHslySJ3DeKYg9dcbTIUNIeixy0d8QVuxRyy
 ztm9zTUC7+9yvNVaMrpOc5LvQVcRvkysdb6qUIcFpGMFz1LaRrIr8oUmx3opRaEFnL0GbS6ZiM
 3Fh2ybfnKAZ+9XwflvX2c2ERtEhTuu/yYOid7FRUE1RLVqHM999LEnFt0SXvNnRKZ9BpdPH51V
 1qYMj5AIAGUAk4k13qzriQto
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="127352541"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2021 04:32:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 04:32:25 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 6 Aug 2021 04:32:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/4] mmc: pwrseq: sd8787: add support for selectable
Date:   Fri, 6 Aug 2021 14:29:57 +0300
Message-ID: <20210806113001.821660-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

This series adds support for selecting the delay b/w reset and power
lines on pwrseq-sd8787. With this the driver could also be used by
other devices (e.g. WILC1000/WILC3000 which needs a delay of 5ms). Along
with this added the DT bindings for WILC3000 device present on
SAMA5D27 WLSOM1 board.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  dt-bindings: mmc: pwrseq-sd8787: add binding for delay b/w reset and
    power
  mmc: pwrseq: sd8787: add support for specifying the delay b/w power
    and reset
  mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787

Eugen Hristev (1):
  ARM: dts: at91: sama5d27_wlsom1: add wifi device

 .../bindings/mmc/mmc-pwrseq-sd8787.yaml       |  4 ++
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 72 +++++++++++++++++++
 drivers/mmc/core/Kconfig                      |  2 +-
 drivers/mmc/core/pwrseq_sd8787.c              | 11 ++-
 4 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.25.1

