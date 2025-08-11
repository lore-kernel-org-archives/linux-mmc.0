Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7D2E0921
	for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925491; cv=none; b=eSnovZykaEUk6m3wYKmuETp4ZokhRXzL/voDYVGARiGaB33GYabS6S3QSqDPcyBLt8JkE+Hcf3UvzQQSW7Va3EZwFiLOjU24+0NmfAAcJWcljzV4WkBM8cY8S2/06leMCrIVmxnYL92Mrc1fqVHEW8Kh2Ji3DsaSp4e1d/ALorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925491; c=relaxed/simple;
	bh=vBnN8DLO1IyK/FF3eoScaAnrczZfW9FMOyK50IcOfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2PAsHY4aI7jhzeS5I21LDny+nGkfBeGdjQG58lkYWSxPmjMPOga+aCLUE+rLFOgYznNmWGRRFCHzzsVieYtM7TZbwDArXd788/6tV3tUZ3Bw8dOosAiYitHdJXgAmbKR/eHM5BtouMn6/VFJ6cyEHk6CjIVaCcKvugQ3OBsgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TtwUv741; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TtwUv741"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso6245524a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925488; x=1755530288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QaxZi5zsPReb4K2terbRmDrkKgIzfIFAXUsOtzdqtc=;
        b=TtwUv741RNGJY7HqKtHUVteLFKMzl/10aa5Q8F1CQIbjf9WIrneyyKB7TwSn7jOWcl
         LrUP3ExOXDSwIHV7/yZ41eXps3KgzfMKU0rnHY0dl37ghpIfCNUi4LhgeI9RWQpZW39d
         nQ/4BdPwOjovPz1cLu+w2j54ugoE56c8oLBRQgxbmMgrdPyRl6xkRFm6xm64GLFnD/JE
         fC1Y9ZPfUmp30w2D91CZNxSznoZaH72eqSD/z/0iEGyWzUTpV5M1t/dE4HYEneJBrT9e
         NwJy3OFMYdUDgVxaEqgdh1WuBfw7MISO69pUxC5t7SCBGBWgrs1gSKLYt2pAKA/LHP9C
         qtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925488; x=1755530288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QaxZi5zsPReb4K2terbRmDrkKgIzfIFAXUsOtzdqtc=;
        b=FFoV095Ay5I0lZo5xJ64glLogockFHGlG3LHVE0xRFRdk11KzW/3R6paDuutoa58JA
         /3k/HbLE6BjGqSgszpwN6QCJQY4+JUvo6JcdNqe2yED8f1fOUExVpkpBExQHGxVAV1ma
         yNfcCDpblLlNq5/KkRbTenq6rSRytL/Se3xM+Av9n/tdloF28bRUGjhQlKE0MWV5+opC
         uVVZcq7wvqRCobqucYo1KuCWkJIZt8Hd+SJKWPt4PknytvS4e70+XoArKGf6yFMgl10m
         hgsyTkYEQzMQL/yp0nJpZ3cc0NEnw7ASvDpsP1h74QdDMcZb8fYLY3NQzBvDOpmGolZv
         V4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVeVS5fY3sfhxys6tCt8yG+uENnSlHV2LyVjYBSEA+NUGXh1HV35/7Zr0S3mV9ZbGSpJ0IZRWG1R5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/ymNmM6QPvbiwHj4D/xsb5mWINUsS8lkecsYT5gGfl9q/HNA
	wIOKCu/M43RDY8oXjJXn1pG2/fjw+tPz7HJYab/g9pBuxlkOIRGC15pV2ndMD96hNEc=
X-Gm-Gg: ASbGncuWS6ZzatJ8cNHZjkPjPYiZtUIueHakuMh3HJlEJ1PvG6vmBJ3d3fEIwgKboEa
	6c6F9iu6p3dHdbX6BeK8MmMLdMypCn4ZUSMiSM9PhPbTrzIy8NlnGemt048sw9LZ6f+jWbLB1XD
	3c4x5KeeVBz5WqY9TjPOcy5sauePStXVNEQwjuPWY+6WQGndaB6VZ4bvGCOBrvPYyJRkEmBn6sk
	BWvT2DR4cTbM9ZFs08q4a8NVD1QssiFZPFkD7/Wg245pJR1pKJwMdHiyI7JWOvXPwUMfM6vZ0/3
	bxXSq3VtVN8oIHV0Q0ETmekWeS/xEoq2PBquA0FZ+QexNU7VTrVRl87rAsecA0U0XwLdjsGsYmM
	R+piMOtLU6/iAUZ05MKmFCayIZpg8Vz2++PggYT6tZ93drzrROhlPrhnmK4mSSLiYPQ==
X-Google-Smtp-Source: AGHT+IG7LX50cUABOY25rRSCA3T34uMmr0GhqhL/ccQxu60Wns2ZkoR7TW4v+bZeLiM3LVeh427NVg==
X-Received: by 2002:a05:6402:510f:b0:617:b3ee:9be6 with SMTP id 4fb4d7f45d1cf-617e287fdf9mr11118841a12.0.1754925487698;
        Mon, 11 Aug 2025 08:18:07 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f28374sm18923305a12.24.2025.08.11.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:07 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 3/6] arm64: dts: broadcom: bcm2712: Add pin controller nodes
Date: Mon, 11 Aug 2025 17:19:47 +0200
Message-ID: <df99c6a2eeac4bed76bcc6bd74e44a061963256e.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754924348.git.andrea.porta@suse.com>
References: <cover.1754924348.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ivan T. Ivanov" <iivanov@suse.de>

Add pin-control devicetree nodes and used them to
explicitly define uSD card interface pin configuration.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts   | 18 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi      | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index 6ea3c102e0d6..6091a1ff365c 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -53,6 +53,21 @@ sd_vcc_reg: sd-vcc-reg {
 	};
 };
 
+&pinctrl {
+	emmc_sd_default: emmc-sd-default-state {
+		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
+		bias-pull-up;
+	};
+};
+
+&pinctrl_aon {
+	emmc_aon_cd_default: emmc-aon-cd-default-state {
+		function = "sd_card_g";
+		pins = "aon_gpio5";
+		bias-pull-up;
+	};
+};
+
 /* The Debug UART, on Rpi5 it's on JST-SH 1.0mm 3-pin connector
  * labeled "UART", i.e. the interface with the system console.
  */
@@ -62,12 +77,15 @@ &uart10 {
 
 /* SDIO1 is used to drive the SD card */
 &sdio1 {
+	pinctrl-0 = <&emmc_sd_default>, <&emmc_aon_cd_default>;
+	pinctrl-names = "default";
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	vmmc-supply = <&sd_vcc_reg>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
 	sd-uhs-ddr50;
 	sd-uhs-sdr104;
+	cd-gpios = <&gio_aon 5 GPIO_ACTIVE_LOW>;
 };
 
 &soc {
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 0a9212d3106f..8a517261841d 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -243,6 +243,16 @@ uart10: serial@7d001000 {
 			status = "disabled";
 		};
 
+		pinctrl: pinctrl@7d504100 {
+			compatible = "brcm,bcm2712c0-pinctrl";
+			reg = <0x7d504100 0x30>;
+		};
+
+		pinctrl_aon: pinctrl@7d510700 {
+			compatible = "brcm,bcm2712c0-aon-pinctrl";
+			reg = <0x7d510700 0x20>;
+		};
+
 		interrupt-controller@7d517000 {
 			compatible = "brcm,bcm7271-l2-intc";
 			reg = <0x7d517000 0x10>;
-- 
2.35.3

