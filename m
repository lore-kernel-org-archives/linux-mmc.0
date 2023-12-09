Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B90zPIvJ"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87110E6
	for <linux-mmc@vger.kernel.org>; Sat,  9 Dec 2023 09:10:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso376247966b.1
        for <linux-mmc@vger.kernel.org>; Sat, 09 Dec 2023 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702141840; x=1702746640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5RWH25pS49A9wtTwrglnRYxNRiRU2sSwkBOk9D2iEI=;
        b=B90zPIvJJWTu2UV8UsC9lgQE2bHVlJNfTp842hXzJHhhAnnF4NDq9h4cE7erM+Moag
         vCtrl/lW5CkC3l1lcmGw9v6B3fK3RWzbo1FONcAEw+kZTh2gSJ66IHGnGxHsm/ySi4aw
         jHjT3ww/SNA5bfMJwbcxJxP3qqDzvFlQmZ1hI3rxr0MTQEQS5vXuz51V184EDQuiBEps
         Sr4EqgtJO8IyIYJD3h2y2koiAWEkCLV15v4wbxVXuWNaPI5vrbnpUFF0EX2ULSvo7T02
         wbCN96lMIQfl6k/Jo+LUefaxuyBmFOtGHUVt7Bgfk0PF1UuMUt9hovBmue4EzTQ1c/Qx
         B96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702141840; x=1702746640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5RWH25pS49A9wtTwrglnRYxNRiRU2sSwkBOk9D2iEI=;
        b=W7DP8qumTKAGJaOg8dvO4Dp6fXnuDIgkYcsAkRZ6hiODngBbaBRsVzVvn8FjoyxKRu
         uL8x48snGmPHtvTBypYcT3HzLc15zGYlMxclcB243K2+HCZgpPUcnJpYbK+Dq7EtC2ez
         FE2M0JSomF0Z+l5ld0g9BLxuF4dhmq7ap4fGVD6P88DfiqN23GzEeWoZJteAcWVPCRit
         mkWaBaMplgTKnsrU6u1TeEM+PLRoneIModMaLNIGo2FkWCQsCy+g2eEeLxW3GISNtuem
         AxRaTX0SqCoHZsBGrUKCxauthER0z6wPvrJvsHUiBdlcews9zYS0owxHHqM+zwbCG3zK
         p1PA==
X-Gm-Message-State: AOJu0YyvEYKoPVsOIZ24K/9VoGrbURrxWEoMN4Ss/1/X+Oe2q2Cw2+pb
	uu07gcjHyH0jMMB7M1dYTyWfgg==
X-Google-Smtp-Source: AGHT+IGN48qr0TD6bf2QcADaZTbl9FnlB1gwoIQfpu2bc0k57aGc/i7eP0yBpt6pqz0CkB2Q901+DA==
X-Received: by 2002:a17:907:9486:b0:a1d:c376:216b with SMTP id dm6-20020a170907948600b00a1dc376216bmr2408908ejc.45.1702141840368;
        Sat, 09 Dec 2023 09:10:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vs5-20020a170907a58500b00a0a8b2b74ddsm2430029ejc.154.2023.12.09.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:10:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mmc: synopsys-dw-mshc: add iommus for Intel SocFPGA
Date: Sat,  9 Dec 2023 18:10:13 +0100
Message-Id: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DW MSHC node in Intel SocFPGA ARM64 DTS has iommus property, so
allow it to silence dtbs_check warnings:

  socfpga_n5x_socdk.dtb: mmc@ff808000: Unevaluated properties are not allowed ('iommus' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I assume the DTS represents the hardware, thus iommus is real.
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index b13b5166d20a..a6292777e376 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -35,6 +35,9 @@ properties:
       - const: biu
       - const: ciu
 
+  iommus:
+    maxItems: 1
+
   altr,sysmgr-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
@@ -62,6 +65,7 @@ allOf:
         altr,sysmgr-syscon: true
     else:
       properties:
+        iommus: false
         altr,sysmgr-syscon: false
 
 required:
-- 
2.34.1

