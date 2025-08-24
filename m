Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50391C8603;
	Sun, 24 Aug 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033342; cv=none; b=hxAHlbid2Pw2RUKrkMoqB8Cg1fv1/LsjsGsfwaYmPD90yay8ae/4z6gHjNnXU4H3NfdoIpTGT3f98U8ShjhE4dEhLlgoRMXU6VSKmdSDhuq71Ud71eaOQEufI+ctoPRELq+dj8W3vdbtHwkxdbGjRVnNB401HF/cTjhAoCLFqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033342; c=relaxed/simple;
	bh=2AVkNJrzePsAwMqI0z9iPMD2+BeeAMyJ8+B2Mp+EkRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBcY2VO1jTCVANCeQ+vxN7nFgd7r+AO/p5nqNOouEKnofLDd6JNlwhJOxn3EUAGz0vlWkpdJOAuS/I2JDghatLbfS0X8ypQg7D9RwwqY/SjSMsTawQuaOEJ1H32LbpZPMzBG0MWo9tfjxgzZh8vUAvm9Tx7qLlbaybqSJMdlSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=AkLRjobE; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="AkLRjobE"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756033282; x=1757333282;
	bh=BIttbaon04d2Rvlw9j5ImGFlCSyQwHXs+hliMJ7LO+o=; h=From;
	b=AkLRjobEuUDghIilXe3TbwaEbnRywcDUzkz+gRf8Xt0NDsSJ0aZ4MIl+HGE9aHUSM
	 m9TK1pWAvaDQY5nguuP+HT0iM9dcmDC8b2G5R4EKPdAY4fmZUob9Hpu93gxWll8BVV
	 odXnZvDoXpcnu3++yj3+Snoj20kFUzW5XkRz3SoVf9a3t8Zjd5sAGqdgONCM0Zn4MB
	 8OHd6b1CsGYAYZigjCjtvUxAr1hbh2llGPNTWb6WNFm6Be15d6yjzswiYiexipXJeX
	 8FkPlHYw24vtKcSkD3j46vUib8cP5k6z22+DZ+7BnWBBP2Iop6TGnJ/HxcvaNyWRNu
	 1h7QUM9DxATGw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57OB1L4X083631
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 24 Aug 2025 13:01:22 +0200 (CEST)
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
Subject: [PATCH mmc/next 1/3] arm64: dts: samsung,coreprimevelte: add PMIC
Date: Sun, 24 Aug 2025 12:53:43 +0200
Message-ID: <20250824110039.28258-2-balejk@matfyz.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824110039.28258-1-balejk@matfyz.cz>
References: <20250824110039.28258-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bind power management chip to the samsung,coreprimevelte smartphone.
This enables support for onkey and RTC as well as for regulators two of
which are explicitly bound here to the SD card.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../mmp/pxa1908-samsung-coreprimevelte.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 47a4f01a7077..240021e7a371 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -303,6 +303,28 @@ &twsi1 {
 
 &twsi2 {
 	status = "okay";
+
+	pmic@30 {
+		compatible = "marvell,88pm886-a1";
+		reg = <0x30>;
+		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		wakeup-source;
+
+		regulators {
+			ldo6: ldo6 {
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo14: ldo14 {
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
 };
 
 &twsi3 {
@@ -328,4 +350,6 @@ &sdh0 {
 	cd-inverted;
 	bus-width = <4>;
 	wp-inverted;
+	vmmc-supply = <&ldo14>;
+	vqmmc-supply = <&ldo6>;
 };
-- 
2.50.1

