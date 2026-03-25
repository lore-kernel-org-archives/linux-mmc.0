Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EA38D6B6
	for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774479328; cv=none; b=Tk8z0aJ4OmHHG490FxtvR8IbgYXgNY/uBX6RsA/289cohCjGvmjgo8KCOmMpQuuBf1W6x3rdCQq8U9YxTFhYneEQ4kKOaVbXmZlilmSUh/WJ1SOW34QjH3Ft/oUlGpqOjWm4Z4kbWLWG3gm7jL8QG05BLnPQwVp4xTsp66++jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774479328; c=relaxed/simple;
	bh=yKRao8wed652hxeWQjA+R1P3kTbcNGO6m9lKM7GnMQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akgJCmqXGAjyXOI9WrDfmtqYt/Hll/BWmwsAVFPT8kpWXlPOTfK2lZ5gFM731Igu4V7ZGfF8fl56dDm822myeJvIUGQcqxlmAIjfL7CCWCsPtTTYSRlQyk1CEtklTEjkPnYgTbiCO76cqDw+MTdEG4L3yOzgEYmKwjWZLMiO1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbVdLKQL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbVdLKQL"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35c16db1b53so211681a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774479327; x=1775084127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdqH9GF/jHNSyWBdrNC7S/eoQNumPq7J4tkoPlO6e90=;
        b=pbVdLKQLZ8Sz9tKzOIb/riZazptz3NYKsipr1yu8VEUbuXE0zv8srkW5sSKZHeDnaT
         M8cHUwQN16LvN+rtLmR0J9Zl+NNg/ACuxdcwZTUspjLaGeHk7vP49BE2Af8Uv8LWkkCc
         XkIBtj7z5WjXuuqFY0h9FNH1lScG5BeFhzPnBRp0FM7G80qQnWYJxlJCecN4kgNfsHC+
         sFH9ax0l+d7CetzJjDg9ZSpOrdxDEFzw3zgcAmaCRuPtkX+CI+5PfF8IGrkqYIfKD2RB
         hyxvwhVwD6lWPFibdL+v28uBU3mnGjiBnFcbhmSynM73/17MVPebTMKFO8H+lLP4q0SZ
         oReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774479327; x=1775084127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdqH9GF/jHNSyWBdrNC7S/eoQNumPq7J4tkoPlO6e90=;
        b=e6GUxp+XLALFjLlFsrK1SgfKBGk/bw3qXTj38ZM4V9fijHpH1IG1LNJZ/nELAcQLT1
         bS0lt5N/Xgzbd0vP3JuUK/2EMXcwrbWY0xHnH/mNRv+Vb+rF956G1g518gsxH1jI+Q+L
         adtAtBvx/DwPxChpmsuzPAax23KzclHm9e/v50egywp4WGPIr6z/DIEGAArPx7M00Fci
         cw6cBd6dtv8LMv+eOSbEURfITRBGRLVEwBPdwoLilMkbKAtUmNzuZ7o294mi2wDCZAkm
         HNSOpfXxUOMpbw/SvonYEmNT8/6o2JRgDl0yi1S5BLvcvOPThO+BxIGSO6ViNRmD513X
         M8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq+U3WW//9Fp/SQfhrDHJOfCkMG80ONSnph6uaIxnfSTXr1qirbeZPG99Xtx2Gz4VCMml3ShM+Z68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIriz9n52siY4FEc2TzY1P5gU289wvlzPaC9OdWRqv9SbU6Ez8
	5BdIzv7rVKlgcBNEH1Nt01128laF6XOJgKPS+PUixbzkxSgDyTKdgl7S
X-Gm-Gg: ATEYQzz+DXvEH88WJMO8XWX/wc6AKSeFLxX1lY5yoNHixUWX8WqrfUFxRJlS9Q44YJE
	MtrIubgXP2hJbwVMd8UHABML5BroILjfhl2KKXaS0gmuphljSTPowC/qjbqHIh0aWEhhiOXeGUU
	Pn5JIu3UDDG4a95YL78+5x8MwrpAqnKw+h4x/4GbpOkMUcYYYFj3CbIvUIJnAFEp4OXMuh4jrNP
	1YjjJBbNVw8emiD9Kgd1HKkDgxngdPcv08qYHlLJnY7dV8KXE9mayLn9fOto3xD23OwJjig3PjQ
	FJgJjMhYfOwC+uA59e7AX0h/YU8NP/GupjCCSy52mRtz08J4Roo0XR8oIw6GstWOs/dKBU5hrIi
	jcYfeHfE8hE2Hppp8IsMOABHmamJM93FIQOoU2wYU+lBJOJahcHetpB0UMUC/8tl0xsbO/hXbec
	8mNfcNWN1SbvwqR5HxJYhvlnAA
X-Received: by 2002:a17:90a:e7d1:b0:359:ff8a:ee4c with SMTP id 98e67ed59e1d1-35c0dd11280mr4584019a91.11.1774479326857;
        Wed, 25 Mar 2026 15:55:26 -0700 (PDT)
Received: from arch ([2409:40c2:5018:3ab3:ebcf:9aee:dece:80da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c1e1a64absm84066a91.2.2026.03.25.15.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 15:55:26 -0700 (PDT)
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
	rougueprince47@gmail.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 2/2] arm64: dts: hisilicon: Rename dwmmc nodes to mmc
Date: Thu, 26 Mar 2026 04:24:39 +0530
Message-ID: <20260325225439.68161-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325225439.68161-1-rougueprince47@gmail.com>
References: <20260325225439.68161-1-rougueprince47@gmail.com>
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
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
    - No code changes.
    - Collected Acked-by and Reviewed-by tags.

 
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

