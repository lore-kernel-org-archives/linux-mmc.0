Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E38C43462
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Apr 2021 02:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D525C6113A
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Apr 2021 02:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhDHCYN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Apr 2021 22:24:13 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:21368 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhDHCYN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Apr 2021 22:24:13 -0400
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 1381hd4D042165;
        Thu, 8 Apr 2021 09:43:39 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1381gIZX042076;
        Thu, 8 Apr 2021 09:42:18 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 09:52:22 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <ryan_chen@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v1 0/2] mmc: sdhci-of-aspeed: Support toggling SD bus signal
Date:   Thu, 8 Apr 2021 09:52:16 +0800
Message-ID: <20210408015218.20560-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1381gIZX042076
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This series implements support for toggling SD bus signal voltage by
GPIO pin.

This series has been tested on AST2600-A2 EVB with APLL and 200MHz HCLK
clock source with sdr104, sdr50, sdr25, sdr12 and high speed mode. 
This series were also be tested on AST2600-A1 EVB and AST2500 EVB that
don't have the design of signal voltage toggling by GPIO.

Please help to review.

Regards,
Steven

Steven Lee (2):
  dt-bindings: mmc: sdhci-of-aspeed: Add power-gpio and
    power-switch-gpio
  mmc: sdhci-of-aspeed: Support toggling SD bus signal voltage by GPIO

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |  25 +++
 drivers/mmc/host/sdhci-of-aspeed.c            | 155 ++++++++++++++++--
 2 files changed, 162 insertions(+), 18 deletions(-)

-- 
2.17.1

