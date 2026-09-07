Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EC46DFF7
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787603; cv=none; b=gIQNXmGTEduxp3J1j3d79euICl1hPHcXCEQdbkbrE+uJ9wk6t8K3OAGaZSIIescPhH/JVX4Wipw5dNueOYjk1zqQQEaHP7ZFF83HghjvFl5DepYA94JDxtjxx58SqUIzejCPG2Fa5IQIVI82bTmQoN9jlrT5gnxBaYmn1EOgJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787603; c=relaxed/simple;
	bh=G5jXm9KUeZYj2Bl7i7D49ZYRWMRfZvF8D6J8EGNejlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCD2v9CRxNxUnlxB4Tuvt2McfbudzLdhMsnktBt4JOKV8k1xX6Mc2DUbj6KZ3DmYHamTecw4+86HkgfSA1iiKomYA1QvXn/0X/QTMt9m8FifZFzjAdTUSTYzXef3w+dXkKkr1LaqLYrk94JhxkTCTXY8SzebdNJ5CCd6KyhebP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=c3PMpTJ7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="c3PMpTJ7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso573913066b.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1788787596; x=1789392396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+tecQI/RAFJySwtEv9OqcvDunXy81vhadYC9Bp1rn4=;
        b=c3PMpTJ7uV3eUQmqwJKZj8MU/BCxWMS/FlDW05chphrUBbMxw/LTrkBm3+m0BSN22F
         rLMOBq6KAtAaQcfajZOsRxi3/+GYrugDHvwnG3Okh+2+sUE+TC6MAHsQ3eDeG7P83x4S
         PmB9aSciY/WcAWc+bMrQFt33zjeTr+Z7svaWILoPEgXLlJhAZWl+ty/6PoGUc7gak2Zg
         A4ZmJGQnKApCkD7/DN+aQjeqm5xrKBcBELYq2cBjC3zd559RScw67SCWDxLkUT6a563C
         K64RNT1vUDzsRvxCGozY9YI7OQaBE422SsTGDUNAvk0OpIyDjSKZoTvlLmY+IEK/PQvk
         ZxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787596; x=1789392396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+tecQI/RAFJySwtEv9OqcvDunXy81vhadYC9Bp1rn4=;
        b=N2j/VP1GJ/GF3Mb+HEhJtTeQ8Rd620fNSTNF2ivalYLX5uUfRE4IkAarY1dMkkjNlK
         llyd5utkEjc8/XOn1TROtDYzvwk9SIAVR66FgImi+1+Hyq6gULSxnkeXhOm47rXBTRCC
         V66YhxTdI28fyZLgVjsun7wWPrF1Vm4usTLhVpuXjybkh26+ZkNRGYnGU+/coskPYGlq
         7uiRyjDjVdtLbQhHZBVhZBP0mBDmBi7MICp9D8UU6ZWoy61x1XKH5MQJlAoDpC9viUpu
         LyIw+NIdUW8tuS/BYfVkO79sVPN4DC6ayB58FBNhxkwSH+d72DPR7mBJQIcUfE9518bs
         Z73Q==
X-Forwarded-Encrypted: i=1; AKwUvBwRF4pyKxeQnNJGN7PGcAYmZGj358jf8BUwa2JvJoN1bdZP4pJiO0Fd70cIrG/loRBDnb6mXFCJfV8=@vger.kernel.org
X-Gm-Message-State: AFuF++ka+/ZkLTnzTRQJXw6wGtfcP2SYbL9Bhu0ugjx3FHJwSa3zuXYt
	S6pfhXGdoFw38yF/80C6XPY8s15FEJiUi88A8HFKjxLoVJifd5lmriLQNoXnCfpUpL8=
