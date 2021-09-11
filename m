Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58ECC4167D
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Sep 2021 23:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9358360F6C
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Sep 2021 23:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhIKX3V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Sep 2021 19:29:21 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:56414 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhIKX3T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 11 Sep 2021 19:29:19 -0400
Received: from localhost.localdomain (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E6DFBCAEE1;
        Sat, 11 Sep 2021 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1631402884; bh=2tvFqXjEPhPNQYHxs6e45wDYmoat6mfrI4VT1v+Fbq4=;
        h=From:To:Cc:Subject:Date;
        b=af4pmIJTCZsYQ/unBvYzU3WITct/0hjJ5iDudyrrrM5SRbroHnixXkAwiJER+ytXu
         EzapLTG3XBVD78j+UaSXvzoeYuQzYxV+k7UdN17jRK2n9AxHCcX5BwrqBo/+IJplKT
         TiBlz8yRHFBS7UUoC61J8tckGagrw5+K9/Zy0hA8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, bartosz.dudziak@snejp.pl,
        Luca Weiss <luca@z3ntu.xyz>, Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 0/8] Initial LG G Watch R support
Date:   Sun, 12 Sep 2021 01:26:54 +0200
Message-Id: <20210911232707.259615-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for more msm8226 hardware and the LG G Watch R smartwatch which
is based on apq8026.

Luca Weiss (8):
  pinctrl: qcom: msm8226: fill in more functions
  dt-bindings: mmc: sdhci-msm: Add compatible string for msm8226
  dt-bindings: firmware: scm: Add compatible for msm8226
  ARM: dts: qcom: msm8226: Add more SoC bits
  ARM: dts: qcom: Add pm8226 PMIC
  dt-bindings: vendor-prefixes: add LG Electronics
  dt-bindings: arm: qcom: Document APQ8026 SoC binding
  ARM: dts: qcom: Add support for LG G Watch R

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 .../devicetree/bindings/firmware/qcom,scm.txt |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt     |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/qcom-apq8026-lge-lenok.dts  | 237 ++++++++++++++++
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 263 +++++++++++++++++-
 arch/arm/boot/dts/qcom-pm8226.dtsi            |  27 ++
 drivers/pinctrl/qcom/pinctrl-msm8226.c        |  74 +++--
 9 files changed, 582 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-lge-lenok.dts
 create mode 100644 arch/arm/boot/dts/qcom-pm8226.dtsi

-- 
2.33.0

