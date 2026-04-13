Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8D3A75BB
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067374; cv=none; b=Nrq5zb8CA+Lz7mAbXDTdG5gk+Puwh69VRlOvGLmh8Tiv5XPbb1fWb+v0FY5Fqg6i3Mp99Xnr4PbmpSd1sJkIh5vu2xNRFJw46i1VXR7bz04PIhkPQJhOEmPZSSs0ummK0ZJhI/BdWemnN+Wld+OTcyPSgJBww5Q4WtT/geM2wIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067374; c=relaxed/simple;
	bh=yPVLAlhkTA+kUGyF0dssolOKikJzb0AxKHREa9fEcLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCf3nsQfk//5/Ww7yGejBpYzR1u5i6RpANWVntBzMo+O0wPYd1jZHURm9IPDKGttFlj5vzFKJpkggoQS4VLXAsfyY36+29F6u2VjSlbQk+fNngC0sDIH0i8iQkFKYlo8IfDVHSXEjscMpP8oMPv7phJpdXdebsK7GoKPpQBS6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJSdlOO1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJSdlOO1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso2573406f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067371; x=1776672171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39t86zaG16kXe9hLAHIjg+gQj/3rkIeOmwWRfItDZnQ=;
        b=VJSdlOO16oExuSwGUTA5QdFg/5Q8BjiRZS8doPCYJhNayDEDRlK9iqI6VClcielYse
         7gLpmsgKVFH+cnbCLBHN242v8ZRejqkPH1IdgmTmjuNwYRefsVfR3U7HN4mS4wnbIota
         2yw8nDzko8WbUypzt7WmB6r3XKs/s6maYAEC1dWbt7HpmaimmohLlmYHLWSpoHOt5ZMc
         MalpVAm/QlGs/1REuI0nt6od2bVI3N3XrXSM42w+Y4UzTXKTDySrse0jaMfyagYBmryw
         flO7DDB+PhQdiIqYFjF+XK+IMjpg2wdBiFL2o1ahaMleDa98qVq5TRhfLmObGYuAH+f9
         vC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067371; x=1776672171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=39t86zaG16kXe9hLAHIjg+gQj/3rkIeOmwWRfItDZnQ=;
        b=hqIXLxN8AVUYfkjU+GztjD1FxWhuM+aPO2EivhAU1VhfhhVEkST4YQ+XKOf+d3OIX3
         AAiLOBTs523wTIps1BdbhVodsX46GeD9q3+Yo760kLP5Ha6n6I9WHvsgGJjfKSNolMXe
         bpO57tTqY6kIt6GuekZ5i3gx9gzELQeqkl8AK8mmqBxeLfW3ufGImwlthQHZBTyzUmlv
         kfQ2jOP+i/GbRMoYE5h1SGNp1w+G/Ybq0C7PtS0iS8nYX9aymwZSGdjGeKVhEnxgmiK5
         F6hmUeYipdCY+DNjUNWqlIm4RjV13XS1LRCo4iQBgZd+d2fEDtgy2G4hwVcrwxODIHC4
         5Z6w==
X-Forwarded-Encrypted: i=1; AFNElJ9vbf37djr4o1ns01gh0AbKgO9o2RGyXBpTmCsAz7/bgmRgcfCkPkvtbKq1Y24gmflYczRnTdS9wEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07L7KzosEDTcRZ57sj8htehYtJA8svqTJA/74j9IDbl2q7dZr
	jCpRL3co6APDmPIPWPVxXHR4WqdY7OIHKyJh1KhJvUjZ3WfXiyKVN8dSEIW4+w==
X-Gm-Gg: AeBDiesbSPdfFsjbsfBJ1xOOFIG3F9vdN8Vt/quRjFkaeomt2dSvj10FAouKxx7VAzN
	pKig+6o7/nmDPWzFxxZudgndju7/21lsyxFPxegX48+30uan5ewT+Fxd4lNdRxpRKz4+HgG/ots
	GXQuazohwVDVg0k1H85rQM8MLNCD9V0Q4swKbAH/YbP83cZ8a3j2S+wdkqvq+7KEoS2WgzKTQoT
	6Ezt3mH14MTt21VPSwZFAas+twToB37buBA6adg/rizouhDXT5AkfZgxfh4EOHKAaUR0kMMqLaK
	09Cnlk+IRCzPy/iNeNeT7X1Ak2OW+v1a1Tctx8sUVgVIeO55oD7pNXpUEKJGrAm/vFtJiBvvtpX
	RRE7wazYR5eIIq/uI2pUsfAJccE9YRQ/gGJQWIn1xnuzy7KviUkChEGzGOBFg6ad01zj1A1eh26
	Y92ayN/KaC7y+lVkIuTlHHoZokAPVOCLpRKZwwgjMGascPtPq+O/66Rmnc+hkTFIIw
X-Received: by 2002:a5d:5849:0:b0:43b:45a0:9df8 with SMTP id ffacd0b85a97d-43d642be552mr17751732f8f.35.1776067370293;
        Mon, 13 Apr 2026 01:02:50 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:49 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:17 +0200
Subject: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
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
X-Mailer: b4 0.14.3

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

