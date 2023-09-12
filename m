Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B4ECA0EC3
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 04:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjILEwa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjILEwY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 00:52:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92353196
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:52:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31f737b8b69so4700976f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494339; x=1695099139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70blZEKYbPkUhjmz5mQWqO3PukYEZHU7HfQH/TSApUo=;
        b=kqfJUrg1n+l53/ypRls1jEYBEQS1yM5qC72Ce83Pw3OSGQAkUGD1/8DxeiKx6pKL/O
         75RwVZ/Cjwgs4HQ29MeiI6n4d/Uf4TNyT9rjxyNDXvIUNLxIqi+hBQF/bKYlEm2/fI1B
         +NhCoUqXP4M1WfChUkI0cXzUF5x/R+IK4VYTJTi7s+N/5aBee5ULv/ySPuOaoRd5u3DB
         RgL15fkwQRAfR2VdN2rR4nWFzjT8bILkCynNm4MVv3C4/JiWV/nqdjm3sx1IJHWaCQg/
         8eINlhMZo/fDx1fPojLruX7ffY9YNj87/N1wKYRNmfTvTXc9N5s3pDXGcjQF1IbjTGTa
         od4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494339; x=1695099139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70blZEKYbPkUhjmz5mQWqO3PukYEZHU7HfQH/TSApUo=;
        b=Bjp1ScRijc1eqICfA0n1T1YCJDptd9iVRF6dh5H9OOhGrWHaEn1JiOWj1a/1Br5761
         ibdzAra9MBVgrlZAZjRNfT88JE+l9yc9QIiBXezmg4u0osJXNjk9t4TkP8zpPrCDzt76
         ahf2CnMBC2fFZl4R+UY9C+a3l/6wGao/T4Zh6JTIEM7t+BNhYyzh2Ehd6N/b2vH6egQd
         cqbEp2BL/lpOKl0BOYQiBrQO6vrjFA+q+SjAR4jsRaFUGVYXhuZ3Upt31pJlBTG81S0W
         /GzO6KOxpGnhaMpIkL6fzayVXDFTfBwkqCOc5mZfCNo/4JDFeMi3DXM+LxeHSwVV7kRH
         e8eQ==
X-Gm-Message-State: AOJu0YxgAB1HzeXb2fh56b3O5Sksb2QdmPX4SsK4NT2KW+rVl2NawCWc
        2UDEfY9C5Q/fEsWbKQc92PReAw==
X-Google-Smtp-Source: AGHT+IHq4NsElZT5XJXLX6atbe5JezA+r31z/sk8n97Du/yTxrrOfNS/FcxRiNTwh32QYFqy3lq2Eg==
X-Received: by 2002:a05:6000:ca:b0:319:8a21:6f9a with SMTP id q10-20020a05600000ca00b003198a216f9amr8919668wrx.63.1694494338959;
        Mon, 11 Sep 2023 21:52:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:18 -0700 (PDT)
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
Subject: [PATCH 01/37] dt-bindings: serial: renesas,scif: document r9a08g045 support
Date:   Tue, 12 Sep 2023 07:51:21 +0300
Message-Id: <20230912045157.177966-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/G3S (R9A08G045) SoC. SCIF interface in
Renesas RZ/G3S is similar to the one available in RZ/G2L.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 99030fc18c45..4610a5bd580c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -79,6 +79,7 @@ properties:
           - enum:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
+              - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
-- 
2.39.2