X-Gm-Gg: AYBFou39UqEYY0RFX0CYDal595HlMrXPrYiG5jv3R55o/eokAKml7ZPPhgPImk2jDLJ
	yYpmeRjZHflRvFah29rNROoQqhBBbhOSDU4+Hc5VSkkT076mly399r/tZEIGNd28fJ7e8PgjmDT
	Uddd/HeTdtIIRbzITMFpMEQIJbKRcVThQhbps08O3SAXxzmWDhRkmJhrD40bC1x4XxZemShmxjt
	g/Co57f/JlB3QbSngn5AVTR9/qBsKd14LzIlfFURj7j5NsSjsmqoAn6IpA1vR1bB9RKCNEjqKQw
	qjWW13nRLUidC1KA2824+BrG7kJbceiAfEZxfyLipuIOGWuFr5/XTDoTr7Z+InbEKF66Vrh2f4f
	JDq3+a1dcw7obuUyHBDbxU0lRjYo2GwaHTBlFr4dU9atUdL8nob4hVq4xS7dYwabGyz9JTWUNIt
	PEP09jzYtU+sSTjfsV0P6ErG1NqSEJUVNIpgeW3BMgkzdjsT/KivjZO0ADQVzc5HqkTh3t6NPxS
	v94dcRey4IsNNiWn/6RLOuGfmginSehD6YYiOYDbGnf+rlvdIApmNIlTSC3SuVmJg7knNl4EMju
	YByJ0GAIVEaJqFZQAcs8Y5HMiCL2a7guIZrle2m3ZRDsEQCE
X-Received: by 2002:a17:907:d28:b0:c25:8eb7:f388 with SMTP id a640c23a62f3a-c260cc0bcdbmr1608993266b.17.1788787595858;
        Mon, 07 Sep 2026 06:26:35 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-142.zg.cable.xnet.hr. [94.253.164.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm366362766b.9.2026.09.07.06.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:26:35 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	adrian.hunter@intel.com,
	aubin.constans@microchip.com,
	ehristev@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 4/6] arm64: dts: microchip: lan969x: add SDMMC nodes
Date: Mon,  7 Sep 2026 15:25:32 +0200
Message-ID: <20260907132617.1198548-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907132617.1198548-1-robert.marko@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nodes for both SDMMC controllers. Connect their bus interface clock to
the fabric clock and their core clock to the corresponding generated clock.

Configure SDMMC0 with a 100 MHz generated clock for 50 MHz eMMC DDR
operation. Configure SDMMC1 with an exact 50 MHz generated clock so the
integer base clock encoded in the SDHCI capabilities remains accurate and
the identification clock does not exceed 400 kHz.

Keep both nodes ordered by unit address.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Use the fabric clock for the SDMMC bus interface clock.
* Configure SDMMC1 with an exact 50 MHz generated clock.
* Move the SDMMC1 node to preserve unit-address ordering.
* Explain the selected clock rates in the commit description.

 arch/arm64/boot/dts/microchip/lan9691.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/lan9691.dtsi b/arch/arm64/boot/dts/microchip/lan9691.dtsi
index a8541c6a098d..5e330d5fab50 100644
--- a/arch/arm64/boot/dts/microchip/lan9691.dtsi
+++ b/arch/arm64/boot/dts/microchip/lan9691.dtsi
@@ -414,6 +414,18 @@ qspi0: spi@e0804000 {
 			status = "disabled";
 		};
 
+		sdmmc0: mmc@e0830000 {
+			compatible = "microchip,lan9691-sdhci",
+				     "microchip,sam9x60-sdhci";
+			reg = <0xe0830000 0x00000300>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&fabric_clk>, <&clks GCK_ID_SDMMC0>;
+			clock-names = "hclock", "multclk";
+			assigned-clocks = <&clks GCK_ID_SDMMC0>;
+			assigned-clock-rates = <100000000>;
+			status = "disabled";
+		};
+
 		qspi2: spi@e0834000 {
 			compatible = "microchip,lan9691-qspi";
 			reg = <0xe0834000 0x00000100>,
@@ -429,6 +441,18 @@ qspi2: spi@e0834000 {
 			status = "disabled";
 		};
 
+		sdmmc1: mmc@e0838000 {
+			compatible = "microchip,lan9691-sdhci",
+				     "microchip,sam9x60-sdhci";
+			reg = <0xe0838000 0x00000300>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&fabric_clk>, <&clks GCK_ID_SDMMC1>;
+			clock-names = "hclock", "multclk";
+			assigned-clocks = <&clks GCK_ID_SDMMC1>;
+			assigned-clock-rates = <50000000>;
+			status = "disabled";
+		};
+
 		reset: reset-controller@e201000c {
 			compatible = "microchip,lan9691-switch-reset",
 				     "microchip,lan966x-switch-reset";
-- 
2.55.0
