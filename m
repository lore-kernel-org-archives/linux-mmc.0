Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7A1D5160
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343592; cv=none; b=b44fBKfaM+jCloGuRWgXmusZVJNP3n2imvwHvV1ecejZs3GFUq/8GGGlmSX2o8ozF7kIp/OtmZy9zVrilLy8bWuNIB9YGBP8eBqQY79wePunypMVry9FH1rQcMf6yeTgDYaRCoZ+Qpk8509evBywudC7/GTO6EQH2fJZbJPvfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343592; c=relaxed/simple;
	bh=ER0AC/Xnj+ibEkD0vpGT/fnWFxVKVDSlU3bLlFczBTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1SohKWnSgaZbmyEwbdrBp6gJK/DK0A/PzXJYKK4WJ4iJR8nw0oleh4M7bxGEUGrZfNojfO+RlJ4CH7Gy0WvzrgdQMdiOF7eHOlWZCul4Gtf0wFBfLZ5ugvbpNFObd92JIgs/f65yXsEJds9qqcq4WjTafh/Yp/J/v3FORDln/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2bN4TCq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2bN4TCq"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c858b5de728so1131964a12.0
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781343591; x=1781948391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAyKAjmkX6PvmXkxrw5YnaLQ/4sPrlWKfDdfdwHLY1Y=;
        b=q2bN4TCqeSO6tz6FxMNyXKf5rzAGRTp1aafyZ/Dl3gCwESHdTHmDcTClznUrMNfsdC
         2q/+TUIRkX9diSmwZsWui/WOBkBK+U2rroXoHotzcaozk7Uq5EXc7t1Xxi9/rqaXmC+H
         V0ZIEa4km1xfAuQqi38vxAP2jbfhUc15DXKsc8y+funIhBESpaNI9B/tSBx/JOxnuJgM
         Lz+7JvpYrnW/v3GH+oGONUN0Hw3zj2BAecPgcaoYp4eYfBloYlVuAEiiOpJFY96QJ2X7
         TuzJ6lIAzf1Q6Q9DOA4yO2DYpmGY3KCC8o6NczBWDcs1FBWzc4MLfS8c3IY492JxjCnC
         RzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781343591; x=1781948391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vAyKAjmkX6PvmXkxrw5YnaLQ/4sPrlWKfDdfdwHLY1Y=;
        b=ZhaC5HEgr4IuPpqZu7XwpfIVYP9yB6cctMgGwdAYCgBo2+ZsQaRvWKbuYzhMYTigRI
         MKvWgjdugtSCWAGa9z/G8tp8tILalPV1o4ddJJwFpc3QaEImMN1AA8XtTUq20RW7AXdL
         n1nOjGOdHjDT/XemrqAbLMWcO0SAug+SehMX67GWFjpi2nYsZfTw/eY9UUwV8QTSBYIp
         pcUptrV9aBuMC3J6+5h0htm0uFSMvsQhsBsQ0U7sUzwhhEwE3zmq9+vDGapDu/H0cllJ
         bGhg2W2V3UzKAR3A0xTBPCK6k33gZdghvSqDDSBMhL6/V9HvTNhodbvO/U08U7vbCjI2
         INNw==
X-Gm-Message-State: AOJu0YzmxQD963BNqZEe7COrBJHV5bFE5VhX1QW0meQLwff14v1uGFIY
	IYUgEpSdtUeTvkb9DO5jBWneOudveZpGGet5dNyLMWD/hZQHVl0xZj4T
X-Gm-Gg: Acq92OGFC/0zNoYk32Ly4h4oqs6tbYBRQ4VnNJ+3r8ch9qNUW8sS2jSRen9CtoiFnBz
	yXu5RvJfcck5OR7ArDtLrLVqPqn2N6PiNqB9dGfyyK2SHNMHOYGPam0WnN/JUaP30WbifHdnsXY
	DOiEWjtVbZhAhHcsay0hQ1CFuu/kBZA8nspMkbZYn3Rp6QI1auniuwkZamK4V5DCz0qmyrb+8dj
	0iaWDVQYAttTYKIKl/46XXnZj/kgh/XLcgODPXBkRcvY+KncfHncR05KMzxquP3DQfOZXeuPvmf
	C4Ga1yd9I5OxqvL4umYdN+ganPJPprE+wJA7jrP30W7AZGU6+CjCff89fDz9E616okBv2dB349x
	sg5Aw15sV0dPJKudlbZrYhpwV1DRk/o+AJwMAKhI1nwhXZ2nh6UC2MDcdTW6xX39Z1IcyJ+iU1B
	pMd1TYlwGBlVqBPJlQAHQ2ghIs2KJt63BsjGq/4IeFzRKu
X-Received: by 2002:a05:6a20:4306:b0:3b4:857b:1ec with SMTP id adf61e73a8af0-3b795fc1499mr3511835637.0.1781343591072;
        Sat, 13 Jun 2026 02:39:51 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.61.84])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm4155826a12.0.2026.06.13.02.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 02:39:50 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 13 Jun 2026 09:39:39 +0000
Subject: [PATCH v4 1/2] arm: dts: st: align node patterns with established
 convention
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-st-mmc-v4-1-b3c385617c16@gmail.com>
References: <20260613-st-mmc-v4-0-b3c385617c16@gmail.com>
In-Reply-To: <20260613-st-mmc-v4-0-b3c385617c16@gmail.com>
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

