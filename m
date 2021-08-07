Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB0DC41537
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24AAA60F38
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhHGLHq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:46 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhHGLHp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:45 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5FxN-1nB8Kg3CeT-01196G; Sat, 07 Aug 2021 13:07:11 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 07/10] dt-bindings: arm: bcm2835: Add Raspberry Pi Compute Module 4
Date:   Sat,  7 Aug 2021 13:06:38 +0200
Message-Id: <1628334401-6577-8-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:cpT888lEhfDA5tu7NBafHh9QaEcmTrj4OEGSxUnl0wGK9NNEDvt
 VhxRJINhtPwXZk/1Kmo6ppb+5G6oWHJnDoMFjMN5+LJxeEXbKA77Sq1Xh4UShemIWXsaS+G
 H2IH+Ak+qjVCpGUTzU8mCm3RGbvGNv0GjLWj7sc4jqwfAHpNsDTiPZx9GLfCgNMi8rcYbAq
 f0GSAKbQVrArRK3Wt6WTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BiNKgemfDKg=:OU8IGaX1tnIOAXVP96H0CI
 YHmE+EYajk2IGMXF554em+izGCW0ChDDEIzLHwbR0WDgHUv5U2X8oCaHBk1WD+hzwzOxn7PBe
 bdLpvR3USR4ejATZh25qN0U1zJ99oQUkQNjXrIZ2LAvekUNxr6ohkF+3RnDe8qrRuPBfz9pRD
 xSXu4yXSZuVVDNIIcsKBSTUJyGz1gC1yyC9zufPfBChuLkMP4INUnabOpnVaJg4TtkuJFOB7y
 FeHWDBbU5zEPD3MZ5oyVY5ec+meoLu4ydh0P73oYpsPo3Ym7NcXUysWKf8gtXRmpRPpaQuQzm
 q1akbwbesRtyXcJUY1F8A0cjWo6g5i5FZFR/iHyDqMtpCKq66bYNciRBn4/h/s7R45MIoMDW8
 Ocim7n5MBnaWk7CJDIqnmg+a53tt9iHflXBvB5yDPEQ/zGkoGRFg8GL/PD0N111sknjwj03qQ
 HvCvcoyxKqLumTQmR0jCAT6HYEthnGXfUShW0zLPcL4ZTOb5jTe9nMDbyv4bIAWrK1MwXxQVG
 CgF7rTaHBmIiGJ3bJmqfOIGnHRtnwmqiH3O3WryJtvQCgmH9qqAx4rB0E37C6TXh/CKcQ5l/i
 mGPJnH1pA1C6iY80QYE8+Qe0lMBkMMeVJ5x0ttjlscoox9NfTT24E0A5G7Tc1sa9pf+TVapww
 AsoIFohalMmljQQDUWyJFqM2SPBX0Jx+DTMa9HDkWuks4WNZnABg1aygy5V/vu1kg4nzw0AB3
 fHLQ4u//Y5zzrXJO00b+18UvVco0JWVGfkScu9g3F0dgRXZJTLv2/2CUC5k6/HRG8j3iHVaiU
 3C7qFCVc6gCMOS/zAh/b02LffcjZpsQWFBXzLcYBfQRj5Rd6jufJR7XQo7hAQrhS2+g8++Oub
 7TeF2cr68HpM/y3n7BlA==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the Raspberry Pi Compute Module 4 to DT schema.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 230b80d..5dc4824 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -19,6 +19,7 @@ properties:
         items:
           - enum:
               - raspberrypi,400
+              - raspberrypi,4-compute-module
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
-- 
2.7.4

