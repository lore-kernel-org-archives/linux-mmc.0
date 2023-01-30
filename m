Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114FAC54EAA
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 06:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjA3GpE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 01:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjA3Got (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 01:44:49 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9801631A;
        Sun, 29 Jan 2023 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675061082;
  x=1706597082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YcuY67xxIgLWevwtR3QWhIGyPEVnXpCDUPLQPchGc6Y=;
  b=af0TD6hpiUsdg9OVmSaKwfLn7f/wxs8InlXgsDiWA0myeD+naAsqBd28
   WZqwMVVXdMYV4ogM+6NjREjgOa0q1waMmhR6NXUTMZpsr999vMueYBDhr
   +3oZ5liZ/vQArHmeo9lhfYwXGOSMuUoZCi2C9oVzCql/CS5ToppmpDwWs
   2h1TI9xtpgcRAkUHloEq5HuyJhW+/nMlsCiKM7laTrGs8dRQwUKtwEiCn
   JKMHo2YLdBb4wr5dkYNhgnbtuAUdZa34l7EAIZFhH3mZ4wI11hgDYHo4Z
   9zuSnM9nGLXqLCJa6HXcP7osKH0hyQRTjekAD3TLxAeVwYF/siPeWJ+9i
   g==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: mmc: Add cap-aggressive-pm property
Date:   Mon, 30 Jan 2023 14:44:33 +0800
Message-ID: <20230130064433.962712-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a new property: cap-aggressive-pm to enable the
MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---

Notes:
    Update commit message

 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 86c73fd825fd..7ca674263dba 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -177,6 +177,11 @@ properties:
     description:
       enable SDIO IRQ signalling on this interface
 
+  cap-aggressive-pm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      enable MMC_CAP_AGGRESSIVE_PM feature
+
   full-pwr-cycle:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.30.2

