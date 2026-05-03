Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157C381AE7
	for <linux-mmc@vger.kernel.org>; Sun,  3 May 2026 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777797342; cv=none; b=kTUCgv/d/r8ZNYfoH3Uzs2phD1+d0kfSdhVvICHR5nzItN/UZ2qd+9gq57EheeCcwK7OKVqG89CcL3K/6Gc5shJ2IhYOSOYZs3nKMHqwKqP2M8+uzVTvKDPc71sDU2gpLHWsvcCXFnLEzbYB4UfJRYTU/gjWQqH9rH0LiG2x0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777797342; c=relaxed/simple;
	bh=ER0AC/Xnj+ibEkD0vpGT/fnWFxVKVDSlU3bLlFczBTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lp1AEzXgVXDGQrdTeIosAG8uDTmvo8J8iBGqIHlPQOF+hQSptsp7FRHwRI+mF0gx5TetO6ofXGVZWvCBHFiqIkpRXIS9DyynNIFiK4AMgg/3zcO/irzZOqZzmGTNRIkegQxKFXt0HzaIImuRsFydYH3OAXx+sdJ62R7OuO7W+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c557duyU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c557duyU"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83537a80ab6so356186b3a.1
        for <linux-mmc@vger.kernel.org>; Sun, 03 May 2026 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777797340; x=1778402140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAyKAjmkX6PvmXkxrw5YnaLQ/4sPrlWKfDdfdwHLY1Y=;
        b=c557duyUE3KM8aRDLMOnfvDKZnxBC6cIPOAch9v+W2os7tDz+Ut7OYp3NVNTmyfbeP
         oS9HnfsXwxvfKOE0A5OgF3Yg71iixjyWms809NhP8Z5u9erIQ8u/fHAm8NBpe7FQ001S
         Y4BI+I7+QGqdeC99of6LfXOqJmLVbkUgPrZC3hF5UHG08hL4gJ8f7X428Nt0xlKDIRgc
         HUF2DfS3nPCdgbv+i+yFBc+gkg5o5e+Gmb00aennBreDcaqMn/GCOhmqG1uhpIpz+xdE
         XWMT9kvSrjVMtPQ/tXvpH2dPCfwiIAuh9gklNQl0iNA6sOWS5r2nO4TmWZLELYsq1i6d
         3lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777797340; x=1778402140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vAyKAjmkX6PvmXkxrw5YnaLQ/4sPrlWKfDdfdwHLY1Y=;
        b=eMxoIvRywq162IVzGM9Vr40lOROqSf4cpwfqLN4guzBr5bhmNbMW+cZ2YcD9P+VaTY
         epiTCqsjprQVnJvyrvrKRiMCcrSFTjdmoyc8M+vOohWk/mt6/TEG15SMEkt64u1Q2pRw
         4nC0g3i70eTXfSv3pkeXwjeAcl4LpHSppLZaXGr68d1I+cCoYUtdIpwsN38tRX3vAz5e
         uBGVGB8y+VsUfIxmbMAN0ahMDKuYdxyqI5tbicPCvNXvuGrTP4ySt3IhC2qvGYSPOwq1
         H/5JvyjzHVPsGxmLqfYbdz93NHAmyAZ9lsRuFfH6iKd7IGTAxcy14zvfF3YN28nFec/w
         oaig==
X-Gm-Message-State: AOJu0YxaxAovxM5YssE5LujlqpkfoffKBf1o6JI3nZ4mTkxlOwzUIvK8
	PPm07z1LPPn0tT4zae+cZlMWJPnU07Yn0xS5NqSdoDUPXWPexEmRbUs1
X-Gm-Gg: AeBDiesLECZzNdEnDSYDpPcnVXmS9VrGbyf0CyRGghjGnVg8Dk8MHmv5kbbb/NdWh+E
	evdRhtmnnXbnChfHnvRB7CxorGDoh+uocs7o314RWp7W3LQDxvsToGozii7F07Lz0gPLU3Xy1yi
	neXus8RrvSgJNcqnMI7nZe1ryLhuK+xO5cYwbtekOC/ZDGGNJPPstbMh5mX4VeiPUEW4AiHAzs6
	w8r4X21oyUcEqdq3kdEbKm6ClCpCTKqFotn79llgYWFPdN4ZzzKkLT90P581qtl8SZJNq+0w85b
	BVlnx8VN2IpPHjfQxa/NH9CA3jn166Hc3vgY/gvwr6r/jL7Ed14zmxWg0Ib9S/+S5fkI/uudSLi
	tt14GblE2o0Yzm1YkvP8jyq7ER7DkCwZ7ZFZDq7DJLmE50/kv1xELWeRvTRQKR6dBs3ZXRmYR8d
	sILvd2Hko9CNL5J9NMHjB0z8PGniQ++huCQ8Ax5BgbvsZSUj2nvtNYToc=
X-Received: by 2002:a05:6a00:14ca:b0:82f:721f:10ea with SMTP id d2e1a72fcca58-8352d1bf331mr5683330b3a.18.1777797340207;
        Sun, 03 May 2026 01:35:40 -0700 (PDT)
Received: from Black-Pearl.localdomain ([60.243.224.75])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-835446b1b0asm1578142b3a.8.2026.05.03.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:35:39 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sun, 03 May 2026 08:35:29 +0000
Subject: [PATCH v2 1/2] arm: dts: st: align node patterns with established
 convention
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-st-mmc-v2-1-11ae3216d2ce@gmail.com>
References: <20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com>
In-Reply-To: <20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2

Update ST MMC DTS node patterns to match established convention.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/st/stih407-family.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
index 3e6a0542e3ae..08acba209c56 100644
--- a/arch/arm/boot/dts/st/stih407-family.dtsi
+++ b/arch/arm/boot/dts/st/stih407-family.dtsi
@@ -596,7 +596,7 @@ spi@9542000 {
 			status = "disabled";
 		};
 
-		mmc0: sdhci@9060000 {
+		mmc0: mmc@9060000 {
 			compatible = "st,sdhci-stih407", "st,sdhci";
 			status = "disabled";
 			reg = <0x09060000 0x7ff>, <0x9061008 0x20>;
@@ -611,7 +611,7 @@ mmc0: sdhci@9060000 {
 			bus-width = <8>;
 		};
 
-		mmc1: sdhci@9080000 {
+		mmc1: mmc@9080000 {
 			compatible = "st,sdhci-stih407", "st,sdhci";
 			status = "disabled";
 			reg = <0x09080000 0x7ff>;

-- 
2.54.0

