Return-Path: <linux-mmc+bounces-2-linux-mmc=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC10C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:05 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838A5280F8A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9493A269;
	Fri, 10 Nov 2023 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dKmu5eCd"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458038DCD
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 17:46:31 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A5B46B4
	for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 22:11:54 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b9c8706fc1so702734241.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 22:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596713; x=1700201513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=dKmu5eCdJqmE/pWr6XaOVLuPR2lRdx6GPZ/UlmbOZBQXcRBzWhvVye6T4MpnKAAwaN
         lrc432/aUNbWv+cjPeOwPiDSeHnTP6nhs7Du4Hbk1tTrRChYk05eWwUykmLCxRmKPIzU
         XTJdHhQBjnNMQn120XyfsdpprzxYh6E/NkwwlXR9C56Wyh9pzZ9Ui9BnQWO16s43f7wK
         vTTMFTaHo5aiYz1GAN5sxpdkOu1PsSObd4YtxMNC+2TrA0WFNg/OpdKQ2Aj7tjAIzc4Q
         yeF24n2X2DwkKZ1jh2Ny8MoxV65MXdp6fGk0YwBJegP4GNcOo/AtE1YkW0+vGHIqbtgN
         Jp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596713; x=1700201513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=nQPi02c9AdX8JmpLWlwbOgZbN479VCydnbO27Mz2koB3S1t6D0Ax9RmUDZYzaaTXan
         g9BR3CJMbyut2skQwguLEyviYzcfuFKu1deBLquD8zVaHWeZGM3CT243hqL9+p9xnPUl
         biWh0HqhpkL8hISjdGK+9fe9uEAYwBnnsHcqJSH5HmenDzhKePSBr6ff26BBhvreqIJw
         +Oe25K9OlrmnfYe/WHBVEtecRuEvG4dBBlQZ2SpqQmBx0bbvgDV2BmSw3v/orOaNM/I0
         InpzhiBWlnl6+1XzuUfHPQmwrHWlmyWaA6l+zRljHgpkUNEkxSbk1IV0URPbJsYBXFMl
         TnzQ==
X-Gm-Message-State: AOJu0YzRJ6UUKXptDA43Sz/bbBr5M45zwydv2iqm/vUY9yQNCHXO86yd
	URgIiiIr+dk6TOa3nn7TQ+KMnoAd++yzzJLkt/DogA==
X-Google-Smtp-Source: AGHT+IFpFkfHNHBYhJCAUHAcswVdjopAz96NNqXsNMtnhZD1PCclguvJ4ptzgVdeIGhBXO4+11fEaA==
X-Received: by 2002:a17:902:d346:b0:1ce:a0b:7314 with SMTP id l6-20020a170902d34600b001ce0a0b7314mr525866plk.61.1699594947284;
        Thu, 09 Nov 2023 21:42:27 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:27 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Date: Thu, 09 Nov 2023 21:41:11 -0800
Subject: [PATCH v5 1/7] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-1-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=855;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=sdi2GBRazAXQCmzsLeFCtwwLCyPq9k+jdkf3IoMSdfo=;
 b=ugpumf9QoPxX+bSKCeojrp6bqXrSAnaGYhOubo1XOKWuUAe+aPIamwK96g3G9BlWXJHvQsys5
 SM5IH7XCovZCPWuPcsoCJ0439BkT26SbduFWhm4sFfHz07D59YfWw5g
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


