Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0784C3F6B0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Aug 2022 20:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiHKUlP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiHKUlN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2022 16:41:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681C664CA
        for <linux-mmc@vger.kernel.org>; Thu, 11 Aug 2022 13:41:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so22589937wrf.6
        for <linux-mmc@vger.kernel.org>; Thu, 11 Aug 2022 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=v65TxKsCBooVHdoEozViTk8e8Jlbg0tbZcJ4XTkHA9Q=;
        b=UUw0P6y4EVVg3hSO5g1xxA0buwiU3NfFunLUxWYXGTc7EdsPQc8SlO1HZ4xr90lqEk
         +NwqlyVyC0eL8gR2/XPe6/BTLzMaRRUtJDX09W+Sm8OEdXbQGXC9R5+9uwIatHXVl2vN
         kskdHTXwoc61oZ/GFsoUkRWtUGokNebzDIwnXFzPUvCzYKuUN8GIb1eKhk2sl6Vetaiy
         oN7UuyTXGZvcYkUyfV7AuxMUi2TrY5nNgyz15XMXWLp/LCPlFODZMqkUQpPsh//bsYsa
         yIgbS4fdIfZR3Y7zNQI6TxrYHf304TS7ZxBBwFOlTHsTL0enqbNq7wZcPQ/uj8whmx9O
         IivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=v65TxKsCBooVHdoEozViTk8e8Jlbg0tbZcJ4XTkHA9Q=;
        b=KMd3LCir8dgc4/ml0PbnWn2IX5Z7Xd3wVXNzjr6QdVeArw+ZfnIytmEij973lG/VIN
         uhm+aQcvFtvV4LCR5r2b7IaULgjg98W69QApbRsS/92jfAHFZc6fy7Uf2EzSp5S8Lu4g
         rkACjaMu+8gZw0F9MpuYBx9BptpVqaajXRKdLWodbO/f7k/865HmsdiIGEQwQM1HeTY1
         rChkvkDIvvW3A/eB6qkencyFLB73fEVNYDfprmSaIqy8RcgtIDOCOMttJzKvzLVbe/Ye
         t6TTVLeUNhldGRZ8XABis0G3j0avoleBanJdiO2MJ2U12SPDacFCLovBHNa1AWLsdXXb
         YWRw==
X-Gm-Message-State: ACgBeo1lVgTlFdJC9sAZ2AEaHw5gMa6SPO+6vR/5+SXliTuzAg67GiDB
        fPCjiJjRw/fNpeyQ/SEhGNTeZx5O4RYAqNxa
X-Google-Smtp-Source: AA6agR6lpzSQl0I67ePvjSIBO0Obd6xiyVZ5YQEY/ZBqrqs7lEllEDAiTUTW7qGxMjPrmrSfdG2OtQ==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id v18-20020a5d6b12000000b0021f1568c7e1mr352199wrw.532.1660250469981;
        Thu, 11 Aug 2022 13:41:09 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b003a3199c243bsm11213544wmq.0.2022.08.11.13.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:41:09 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] dt-bindings: mmc: cdns: remove Piotr Sroka as a maintainer
Date:   Thu, 11 Aug 2022 21:40:24 +0100
Message-Id: <20220811204024.182453-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Mails to Piotr bounce with a :550 5.1.1 User Unknown and the last
mention of him on lore is the orphaning of Cadence NFC drivers.
Remove him from the binding too.

Link: https://lore.kernel.org/all/20200510122430.19105-1-miquel.raynal@bootlin.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 99f89eb19356..7124e77617c9 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -8,7 +8,6 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
 
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
-  - Piotr Sroka <piotrs@cadence.com>
 
 allOf:
   - $ref: mmc-controller.yaml
-- 
2.37.1

