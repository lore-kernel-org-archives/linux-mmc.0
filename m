Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3027C4332F
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Nov 2023 02:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjKBCtO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Nov 2023 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjKBCtM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Nov 2023 22:49:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0812B
        for <linux-mmc@vger.kernel.org>; Wed,  1 Nov 2023 19:49:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso3660175ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 01 Nov 2023 19:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698893349; x=1699498149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=AJ7HWqubkrFSUTfRothSOiE8vpaCzVASsCrmbX7k1rIVEp+dgi5Wp+ElbjimtNKm9X
         KIurZ96vmtpdBoSJCzfxXH57MDLrfNlozb9toQPH7dnoPrM3Q2sr3fbGU/K/Fc5OxkVe
         JcJevzyfKWKNK0qOGAXpcqY7xxs61hM+Sx3/W9C6O5/7N3jIM6IZIu4IWLE76baQQj1S
         rP0L6Y71KRhBbnw0OjqqJRZnL1kI+Qy1Eqc3nHL7ocMkn6zY5hpsPFLvyvgUtchRSJWC
         tYOllm4mTJ+ijtekrZu+OLkRnPysVJeayI7MHfZX+3r6UF8nCTzX/KB7UoUZBjx3yGI/
         NZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698893349; x=1699498149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=AFjI25UM+MxCaym8J/zQenNOTCRcTz31KAttYrfhJ5SolvaJpgTqt/A0ogpYiaqxmb
         +vG/6lccvacxw6XoKa1hY9Cs9I9T+8lhSQhqk3HQI8O9fhO+KWRgbcATl68ptQeR112k
         X71dpTnK3P/7wsQemPYSJNPShLrpDNyMuyI4P3PxFTAvqr/toeuJgW5O8A8H3IXLENGq
         rLfarWMXyVYss7suXiweTcBJMsQVSYScy/XlLlYWhGRiaa78q+8rd4z6FmXvX/VcHhP3
         9ws2Ba5eRtq9IuvwC/Ckk356kaB2bO7HwLLHL57J1PfyOtsnETK8rrqNeR/hOvs2G3pI
         ih+Q==
X-Gm-Message-State: AOJu0YyIzco8VLo3gY2Ooomu/A6FWuDNcWywd/QBxyX9NjZxowWcJJgZ
        I9anB3/gbRKGCXgDLjk1SgNQlw==
X-Google-Smtp-Source: AGHT+IFJRRc6LBUGsDW9ZAGafzrBM0gNGpEPwmu96hSFHU2mmeWEtKtj688InhZr3neYv/dkS/dxwA==
X-Received: by 2002:a17:902:c78c:b0:1b8:954c:1f6 with SMTP id w12-20020a170902c78c00b001b8954c01f6mr16004599pla.36.1698893349593;
        Wed, 01 Nov 2023 19:49:09 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:7e4c:4d4e:6943:bc0f])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001b850c9d7b3sm1925787plf.249.2023.11.01.19.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 19:49:09 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 01 Nov 2023 19:48:52 -0700
Subject: [PATCH v4 1/7] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-th1520-mmc-v4-1-86e0216b5994@baylibre.com>
References: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
In-Reply-To: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698893345; l=855;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=sdi2GBRazAXQCmzsLeFCtwwLCyPq9k+jdkf3IoMSdfo=;
 b=H4G0SP7skk6Qkcbi+uapfpuNbAmQTW/dR3ZoBNmECYpgjatiRsb97dClg0sTNqpZ4Jlitliv7
 IQ3UFs6gNtTCBp7USBUipzcGlL3y+nqr907S94xunPmACrwIsm57q05
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible value for the T-Head TH1520 dwcmshc controller.

Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index a43eb837f8da..42804d955293 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1

-- 
2.34.1

