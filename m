Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7C2FC33
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qAJMH3NN"
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE47C2
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:08:08 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2f4a5ccebso3979552b6e.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699996088; x=1700600888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=qAJMH3NNKpTdkfJnNhVnPB8iCcIvSMF9SdTD2cgZajx15fnjwmdhI+o9raR/KcMQra
         e5CCwwtl3sQPpYfA+ThmoFnmb2L6vV+axLyeYzetDsVYN2KYyQWIfAzBgZSADhs5wdh/
         uD+n039e6M6dPnBSElp7ncpeUptbzO//BYd7yBnduI25AIPjkHphuoB4FODKMmm1sUm+
         MoxuFnDXAmtFQJxL/294hhQgDBBDmch3ohq5fZ50zsvlzXXPeBpbS3EcFuhL6gwvs1PO
         KVAikxplfScYKjJsLoteKHd97FDuMreRIssu2UhL4hsxkkuF8syv2RN0lCv6UzaXItK+
         sOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996088; x=1700600888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=U2edjBmzvDTFgK9abneGdu73KQHkVSoZm834B7N7hBLZV6C65+VW/+r9HK1i+bN1wI
         fZfm8aXS+ouMBDSoQr8xhC7/9JeoKx8oUnoDDkyeXzTnIcFc9ouil4p5V2az1CsYbYK1
         d4Jj5XrBrP8CuMdwGMG7Vu/is9iCWv0xGXnN9vQNN3tbpDXh/dm0QqIq81+f1CKp9zW7
         m2Ok1xi86tQgcb5He1aKg+owKuZCGnDeZiqOiLoUudqbvuaIQwvdKNfOOEdO2eQZ37I+
         AAMA3VOFBBY/ZPUgoffv8DwSSOb0yqXYtz49bUYVkQc+wQON5p28SbZrEOH52hyk8T9o
         3MQw==
X-Gm-Message-State: AOJu0YyUx3PUDvSOCG6eOgFGq7EuqvPMKuyPH++vQr6I3J544EUFQHG+
	dunTvK7ENBfmUYftDO5gp3uhZw==
X-Google-Smtp-Source: AGHT+IGC6dCh8CngQdS8ipJ/wmcb8gleqQAhQZL3+1+fy3Z7J6ygYty+lTHTkjgne4uoZ65ptYNAmg==
X-Received: by 2002:a05:6808:11ca:b0:3b5:a58c:cca6 with SMTP id p10-20020a05680811ca00b003b5a58ccca6mr15033179oiv.3.1699996088217;
        Tue, 14 Nov 2023 13:08:08 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id x16-20020ac85390000000b004198d026be6sm3027549qtp.35.2023.11.14.13.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:08:07 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Date: Tue, 14 Nov 2023 16:07:55 -0500
Subject: [PATCH v6 1/7] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-th1520-mmc-v6-1-3273c661a571@baylibre.com>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
In-Reply-To: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699996085; l=855;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=sdi2GBRazAXQCmzsLeFCtwwLCyPq9k+jdkf3IoMSdfo=;
 b=l8NAiEvdoppIB/0jKWUFZB8IbAYQ1k/jwcCXyJuMHrxJvC/ZlLI+hGBofEFwdHm6gNDYhD7qb
 7JMlwY2lmvjCOhL4yZ834jj1QaEgk2BEikRzjTYlyc0nYTCTRTeRttY
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

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

