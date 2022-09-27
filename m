Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B1C07E9D
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 10:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiI0Kl4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiI0Klz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 06:41:55 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED6A61E2;
        Tue, 27 Sep 2022 03:41:53 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BAF8684C47;
        Tue, 27 Sep 2022 12:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664275311;
        bh=mRPELCHpKyhwl8uzJmRv9CDpfWvwl5jfLEfVArgnJ0w=;
        h=From:To:Cc:Subject:Date:From;
        b=lRQjMAu99GI0OHjK7r+gpi74rxA2499pUJGFu2KMkIiCMhZap3BwRE2RJ90ZcVlGQ
         eommJl1PDW88JlT9WWVI+ja7kefB/pXT+rZOvVhxRQEw/zQXP5osMi1F9v8w2vVx8S
         vTrPnnoVAe1Xhd2JWvS5cJV5atVE2kuQ8nVen8ieuuZQlOy+oljq8iuz8TA8cKlmaL
         7cjk+ngEoG9rjuIGtvoj3GpDJXIpkofY+uKx3YW03bmIcEnEwdD9D+BcJu1DSVPKU9
         Be146kuLkWuwKxwIfo3t3FycOoc2JTcLg3vtD52mAcJj5YYGqFzUh23txTAtD3vA33
         n2t0OeSVe+mrw==
From:   Marek Vasut <marex@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] dt-bindings: mmc: arm,pl18x: Document interrupt-names property
Date:   Tue, 27 Sep 2022 12:41:38 +0200
Message-Id: <20220927104138.5924-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document interrupt-names property with "cmd_irq" interrupt name.
This fixes dtbs_check warnings when building current Linux DTs:

"
arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dtb: mmc@58007000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
"

Reviewed-by: Yann Gautier <yann.gautier@foss.st.com>
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
V2: - Fix copy-paste error from similar patch for I2C bus bindings
    - Add RB from Yann
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

