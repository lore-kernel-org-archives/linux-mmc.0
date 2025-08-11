Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13C2DEA9D
	for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925495; cv=none; b=i9cm7Ri8IWsCFMSUTge4vPJZjzXiqg1GtYI/f7vq2ofYU8FTeJw5DLWpbB9cRzU7+RyT80nMcqQXGqi6WCO0dgPFpxnqaFEGZ3X3cwPtZB4nMFYYyltZmhJbyWJhMXTbGnC1N1UuvHx38D8PeikMHs4hKooixsdoT/Kf64VnYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925495; c=relaxed/simple;
	bh=CtH8XQtPGXolbBZdVmqnACGN9ZTA/rgd8EyPJEQl8lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kohhohEwVvjmlK26kBjgdMQiTB9n+YeWIZlGUjf4bd5RFnDlmWFp/WerriYN9dd55X23w+HjcgAwW/MoSR+VTG+dTlPrizqeQ++ZGB//Z/bdrfq8jRzCzcEBw7S4MGQ3OHKVdIygSiK4VJwEsqatxjG1YrtOqZBo/eAgolzEP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N4MZSGjr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N4MZSGjr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so7048282a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925491; x=1755530291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fng68D5ON4MtHXF/Xvnv7dtbGS53hmAqmZqCopjU5kA=;
        b=N4MZSGjrTHK1RyGCBMZEtLB+TkRTLLTvEuDZ75qEdazrdweMnCKR8CPiv8esZvZjmk
         4zP7hbEluUgfCcEjSg6lZoxaN8ZQxfaNKxMDQgGXw0pdDwxe3q1BGlDwNkx17JHQ3WAy
         6pm7gxigwRaDt0JAI3gcndlpQrQ7qvo64D4bHylJcFlncG5lXCQtChA2/BcDu1TqMbpt
         QqzDikoA3aBMFUIx9Wk5HKv6J0U+4/+LUZGiZAPuoZxbivzavar7MQZwQDW/pH0cqfK0
         OtJciwIOQC/mq8gPqK7x8AaIRhiEkV2AiNSWzhjmD4jzayYVaOUrysGHN6aUN8n9omGb
         i9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925491; x=1755530291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fng68D5ON4MtHXF/Xvnv7dtbGS53hmAqmZqCopjU5kA=;
        b=q+OaViQy9xXHQ0fsKMyvIh8p8hnBV5+ZqT4IJR1ccj80jQNGKjeWbNDAQL00DWryQ+
         t6ww1cpT2jfl5E4rM1NTv9hQFOWXLY6Tr1f8031UCv7/PT/J1gqr7kNMIFsxVDa4au1T
         d57JXFrLWWalvIHGJZHmmxtACsshsy0WVEx7qeqJkDEEkAfApyOjlZ8WQZbUxeXCxYmk
         GlwE3+s0DtQKpNWMhUZxs5vTGTvphxaeczs9TLJLrF0/uEpSKmFT1+dSY9FPNVNxkKEJ
         OCCljpMYtUynl9jGIMEenPNcfaLT0k3o9viorhNYP2jzHANEOPz9EtLu4klvkif3Flxo
         /1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXoyHQvpJJopb4OVWX/U0++ZdmnmqJ7jqvmOL7yRCMa7h2ngqhXOelMsPzO5fJ32OEDDz1Voe6tthI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZI2VjdR6hu60Tyn8waa1OmFM1pH+H/0W+/jAW+bZooRlFN2z
	Q085Eppo7MwSX4ERqstHzaXZNbu14PK045Zs8shwP6ceij60DBkIExnk8SVjd/lTcz0=
