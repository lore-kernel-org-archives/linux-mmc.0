Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59080C43460
	for <linux-mmc@archiver.kernel.org>; Thu, 13 May 2021 06:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FCC61433
	for <linux-mmc@archiver.kernel.org>; Thu, 13 May 2021 06:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhEMGrg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 May 2021 02:47:36 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:51266 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGrf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 May 2021 02:47:35 -0400
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 87E12C8699;
        Thu, 13 May 2021 14:46:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22004T139994226214656S1620888367858788_;
        Thu, 13 May 2021 14:46:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <33e9ab100598d444a69fb444c920c885>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 30
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jagan@amarulasolutions.com, wens@csie.org,
        uwe@kleine-koenig.org, mail@david-bauer.net, jbx6244@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        cl@rock-chips.com, wim@linux-watchdog.org, linux@roeck-us.net,
        jamie@jamieiles.com, linux-watchdog@vger.kernel.org, maz@kernel.org
Subject: [RESEND PATCH v4 06/10] dt-bindings: gpio: change items restriction of clock for rockchip,gpio-bank
Date:   Thu, 13 May 2021 14:46:06 +0800
Message-Id: <20210513064606.18397-1-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081151.17558-1-cl@rock-chips.com>
References: <20210429081151.17558-1-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

The clock property need 2 items on some rockchip chips.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index d993e00..0d62c28 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -22,7 +22,10 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: APB interface clock source
+      - description: GPIO debounce reference clock source
 
   gpio-controller: true
 
-- 
2.7.4



