Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6D395AD1
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750414; cv=none; b=k5vd/s/oswMCdvNMlR6z1pyOuHm5bRbt82/eqLa/0y4IZYEyeEBxJ4h++Hc0OHeer+RTGCwLZC9QTmhf50jyMgfIp2OaqKCwnwIe4nmHl6JOKnVwLEfMtTajdXUV29SlMxkfZdQHv2q/xRTkvzMAjlV6w5Ljkv4SQ2ivoWUSIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750414; c=relaxed/simple;
	bh=P0M80+dyBiRxJ3qOApePkB80zPAcMBvvg34YfSL9+0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFjfCzO/Ll5RiZzUR4ZSsBSqd1KzBfNVJR4fOK8Erem1yNTUGnFUwJ21i2mmTZoUjnS8nP4Pt3WiiMDNoJTe3DpYF9fiHtgevN/4BufA/SEXF9yb50d8o+ONboQwt086MD/X+qd/7QRzxOkMSKXM6xMImaRyeQJOMSgAuPRbtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu/xBF1y; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu/xBF1y"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-139aaba3522so2358496c88.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782750412; x=1783355212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byGtwtgi7pm6ZOuMJ3fH7+tgRzdrXvaDzEyMgIaZ2t4=;
        b=iu/xBF1yMNyMsJuGZ5hTxUjmYHTPZFTjCyxB3DoS9V4YL0uaJc0Eq5dUcJeJ0rbFeH
         MyTrt75d0YkpGbg5VL06Ic+wEZr4jMstNTinLJIruJOCWw0VF/IH9DXmAkVlGAGXLRi/
         2uI59vhhxWVe2twwz7Ry9Kr39TyTablCJpCsIytTmosJR5n9MNfEF62+FqT4B/dI17JZ
         riUl1fCG4jHfjol+kjnpxohx/cyIWzRSVxOQPhoKoGbGu+/80vdrzK4InGeGORRZvBVe
         ytgHaPhWOZzlveVEI7VCSL7WHyxo4Bw77e6HWL88qPKrSsw0k9NPEJ/gbMg/42pqYhpP
         UyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782750412; x=1783355212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=byGtwtgi7pm6ZOuMJ3fH7+tgRzdrXvaDzEyMgIaZ2t4=;
        b=dtT9WxfYY8xjcwHcXGXiQvQux7rJdbCT9/UfSCQxUqWzCaWkp43lESa0RoA18tXATg
         R0KBFoYW6C8FFZfI9HKDtiHfiGHa4U8ceauuAnT7C+X0zwdSh+CsephbygDEq91NYCDE
         HjaXSor7zVHrLtK0xNQnfki+ZDwRc5MUA8TKa0rNM7qRosvGIqb2m0IiGDDfwhA33GTA
         4CgmyvoMl/JYDbxZl8cJ3lDbDn+P8Lc3Fz5AP8EzDvCG/EczoiXxh2RftqIgM5biIm8n
         LmZ3lSwUSttw3f48lWjPbXFAaBofyTw9tXbSi8WpeQd2Pu7xixE3+EGaIj496S+S9Y/J
         zFNA==
X-Gm-Message-State: AOJu0YwP3b9eOPmD8O5AXjXRSq8WuWTHVc4JYno8CG036tpNy9ooZcQH
	m96hHQT+pVOD1I9fFpmjhhP9ttkQgREiz/gkJtUko45iXg8gcKv95Mau88QPaA==
