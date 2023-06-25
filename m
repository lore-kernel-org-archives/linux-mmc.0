Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E706EB64DD
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 19:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjFYTT6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 15:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFYTT5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 15:19:57 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1823A7
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 12:19:56 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 7227B100877;
        Sun, 25 Jun 2023 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1687720318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOhkIMP+kNOLQ9YAs2dWlhnv2oixfRQubnTydB4EaJc=;
        b=Z3J2zGRjRQFq636jMHZKVXR0v7VK1OT6o//nDMxRKiErjeESe5un7dVgJNFsr2D4R280oJ
        ux7H1TtvlRrnHvN1bBHEv/RJk7nVAuu07iOZd+c+Dz7FgAMyqZjttI1TJkEwR3EDvm4QlU
        f3YG1zgMPUz3IQb8AqehVB7EFDDNNZk=
Received: from frank-G5.. (fttx-pool-217.61.151.158.bambit.de [217.61.151.158])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id B5DB0360931;
        Sun, 25 Jun 2023 19:11:57 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: update assigned-clocks/clock-parents for mt7986
Date:   Sun, 25 Jun 2023 21:11:50 +0200
Message-Id: <20230625191151.7808-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625191151.7808-1-linux@fw-web.de>
References: <20230625191151.7808-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 111d6e13-9401-4ca9-bbed-5c71f5bd419c
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

MT7986 has 2 clock-parents so update the binding for it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 46eefdd19a2c..485516dcc759 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -247,6 +247,10 @@ allOf:
               - mediatek,mt7986-mmc
     then:
       properties:
+        assigned-clocks:
+          maxItems: 2
+        assigned-clock-parents:
+          maxItems: 2
         clocks:
           minItems: 3
           items:
-- 
2.34.1

