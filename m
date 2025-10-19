Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6CA2EA73B
	for <linux-mmc@vger.kernel.org>; Sun, 19 Oct 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760879137; cv=none; b=QbxEKTCMDHjggrGJOq9yhTOlBDKqPrThT3GAXiM+cUjlBr2jjb0ae5ODxUhuqc2o657fl1LYYlNTeBAkZWf08PcsIYy7hf3X7CONWCid6Edv6zDLXhJ1LDeB1ur+2jcA6kezz/LTECiDKyvR4/b2fU1hB1uYbstf1GONIxsmCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760879137; c=relaxed/simple;
	bh=WupZjDzp+mYLUnPliPNHAA8llyM+D76W7Nv/oh/99/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWE7b+nwXHilQthJ3g71+eRYqzCKiQMZEAg90d9SCsWd6p4+7xJQYgAa3eMpxEFcqKVApO/XZd4pVCJ6qf2Svt34IoN0Un9Pl7Ql9Fd5XrXVcpBtCb1s4Fk9uvjhT2Jla7sORDrIVzeiGUWhHhEZDkoNGrUgXo/ahasRe4Atut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmMODl/U; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmMODl/U"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so3084749a12.1
        for <linux-mmc@vger.kernel.org>; Sun, 19 Oct 2025 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760879135; x=1761483935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8kUPDmdGFI5dlB1Y4l1vU9fWBs35HJfqSRekTM7U1A=;
        b=ZmMODl/U5ZBaJnWBOI0JWM8cWaXuxDw6R68L9tVivnXa3qyug7K66F3ZkPXw5np6dp
         HdQYrNjoOS7R4mzcnPuECTrLmgbQKgkZsd4gbyFJb9uuOg2ZnYb2+nAHP3nnMnhW8G3/
         rCH5OanDFXb/XAXGIl5Xae2OW80FlXu4u4/ZCnFj4N71trbtdpcwu9B2Mb1gz6tI86r6
         E3ecctQtwRnJa87kYJgHRu/B5D7EXS2vk0RaHcCrpr14yh7KzF+EVvhKZ4Uh2AQOD0ne
         n+LfX1OQZdYsWwY2a1wUqO7P8ylPfihhFoTWkZQw67r+IEovOx4Wyw69wg8fBkV1ECHW
         gJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760879135; x=1761483935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8kUPDmdGFI5dlB1Y4l1vU9fWBs35HJfqSRekTM7U1A=;
        b=eEBUEI4gl007AopDxVBy15ZAm6Aju6NJNs2bB5Ah0xL82Q2S/dJtO3T0iCa0+a3iux
         tsV7bWZiJ57HJlYIMWzyC+lUy15nW96oFlJytV43CDbemSwTxJNPkLFpPQz5pcISdNUX
         X0Zz7vrnYcDwqWJQuyBqpoO2hCE/JDOJETBgoELwQp+kYvGIEhAPxQ6tsGiL5zl81jjX
         cpBRXcTl0ivg5Pu9k7xkGAMUBDnb8TC/hmJhpOTvStdEL+NtU5cl4U5WmTRjOzUQAYL+
         qWns5mYDH+MbiLMKaJLbR8QHRaP+Pf01sPy+C3aD36J3yDXn+mC9zMuYYynA8ONPMK9E
         ZBhQ==
X-Gm-Message-State: AOJu0Yw1Qg9vs468zEJQcKfzVr1lbvxrDnn2TUzg065vZGfLbYxkZq5l
	xJB/STPxCmugSw+bMiFw8CYjUBMSR6phkSHuLrZkzlAwSzv0Lx0SqXOt
X-Gm-Gg: ASbGncs9vOPp7sQpGIN1W1A/6u3U+h20DTJdrKT8mldNEl9MLwOGJaVzWfRIiHgJ5mX
	RiwZ+Axw66cTBaZiY44z+DMx+Gf1MWbrVsKo6M9RlgVyhJpxHF1eKLNgJh2wyS1uZDufrxty4qb
	XSHzdbbja62nJyG8POlKRqnfLOIVp1mTASheJoInzKHTmPrSa9b1Ywhtp5vEUwyMTGUfVDT0R5o
	kaRbS3WNFQe9OJaVycgYiVlGbLN6no/dPYY4bQAAO5G9MnwPnpLfRpaoIyKdQnKN25pmhCPi7Sm
	PubymnCkN0CAV9mnwt6SU/gccyRUyhqFg2ccORRkrwJ0EyGzcbKHt3hhNk4ZzW3SQukxMZNM4o2
	k7t9NcyZm7e2zhDTwhW5YborkwZ4/I8kwV9xyXtC7U+1KrEYKWjS0C2BgA6jCiQoqIhc7TgDFCc
	zQu4YjCAPuyizOkXHcFpHysGMx
X-Google-Smtp-Source: AGHT+IGna40/zgNzr/p+PlcAD+sAsPiE5QfzBrHx5lk8tHw0QkZCgRgKv2JV/dzTPM82UtUsADs1Mw==
X-Received: by 2002:a17:903:2990:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-290ccab59b1mr119270255ad.59.1760879135435;
        Sun, 19 Oct 2025 06:05:35 -0700 (PDT)
Received: from Black-Pearl.localdomain ([223.181.116.113])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471d5c33sm52842425ad.73.2025.10.19.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 06:05:34 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sun, 19 Oct 2025 13:04:37 +0000
Subject: [PATCH v4 1/2] arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply
 property typo
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-ti-sdhci-omap-v4-1-fdc63aaeb083@gmail.com>
References: <20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com>
In-Reply-To: <20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Rectify a typo for the property "vmmc-supply" to resolve the errors
detected by dtb_check.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
index e7d561a527fdd9eeb15237ddee4c8db1dfd48edd..10d54e0ad15a7ff9770ad02c224b4b47aa5040de 100644
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
2.51.0

