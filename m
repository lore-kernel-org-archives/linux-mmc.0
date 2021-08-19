Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4CCC43214
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EFA610FF
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbhHSPpz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:45:55 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52734
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240269AbhHSPpy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 11:45:54 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 7EE0B40CCC
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387917;
        bh=9g8lVxW/0vIBsgyWcHYECrU1Y69l0dfoNbAMk8ILUfM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SKS4tBzPDpF0JiynZAqsbxOp3Iltx/bv2Q7GVXtjySELskxRmkerEEGFhqUXtCbQl
         bDt7PrCm/sz942+ZfGV6huN/hv1zXmhWhkDFAhTh8pp7/ckfflbGFLY1jNl6vhGQGe
         PLmG3XMj6N8NF7WNNdD5e3FR2M/9Ln0s7y47BMU6iWAD2zAJnjwa4DM5xt/Erni4I+
         aXrJS1Neszfzr8lF+keIgTBebHKNRpbcFpZ1I7Ztttq565aeAeQqkJ0P/Wydg/tumg
         1CnH1tOistWoImKnURofDvTKB+W1mqoyU+vGMIQ3EyBlTrsCmVUVmr0tiEjNFrSvq7
         CMIgL9FSoCWQQ==
Received: by mail-ed1-f70.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so3001259edr.16
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 08:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9g8lVxW/0vIBsgyWcHYECrU1Y69l0dfoNbAMk8ILUfM=;
        b=qTDqzk+3CfeRN7rSni6kBh/t3Pz6qGCdNvdfG+/c0tV5YNpjp6BOhTnM3j9MXbTUOt
         lDMo3dUxY8ojf7tjs844GuAgCf3eHv1ajYt/GiUeZB/3U05OwfT2adIo0pw5SZTAnro3
         EitHspPtaR9MfDH97zeUNnhq5tnxNf3XFDZKGoEANXfggiLUPyXaEvR4xz6z82rmjbZt
         LUTE8LL+ufb4+WOZ2UPzyxFfO4dsSkAp4KSf+CFUqLFIdBbd1uhAlq373P/kHabGX9kq
         sfGNE2gWbg4OXAD548sSoHyIYd1zHW9RQNH8AQIDufHYfa25QPmc5hTqVkUB1zRsdG/S
         7+gA==
X-Gm-Message-State: AOAM530H6XSuaeeg0HUuJ8H0WryMQ/NhEfJljJ0zQQJD+362LJHpAVJw
        MoTur6u3f+xalqW2hqnEySud2f8CnO/A250gmFTLuZ4tTn9sFY3rXEsQXe/57blWBvhEQelsN8L
        Omxcc68COL+/0ofbm+4GJWWYa9MLzfk/Gv14nfA==
X-Received: by 2002:a05:6402:2936:: with SMTP id ee54mr16886871edb.70.1629387917314;
        Thu, 19 Aug 2021 08:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydJxAR9RqcEIloU3dIrjmUihGpRPfzhtv3jlhyIeTCtbI+Pz4nUoF1CAoY/Ww8GACdR8Ks2A==
X-Received: by 2002:a05:6402:2936:: with SMTP id ee54mr16886841edb.70.1629387917156;
        Thu, 19 Aug 2021 08:45:17 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI controller
Date:   Thu, 19 Aug 2021 17:44:32 +0200
Message-Id: <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
without any additional vendor compatible:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index af7442f73881..0489aa92cb54 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -15,9 +15,11 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - socionext,uniphier-sd4hc
+    oneOf:
+      - items:
+          - enum:
+              - socionext,uniphier-sd4hc
+          - const: cdns,sd4hc
       - const: cdns,sd4hc
 
   reg:
-- 
2.30.2