X-Gm-Gg: ASbGncuiu3u8dft+P6CteZKN5/EX8SxBGhOxNH8YmzxLOVy7R+Xzyof3TR7EeE74vkW
	D1XN2rYbI5RACgx68qlY6Mr7fIzysRfI2rk0bCVmIlFBWmlmxHaQ0oigievFqoGdGFEGnPPPzoN
	aktWzSzn5kNmAjQkahB4Oi7+8uv0aJrgqTvV5G8jAGRpQcGQXJS4NdxFwTL5psBoWrs9g+LjGnp
	Nebka2lozOiiN43DotBGy2O3URMGVgRBTwrTf4Ah4/X1Gfu1Szo7ZJ3ozTtG1ILHGOOrD8NbeB6
	AkcL18DkDnhTk2CQqSR925G4sgh6iDViuTnCJ+yjGZ8XAdMALZmSQopcUudSBrwbjUjiaSC1ALV
	NQM1a8NBhF18EoR65HrHYSyJNA/ttn/5pJfnmUGpFvgRg6VWXSUxWNRtz8jVOhnEtJA==
X-Google-Smtp-Source: AGHT+IH258sr5DlmoIs2dXrt8URBUrKXF/WgpLPedlCY2bJF2kB5AZhyPhcJHZNSotah9gafIa5oGA==
X-Received: by 2002:a17:906:3687:b0:afa:97:55e9 with SMTP id a640c23a62f3a-afa00975734mr328441966b.36.1754925491486;
        Mon, 11 Aug 2025 08:18:11 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21ac0asm2033507666b.99.2025.08.11.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:11 -0700 (PDT)
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
Subject: [PATCH 6/6] arm64: dts: broadcom: bcm2712: Add UARTA controller node
Date: Mon, 11 Aug 2025 17:19:50 +0200
Message-ID: <c61b830b6f8f691aec9607b4707d3146bbd2ee84.1754924348.git.andrea.porta@suse.com>
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

On RPi5 device Bluetooth chips is connected to UARTA
port. Add Bluetooth chips and related pin definitions.

With this and firmware already provided by distributions,
at least on openSUSE Tumbleweed, this is sufficient to make
Bluetooth operational on RPi5 \o/.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 42 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 10 +++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index 411b58c1dddf..04738bf281eb 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -81,6 +81,11 @@ wl_on_reg: wl-on-reg {
 };
 
 &pinctrl {
+	bt_shutdown_default: bt-shutdown-default-state {
+		function = "gpio";
+		pins = "gpio29";
+	};
+
 	emmc_sd_default: emmc-sd-default-state {
 		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
 		bias-pull-up;
@@ -110,6 +115,29 @@ dat-pins {
 		};
 	};
 
+	uarta_24_default: uarta-24-default-state {
+		rts-pins {
+			function = "uart0";
+			pins = "gpio24";
+			bias-disable;
+		};
+		cts-pins {
+			function = "uart0";
+			pins = "gpio25";
+			bias-pull-up;
+		};
+		txd-pins {
+			function = "uart0";
+			pins = "gpio26";
+			bias-disable;
+		};
+		rxd-pins {
+			function = "uart0";
+			pins = "gpio27";
+			bias-pull-up;
+		};
+	};
+
 	wl_on_default: wl-on-default-state {
 		function = "gpio";
 		pins = "gpio28";
@@ -188,6 +216,20 @@ power: power {
 	};
 };
 
+/* uarta communicates with the BT module */
+&uarta {
+	uart-has-rtscts;
+	pinctrl-0 = <&uarta_24_default &bt_shutdown_default>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+		shutdown-gpios = <&gio 29 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &hvs {
 	clocks = <&firmware_clocks 4>, <&firmware_clocks 16>;
 	clock-names = "core", "disp";
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 871537366e96..1ed26a211ed5 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -260,6 +260,16 @@ gio: gpio@7d508500 {
 			brcm,gpio-bank-widths = <32 22>;
 		};
 
+		uarta: serial@7d50c000 {
+			compatible = "brcm,bcm7271-uart";
+			reg = <0x7d50c000 0x20>;
+			reg-names = "uart";
+			clock-frequency = <96000000>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart";
+			status = "disabled";
+		};
+
 		pinctrl_aon: pinctrl@7d510700 {
 			compatible = "brcm,bcm2712c0-aon-pinctrl";
 			reg = <0x7d510700 0x20>;
-- 
2.35.3

