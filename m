Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666B2F83C9
	for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292646; cv=none; b=fIqYzJz27Uc1uHImj61cJDMpbxmJHlnpyJfOldzKzhPy6lyVFqtBrl3ZN2tXQ+yRnBNkTeW+CUfc9C6Gt7c1FVSlVMnlTgtpLixM/RRLL2sH5XCZ3GtKBMtPQGE55yg+NVa1DjwoBF2X0BxUUw5J/jtYGZQIDJSs+djgMbuj9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292646; c=relaxed/simple;
	bh=1S4UQ+7nhEA8zNaooCtgSqA9haFJvF9HfZbaXeqS2EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIGf27hQt9WHBSfMH98tzpt35JfIt+MTw9gHbjm6CV2CmlkjVt9GZ8nvnP+y06ssXm4TWHA76vzs9QZiGCLVREdNbFdvUBF+3q7V7AYxf0ZNZ+TIHKa8LY/9xzPbBsWNTxurobPvB1azCpozGstqQM7Iu+2FG1iD2jT+/DKeZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjmaJSio; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjmaJSio"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso1293157a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761292644; x=1761897444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsCgGE+t2FAq88PcqDeZB7E9huH7ZBCKhVdOKCnfFwg=;
        b=IjmaJSioIn++WVvjuZqEGIOa8+5Te6i9jBTQXZlrlhB+d3pQfBl0tp5RSuuljbU/04
         GXpRj5k+sDatnfiS2r18jGkSLvTBTLqDFfeLHmx2dLMzxJ96vO43g75GaDAjxzSzFT2I
         opoVsEyZ+0WnkQxTQc4ivDeSX+7mSalro16ShXp/xAxiRN7lTuzOl9fitqVY/8QNMXxG
         upJrNUL6O75POGqRRAyu1tUKF9fdAO2uphCysolERxIIOts+DzyxrtaiQyrqCOaLqEnp
         lYsmMdLMh7QAOW047695wd74e6o9yiyrsBHlweqpS7eL+NFkI9jBF1XiD5nJpZgMGPk7
         GkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292644; x=1761897444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsCgGE+t2FAq88PcqDeZB7E9huH7ZBCKhVdOKCnfFwg=;
        b=TtbqxnyyubLeFLnAP7BewXR7LDB1vrQvH1xWOj/kZ0pbgcy/Uy28s33dGNCymAZgV4
         ovZGwG0eVjgnM1pycLqZxW0cHRHp1BnVcgnAKMu/HrzZ/xiMgcG54Q9KtqkBLWGbAmGq
         eVUp4+bnjWRqqfaVVSzrAr8vwfgzgKGVZXlwWDZoUJqKo7VXfy+xiiASzeYojGOUFIdp
         jHdpw/94pFIOCzugpyaWDCTNKiIPFfb5+vEbe1eOSCIwZzzZHJYiKjv+5MGvEwu0ppsj
         U6GI3qOXAVzqXWkJ+4lbtr3xpHol7XiKDj+HdePsDOJrdm1aPhFU37uCLIjSiVZ/eCsF
         urFA==
X-Gm-Message-State: AOJu0YzyH5YcQ/cg4K4Utao9yuXQMQH0wH609lkT4XPfuMYRvX+Uh3Bu
	L6cILNzHBfn2OHSturu3FCC3fqCfyl7I3fEhGradRTmDjSI/IGROpcDQ
X-Gm-Gg: ASbGnctRR+amaWbjs34F3ryYdrghIVkoZ/X8Ez1CaSbRFiOSwzKISfqthgMC1OgC/8R
	B2ih10v2ymUqPCNTVsDZQ95IiclFD9LDSzVlszsX2FfYHyXzfLihEXCG28H9PkG2C4fYgKWDb2I
	FI9upo4vqAGAC3RmRrUzTC6opwk7dGfNlOsy/920KzxJ2//d5CWkmBz74hLafFttewgyjLH2vjz
	tOoPwPfByUyZHti96TrDYL8D89TyxlaGJhOgIWDALmg74pZ18Pcz6NHNG0rSXgqikR6YGUzd2/g
	FYRO3e6QqD1kTScBpnon1D39cptvH1A2dN0AK4EYrBaOebGr2sG+aKCDjAKkpQ8rPxaeSDlatr5
	qlKMbE/EXl8Tt/CVED4Mpy4TNrFIsvgR1X8x0OveXfIfmbR4O0ZCGvqOSySfKYVmZO3tqk8ALOm
	2+PtomkpffHqhEm1YJKTS7
X-Google-Smtp-Source: AGHT+IGTHOLGIwrjQXatww+KV9yMhd2IOEe91lui9OUaDG0ykvPq+cnpLgcMgz87qAdZPtufjmcT2A==
X-Received: by 2002:a17:903:2446:b0:290:6b30:fb3 with SMTP id d9443c01a7336-2948b97658bmr17002255ad.16.1761292644352;
        Fri, 24 Oct 2025 00:57:24 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2946dfd045esm46608205ad.64.2025.10.24.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 00:57:24 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 24 Oct 2025 07:57:08 +0000
Subject: [PATCH v5 1/3] arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply
 property typo
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-ti-sdhci-omap-v5-1-df5f6f033a38@gmail.com>
References: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
In-Reply-To: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Rectify a typo for the property "vmmc-supply" to resolve the errors
detected by dtb_check.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
index e7d561a527fd..10d54e0ad15a 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
@@ -347,7 +347,7 @@ &mmc3 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wireless_pins>;
-	vmmmc-supply = <&v3v3c_reg>;
+	vmmc-supply = <&v3v3c_reg>;
 	bus-width = <4>;
 	non-removable;
 	dmas = <&edma_xbar 12 0 1

-- 
2.51.1

