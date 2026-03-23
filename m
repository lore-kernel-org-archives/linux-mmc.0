Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9D3D6483
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295090; cv=none; b=UUuXNr1oi0a8c5Fa24KBRxMga0zTwARyFHbzmV6HC6SM/uh3zty2JkrZZgYEcTp5RwjA/ihG2Ov4rK+epthSy0vSh9zuRJPxFdLxAztggA/v7WOjP7dGRzEHfxY5eaKGTiQdUgF7VNitSCaOOHzLRrR/cxGUGb++tQ50TOIbTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295090; c=relaxed/simple;
	bh=2eP39sb43Kgh9fhyqShnq22EdSMyNVuTucPevw7/1pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8uaD5LECaOOX5lQCBfICBcXeACzEOVEFMaYOC96If6UG6y2nkWGZmQN1gIyQJVUdJ2L/Vy6LoknwDlZqFVpSkDth7VpZTA0hPBcl9B/89EvUVzZ7cIMoZTTqjSoUen8uvR/kPkIAw97vou6FYS+cbGxyYBeiXFfwdLAwAXcbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvZnlfhO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvZnlfhO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2addb31945aso33639095ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774295089; x=1774899889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5NEDQbOtjDud7bnDY+GwHBPLXpf4/JRpvLsQ7SzQtg=;
        b=SvZnlfhOk/69WscY1rDeLh3LwazJjekJb8/E5q4KumsRMOz5DATdsLJwLdxtgVBx1C
         bijWObxAdn9nMpRpD7jC3Pc6TGc4hvMYKR7EcCWRVLhHOqBenONXAlELSqUtgLcp9zlm
         dbq8lNTlkDei5iwk4Kc9m1J+eHCLhYuRMLZvMPqx5UvmReoNTzVJARAXUs6z022WO7V6
         QAGBnIhpo0WuBN/7UalVUKxbZzHTdyICAjV8HS40YSrUIHe5o4t+Ky+ve2W37gisecsJ
         u2BU3BAzPAyDrcdR3X9SP4XvFLuqpSVeAaapskzpQqeTSSIRAHpLgfUyIHmtypCsswx1
         JpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295089; x=1774899889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5NEDQbOtjDud7bnDY+GwHBPLXpf4/JRpvLsQ7SzQtg=;
        b=DTZ443roqzugYDFrsaPc4lceAQ90Ua+Y4Xt7bVuXprMXUCCAQNqjVUtm9C4ea/DKzx
         aPuwS1UcQ1Hr1/U/kwxL+cMcPF10CvEfrS/IC8nDZyzXneAjqCdWBH5fZn5oxdOR/vsn
         0n5QiKjeU83svmKNZJgs2jSBgUZ+//Xw1TCfQJWUIX3HOvFAgHYlZehcEG/XZNJmgQsd
         xZbVWwpw9kiD2IjivaV2ybY1qevO5vchiddwaZPUBzvBZ9LoX+F/rObbOSRkqwJuF00V
         jEXbTodUBYgLL5/tbrHCECbcG6GoB1zVps6fcR7qQDFkjnfES1TmKnaq2C8qmhyK9qQH
         7wnA==
X-Forwarded-Encrypted: i=1; AJvYcCWF+bT+GlOw8o4f+yn6c/pgfs5DuIsfUQbcJKmdiYEUbaCqmjFdr7tE3yOGvf89qp+/j7GivHxOpwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6V5qC8M9LDJxW4LeZrWpBA/vGVlVrzoLKJ1zHMbXIsoCf2Vih
	un8Si+lNFsVQKzF1oK+OjuSF9Ly862+TGwojSnd0z1Abhln0r/HUyOsT
X-Gm-Gg: ATEYQzwBKk+Cv1qrlwLwno5SMzK1y5cul7FSfYP93q/f78oKFP1RcVDybRJ/N/7cigC
	zknKs22RL/UfNvTGLt+oGa4cApl3k8JRmT5WOEcE3p7h/xyMi6dpmexHnLpwkMsKVq7R1xc/491
	8w+QqBQ+/5oWOijuPoe00sdiZsZwH7QwTqHlFhZI5waCuszIQmz5sJG03Xz/TDLDp0gAcJi+KH8
	BgETlqRPPcLRab1+yhL0odLRW04v1CkR/DTEczBxnjBApQwyJxr/4dr/DYZbOgzOyEgZqOrGSRJ
	heoyXd0nE1MTZMf+m0PfHuHfsQsgppJgZtR0JvuAAa7HME40Eqz6RsaQdFapMLRtPvAWyl9eM69
	ZgJC2iQlQolWfhVHYfxJGxz5vTFxRzPD4xSuBcXlxhDRkttdj5BMgvk532M4TaQJyl4YaQVgFDS
	CdHOG0YMBIWzKIM52KHK1biFQCX9MK8nDtEg==
