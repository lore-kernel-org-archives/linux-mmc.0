Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816D3932CA
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065216; cv=none; b=kpXvjisqo29mEA3cfPsUdJ7LBI3b9XIchjWVilEsJEsG8b7JozTFYhZ0AR3yklWY/UVcVQ0nFFYH5pe87IOEEJj8mFTvrVs5gXE6t1SV4pK4uWHhTZwQwQ/e6bskGd+fdva8R05X1rfs76ncIBtMnN7Eyo9rweqCHZMc+tQ5ueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065216; c=relaxed/simple;
	bh=yPVLAlhkTA+kUGyF0dssolOKikJzb0AxKHREa9fEcLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oi0V+l9ZOxgL6f69sdO0MPa/HCGaV3/DVU6iSJD4CyihnB47Hlr9KET4lLmV7sWCJ/4MQkgocYVA6hFDVbMT7sMzYdfIIYQhnDFWXfKXoCyr5U45iicqIoQO3dGSt8yPsazpkS5zSVPI1gIah9FPABi8FMt3UwMCwXz+dWMBAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odlFGFgq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odlFGFgq"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so2907929f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776065213; x=1776670013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39t86zaG16kXe9hLAHIjg+gQj/3rkIeOmwWRfItDZnQ=;
        b=odlFGFgqBtKQ+GYHEMVyNZlJU+/ZAfGnsyDilHN6j35CLePn32/atvVXDrfuaFWS0Y
         ODRPVBH9VmsVZXXB/45fetful1G8R6EvlPAAvjIgELe1a/G362HfDqgbDVKL8OxJ5BNN
         c/o7rXE29CHg4FmD9qySldy9wmjgUaVBfbpvLSOlcd4L587i4rEK90Hdgceqvm3GZxdq
         wS/zCQTNUwszP0arCs1Xx8YvuuC2ejRW7MPIckRgF83teBlCd5kmVw3m/b4w6R8lykKz
         qaacgTzXO9U8plpA0v2Rpv/lE9EA86RbyVHhaF/dLCkJjnmKCDDgWqSS/JUAtt2ex4VG
         hF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065213; x=1776670013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39t86zaG16kXe9hLAHIjg+gQj/3rkIeOmwWRfItDZnQ=;
        b=Hm3vnevOsfJP7lg4IM9CNYVlQsYs0KxtMSk7haDuxxotURHsNsxLImTJXmQXoqUKa6
         QEXXSgKT9ejhQ2MwCjbrZpIRNfOPVwiTwz35731DESKpS7C/Yr4vqGXN52G9t3OCNKPj
         /r2wDcsfnm7hN8dnTZGI0FVZXNzq1K7KrxnFAiSxau4CXLN9vth6xYB8fPEUK6Knsn20
         ktJJhuSaybGaJ2bt4w5lPcT41fPTdSDz1BMZHYQwEsE5YLq4kyGiAym+8Jffx4+ENc5c
         xbfdD9+/Vc/iXV5STEeixRwMDt1MZXhh1S/fLs0fUlSf2xQ0+XK7Z9lr6t92mIcjIHTd
         eIZw==
X-Forwarded-Encrypted: i=1; AFNElJ9UOec2stoYrKpGuTTUXJ6A5FFFk3l1FIq4KdHIglGOmin3zEzalVhR8Ocl9CaP0wJbWw1rgtFbqGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsd5g3ZYMHXr7qv80i45/+dBhEvCXgTwxaqNDuHICE36LfjWA
	QmTRgQ/nJAtWI0dyyuGHZkNmjKS2blprb5x7kSuwRpK2YeCN9RNX+CAv
X-Gm-Gg: AeBDieudzBvidQz2usuSYgCSO3kMslH9VdW0jYwqizwWLYoIC/aULDzkyOvTuBw73bU
	fl/GSjX3ok/ystsYR/QAg9Qt4mKDBB0KWIsql4S9pErDwBUHt5wXi29zHaO7BW4ahei/G4uz+Ru
	4dNmsIoeGqyv96ZyQ4T0x0omzalZ/v5fLSBUbDnvsyodbCIdxcty22xh3+Hu/yNO6sYpK/e76Oi
	xOJ96fuf9ohmbBh0Ii+cw03xCRZwf3LRsl8+OgtJC4Yt7ubPtU2wORjczCSsn9Vubf0wrclC5oW
	QhrZ/svFgKl6nzpysDqR1ry5//BlVVmik66luTCSyQiAueNfi/tdH8bvAJ1W5Rgz43pHbCr+PvJ
	0v7VRRMf1CKn1tcfRCgrxKK3tptUur6Fv/2qW7tthyc7qyJn+TPySUM7q2tob6VrAOu6ksajVtD
	u0/Z4o1XtVytDmLEHtmKnvuYOmGHQmvv5HI1IAWS3ipRlt0NFfE9EmNoFX4DsXpvM7iUw4MHYsk
	SI=
X-Received: by 2002:a05:6000:2586:b0:43d:1c7a:8b59 with SMTP id ffacd0b85a97d-43d642ea4c9mr17192774f8f.40.1776065212404;
        Mon, 13 Apr 2026 00:26:52 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7d5812dcsm340817f8f.32.2026.04.13.00.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:26:52 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v7 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes
Date: Mon, 13 Apr 2026 09:24:50 +0200
Message-ID: <20260413-orangepi-sd-card-uhs-v7-8-16650f49c022@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit

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
index 5790d927b93d..a7d88564630f 100644
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

