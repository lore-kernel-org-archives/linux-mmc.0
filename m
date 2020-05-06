Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61988C4725A
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F620870
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 19:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgEFTvw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 15:51:52 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:51023 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgEFTvw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 15:51:52 -0400
X-IronPort-AV: E=Sophos;i="5.73,360,1583161200"; 
   d="scan'208";a="46431211"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 May 2020 04:51:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6DF984003EC8;
        Thu,  7 May 2020 04:51:46 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/9] RZ/G1H describe IRQC, [H]SCIF{A|B} and GPIO nodes
Date:   Wed,  6 May 2020 20:51:26 +0100
Message-Id: <1588794695-27852-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

This patch series describes irqc, serial and gpio controllers on
R8A7742 SoC.

* Patch 1/9 is from series [1], which added initial basic support for
  iW-RainboW-G21D-Qseven development board.
* Patches 2-9 are from series [2] ("Add R8A7742/RZG1H board support")

Cheers,
Prabhakar

[1] https://lkml.org/lkml/2020/5/3/294
[2] https://lkml.org/lkml/2020/4/29/1300

Lad Prabhakar (9):
  dt-bindings: mmc: renesas,mmcif: Document r8a7742 DT bindings
  dt-bindings: irqchip: renesas-irqc: Document r8a7742 bindings
  ARM: dts: r8a7742: Add IRQC support
  dt-bindings: serial: renesas,scif: Document r8a7742 bindings
  dt-bindings: serial: renesas,scifb: Document r8a7742 bindings
  dt-bindings: serial: renesas,hscif: Document r8a7742 bindings
  ARM: dts: r8a7742: Add [H]SCIF{A|B} support
  dt-bindings: gpio: renesas,gpio-rcar: Add r8a7742 (RZ/G1H) support
  ARM: dts: r8a7742: Add GPIO nodes

 .../bindings/gpio/renesas,gpio-rcar.txt       |   1 +
 .../interrupt-controller/renesas,irqc.yaml    |   1 +
 .../devicetree/bindings/mmc/renesas,mmcif.txt |   5 +-
 .../bindings/serial/renesas,hscif.yaml        |   1 +
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../bindings/serial/renesas,scifb.yaml        |   1 +
 arch/arm/boot/dts/r8a7742.dtsi                | 259 ++++++++++++++++++
 7 files changed, 267 insertions(+), 2 deletions(-)

-- 
2.17.1

