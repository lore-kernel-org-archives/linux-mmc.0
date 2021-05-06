Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D98C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 10:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE38611AC
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 10:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhEFKI2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 06:08:28 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:16570 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhEFKI0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 06:08:26 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1469pPg0024628;
        Thu, 6 May 2021 17:51:25 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 May
 2021 18:03:12 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v3 0/5] mmc: sdhci-of-aspeed: Support toggling SD bus signal
Date:   Thu, 6 May 2021 18:03:07 +0800
Message-ID: <20210506100312.1638-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1469pPg0024628
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

AST2600-A2 EVB has the reference design for enabling SD bus
power and toggling SD bus signal voltage between 3.3v and 1.8v by
GPIO regulators.
This patch series provides the example for enabling regulators and
supporting SDR104 mode on AST2600-A2 EVB.
The description of the reference design of AST2600-A2 EVB is added
in the dts file.

This patch also include a helper for updating AST2600 sdhci capability
registers, and assert/deassert the reset signal for cleaning up AST2600
eMMC controller before eMMC is probed.

Changes from v2:
* Move the comment of the reference design from dt-bindings to device tree.
* Add clk-phase binding for eMMC controller.
* Reimplement aspeed_sdc_set_slot_capability().
* Separate the implementation of eMMC reset to another patch file.
* Fix yaml document error per the report of dt_binding_check and
  dtbs_check.

Changes from v1:
* Add the device tree example for AST2600 A2 EVB in dt-bindings
  document
* Add timing-phase for eMMC controller.
* Remove power-gpio and power-switch-gpio from sdhci driver, they should
  be handled by regulator.
* Add a helper to update capability registers in the driver.
* Sync sdhci settings from device tree to SoC capability registers.
* Sync timing-phase from device tree to SoC Clock Phase Control
  register

Please help to review.

Regards,
Steven

Steven Lee (5):
  dt-bindings: mmc: sdhci-of-aspeed: Add an example for AST2600-A2 EVB
  ARM: dts: aspeed: ast2600evb: Add comment for gpio regulator of sdhci
  ARM: dts: aspeed: ast2600evb: Add phase correction for emmc
    controller.
  mmc: sdhci-of-aspeed: Add a helper for updating capability register.
  mmc: sdhci-of-aspeed: Assert/Deassert reset signal before probing eMMC

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 101 ++++++++++++++++-
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      |  18 ++-
 drivers/mmc/host/sdhci-of-aspeed.c            | 106 ++++++++++++++++--
 3 files changed, 211 insertions(+), 14 deletions(-)

-- 
2.17.1

