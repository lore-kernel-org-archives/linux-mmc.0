Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC20C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452A060F4B
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhIVKdi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:33:38 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:6803 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhIVKde (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 06:33:34 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB7vf012562;
        Wed, 22 Sep 2021 18:11:07 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 18:31:25 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <adrian.hunter@intel.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <andrew@aj.id.au>
CC:     <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 00/10] ASPEED SD/eMMC controller clock configuration
Date:   Wed, 22 Sep 2021 18:31:06 +0800
Message-ID: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB7vf012562
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series aims to configure SD and eMMC controllers' clock
frequency and clock phase parameters. The main modification is the
clock phase calculation method which has been checked with the HW IP
designer. Also, the clock source detection method is updated for
AST2600-A2/A3. This patch series has been verified on AST2600-A3 EVB.

Chin-Ting Kuo (10):
  clk: aspeed: ast2600: Porting sdhci clock source
  sdhci: aspeed: Add SDR50 support
  dts: aspeed: ast2600: Support SDR50 for SD device
  mmc: Add invert flag for clock phase signedness
  mmc: aspeed: Adjust delay taps calculation method
  arm: dts: aspeed: Change eMMC device compatible
  arm: dts: aspeed: Adjust clock phase parameter
  arm: dts: ibm: Adjust clock phase parameter
  dt-bindings: mmc: aspeed: Add max-tap-delay property
  dt-bindings: mmc: aspeed: Add a new compatible string

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |   4 +
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts   |   8 ++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      |  11 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  |   3 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  |   3 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   3 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |   2 +-
 drivers/clk/clk-ast2600.c                     |  69 ++++++++--
 drivers/mmc/core/host.c                       |  10 +-
 drivers/mmc/host/sdhci-of-aspeed.c            | 123 ++++++++++++++----
 include/linux/mmc/host.h                      |   2 +
 11 files changed, 193 insertions(+), 45 deletions(-)

-- 
2.17.1

