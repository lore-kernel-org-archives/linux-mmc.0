Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5F3B47DA
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859921; cv=none; b=oPqAIfj1v44STaQ+ASmfSWuzq7gUb6RgxAO+feLgB1xl5bDLcjfw5hzG29932cTSfxoaBq99CY9aFKWDZmwaM03xaCemvsOLLVfxpVItr4Sd2OS4i5Sc+BwIbds0SIyhzXKGHxFBd/uUl1UdFUMelrOqms24DHLKuZK0Rw9t1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859921; c=relaxed/simple;
	bh=k3WQFpTj3xaaEoiZ9UoAc/GeyanLbBgvNpL3Q2ubkLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz+rEDiLCkXTm5Oaeazdy6ZpnpseNl7tJx18bUKYg+QH4/mx8jURpVitWI7e/rWC9d0obrQ9Gm8lCbFNncQKdKC2Xzg03c9dsFPWjeoWZeSqjXUElJR4snYCN8oFQWUPHx4O/VfXo4pX8Jnv/3kFrKTJUw/6HyV1ZUMUNjlh80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRnhZNls; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRnhZNls"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso35465815e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859917; x=1775464717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWssdxlHALW3Qgq+7Nkzy7T5aM2eq9AsrkcjeZdUOek=;
        b=WRnhZNlsBSkGPpxha/y3jm9bE81rhB/Wl/trapAR9Eiz0VHkrWF//OIG2pRohn9IzY
         OJn1A43SbAJrhBrllPLnft/qHeSq19OR5/Bcmp9KCCH6w0sC5c+r0FWK0Vhj/6Qj/TgH
         PyZXQLjfYlJ+Vj/gqJhVpSJGJTsVWD8jeV7arxi1IMvmwkYbt6rlDYRIV72pvJ0TL27U
         84Nlg90ZVv6sgwJhnx2siKLYt/DZF7nrknjlmXYeuTnl9quwBlZj5lvXqpcnVGxzonLr
         gn+dHXkfvzr7xmlPFTAZlOMwcq52m2Ph80Jml4YXqV8lH2am+tfhZ8mCTDy+tEojow7/
         gt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859917; x=1775464717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YWssdxlHALW3Qgq+7Nkzy7T5aM2eq9AsrkcjeZdUOek=;
        b=lROLa//Tndgjt9YNozODfsW4sckX0gzz1JyiSG53ulYRUmbF8aE5ZsereWP/dp/NSG
         i65zAAaMrk9GKUfbJ+DEEfojfOWLgzPrbSp8ri1n806cZc7ak7pqd+fKOLsGCiyddMep
         bOeqhiuGxU+i6dLZ9nef9QYa5yDwtJH1XtrIWLdAewduPkio8mdnqQxWwOuPoMykGDGG
         3shiroBlKtu8opyGI4tRD7TRkIUH8Q1McvXjvX0Kg/0VJG/w/EK9NbhtxW71tn9cRFfg
         9riwev7YiLF2FR5zEPpBvSu/HSbMj2xEz9HFoRPLhm7socteGP/3bEJWmCugvQSlnnPX
         fCpg==
X-Forwarded-Encrypted: i=1; AJvYcCWGWw0SEd3gBbSz0nC/NgpYyj1PtGr53IBN6dhSqjdRFZ1P+sBls2wG9i+Mbnqw9QmdKMJfx7P4w1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz973kFQ+oQenLb+LOb6b80lxRE98RTkBYE/ArSlfJ6P/8l9sxJ
	nHAdd+vgXi1qsuM067a5u/ifFyK3uDF9ZBqEvHLU1vPoH6JBFTzfmHtM
X-Gm-Gg: ATEYQzzrS74gutlU9JjNw7+9a1UPjGE1ieahbrj7ViLUp1G/EZCbk9xpgrYN7eA1r6H
	3UzKwyI+yHvbg4hbeDzqdLEpbBwDgPqxS+a7wAaI5/GJDqW0Jbw0wi6GQ3GU+lOIwiOkJ8hsSH3
	xtT6C2cdETbDZGZ8Q5QoOiXERzobO3e/5+pjROLnnTl+OiRqYhxZZbICUvazbjRSs03S6vhBRG7
	m6wJmO1z8L+0EnVUKr8SCiBEmzZwQmSPdSelzbtHyVOhWrktidmRZ/nD1SwaW1Wd7IRTJoRI1v6
	lJ2qey/CyGMF2O1Gz06GOHHIqLAAKjBQdumtTqyI8hknU2BWCAP1VxBEjV//FQNJlqFGLztAx25
	E/Y/qNHHL99F5lIn5SkQEMU3qLDr2mQTCxNi/GGxXewUoawsiSYhjOYD7GcrsMF6L93vPopJMz8
	o5xXI2L054sU7oA/Qx0FRwnYap696+KDQeaQAR1Pwg6RffJfIzlXGStfmDCSIOqBRTvrfLG95Qx
	ko=
X-Received: by 2002:a05:600c:4f91:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-48727eda549mr197940965e9.17.1774859917344;
        Mon, 30 Mar 2026 01:38:37 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712c236sm74063315e9.14.2026.03.30.01.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:38:36 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 30 Mar 2026 10:38:09 +0200
Subject: [PATCH v5 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-orangepi-sd-card-uhs-v5-8-bd853604322d@gmail.com>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
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
index 5790d927b93db350c8f53aa0f314183b3173fd76..a5bd63976a4ff772ae9a9f983042e9b032ecff95 100644
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
+	pinctrl-names = "default", "state_uhs";
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

