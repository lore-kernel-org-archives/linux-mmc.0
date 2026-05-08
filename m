Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369933343B
	for <linux-mmc@vger.kernel.org>; Fri,  8 May 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261002; cv=none; b=EERwC9lvrq4LQq9j4PA2hLU808z8Oo43W8fqvSbEc3xhcuS0oYIiYYgrM5RxtCgFVA2qNvzLiY/Sl5ghBFtXWt9iVvNK90t+uvTAeLOGYr6VNhN4HmsiiEYQ0GbvIm8fzgFYky565+WJ3qJekusK80yJsVuhDIagz8FaCv8/BU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261002; c=relaxed/simple;
	bh=ER0AC/Xnj+ibEkD0vpGT/fnWFxVKVDSlU3bLlFczBTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVgIXLqNOXqIwI6sJnQieohii/3NNp3/ra1yX9MheHIV6Z908aRJvIccWHyBQOz5xAy/s+x2mUyaa9aITJIHYf2NTNZnIuoG29iUqTMNp75vSWWs6Dl9CEB1T94Q8L527v/HV2k1rJQ6ziSNnKpMXhrOW/d0fdoweUK1E36wElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AihoeGQc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AihoeGQc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab077e3f32so11543395ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2026 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778261000; x=1778865800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAyKAjmkX6PvmXkxrw5YnaLQ/4sPrlWKfDdfdwHLY1Y=;
        b=AihoeGQc9YJ2rEJK9zTLH519qkSLs2xQxAjGolcqvmJDz1zBvIGuXozAPEYEwFPjBO
         uaExtNWD2jMTucPb5TXmcMdXo1L1fiJzJQG1cK9dIt2ra6jLGYZf9LfWAJm7TCo7JOJ3
         v9mwsRI83TV0SFAHx8WzWmOqnlsBKmJrYUBT6t8d+fvQ0m33AOn/N/xBbQi06Fsp8q0t
         Ef2+N8c21wC8aoXZvQWeLndgghkTg9Bb8CP8o/69FC4L7lvxZc6Nz5smCLrXCuwmz7jR
         Rs03dd5oohTf3t/2g94nRcWDGpc4kwsLUtJlDCSSMmlWNOvdKEti7j/lsS12PtTLFcPU
         a1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261001; x=1778865801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vAyKAjmkX6PvmXkxrw5YnaLQ/4sPrlWKfDdfdwHLY1Y=;
        b=nXWytat7PScTpyxMC7vgRRm9WFCSs5GHkZtFViRlHSG8A5CRfz+vbu/cacVzLtRJdr
         zVc82BlExyfG1/kij6CwaJUV0EarSwG8xNO/S40mMC19KKt892uMxXQKUcD9ETQ4w2MC
         1o0Q3edhYpZOhgF0wAIgqb79M7onIowBuGUb47BziCjv2CdAcwe0l9Nutc2Md7dUZREM
         l1MLiakTlfF9Mq9HsJ4YNDM/TF8XTQFQJZU02Df5UW1mbDd/HjkhlRJR8PWeTQAHKuy8
         hs9aIRUF+LhT7Ll7uQbeT7sNHA8vGaQirQeQEtUs+SCRHuiT13O3M5JC0kqVeqmVSLE7
         qmyg==
X-Gm-Message-State: AOJu0YzqRjUeJEyjVJBJcbiBHozdEM0vGu0jR5p4ouI4cZ+/pGGTwD3J
	QZXy6ROptxnLFAxK4Up9lax8K7/H7oPFIVvL8z/ex5aGpO1fOYtZTghS2AK15g==
X-Gm-Gg: Acq92OEWTZmCoavbxPG0m9RFQq1YfvHGXN8Ug+RIC1Nb6YgQCT3APdfWVZEf58wyf/7
	AjJN2cYuRMy/kO1o8HStgqR7yZHrHNmxlvfroq40jvwCtIUxqlGqXhH/YjvlulaCY1QSpT2y7rr
	MML9V13c4FSd/52FDVzwOBr1WA9TNM1HDkBls0QW4a39dgseQaaagyAssQM/eBc3DFNjSlo5ciN
	1Nbfw1FRvHNNG8plVmh53j2Op/oq+kTanvbTqDZ/KHA6UijNXmk0x0Rc3wV3uMUhZQQmi23eXAz
	G/HHMDd8RjKZlxXJaM4RnyIhIDlx5+7zSBOSJ1xw6BCLGv1ART4ABYEUUtuU9K9Z05h/b057Bay
	gUGzwhhXtyuobgd33ItDVYHVMHFY9LeJU5WrsxzvMROeTHHiB+w0R4zAViKeP3Q30Wx3FHbxxtv
	wQaihYyNB5T07T0AUhkR8jVXUxxOctPf+YJ787ovsK7Kuf
X-Received: by 2002:a17:903:181:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2ba79287515mr137856355ad.20.1778261000634;
        Fri, 08 May 2026 10:23:20 -0700 (PDT)
Received: from Black-Pearl.localdomain ([60.243.224.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2baf1e35487sm24907985ad.46.2026.05.08.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:23:20 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 08 May 2026 17:23:06 +0000
Subject: [PATCH v3 1/2] arm: dts: st: align node patterns with established
 convention
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-st-mmc-v3-1-81c329ed28e8@gmail.com>
References: <20260508-st-mmc-v3-0-81c329ed28e8@gmail.com>
In-Reply-To: <20260508-st-mmc-v3-0-81c329ed28e8@gmail.com>
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

