Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65A3C43219
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 07:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE030610FF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 07:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbhKIIBV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhKIIBU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 03:01:20 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8A7C061766;
        Mon,  8 Nov 2021 23:58:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k4so19456275plx.8;
        Mon, 08 Nov 2021 23:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCWSz4QN3WNzVVvhSoXQuOy9tk7Eeg6f5rpYUbhU+Sw=;
        b=DBrSpNRZui658QX2wb4IEHP5iK1zjxcAO0g7Y3RoaCj1GFyOQGya3cUlXXIyUmGph5
         qmcE5Ub2kKW5kJiQkecKkaIdC04xuigspIdOt1d+W0AixKYEvJKhv2SANJC6jjG0D0Pd
         yy6LggETX34ZCtb7Mwg/X/owBP19sSszs2Cf2QH6lfr0x0lXEdVdSgR3jwW8k4U1U7gP
         9BRqOLxejYmlnX+DN22o3hFQirRZ84+UT/uANyjBSaopWywVNv/BVNy8Z6cP8CgEBEEQ
         Zm61AGbzRua3zOxPxoBpQAqoRG4rnNl530FZKKeAPss0qQqDYIUsafOYfzW4Gjdn+g6s
         FiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCWSz4QN3WNzVVvhSoXQuOy9tk7Eeg6f5rpYUbhU+Sw=;
        b=iXUozd2Y18agTZ5YgaWLyMfxi7+hm44ESWcKWklDq+oAjpImJD0iojWU3xHX1j+ERF
         dMRps2eCtVKYL/ROYu2bTJ3mhkJJBEMlOKgvQ6cCIigoYhnnSbp/cjyYP++FUtzT/7HZ
         5w50CvnCDY1gbh4cQd1ZOI1JZRUHMC4rjhKFYN3xlw3kLlv3RgHylEQ4tuhsMj7dOhoV
         rT4BcyD8gS1GfxsdrnScjf11myA3xVsuIWmdCAusotG84kuTAD3STLVK2BhUGWcHPt7w
         fL7qCvAQEKpPjG+4FfAiqSGwfAUpSToLZUB6LnodcLBSzjx1YW8Plxw/8ho6kR0oAcoR
         wzIQ==
X-Gm-Message-State: AOAM531KSflc+PFv2FDpmtP3Ay6pEwAXfc5jMvbbOc/jRhvbQu3BbWG8
        2shN7XGvHWqzjnVcXAidB4gkhJ7F9h3BbQLk
X-Google-Smtp-Source: ABdhPJy/sbQq5gMbTr4cjg5ZLeREC9ECvRUxYiHBZgaXlFBTMePM/i9+eC6lGga+fOGw/5+KNISwBA==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr5051261pjg.202.1636444714335;
        Mon, 08 Nov 2021 23:58:34 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x135sm10635714pfd.78.2021.11.08.23.58.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 23:58:34 -0800 (PST)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, daniel.thompson@linaro.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH v2 2/2] devicetree bindings mmc Add bindings doc for Sunplus SP7021
Date:   Tue,  9 Nov 2021 15:58:25 +0800
Message-Id: <1636444705-17883-3-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add devicetree bindings mmc Add bindings doc for Sunplus SP7021

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
Changes in v2:
 - Addressed all comments from Mr. Philipp Zabel
 - Modified the structure and register access method.
 - Modifiedthe path about MAINTAINERS. ( wrong messages PATH in v1).

 .../devicetree/bindings/mmc/sunplus-sd2.yaml       | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
new file mode 100644
index 0000000..95dc0bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus-sd2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SD/SDIO controller
+
+maintainers:
+  - lh.kuo <lh.kuo@sunplus.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-card1
+      - sunplus,sp7021-sdio
+
+  reg:
+    items:
+      - description: Base address and length of the SD/SDIO registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  pinctrl-names:
+    description:
+      A pinctrl state named "default" must be defined.
+    const: default
+
+  pinctrl-0:
+    description:
+      A phandle to the default pinctrl state.
+
+  max-frequency: true
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - pinctrl-names
+  - pinctrl-0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mmc1: mmc@9C003e80 {
+       compatible = "sunplus,sp7021-card1";
+       reg = <0x9c003e80 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc CARD_CTL1>;
+       resets = <&rstc RST_CARD_CTL1>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
+       max-frequency = <52000000>;
+    };
+    sdio: mmc@9C008400 {
+       compatible = "sunplus,sp7021-sdio";
+       reg = <0x9c008400 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc CARD_CTL1>;
+       resets = <&rstc RST_CARD_CTL1>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&pins_sdio>;
+       max-frequency = <52000000>;
+    };   
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2746084..e653a1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18193,6 +18193,7 @@ SUNPLUS SD/SDIO HOST CONTROLLER INTERFACE DRIVER
 M:	LH Kuo <lh.kuo@sunplus.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
 F:	drivers/mmc/host/sunplus_sd2.*
 
 SUPERH
-- 
2.7.4

