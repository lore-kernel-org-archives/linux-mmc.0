Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9EFC41535
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 21:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378645AbiEDVgi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiEDVgf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 17:36:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED851E5A;
        Wed,  4 May 2022 14:32:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0830C1F44AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651699976;
        bh=pa0fs7XjK4PqOe4j9zjXKTbHKKSHl37XzD0JnO2WBBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVWU9+elaQvavkKi0h45vWgkPk/VoLm7E3vuWYCjs1/QS7q70hEVSM9pQPxoKSdZa
         6ZIzapvIhRD39PYbIQ+jGCfnebefCOwK2duHhcDjDNQ7z1YTc76lBb1sZgSdHMAU0u
         SM3yDtMLLZneHP5nE/npfxVEvILp4vpZz3ALR+baCA9pUKGY38fUztK77AsXZSY+/t
         JJ9YE5fTTZi586OGKn1Oc+nCPir6MLj/vvql3mdpupH1+4d/b/uD41qWvnNcf2b8Q/
         t/KPBfuE/ZcmGteIAu1db/IwUNdwrdZtgr2vQl6m4lu20qQBtSymClrvHuZtnpzzzS
         1k7iQbvMZbJ0Q==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 31E4348146D; Wed,  4 May 2022 23:32:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCHv2 02/21] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588
Date:   Wed,  4 May 2022 23:32:32 +0200
Message-Id: <20220504213251.264819-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504213251.264819-1-sebastian.reichel@collabora.com>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible value for the Rockchip rk3588 dwcmshc controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index f300ced4cdf3..71f8e726d641 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - rockchip,rk3568-dwcmshc
+      - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
 
   reg:
-- 
2.35.1

