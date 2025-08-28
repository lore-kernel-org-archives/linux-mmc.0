Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A492EE61A;
	Thu, 28 Aug 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374705; cv=none; b=YOjttH0NgcgRRA0F8Uptn5gVGBQBjLOTBfqYPihNbIalfMwOgw7Sm7wut1rwH+QJBeIjX3KbIKLHFQYxAeMNDd+GeH1CQgpgB0MhpeOdkXjzE+r/74BerHPPcM/5MrUy7Bh6WV202S3CfLeo0aEBhzSPF4ZhZJu2W1qPuF16AX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374705; c=relaxed/simple;
	bh=slP7/60xw9V0znMJSY4CskRnp7DU5hJfO5poLMUYqmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1QIpg4B9+2xWp3Z4Q3Xmolw5LRQyXfUsziS9TKrtgrD5PvgwhwpQsmWipXKCmFWBQYZKs7M0qi8epf9dlioyVGfKuEnof1G9Fg84fhafVS0aSnKmsBoTS69kBedHg3IU/cLwjNeT5XaCwzMJrUHgwKAED5/EiHPCDd9C6qawvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=EakrUBza; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="EakrUBza"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756374651; x=1757674651;
	bh=6s9hYIjQmXy/YswNdLVOWz53M6iEE/junj0ih+puxqY=; h=From;
	b=EakrUBzaiTa4DNuBYMRKZqjOMdWIZXEliyTklD2kMNCBmz+ZZ5FFsF1P/hk2THyH9
	 YAcHOe1q0PSdihR/lAmkT1aobCR/XV8bGRGfAAbgkNenAR/brZhQO/xBfsg7uy6ZHN
	 5BBzQP2JGSvprrdkmSJlGsC7d8emUks4P2z/f/pLJN5dB3MqpUmJuL3Qy9W2HONS4G
	 Zfczrc4tUuKQ1LfOFqsWBVc1Kc1wpbIPK2QUJqShFihOCT3tTDJVw1Tq4B6PMMwHkU
	 CE4WOLhZxsSSqtwy8hZ4rOlX86O3vyXQvRRsJcxVwWzQVZiPGGq2tn5IW4PV5aG9i1
	 CDwnWtYk6P5Tg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57S9on5X046274
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:50:51 +0200 (CEST)
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
Subject: [PATCH v2 1/3] arm64: dts: samsung,coreprimevelte: add PMIC
Date: Thu, 28 Aug 2025 11:49:02 +0200
Message-ID: <20250828095028.24503-2-balejk@matfyz.cz>
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

Bind power management chip to the samsung,coreprimevelte smartphone.
This enables support for onkey and RTC as well as for regulators two of
which are explicitly bound here to the SD card.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v2:
    - Modify interrupt properties as advised by Duje (thanks!).

 .../mmp/pxa1908-samsung-coreprimevelte.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 47a4f01a7077..54131b0e5617 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -303,6 +303,27 @@ &twsi1 {
 
 &twsi2 {
 	status = "okay";
+
+	pmic@30 {
+		compatible = "marvell,88pm886-a1";
+		reg = <0x30>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
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
@@ -328,4 +349,6 @@ &sdh0 {
 	cd-inverted;
 	bus-width = <4>;
 	wp-inverted;
+	vmmc-supply = <&ldo14>;
+	vqmmc-supply = <&ldo6>;
 };
-- 
2.51.0

