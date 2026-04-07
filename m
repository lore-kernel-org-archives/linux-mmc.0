Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352AD3A5E7F
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550377; cv=none; b=ArTw5hvKL1xt03pVTqEWjbMA+jYHHxoqfNvOamc/5pLB9zoLZ9ar6R2WvBF+7B7zjaZSpzUZvv9/Kc9qgSsxlkr3OHuwNiAOjvz8+vGUk4NROYRxBzQuN1Syak59LYBgCkP6L8HlGeHF61UHKV4RzKjPTyv3bDOCfZ5UfXvzzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550377; c=relaxed/simple;
	bh=P60e433P/IRmmrRLLAQOHXv5D73fLkqt9Yaf5YISuyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIZCzZuisEN3u8CxuTRDoWlcFsE4+rwHZ6YxybTRULRB+7OTJuBwUb3KhvJjoD2Hm8HNoKOY74bGn2I3FqkrN3nG/jbSCRtZ8aTm559FPry5IeU68lR9ndcRultTKDsH0y7qPR3NQSTPntk/eLjkAwetvB4hfhD+Fmk6n1+rYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVPE06Rn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVPE06Rn"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d02a71526so2720050f8f.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550375; x=1776155175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+BJYlYfkNO3bzgJIrrKwScy12NnJdvPgI8y4TWtzcM=;
        b=fVPE06RnhB+KnepdJsMxqMRxZ1cc4pJXf58oO9OaoFFgt008XVkZmGX6GpktHqHUA1
         uvNrGpJATNSSBNGiL5Yd46FOJlm3Ym9U+un+RBGihOKaRphtj7KWHx6fmkEAgZyT+q/M
         c/nXAcvAacFfj1ptwL7O5X4RWJniYOeUwDvcoI91lZf3s45o/Oy5R24fatk5FrYpn62q
         YhJZEpZ+3O8ejEMpyHe5O0stXDkXM4DpXORn9XW+JglT/FRcusK/fI11AkJu/evtrzxH
         QRmphIp7LNOlcZZ0AEGBYuYcx8w4DYz14QiADWr/su6581m8mtjJ1gxLlJ+8RAOo1LuW
         r+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550375; x=1776155175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W+BJYlYfkNO3bzgJIrrKwScy12NnJdvPgI8y4TWtzcM=;
        b=kG6z5Aln9si2vYYTjTqWiw1NpU7mHrf+lWnI8Op6A+5wHioLFuUa8k+ykb1gVQi8Yg
         fUjlVtmQI85rLYakQB/UqK9/jupPhHMFtSvkoHz/WyWf67bIC9Lbh7iscOqHt/FnIuvd
         C4t7cQmePrWxkVyV8VUZ7VEViBBFc/KJQw5IJg10pfbiSlwcUE+rj02IlPE5CbUfJcty
         H/Qfpuyfpp50mVvobmpauTISy5qY3exhMbllcHStasS7eFeZorQTHj5kLF8DDNcRsFrO
         7sWF3QTYR40NWmr6JRDsdgWiisvGtz9sJg4cCCrNZa0o05dqYc2SU+6OOvvXRwAazmSe
         y/rA==
X-Forwarded-Encrypted: i=1; AJvYcCXPC9HupRlPfx1r32EoL3y5u+XAP2LRiEGsw0JbZSLmckRMKzQ0JsIwonP1DfU1jm7Rl1r+mIfOidA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZslLiFsdVdR+DUzkSnLl3IzRB7SvFhvn2Txqz80ltrfHGBeD/
	VhbECX29wz39aUE7FRLnkALxlVlbogk+wfwiV2yyyPkVcsOUBCwYje6/
X-Gm-Gg: AeBDietFGHR5kzNAFcHqOWHrpGDxU0uLsPXqv6NjLCJw4JIJM3SMLb8yTnZtEj1sk6S
	wFveZep3oHdzJ5G22iYGOwEvg9BaUAKN9cuIlK7JK2DItKqn0QwSraEPnmHtvpPNJ7eoCOrjqCm
	Zu1WjqpqmeGen80T6SX/xjZkIjA07Dv5Psxx6sPysiiCHBPrw3XZQhU1Ckt8kYjwcH98Lx/899n
	nn2tR4V3Ub9QbFYil2JAHs3qBnFXnccoMSPuHzDJI8jIiJz02Yxbyt/zqA6MlmHRG8yDE0oM5XM
	8Q8jnyBAM2N8aDCgnJle0PvgqDibMn8yat2AFbr/5pOmyhKJBREVU+pzfD+AKHUKks4R09Lb3fI
	DOPgTq1gxTDosT9HbdD8WwzS+qDT3BGCE9tK4DU11J9ndedwj0Jun4sp1QBCW+V7nEbrwVul7i1
	Oho6YQfaRylLRzF0TWjKbtPQX1VX5aPOgTPNpo6XTCoQlgp1TpoPtVaWwDvteJLEgj
X-Received: by 2002:a05:6000:1883:b0:439:f605:afde with SMTP id ffacd0b85a97d-43d29314e93mr22324658f8f.51.1775550374535;
        Tue, 07 Apr 2026 01:26:14 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm48669958f8f.21.2026.04.07.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:14 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 07 Apr 2026 10:25:28 +0200
Subject: [PATCH v6 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-orangepi-sd-card-uhs-v6-8-b5b8a1b2bfc8@gmail.com>
References: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
In-Reply-To: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>
X-Mailer: b4 0.14.2

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 5790d927b93db350c8f53aa0f314183b3173fd76..a7d88564630f3332270ba5fe47b078bb14f564e5 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -220,7 +220,7 @@ buck3_1v8: buck3 {
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -241,7 +241,7 @@ buck6 {
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -367,3 +367,23 @@ hub_3_0: hub@2 {
 		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	broken-cd;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.53.0

