Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB87CA0ED8
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 04:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjILEwa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjILEw1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 00:52:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A158E6C
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:52:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502153ae36cso8302691e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494341; x=1695099141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w90FUtPMI0czzU7H17II7VSdTXdjnYx+N94QP72v1PQ=;
        b=dKVEIer5m8Q99AOMcFYgITometDGlilno5OUcCA4SYvXn4/ib4VgjN3iceE1MG5PcN
         5QpFvKndsYgdrAZv5wzCj0aGx8uF6rz0QTh+C2BYhX/DzWzUWRQfW1BUPDbvQUC4V1Sw
         MNgfi80Ne+I1oOkerKvIeHuXM8pU7DREbYgGyVbylC2hnnH2RlPlaWvB2nvCpu6XLtpb
         FekDRtUzSOxpkok+rVJzM7RFs4AI3Z5TXexjk4b7h1ZbwVapnmpa+6yZ3f1f3ksZd69c
         mF2wWTT/qCd8ELJYdg1qZvvUKY/5Cw0W7xFkQ055mEomGhVCp1Y1BRj6QEwDuN9oJ49w
         ah7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494341; x=1695099141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w90FUtPMI0czzU7H17II7VSdTXdjnYx+N94QP72v1PQ=;
        b=lPgt+gzOQh1JqfiWZxG5O4MvrD3fjnkfuQpxi18CR3+wBDkyPfIBDlx+H5AFAD68n+
         LKXVJH5HyI651laJRx9+kglWmBZcLUipf1yeAtaPYYpwSV0HZct/kOLiZkN53m6vzgKJ
         RTodaw1Xv6txJ0a2iwR73Jei8K3f+RT7qqY5M6Cc+88YCSH54DG/jzQSfd0vhILjvwR0
         M/f1Ss1WhxdwM685hCf8Nm1nt+Rw+YYQG8av1PJWw6G7qzO2gnq6EC66KWHHY5+OqyRO
         ErjpMIVUwlbfpYQx9KaQwflaBTEoVfOzVZBqVhTaTp1uMwJNNHwlznrItnHcS05Ih7iA
         uXLg==
X-Gm-Message-State: AOJu0YwJPRb+S5b/lEE65jBBk9C0OspGtzEmXpiRNOW4SwjPGfzhz49P
        0hXrB76JZhcdxTRcWku3EXTD0A==
X-Google-Smtp-Source: AGHT+IELmzsWU1otNTyeKxCyz+acJywZL+qAyX/1Qem3vil+a9S8qIts3JL61DCTWjnZD5Ll+knGnA==
X-Received: by 2002:a05:6512:3713:b0:4f9:556b:93c2 with SMTP id z19-20020a056512371300b004f9556b93c2mr8048220lfr.1.1694494341080;
        Mon, 11 Sep 2023 21:52:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:20 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 02/37] dt-bindings: soc: renesas: document Renesas RZ/G3S SoC variants
Date:   Tue, 12 Sep 2023 07:51:22 +0300
Message-Id: <20230912045157.177966-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document RZ/G3S (R9A08G045) SoC variants.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 53b95f348f8e..822faf081e84 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -474,6 +474,12 @@ properties:
               - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
           - const: renesas,r9a09g011
 
+      - description: RZ/G3S (R9A08G045)
+        items:
+          - enum:
+              - renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2

