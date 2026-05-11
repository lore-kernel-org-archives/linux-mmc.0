Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7963BF67A
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489671; cv=none; b=Wgi+k/7jV9rd2ckskaaHrfy+UZnJmFdXFgdualjFHKf/8zISRUEteUp3txYpazDbGECMmTn0ccqphKfzh+MiFwIUuv/JBtl/aMKse5RxPnwjGwAGs03qnjgX5+JHEE0un67j2+CNZoj4srOVONJO7mwWixEuiGIC0zYox7u9T5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489671; c=relaxed/simple;
	bh=Zbia6kwCaTPqaM7mSuVvAG80BXlogFVq9JLCXZ979Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dA4StB+M8gxE7NXs6dXmBxOj25vjw5DgLm6xFcW844b8DG4ee1jugVKv+zH9WSohh/PnjUMJsdC77mBkteySC0VTxYsZPQCLxOg/WhZkmzw542l5joriALAxE1g2augVS3ufRwC59xfBWmF5LldTkon7OuCuaNXly7tP9JqdOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8rx/U7K; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8rx/U7K"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so3204668f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489669; x=1779094469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNCRp7u8GA5aDjDB3Y0lI0oGuBZ5cilcPaEkSfJ5vdc=;
        b=a8rx/U7Koo69H+aJgvDCiOozJc/hPFYFj/hZhVXH4C3W+Ss/mEGFB/xotp78+F9RLd
         QNJzKq0oAQTbujzHx+PioNC2CLgyBgOtaE6uj//MpVGlHk8Moj8ar52em3zkTpQyS88P
         1jMVquLEa4kgR7ccHtrKi3pstzGc3GJH3jaXjru0lFxjD78mxUCTHLyWJ9tFxOk943YD
         FLUxaKfM0ZBp231YkgOUSkFZ4aTgQCrgPLlm6fb4f1u3eDFIaXAad/brRUncLZnyvdgU
         GRP1fOr7GjfeER+MLD+hE6MoH5p3gnjpbrNd+IOPN3Sn9Oua1ewewiEzCyv0RxoWJ4o4
         LavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489669; x=1779094469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNCRp7u8GA5aDjDB3Y0lI0oGuBZ5cilcPaEkSfJ5vdc=;
        b=IIOV3KgZ/+B8PqM8XMzROrjSFVo7TU1gPeYz4C0U/cBhGpvb9vZ06Yr+guqnKFkT+w
         t+8Ff0jwkYpTn4tjY5MJNGnQUV37H31+wWIBcDd8+reEwNE8wkhr0Um+VihbcuWWFXEz
         pgZNYm0gYHjnAdUvvEWY8BA74gKfmDYAYAErwqtuo209EDFLz/u/IiqikrZz5JpZnLQs
         gGmBdL5mMT1KkMQLE+c97LGVLTo9b1gO145Ozm8Ir66Y/ylKjERPU6eTSkNyHusJyvSQ
         eWxwScbyvhr8mMe1eS0AcIMcta8u3wzwrRc32+odtXTLUMEqLVui2x8DhlaB3WKnnkFq
         p5GA==
X-Forwarded-Encrypted: i=1; AFNElJ+XUxeVExF07e9B3JhyUIF2Bg6uyQn4CBEdmvp6MA+ExmyqtqPDXK69sPeNE9kW1xiCIjIjGH4DbVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdcvrgGcSuyAT18ejRYKQOnORuouxcCAM4qu3qDYaR4FQ6r6m
	b8VWo9XCvakmGaoEvZ/Wga/BskcvxC93rCwyr1tPtzrCGJF71lcIU6C5
X-Gm-Gg: Acq92OHdvMh4CedjypN4Y7Mb3QQ2TWsa2CBbe3qGfkQEvOQZVVqfC05PCzFuPFgW2bj
	UuZPYnxh5BceGeMIutPV7TpY9KZL1iVumCVdVjo3bMe/tCYKSKCEkfVVILJd3AhMU8Oe7gjUK1G
	KDk7Hw2mmsSozPGb1Hze4xOxoLMffZfKGXByDBj+h82t7nZpZ1HxVGUh0gOzjir1m69jihkVaYl
	xMPBoTsIfJEIzPc2dfm57QHwuorLPKg6NayIIFSyO/cYGmkBNZ1uuWmMk2dOh5Amv6Q2Vi9cIde
	XLjSetXtvQTv4sAb8XgZKAYQjU5wIm7+ow/aSDeHbCZxjo4jW+QFUluME2jkKnE4udXn0fHbd1Y
	VukPqEEvUDl3w8eLPzMUgQOXMT5hJbAVaZeB0eTE3yH+yrvAn4Xh4A+HBkAfukyZo8I6ACbpgeY
	VS/Xsrt8kYKMA5OMazb/yrlk2EwqZh3OwAkfIGdg37Zg4GAJbI227nLp42r4eBLO21Gg==
X-Received: by 2002:a05:6000:2181:b0:44f:b82f:2d18 with SMTP id ffacd0b85a97d-452e81764a0mr19569331f8f.11.1778489668568;
        Mon, 11 May 2026 01:54:28 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.237.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm24944189f8f.30.2026.05.11.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:28 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 11 May 2026 10:53:56 +0200
Subject: [PATCH v9 1/8] dt-bindings: mmc: spacemit,sdhci: add pinctrl
 support for voltage switching
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-orangepi-sd-card-uhs-v9-1-ae48c0b2b2cf@gmail.com>
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
In-Reply-To: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

Document pinctrl properties to support voltage-dependent pin
configuration switching for UHS-I SD card modes.

Add optional pinctrl-names property with two states:
- "default": For 3.3V operation with standard drive strength
- "state_uhs": For 1.8V operation with optimized drive strength

These pinctrl states allow the SDHCI driver to coordinate voltage
switching with pin configuration changes, ensuring proper signal
integrity during UHS-I mode transitions.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 9a055d963a7f..34d202af909f 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -44,6 +44,18 @@ properties:
       - const: axi
       - const: sdh
 
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: uhs
+
+  pinctrl-0:
+    description: Default pinctrl state for 3.3V operation
+
+  pinctrl-1:
+    description: Optional pinctrl state for 1.8V UHS operation with "uhs" name
+
 required:
   - compatible
   - reg
@@ -62,4 +74,7 @@ examples:
       interrupt-parent = <&plic>;
       clocks = <&clk_apmu 10>, <&clk_apmu 13>;
       clock-names = "core", "io";
+      pinctrl-names = "default", "uhs";
+      pinctrl-0 = <&sdhci_default_cfg>;
+      pinctrl-1 = <&sdhci_uhs_cfg>;
     };

-- 
2.54.0

