Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A447798E
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842161; cv=none; b=OQ9ZCKrTBiROo4iLmOh+fVTUjdJwpniuC79kFSzTNvViRRFvJ0jYNY8x7+W6bW6KNSSQBQ6fNfFoDW19QluyfNlnT0Bqd0sruqe1/SLV0QA3c9/33UvzG1NxAXn8HyW7k6tT0Kj6vMZtBf11/S0/sKWMuIdv4Qj9c6dHYpE+XSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842161; c=relaxed/simple;
	bh=AE9piC3ZJIVgnZZvOh4UzzLQvqXylhoIUDIYukgk3Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oede4lqGGU68MdXmQuKGcXDLgQelCZMkBF3vebvFznFjgwTKLdNkl+xcrG5Yk+wh9VgshO0sV/wxYDUtfgq5qtoRI33SibwOoRPN1EkoA9ct83EGEzBm1W3UoJG4ZYdhum55cdfku0//TpYqyBGi83eCCEtYHsBunNJJvwT1WUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUUolopT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUUolopT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d77f6092eso5636999f8f.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778842157; x=1779446957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gj+gGcawYCc+wqAPbdfgxnVj/lSmz4s1J3fKvDtI2Ic=;
        b=kUUolopT9xsGxxplp2VXQOi1IVUEFxzVppzxo8mllLj+Ze5BtSitl8aPJRXIWaVhWH
         XEWDN7KG+CCdTOsOlIiMZ8HjFtdCjtXVlWeyL/WJQ5nvUNjvb+FwZxXTkhxJPqDANwRJ
         FZh5fqnGPQEpz5GvKcoTOFmOcBrywmIHgNtVNxilfF/b4uHwZeAhrsGZqXqCpPMczL9O
         /D5882D1cWairbXuo5wS8sWZ96LTyWY0q21nf4vMMaCQwPoX/DaecshakvLRW4Swpw+N
         3RMs4yQqAtC5NP6wwzXsSSUuvFO4ndTU8Dmsjt0Tany5rgz6pbfuPgC8iYylAu1cVxpN
         8V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842157; x=1779446957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gj+gGcawYCc+wqAPbdfgxnVj/lSmz4s1J3fKvDtI2Ic=;
        b=PI0RDr1zYgy9lQPUrurmRL1imZE/6cNuY+5J3b6dSfR3xBZkr+t2n0xSt8yMRwsoTT
         cxZ8RIOoRAB1/X51pwSkK2eHlSwTWPmeB2sW3W+8Ba4wDvWUMI+stYaHzwxT6nt3ZBZL
         IcmTi6R4BfKuYp4vfGTRiQRswVjAPqAKiTKGgRejm9AfWvF66UESIn4YgMq7vGlBDMl6
         Dmy58qZd7T22jnCQu+pOYI5ZUTMXEvgmlh/rOMiey0SgxxtzLyx6544k5Hi4auNcOkwR
         Wkas3enzaeC915a19pV9K/ahZHeCHk5b+HQ9i4e3Xr7Pq9vSrs3rqKi0P8aYOsfSYdkY
         Y5Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/cYTm6N1BN7tJBmb4oQN4svzI3qSarXzEQYPdu2Wq5R0xl4GbfaC9VQ5cZeuWVHcVP0fyra8chRyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2St52IboMj2vmGURqz6VOAUb3vbs43tv4V+kfr0JFmkS/Jj8
	4pA5vMAFAi2woO2BfPhE+2KrKmu8iDQiJ1ssyyO8lHG94pzQGkCYdxliVXUpSQ==
X-Gm-Gg: Acq92OG7+hwJwEeyeGh1hV66Ufr8FHCzHoPKOZXeObQpPChZlN/+fPlTHoLx8Xs4gcE
	+OlcHpGx3GFuIuTcsXyfmq6ySUjtlaJuloq4x3f8wdUmkZbl8tSnJDtgyMwrSeN2izKNh4b5J/N
	+aOMPgFxOpfXQBd8U7F85n9vmOpYJp4WcPUnx2Ttvwsn9jJS0NXWWlKZKTv/iSQjvNkFsWG/AJs
	RbmQ6ABztH7N+dSgIuU2iak6M4DZt45c19UkdBTQ26n5leNT/9kZ7IU15VU1MuaR2LJtkwqFpKh
	2twDRuhRCCJQlmPoDyhaJz3DzRO85mmc49SE4nrbFIKfU+6lPd1o/lyKMnNJWGszEEdhVlpJ5NA
	9VmyvpfY7N81p+wBqJDUTOzl98gEPFzqu9O3LdZxruqNlCOlfXjfw9Mr3oR11Iiupng0mJuziFY
	j/h0CMumB3pCmq5ixSfvye8reBGpvPTEYhvmxQuob72RQFTT8vLt4qgU9mxWbA9GGggtWfTMmag
	cKW
X-Received: by 2002:a05:600c:34cf:b0:48e:5990:9698 with SMTP id 5b1f17b1804b1-48fe651588fmr49447535e9.24.1778842157464;
        Fri, 15 May 2026 03:49:17 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13975602f8f.14.2026.05.15.03.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:49:17 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 15 May 2026 12:49:00 +0200
Subject: [PATCH v10 2/4] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-orangepi-sd-card-uhs-v10-2-094af27e310d@gmail.com>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
In-Reply-To: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
X-Mailer: b4 0.14.3

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with GPIO_ACTIVE_LOW logic
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Tested-by: Vincent Legoll <legoll@online.fr>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index c95ca38e3d4a..bd40bc9011e2 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -17,6 +17,8 @@ aliases {
 		serial0 = &uart0;
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -202,7 +204,7 @@ buck6 {
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -319,3 +321,21 @@ hub_3_0: hub@2 {
 		vdd-supply = <&vcc_5v0>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4_3v3>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.54.0

