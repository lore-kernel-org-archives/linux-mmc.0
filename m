Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22752E092A
	for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925492; cv=none; b=tlS3a7+gVhnTU08gYrkZLb802W42hGdcKJWcT2IEHkBr4QaVCiCeEs1kgcXABgk671cRCpcfjUDY497NYdFkMxBV64+er/8oQdSK6jBdk8dqYNaIYhyGKHtZO8FIXjbtSqUbi4drS9YyByX0YpwX+7l1vlQorxgU9bC6ZoWe2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925492; c=relaxed/simple;
	bh=7tzlDwbCU000uIS22b9GF1Z4Cn4FUZZpaRhqWJq/YAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luSgBFq8U/tp1uP9vak6ZAHa2B2bqq24LC3y4OTwI7dfdaFVCX5dhHhlr5CQ1KdWGJjYXqJPSn4Dk3F6QO5lBCxB92B7eTIui4qAgcm16QMvKYh9Plsym4vcZei9GJijBCcqEcsBeFd7aP856QXXfiUFtAvuMSFq150mMWh/zY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YhxV9I/l; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YhxV9I/l"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso8525716a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925489; x=1755530289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuvwZFkQA9C7qsU3a5Mf07+vt99ZB7O1MdQDYloQZeU=;
        b=YhxV9I/lmfwJ6fxQPZCJeQD5Wk8UXK/JBWFM5g0Z5HDP6EnultDbRES/XnKLkW5MZI
         o9cg3UYXFb/0SkBWBjk/rqtUMCMoj71eo1OUXDhLL+zZfAU4PLdon5K+c81DeaswLN1B
         Mk6aVd9gI+h4T+g4T0XcIUs0qQGoyiFOsW2B0CQyOMFRkAhjPuhfS2+4FfSGg3z3N+fe
         ovKuD/5HyBKW1sM8DnyO81mqA+lzZyb7XfWq4bqiG7hlwOslLAtU8km0wPhzCkpMgJxb
         aqQyO3k7oNZQGmWPxk5pUXEmJ/GlV/piD2mlAMe5GcUJdMpNavbXuI4P/qS3+fRsdbnv
         Noew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925489; x=1755530289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuvwZFkQA9C7qsU3a5Mf07+vt99ZB7O1MdQDYloQZeU=;
        b=DsATSBIw/u6FmQvaEvNqQWKmfTL4EgNRtgUPM1I/SjSMvnQMLdv7FFNQ9TN/bnVq1W
         bkcCpTScn1tfPqjCKDZV5d+caShznbknOZ/PZlD+0cb7lbCU9QjSlZ59aumW3nbxoIW9
         Nqhle+nlIq3BX9qcfFU1RkUapB5e49vDb/I9uqeUwgwPCdFDoKJ+6jk6J3eskdc1eb5k
         yYef/rwkypr1qmJiHOLSdW1F/UccWpYxwXp0URerZO5A40xmp3CHZtK5TxfUJUREcaDy
         tmu/iMGHHheSUpZkqS6pQkBz7WglklNMx9ThMRXXd/wVbQkdujL1kat2AjQErp9bZw7a
         FcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpKhWEgOi9DYjDTvXxOlYThQ2SsOw842qAViAqrtHwoJALwPKhmwYUfqBAlT5Et5Ho0fKHyi/l6EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ESfuxfrCA3EcD37ZbgDp5LpeRmosYuIJnMeYqfhwW0PDbFf5
	d7zsb5PgkPZfNP1lti5gg5jfLfm50Lj/ut0FAu2YgQHbUb/NZkuPTJpz6LRxcQMvDi0=
X-Gm-Gg: ASbGnctqEwUm62FCUbC0PHeK4A/3RcjVm48MRf3oGdzhn08BOzbp8y7t3N9NLDAUHBq
	ryBD031J0IGVztqOBek8SGlarPUnAllGcvJ8e2urnjVkuefg+rO2TH8JTlXcoV0oR/CMrasMcpD
	TR0E1KvqOyLdQ0SVi4NsXYnFhxk7vbmHivw8/6pLag2Wzv1DAANk/SO7jmiT98yYOX3sEA1x05B
	DndHkMSYEGiOppdNzS2aRA2zMHtq98+kZIqhsTBs7UNnZE1cwfhlFcQSExZc4BgdpHbOUbmuzrN
	zjlL6Ws7FW1TaOMwsnujl0SyUjVvSyWzHoBhfgBPWN8+c671476da9n9btiT9zvwyxBJh/61rEZ
	pyJWDJhhP+QM+zCNEAvBAsyis61OhjYYICHCPg6YM71mhRqNM1A0hl5L9RsuYkQpGHw==
X-Google-Smtp-Source: AGHT+IEIVBs9d0xdJDBl+mpTiXaCmyfbfIFlGuElvhGMrwN5kIk4NUp0IcTo3IUJQ+HnGSN/veCQVw==
X-Received: by 2002:a05:6402:3510:b0:618:87:bb02 with SMTP id 4fb4d7f45d1cf-6180087bf86mr8011371a12.14.1754925488901;
        Mon, 11 Aug 2025 08:18:08 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f152easm18386370a12.15.2025.08.11.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:08 -0700 (PDT)
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
Subject: [PATCH 4/6] arm64: dts: broadcom: bcm2712: Add one more GPIO node
Date: Mon, 11 Aug 2025 17:19:48 +0200
Message-ID: <a86e12a27f4e89f4a95fafcd659d32e7049456b6.1754924348.git.andrea.porta@suse.com>
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

Add GPIO and related interrupt controller nodes and wire one
of the lines to power button.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 21 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 12 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index 6091a1ff365c..f0883c903527 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "bcm2712.dtsi"
 
 / {
@@ -29,6 +30,20 @@ memory@0 {
 		reg = <0 0 0 0x28000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_button_default>;
+		status = "okay";
+
+		power_button: power-button {
+			label = "pwr_button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gio 20 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+		};
+	};
+
 	sd_io_1v8_reg: sd-io-1v8-reg {
 		compatible = "regulator-gpio";
 		regulator-name = "vdd-sd-io";
@@ -58,6 +73,12 @@ emmc_sd_default: emmc-sd-default-state {
 		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
 		bias-pull-up;
 	};
+
+	pwr_button_default: pwr-button-default-state {
+		function = "gpio";
+		pins = "gpio20";
+		bias-pull-up;
+	};
 };
 
 &pinctrl_aon {
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 8a517261841d..f70ec8d3dc4d 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -248,6 +248,18 @@ pinctrl: pinctrl@7d504100 {
 			reg = <0x7d504100 0x30>;
 		};
 
+		gio: gpio@7d508500 {
+			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+			reg = <0x7d508500 0x40>;
+			interrupt-parent = <&main_irq>;
+			interrupts = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			brcm,gpio-bank-widths = <32 22>;
+		};
+
 		pinctrl_aon: pinctrl@7d510700 {
 			compatible = "brcm,bcm2712c0-aon-pinctrl";
 			reg = <0x7d510700 0x20>;
-- 
2.35.3