X-Gm-Gg: AfdE7cklRYKAGeTRPyldLPIOVGBEPHCwFxyfz8imInYNA6+FPivWiNyAewzKqAASOcF
	1j0pEnRetrkEN/xUAhYVKYhvPWDVzql1rBBropfR19hqlVBxHF/RvusW35oK4tj6/HZOq/lpJYn
	iBJEQpqNw7t3FQFAHezbSu+QnDm92Qel8oRnCrtnpouLDIk6kLqXuit6UmEft88GaeRCCupxnC4
	lSS4mVA9W7dRlwDDcaUM0ZoikfHe8w77DrOkkZaL7OcHqgxfHVWNXiAQxIh9gJ5ru0/opyxa5cJ
	3VAh1RYwEtZPi3a2ZWXtcC1u/Vo3nx/cksUeGrtluWILQoCFa6hdo3R57VGj8WNB+U9Efext83V
	AG041QsLvpxyHttoxzb3O7QzUdnX/m1mpzu1apm0hkpA8RkdKJTpxKRWeKMjrVnEWKCcK4NINuH
	RliThIMPuEKdGoJMPfD6PW9f42EvRH5GSMmTaJbi9mhTZ7NA==
X-Received: by 2002:a05:7022:238b:b0:138:43a4:925b with SMTP id a92af1059eb24-13b2a52d100mr21534c88.20.1782750411902;
        Mon, 29 Jun 2026 09:26:51 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.62.174])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-139d912197bsm80851896c88.15.2026.06.29.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:26:50 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Mon, 29 Jun 2026 16:26:39 +0000
Subject: [PATCH v5 1/2] arm: dts: st: align MMC node names with established
 convention
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-st-mmc-v5-1-3cf0e639bff8@gmail.com>
References: <20260629-st-mmc-v5-0-3cf0e639bff8@gmail.com>
In-Reply-To: <20260629-st-mmc-v5-0-3cf0e639bff8@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2

Rename sdhci@9060000 and sdhci@9080000 nodes to mmc@9060000 and
mmc@9080000 in stih407-family.dtsi and update all derived board files
atomically to prevent orphaned node overrides.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/st/stih407-family.dtsi | 4 ++--
 arch/arm/boot/dts/st/stih410-b2260.dts   | 4 ++--
 arch/arm/boot/dts/st/stih418-b2199.dts   | 4 ++--
 arch/arm/boot/dts/st/stih418.dtsi        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

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
diff --git a/arch/arm/boot/dts/st/stih410-b2260.dts b/arch/arm/boot/dts/st/stih410-b2260.dts
index 736b1e059b0a..44048a98648e 100644
--- a/arch/arm/boot/dts/st/stih410-b2260.dts
+++ b/arch/arm/boot/dts/st/stih410-b2260.dts
@@ -141,14 +141,14 @@ i2c3: i2c@9843000 {
 			status = "okay";
 		};
 
-		mmc0: sdhci@9060000 {
+		mmc0: mmc@9060000 {
 			pinctrl-0 = <&pinctrl_sd0>;
 			bus-width = <4>;
 			status = "okay";
 		};
 
 		/* high speed expansion connector */
-		mmc1: sdhci@9080000 {
+		mmc1: mmc@9080000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/stih418-b2199.dts b/arch/arm/boot/dts/st/stih418-b2199.dts
index 53ac6c2b7b7d..4ea174597365 100644
--- a/arch/arm/boot/dts/st/stih418-b2199.dts
+++ b/arch/arm/boot/dts/st/stih418-b2199.dts
@@ -82,11 +82,11 @@ i2c@9541000 {
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
 
-		mmc1: sdhci@9080000 {
+		mmc1: mmc@9080000 {
 			status = "okay";
 		};
 
-		mmc0: sdhci@9060000 {
+		mmc0: mmc@9060000 {
 			status = "okay";
 			max-frequency = <200000000>;
 			sd-uhs-sdr50;
diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
index 8fb8b3af5e49..1a5fbbedc8cd 100644
--- a/arch/arm/boot/dts/st/stih418.dtsi
+++ b/arch/arm/boot/dts/st/stih418.dtsi
@@ -136,7 +136,7 @@ ehci1: usb@9a83e00 {
 			phy-names = "usb";
 		};
 
-		mmc0: sdhci@9060000 {
+		mmc0: mmc@9060000 {
 			assigned-clocks = <&clk_s_c0_flexgen CLK_MMC_0>;
 			assigned-clock-parents = <&clk_s_c0_pll1 0>;
 			assigned-clock-rates = <200000000>;

-- 
2.54.0

