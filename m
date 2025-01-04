Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838651D364C;
	Sat,  4 Jan 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009016; cv=none; b=iwJllq8KJlKqX9oeYso+wUzpKI9U+e2Lw024C2U4V3dNUnuzktVMUao9Eo9YPyRM2QWOFsFYVfrbrfzaW2FwjiD7yCOvTnJJbhsV6rZ6UdJ0medAW8puuy3gaS8e2dO3O3EzU+ghydn/mqFbJo/xNjEPVLZ1MNerulogBgx16C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009016; c=relaxed/simple;
	bh=dPKQ833edyEcVdeRaMAPYGGBsf88WVzIzfOKhY2RE2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZESO4sl8O/MtTEoY2dvGwjZKb+bL1atrATGUBMMPXFKH64lbUG/6/6+PIKhRpW4C/MNyWIAw1py55Sv3izx0Hh++0miib7Hb5CeWERxjLPm01mk5sRtRNBp1aH9NFIXs51YlIHUa0LWEWMvzEVxRnMNHysxt86oPp3kCOtp1dbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgEUErBW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgEUErBW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4368a293339so95486505e9.3;
        Sat, 04 Jan 2025 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736009013; x=1736613813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpWoGBpI5JjtqZNRK0ytQyJ2WYZd1lAvc/QlVyBoHrY=;
        b=EgEUErBW3kE4iNR7t7+Lbc4Kn+V1p4GmC7Y8DqDmIXTGEyxNZJi66t54ISdlTjG499
         KZ5K3H2OG+L2uyZbxtUZdITSxVTEk9bvXg0Lj0o8tF0Ae+LKXI2f299DzVhGMke2gR3D
         00kEeLNLAS8Ia1xhQ7H01v6mmu7aOdTMzACcExmnOfGrmsD/hUJ+lPRlfZvh7Vur8Q9j
         PjRysxm5QOWk4jUwRaSGvo2AOYROLrd803dWG6kKHki4bWAVF1pah8ECF8NuUvx2hSup
         BmbYf5vepuxptnOjctHv17vlJnpQFpCT71yhNdPOREUjZdyyZ+Ahl0S760439kLl5vwk
         viSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009013; x=1736613813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpWoGBpI5JjtqZNRK0ytQyJ2WYZd1lAvc/QlVyBoHrY=;
        b=S1+xNqYSh+ScuN8XiL0IU3HXy5eIbXG2votO9ukLEzdCujbf6gcguSnbpG8OSjqfXS
         ZjiB6/iwQE9j5OKJs+Nql6T7EKPmhAQg1kXBIOo+L/LJJbbRYwvO02/8taMAyIChrfI7
         DlZrEd3h6Qs+lL8uBTRZxWhjzjEmpprn86+q1o1zSM6r8Xczc0m/i0aj/9L5jIVUDmeQ
         iGRtKPNa7zPuGWvhrUSRnPMG/zLYR9kHLTuiIhwrTnQMoJS69r4aZeoBDDRsPgS2Xyy0
         zufYFhkgiZEGURzhKg4iUbok0fKdXs3gHHAPzuPvGgMgN45hqkf2waQ4m4HvUSGvtgGc
         goeA==
X-Forwarded-Encrypted: i=1; AJvYcCVYCkN5N7Rs5DDHX3hm3NKvA/o3NL0oYcgc8Us2mDeLxvDJx3Alx3Gg8NjIubK58TNN6tyilC67cgm4@vger.kernel.org, AJvYcCVwX6gb+cX3+CMMZTxEalCyy2HVRG9mP5mFaKJz002tNomQL3D0rfhkumxsaRKh4v94X3LpvTlp+3lA80SwCeeVd4U=@vger.kernel.org, AJvYcCXXGRi8VPxYod94cV4OJqOx/5KXRINcFCz3GD1ehoRkPIOzBAQX3MJoc9DhxJPeBwbOIMPt11EzXesHGPxA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaj6N7HbhvwghY6LHmC1jcQbXmOLj+Ypln1Xs9HQHzrCrPFKPF
	VRRBFRI6SDT8wBBnFB1QXPtdvKDstEP5EuUh8Icmwo/dNTiNKWwL
X-Gm-Gg: ASbGncsf7Fr0JSsrHPWmTpjKGcdT9Ag7LHMtEhzGMEin+I5NsoJpvFinBreXQ7OwjEX
	hqZayegoii0fzqVw80iuZEUQvlVg8omX7mXsAvFo8uIFI3f2hx8h4z40WajH3fwelte/Cpyx7i8
	9lZgcM2DL9x0ahSk/8x6rtJzbGQ1IEWEa6WT/cW5zbvXdIKS1agmYXrDVXewdcr71ZOZl1YXyVC
	BVNByQuSV8W3ta/StOZ0a3GH4D2Y3g7w8ActK//CI0woRgUigofJq+gjpRSHxRsiZ+Ay00=
X-Google-Smtp-Source: AGHT+IHfQZz2+NCGzzwq7O52VwrJnAqioRl5raW0vWJTOwnrKjnX1MOwAae3u2Ckis2FUe4UnLwOvg==
X-Received: by 2002:a7b:ce18:0:b0:436:6ddf:7a27 with SMTP id 5b1f17b1804b1-4366ddf7c00mr401351825e9.23.1736009012670;
        Sat, 04 Jan 2025 08:43:32 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm513321455e9.24.2025.01.04.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:43:32 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: exynos: exynos8895-dreamlte: enable support for microSD storage
Date: Sat,  4 Jan 2025 18:43:20 +0200
Message-ID: <20250104164321.333669-6-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable MMC for the Samsung Galaxy S8, used as external microSD card
storage. Since the main PMIC is currently not supported, assume the
required regulators are enabled by the previous bootloader.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../boot/dts/exynos/exynos8895-dreamlte.dts   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
index 3a376ab2b..6c4f8d4a9 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
@@ -16,6 +16,10 @@ / {
 	compatible = "samsung,dreamlte", "samsung,exynos8895";
 	chassis-type = "handset";
 
+	aliases {
+		mmc0 = &mmc;
+	};
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -95,6 +99,27 @@ &oscclk {
 	clock-frequency = <26000000>;
 };
 
+&mmc {
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus1 &sd2_bus4 &sd2_cd>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	card-detect-delay = <200>;
+	cd-gpios = <&gpa1 5 GPIO_ACTIVE_LOW>;
+	clock-frequency = <800000000>;
+	disable-wp;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+
+	/* TODO: Add regulators once PMIC is implemented */
+
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <0 3>;
+
+	status = "okay";
+};
+
 &pinctrl_alive {
 	key_power: key-power-pins {
 		samsung,pins = "gpa2-4";
@@ -123,4 +148,11 @@ key_wink: key-wink-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
+
+	sd2_cd: sd2-cd-pins {
+		samsung,pins = "gpa1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
+	};
 };
-- 
2.43.0

