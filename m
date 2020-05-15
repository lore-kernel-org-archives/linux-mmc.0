Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D6C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F477207C3
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEOPJK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 11:09:10 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:21397 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726219AbgEOPJK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 11:09:10 -0400
X-IronPort-AV: E=Sophos;i="5.73,395,1583161200"; 
   d="scan'208";a="47188317"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 May 2020 00:09:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AC0BB400D4CD;
        Sat, 16 May 2020 00:09:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 00/17] RZ/G1H describe I2C, IIC, MMC0, SATA, AVB, RWDT and APMU nodes
Date:   Fri, 15 May 2020 16:08:40 +0100
Message-Id: <1589555337-5498-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

This patch series describes i2c, iic, mmc0, sdhi, sata, AVB, apmu and
RWDT on R8A7742 SoC.

Cheers,
Prabhakar

Lad Prabhakar (17):
  dt-bindings: i2c: renesas,i2c: Document r8a7742 support
  dt-bindings: i2c: renesas,iic: Document r8a7742 support
  ARM: dts: r8a7742: Add I2C and IIC support
  dt-bindings: mmc: renesas,sdhi: Document r8a7742 support
  mmc: renesas_sdhi_sys_dmac: Add support for r8a7742 SoC
  ARM: dts: r8a7742: Add SDHI nodes
  ARM: dts: r8a7742: Add MMC0 node
  dt-bindings: ata: renesas,rcar-sata: Add r8a7742 support
  ARM: dts: r8a7742: Add sata nodes
  dt-bindings: net: renesas,ravb: Add support for r8a7742 SoC
  dt-bindings: net: renesas,ether: Document R8A7742 SoC
  ARM: dts: r8a7742: Add Ethernet AVB support
  ARM: dts: r8a7742: Add Ether support
  dt-bindings: power: renesas,apmu: Document r8a7742 support
  ARM: dts: r8a7742: Add APMU nodes
  dt-bindings: watchdog: renesas,wdt: Document r8a7742 support
  ARM: dts: r8a7742: Add RWDT node

 .../devicetree/bindings/ata/renesas,rcar-sata.yaml |   1 +
 .../devicetree/bindings/i2c/renesas,i2c.txt        |   1 +
 .../devicetree/bindings/i2c/renesas,iic.txt        |   1 +
 .../devicetree/bindings/mmc/renesas,sdhi.txt       |   1 +
 .../devicetree/bindings/net/renesas,ether.yaml     |   1 +
 .../devicetree/bindings/net/renesas,ravb.txt       |   1 +
 .../devicetree/bindings/power/renesas,apmu.yaml    |   1 +
 .../devicetree/bindings/watchdog/renesas,wdt.txt   |   1 +
 arch/arm/boot/dts/r8a7742.dtsi                     | 270 +++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   1 +
 10 files changed, 279 insertions(+)

-- 
2.7.4

