Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D14C43219
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4677360F4B
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhIVKdl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:33:41 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:57747 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhIVKdi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 06:33:38 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB8xY012565;
        Wed, 22 Sep 2021 18:11:08 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 18:31:26 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <adrian.hunter@intel.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <andrew@aj.id.au>
CC:     <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 03/10] dts: aspeed: ast2600: Support SDR50 for SD device
Date:   Wed, 22 Sep 2021 18:31:09 +0800
Message-ID: <20210922103116.30652-4-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB8xY012565
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The maximum frequency for SD controller on AST2600 EVB is
100MHz. In order to achieve 100MHz, sd-uhs-sdr50 property
should be added and the driver will set the SDR50 supported
bit in capability 2 register during probing stage.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index b7eb552640cb..4551dba499c2 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -280,6 +280,7 @@
 &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	sdhci-drive-type = /bits/ 8 <3>;
 	sdhci-caps-mask = <0x7 0x0>;
@@ -292,6 +293,7 @@
 &sdhci1 {
 	status = "okay";
 	bus-width = <4>;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	sdhci-drive-type = /bits/ 8 <3>;
 	sdhci-caps-mask = <0x7 0x0>;
-- 
2.17.1

