Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607CCCA0EDB
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 04:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjILEzV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjILEy1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 00:54:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D11FFF
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:52:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13436866a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494377; x=1695099177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gKkCgB4ILmOLpzZZ+BKABIB/pKESCsm2SnQE8jVkyQ=;
        b=jDi0+XVMx81XZwMNMQE9homK3rjAvJ056SHlvIWfKh6mxh8XdAVtrRQwk8TambZ6q2
         pio3z6PPwOCMXtgRNoV73XFsxwo3EditfRFPF9uNbUwIVNWJQonGCa8qpMCDSVvECliA
         /TYx8T5Yl9sWNurkRyYURV1ObNtVZYsOEZCIlxewKWJWfwLuhVfRS7UYHenlAN1DKqIR
         JVV1ib0krxuwUm0XXHNedeRC8c5JqdUN1aKN6IwUL/skI/ibvKq5tCm9/O5XQrXcBOol
         /tGp2fFEp4yR969f/UMf4XTvEA7BTTen/NJkC0cRIwqdO1ng72zkf9OlrfMisIOWHskm
         FsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494377; x=1695099177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gKkCgB4ILmOLpzZZ+BKABIB/pKESCsm2SnQE8jVkyQ=;
        b=eP+cGOhIK4ox7IuOmZ0Wd3TxlvvbNAdfmmnSUMFBGRwklppTynQuGltHNyUMotTnMI
         wt1YO7XypCjCPtKKthiwpQYEY4PVXogn+kpBYzp1cT8zQcJV4PtgKQ7gWVXMoSkf00tv
         Xs9fmv7G+BhcEKHeB345c6yOtLCRMTROLV+lHvtFxOQlOsHTPQ3hYGomBj4Njg9PLEVN
         7KpqQWCxOH/EDuUtEwfR7X8fyo3dJlROik9HwNFU7J8begEv4PMee563gkNGy40/1Tzn
         /UuSVA/q5fOAAZiUGowhEZIEkjwsi5rLIynmBEKON2xm4Gfe8kvCD76l4ZFrSAN/4pSQ
         EBsQ==
X-Gm-Message-State: AOJu0YzT35GrBeKxMR0CtgpQR8PZbuSFASyqYQHlDic8T1Fbee1f+u3U
        2qAT8tn+g+DZj8arUrGr6smvtg==
X-Google-Smtp-Source: AGHT+IEba+F0SW3f5iaJYXo/DMzGsL2JCRp5dewcFUZnqLKPFKTesZJDe6RJBJyb4qJ7oxzLMeq5qA==
X-Received: by 2002:a50:ed16:0:b0:525:6abd:2755 with SMTP id j22-20020a50ed16000000b005256abd2755mr2042991eds.16.1694494377735;
        Mon, 11 Sep 2023 21:52:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:57 -0700 (PDT)
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
Subject: [PATCH 20/37] dt-bindings: clock: renesas,rzg2l-cpg: document RZ/G3S SoC
Date:   Tue, 12 Sep 2023 07:51:40 +0300
Message-Id: <20230912045157.177966-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add documentation for RZ/G3S CPG. RZ/G3S CPG module is almost identical
with the one available in RZ/G2{L, UL} the exception being some core
clocks as follows:
- SD clock is composed by a mux and a divider and the divider
  has some limitation (div = 1 cannot be set if mux rate is 800MHz).
- there are 3 SD clocks
- OCTA and TSU clocks are specific to RZ/G3S
- PLL1/4/6 are specific to RZ/G3S with its own computation formula
Even with this RZ/G3S could use the same bindings as RZ/G2L.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index fe2fba18ae84..80a8c7114c31 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -27,6 +27,7 @@ properties:
       - renesas,r9a07g043-cpg # RZ/G2UL{Type-1,Type-2} and RZ/Five
       - renesas,r9a07g044-cpg # RZ/G2{L,LC}
       - renesas,r9a07g054-cpg # RZ/V2L
+      - renesas,r9a08g045-cpg # RZ/G3S
       - renesas,r9a09g011-cpg # RZ/V2M
 
   reg:
-- 
2.39.2

