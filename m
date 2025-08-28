Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE231159C
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386930; cv=none; b=PtaBLsbothUNQSyEE+oLpQbtx/X+XIgPSM1DYv4PHqQljOoYBXOkqJT875ifbimHmStueEwhBOsvGlkhb2wlskodb3TvnE74vKx0tEnB31MYE/llMac4PVxfz7zN/40upr88ijv2PJa7BThjXQ76hlFZupsG8P3UpGEszEN6tGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386930; c=relaxed/simple;
	bh=vBnN8DLO1IyK/FF3eoScaAnrczZfW9FMOyK50IcOfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT1ypQXCQdssgaOKI87NiL/onjQniuPHXuozmcZ0NfXQSKbHsCH6z3/Lt96B66xPoK0NcRlBaIKfUt8s77vNh2uoOL4U7Y9uL2mDeD0vzi9GkqkwVmBua02UE+S3KvoAMvbjwb4AzdvWUbfleMAHBZ5PtPphdiZRciy0G6m3I/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PSjJ/pY2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PSjJ/pY2"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afec56519c4so115126766b.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386927; x=1756991727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QaxZi5zsPReb4K2terbRmDrkKgIzfIFAXUsOtzdqtc=;
        b=PSjJ/pY2eHJ30+7hqCkAT+PHfREf9R7gSZnFgsbOLtQ3Ksp2ZYbkB7ci3TTY4g9nP5
         GTSFJGWBm/JEO6uqUy+DOu8NnmV35AcoTcitSVcZl5VL3i4x50HMPexRSiFjW40zTvc4
         5gIFRZj61ptGRICNfYAr3ryxZNrGw4drY5wCQzjCMhoaQ4cwon04ShzHrMO7KFy4zWTY
         8tnoeq2akV3EUT3JekutlEbHIe5AykAGjVCGWExXYwhItL7Fw7ob/fLvVGkmcPrhGins
         E0O7cGbuHPZW+lUp+avaHrTMc6qYusbieVvyq9vPrORB4qXSPTOdcJbK1f46SjvTWOoc
         x4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386927; x=1756991727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QaxZi5zsPReb4K2terbRmDrkKgIzfIFAXUsOtzdqtc=;
        b=EUhP4WriUDIx6ByQazytKtYpuZtdloqyFRPBj81uUIExAeeXsrjT8VznKkpLFr09Ov
         P2FFiyBVDJIRsDlo2AJfq/6vEQvoCO8mOH12qXqr6zeErMj3ERYNRzMMOf3ygD9AkNGp
         quf5gKdyH8jCFXepQsRMqQs292itbFKZ4XiJ4GA4XKkIiS+/xEkt6UIWjjOKY68f7AYm
         9uW/Ln10YcuNb0v7fG4rNOUvMo+NPo0Dnz/RsO8L6iUyEr+GS0LelYMb56exHWFP47ja
         cJSXWQ4zzFWES8TttxdyMUz0j1CEcchAy03dMqrZIu+jRgoBzF5cbwkT74K1KVyqPFxv
         tAOw==
X-Forwarded-Encrypted: i=1; AJvYcCWSZSx5+xfxJeZg2VncicEVNX8eox13vC0/vzK3agmvTYcLfyHdS56kyiU8irYJgLmqU7EcYpX+p/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEozZU+rQqJ5BmPlgT7A/tVdZZd+GtDr40x9bSPH6fk8/N84/u
	gIXPDpN8u9H8DTJLOKDym3URgjpljpu3PvF4fvzHKv3ymYt+OffqphvNeCCiGghxd3Y=
X-Gm-Gg: ASbGncvjPoQvpZZ/+wbFXR2TG6hUp6rsrD2CWCfqcABfri45+J7CC1FT5/7LLfXvlNM
	Zx/DrfL2gpAxIlQXw+gI+4oSo4/oiqdCXjMQH+QfwNBFKYjz7Flq8S7VrzRvxLvQm9i1uZyjecN
	bFnsUm7mx8H3Y6cK40nOGazMCTLBIYZgTsroo7jxm/rTNiktCQXGAFB+aTrSVu4/JXMDlxLTIcc
	ydhKo17v0YVsCbSrnUPGO9719mWa+L/d2JijgF8cPbBieLSwWY/P+xei8mAtSXA+j2yl4or764P
	KqK7GkuV2p9/5MoE7tM7T8Q6SwnaU+7Xch1HA3pgPXbUuI4iTiz869PlqI5EZPyOR8DU51EJqz4
	R9jk59NWDapHcDfBxSfHjubPiidULRaYZyu2ea5fipun5q11aJ2YjmDxJNfxep0PSr3UNOjXGTY
	RcTsfMs6ILFqqDIwI4TpkN7bZ2w1Q=
X-Google-Smtp-Source: AGHT+IFASTcYU1kmiPw/dIyGBabTtHK5TXjK29v0S8XCQMxwAXDktvkvQ4lV7/Zr24KakzZQ7bRZwg==
X-Received: by 2002:a17:907:3f82:b0:afe:d1cb:632a with SMTP id a640c23a62f3a-afed1cb6ea9mr444267566b.37.1756386926851;
        Thu, 28 Aug 2025 06:15:26 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe9c908414sm641942066b.97.2025.08.28.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:15:26 -0700 (PDT)
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
Subject: [PATCH v2 2/5] arm64: dts: broadcom: bcm2712: Add pin controller nodes
Date: Thu, 28 Aug 2025 15:17:11 +0200
Message-ID: <5ceba8558e0007a9685f19b51d681d0ce79e7634.1756386531.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756386531.git.andrea.porta@suse.com>
References: <cover.1756386531.git.andrea.porta@suse.com>
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