X-Received: by 2002:a17:902:c950:b0:2b0:60f1:de58 with SMTP id d9443c01a7336-2b0827d1a18mr131462675ad.45.1774295088929;
        Mon, 23 Mar 2026 12:44:48 -0700 (PDT)
Received: from arch ([2409:40c2:5005:bea7:1ec:aaa7:ee5b:2371])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c3f7sm152080805ad.60.2026.03.23.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:44:48 -0700 (PDT)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xuwei5@hisilicon.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	zhangfei.gao@linaro.org,
	linux-mmc@vger.kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	rougueprince47@gmail.com
Subject: [PATCH 2/2] arm64: dts: hisilicon: Rename dwmmc nodes to mmc
Date: Tue, 24 Mar 2026 01:14:00 +0530
Message-ID: <20260323194400.22886-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323194400.22886-1-rougueprince47@gmail.com>
References: <20260323194400.22886-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core mmc devicetree schema expects mmc controller nodes to be named
using '^mmc(@.*)?$' pattern.

The legacy Hisilicon SoC files (hi3660, hi3670, and hi6220) previously
used the 'dwmmc' prefix for their nodes. This caused warnings during
dtbs_check.

Rename the 'dwmmc' nodes to 'mmc' to comply with the standard schema and
dtbs_check warnings. The legacy phandle labels are kept intact.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 957a1b41f19b..374aa173bec6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1057,7 +1057,7 @@ ufs: ufs@ff3b0000 {
 		};
 
 		/* SD */
-		dwmmc1: dwmmc1@ff37f000 {
+		dwmmc1: mmc@ff37f000 {
 			compatible = "hisilicon,hi3660-dw-mshc";
 			reg = <0x0 0xff37f000 0x0 0x1000>;
 			#address-cells = <1>;
@@ -1075,7 +1075,7 @@ dwmmc1: dwmmc1@ff37f000 {
 		};
 
 		/* SDIO */
-		dwmmc2: dwmmc2@ff3ff000 {
+		dwmmc2: mmc@ff3ff000 {
 			compatible = "hisilicon,hi3660-dw-mshc";
 			reg = <0x0 0xff3ff000 0x0 0x1000>;
 			#address-cells = <0x1>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 886b93c5893a..0db1849a2878 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -679,7 +679,7 @@ ufs: ufs@ff3c0000 {
 		};
 
 		/* SD */
-		dwmmc1: dwmmc1@ff37f000 {
+		dwmmc1: mmc@ff37f000 {
 			compatible = "hisilicon,hi3670-dw-mshc",
 				     "hisilicon,hi3660-dw-mshc";
 			reg = <0x0 0xff37f000 0x0 0x1000>;
@@ -698,7 +698,7 @@ dwmmc1: dwmmc1@ff37f000 {
 		};
 
 		/* SDIO */
-		dwmmc2: dwmmc2@fc183000 {
+		dwmmc2: mmc@fc183000 {
 			compatible = "hisilicon,hi3670-dw-mshc",
 				     "hisilicon,hi3660-dw-mshc";
 			reg = <0x0 0xfc183000 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index f8b56d443850..61eaa7f8c1c9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -799,7 +799,7 @@ mailbox: mailbox@f7510000 {
 			#mbox-cells = <3>;
 		};
 
-		dwmmc_0: dwmmc0@f723d000 {
+		dwmmc_0: mmc@f723d000 {
 			compatible = "hisilicon,hi6220-dw-mshc";
 			reg = <0x0 0xf723d000 0x0 0x1000>;
 			interrupts = <0x0 0x48 0x4>;
@@ -812,7 +812,7 @@ dwmmc_0: dwmmc0@f723d000 {
 				     &emmc_cfg_func &emmc_rst_cfg_func>;
 		};
 
-		dwmmc_1: dwmmc1@f723e000 {
+		dwmmc_1: mmc@f723e000 {
 			compatible = "hisilicon,hi6220-dw-mshc";
 			hisilicon,peripheral-syscon = <&ao_ctrl>;
 			reg = <0x0 0xf723e000 0x0 0x1000>;
@@ -828,7 +828,7 @@ dwmmc_1: dwmmc1@f723e000 {
 			pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
 		};
 
-		dwmmc_2: dwmmc2@f723f000 {
+		dwmmc_2: mmc@f723f000 {
 			compatible = "hisilicon,hi6220-dw-mshc";
 			reg = <0x0 0xf723f000 0x0 0x1000>;
 			interrupts = <0x0 0x4a 0x4>;
-- 
2.53.0

