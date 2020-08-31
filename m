Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93880C433E6
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7347B206CD
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598890321;
	bh=AN/d5dS86d/EbitIqLwCS9w3KgDwC+T8YZziwmEC+vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WobMMMcLQ/UfgfX7K3ohyeEc105FMIv0Feyz/ZaR3JrIYH8T3WdaMcBZDHTW20JzK
	 h8XrvNRzE46oY5cjVkKnWEk3OPDTLkwTZcSXinmN/i6IybcjxABgLD7NFOMuceEu1s
	 JnAOg2womU/mH9qEKw3DeVWF7zUx/fGdY4IK/YX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgHaQMA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHaQL7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Aug 2020 12:11:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5AB2083E;
        Mon, 31 Aug 2020 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598890319;
        bh=AN/d5dS86d/EbitIqLwCS9w3KgDwC+T8YZziwmEC+vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPIwY0uCbpRLbB+K6SzgotqSpd+G5zrhY4Q4UbrfiJkTXG6tm25NBin5WIFHk12xp
         JU2SCKxnis9ImL5EcuayeCmo+PpkOU4XAtbvnXBUyRCIiTLlNeK0WpQ1u2WiOaSuwQ
         IzsT/bDFg38aYdGkmHH0Y4L5QDnWdNg7/tfauD0U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] dt-bindings: mmc: mmc-pwreq-simple: Accept more than one reset GPIO
Date:   Mon, 31 Aug 2020 18:11:47 +0200
Message-Id: <20200831161147.13515-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831161147.13515-1-krzk@kernel.org>
References: <20200831161147.13515-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There might be multiple reset GPIOs but dtschema has trouble parsing it
if there are no maxItems:

  arch/arm/boot/dts/exynos5250-snow.dt.yaml: mmc3_pwrseq: reset-gpios: [[20, 2, 1], [20, 1, 1]] is too long
    From schema: Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
index 449215444723..8d625f903856 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
@@ -20,6 +20,8 @@ properties:
 
   reset-gpios:
     minItems: 1
+    # Put some limit to avoid false warnings
+    maxItems: 32
     description:
       contains a list of GPIO specifiers. The reset GPIOs are asserted
       at initialization and prior we start the power up procedure of the card.
-- 
2.17.1

