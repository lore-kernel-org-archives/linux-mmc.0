Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791572EF66E;
	Thu, 28 Aug 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374705; cv=none; b=HKPtCxU5tDBi85kmDsnnP4nJj7JfYDy5M+y8//33X3D8XhrKVLnwFKeT0KXHHX/E7NBou0/CEzk/gJRNLf1H8uJLYek5NDw8PcViRkmggbjWuY/suwGamiZWh2iz6/e288HdfTs+1RCLayNyDVo6ZwZxGmIzX5zbojFl1vtFSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374705; c=relaxed/simple;
	bh=TskH+7GDDut36drXu3SgCZtTHGjWiJr+vY2lVLri/UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io3P1O5qqaxqOvWC0OqOJfa6NYI8uqj1ZZzFYXmPRYZP7qH1Rz4I0tHDrF4fnrNZuATAmf6vZGtTb0oUE7+UL+0s1JyyJZs+vBz2sI6tyCo1wJkyoAvrDmxb2txyKGnOsqGYmjl6pqRqu9SGC16IIOpFJDIFWfZjwFRIJfjyb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=MUVDZN2i; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="MUVDZN2i"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756374655; x=1757674655;
	bh=vepzPBjYXSUFrYqzyS7A/BpKb61T6nS2eQf0DEUW5nM=; h=From;
	b=MUVDZN2iNt1PiRmodgpTFDAbxAKL1QrEsMFcxjJ7epGCyeqYpCkPiSbtFbgdBwzZq
	 2AkNMtp4SNHshqGaIay29Fi6/6NMqXPK7qF4sc9wvFtoyzRgvb3tbMV/Qzr0Opghdo
	 JCo/4KPGQK33BmMov+OPJ90Qy0dBRebBKPHLuWdH9JVmB0pd7zt+7PwvvvXAN5CFiV
	 avdNQg6njbH+roGFommiwaHRUaRq1y/z174WHdeeumf9VLU6xrt0LAAm6G4P+m7/fD
	 WCu9Li6PfOY2sB9XfnyM8XRfmtFo+Y1TT08Qi9bBhEg6ttaieo4iWpo2fkgJAZaJHj
	 L3ndID46aW0SQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57S9osTn046282
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:50:55 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH v2 3/3] arm64: dts: samsung,coreprimevelte: add SDIO
Date: Thu, 28 Aug 2025 11:49:04 +0200
Message-ID: <20250828095028.24503-4-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828095028.24503-1-balejk@matfyz.cz>
References: <20250828095028.24503-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set some basic properties of the SDIO card of the samsung,coreprimevelte
smartphone.

The SDIO is used as an interface for WiFi, Bluetooth and FM radio
serviced by the Marvell 88W8777 (SD8777) chipset. Support for this
chipset is currently not in-tree because the firmware is not available
in linux-firmware, however it is possible to trivially run it
out-of-tree using the mwifiex and Marvell Bluetooth drivers with some
caveats.

Link: https://lore.kernel.org/r/20231029111807.19261-1-balejk@matfyz.cz/
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v2:
    - Drop the sdh2 pinctrl configuration which was originally included by
      accident.
    - Drop broken-cd on the node as it's ignored with non-removable (thank
      you to Duje for pointing this out).

 .../mmp/pxa1908-samsung-coreprimevelte.dts    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 0ac1a24dc410..81806f655c88 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -10,6 +10,7 @@ / {
 	aliases {
 		mmc0 = &sdh2; /* eMMC */
 		mmc1 = &sdh0; /* SD card */
+		mmc2 = &sdh1; /* SDIO */
 		serial0 = &uart0;
 	};
 
@@ -286,6 +287,69 @@ sdh0_pins_2: sdh0-pins-2 {
 		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
 		pinctrl-single,low-power-mode = <0x208 0x388>;
 	};
+
+	sdh1_pins_0: sdh1-pins-0 {
+		pinctrl-single,pins = <
+			0x170 1
+			0x174 1
+			0x178 1
+			0x17c 1
+			0x180 1>;
+		pinctrl-single,drive-strength = <0x1000 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0 0x388>;
+	};
+
+	sdh1_pins_1: sdh1-pins-1 {
+		pinctrl-single,pins = <0x184 1>;
+		pinctrl-single,drive-strength = <0 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0x208 0x388>;
+	};
+
+	sdh1_pins_2: sdh1-pins-2 {
+		pinctrl-single,pins = <0xec 0>;
+		pinctrl-single,drive-strength = <0x1000 0x1800>;
+		pinctrl-single,bias-pullup = <0x8000 0x8000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0x8000 0x8000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0 0x388>;
+	};
+
+	sdh1_fast_pins_0: sdh1-fast-pins-0 {
+		pinctrl-single,pins = <
+			0x170 1
+			0x174 1
+			0x178 1
+			0x17c 1
+			0x180 1
+		>;
+		pinctrl-single,drive-strength = <0x1800 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0 0x388>;
+	};
+
+	sdh1_fast_pins_1: sdh1-fast-pins-1 {
+		pinctrl-single,pins = <
+			0x184 1
+		>;
+		pinctrl-single,drive-strength = <0x1800 0x1800>;
+		pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+		pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0x208 0x388>;
+	};
 };
 
 &uart0 {
@@ -367,3 +431,11 @@ &sdh0 {
 	vmmc-supply = <&ldo14>;
 	vqmmc-supply = <&ldo6>;
 };
+
+&sdh1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sdh1_pins_0 &sdh1_pins_1 &sdh1_pins_2>;
+	pinctrl-1 = <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
+	bus-width = <4>;
+	non-removable;
+};
-- 
2.51.0

