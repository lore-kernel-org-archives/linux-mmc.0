Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FDFC04FDF
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Aug 2023 03:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHEDPZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Aug 2023 23:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHEDPS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2023 23:15:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE84EE1
        for <linux-mmc@vger.kernel.org>; Fri,  4 Aug 2023 20:15:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bba04b9df3so23737995ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Aug 2023 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691205314; x=1691810114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKcPemMGXOGkd6e68fBQ7r4rih8Hsd/tMIAFH2zBKKY=;
        b=U9I8H4H2oSIiHiOYExHzDbtlEabitxKvBb85zzo0r3kYZ6LI5LNB4FdOfbfx9fW+CS
         I18MTXDsOia6GwK/EaiQtLBaEXYAxJhtyGV6rUdIpPPTYVLBaHiC58bVnDkZG5khGWS4
         S/Sm67JmUcT6KSvSYPyRUuElVgQqKIeqbz7BNVmjWMJyw5BmNgCZQfXFu0BsSrKP/B1y
         ZJtjE2W7iJVx/r2vONa4XeykBpdVvBfpbg3TnpF87W+C+YCIwUP/jrUbfXVCng7E9Xbr
         CM1oxTtUzu7e4+Iy7+BbFj8NPKmqBxH67qQEG4lno0ULzNVPG9N8ScrbsW3jubkcIbVn
         V9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205314; x=1691810114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKcPemMGXOGkd6e68fBQ7r4rih8Hsd/tMIAFH2zBKKY=;
        b=bPvjxL85sMln093RFL2ZSDlQOHJOLiIIOnooZrx1izHCBch8/9uh9ZF101GVC2koCb
         l93Sd/S9q/f9BQXU1TdIuK7YKI8+0FWezAAhCvc6qngyT8PMKE+4okvlXrxghv0gJEU8
         8mTMHOtqNXc2fpJFT1UNaH+0ymdo6f60S8UJRGPbiQEeCMfq6lr6kIYgC+MkbuTjmBAp
         3+ff1+sOs3fINwodr3J3dB+jtDXhOff8nSyUiqbOGwLoReWkH1V+Dih9Llmyhoz2bTx7
         Kp2J8K68d9es5ExURLI8fRFVxRo3kqZWaiSizxfDDIkC1n5SI/MWBTyZO3F3c6hXiqJ6
         ikhg==
X-Gm-Message-State: AOJu0YzP7atk8e+lIF9gIfGkjy1VDukc4DuzpFHKrtUzPQzz16aFrTvF
        Y3/Ca16XRWD/3GSOsmMqN+6LEyywpJ0YqfBRyM/DKA==
X-Google-Smtp-Source: AGHT+IF727UsB1OR6XS/j1Pmf2w+TyT9qGOvl5s/PK4idgD8K/HaVsCLAuTp3MqO9Y2YOQmfrB930A==
X-Received: by 2002:a17:902:da89:b0:1bc:2437:e54 with SMTP id j9-20020a170902da8900b001bc24370e54mr3797471plx.24.1691205314561;
        Fri, 04 Aug 2023 20:15:14 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:e1a0:2f9c:e6f9:e66c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm2412145plf.154.2023.08.04.20.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:15:14 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Fri, 04 Aug 2023 20:14:45 -0700
Subject: [PATCH RFC v2 1/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v2-1-132ed2e2171e@baylibre.com>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691205312; l=1185;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=3K5rDs8cYMn2D0gb/trpA7jiBkfDo26+066jZaEVEao=;
 b=s97bIRVyIikHucjhtT5xHg6IE+2nJkWw++h9HqF38zuLSXpBN5TObT50Cq6e4vAfFPT3/ekl1
 v33K7rJ9RVLAuIBoLMoXCyjGyiH993EE9BTsK6JRgLspdZdKbuBOumq
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible value for the T-Head TH1520 dwcmshc controller and
thead,io-fixed-1v8 and thead,pull-up properties.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index a43eb837f8da..57602c345cab 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1
@@ -60,6 +61,14 @@ properties:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
 
+  thead,io-fixed-1v8:
+    description: SoC PHY pad is fixed 1.8V
+    type: boolean
+
+  thead,pull-up:
+    description: True if pull-up, false if pull-down
+    type: boolean
+
 
 required:
   - compatible

-- 
2.34.1

