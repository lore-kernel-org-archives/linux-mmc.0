Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ABDC07E9D
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIZUrO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIZUrN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 16:47:13 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD930A6C6A;
        Mon, 26 Sep 2022 13:47:12 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 53BDD84DD8;
        Mon, 26 Sep 2022 22:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664225231;
        bh=Gh2QjyUkmiO32DGRxcQU3CNv4FWYd0POTeXHUuz2q9g=;
        h=From:To:Cc:Subject:Date:From;
        b=t5KJDNYcctXGFOFHbpTuM+U+VjLWiHWXWoyN7rSklPOp/oZhg9XNl4WW86i7vBxOo
         +PYNC7NxHUDictsAAFIaqmIXRf/OLl9SkorzokomPaHbThlUZ3J0QZAY00A6IORpge
         FxqEPSRWIXaat87zD2ri3KDzuIGXKb1jxwl8kqno52zGN+IM2yxbBT5i89uudGJGA1
         q3vdzrZwHdiTnAq6Pps4yi6zWpg2TuIkNukUym6+l2K4o0hTN8AB/oexO5TQi/9i/U
         a1ffqmrzmIFRmfa4RpT0w0ryZ12ral5ZR/+7JW8eYm1vDK1eBWgSACNw5kLiEK6KZF
         us2/mFAU3C+AQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] dt-bindings: mmc: arm,pl18x: Document interrupt-names property
Date:   Mon, 26 Sep 2022 22:47:08 +0200
Message-Id: <20220926204708.381741-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document interrupt-names property with "event" and "error" interrupt names.
This fixes dtbs_check warnings when building current Linux DTs:

"
arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dtb: mmc@58007000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yann Gautier <yann.gautier@foss.st.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 1e69a5a42439b..5f7eae8d57ab9 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -99,6 +99,9 @@ properties:
     minItems: 1
     maxItems: 2
 
+  interrupt-names:
+    const: cmd_irq
+
   st,sig-dir-dat0:
     $ref: /schemas/types.yaml#/definitions/flag
     description: ST Micro-specific property, bus signal direction pins used for
-- 
2.35.1

