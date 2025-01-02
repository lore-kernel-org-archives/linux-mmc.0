Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E31B6D0B;
	Thu,  2 Jan 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851546; cv=none; b=FQQoZW12tMEgAkZC5zgwHtx7gfJsXr62tXOg+pqDrUh5UrufExk6ArLioF+JmbEe+QJ7zUvnYUCm/UQ7202MDMHq5K1W7yngMGs1yQ7kTwZJhf5HEEIM84rgB1UawKjO0noTu+589nZKEuJ/aqrFPpDpjBBjuXxPhwyR99UZ37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851546; c=relaxed/simple;
	bh=mcpMOgTXufd6BmfbvFw4DDSbcLG53qyUtL75A+s6dz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYowgIwkNPnEQJZkGfPXDo+611yE/EJg0hpG+enL58Cy+gsRMC+jrvfya2tKa5XZyxJUxSLkElpFSkVNEIoONsNrfw26jkjVfUz3Xcq2EBajXaF/wyES0cH1kEJoXwGfF9g7f/phxVQ7DxRPSlCeaM35LajiED9c42novQYYwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0PIhDFk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0PIhDFk"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so1669132766b.0;
        Thu, 02 Jan 2025 12:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735851543; x=1736456343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCu8j5qgaYDYPnaPdDgFFNsAqlm/hMgJljoqnUl2UNc=;
        b=P0PIhDFkMeDbdlu701dQP32j/WRmKBUL7Fbpo1uqfY0Eg8uzkSzk6glhqYHU0FwDhT
         lLLF2FcJpy8a3WttBfVamUqVia6pfn/+thnWMeN1SmS0Onhlmpux6c6ZoEq8iw/pGyUE
         4MA72JW7vJPQ8nKEZcKyF8epYjCpNWAJ1Ie84bLyMKB+Cgl0RXPrAT0+Yi7PkjQiGOw2
         KCqCGfCUcnm7hng7WTZo1a8APi8yu922eJ+3e8KdwZDecB8T9p20qRw9cyYXBquw7C6T
         XE0GOG6XtcOKHau/GgL4DM8Z/iSVXvEmKxCD5y/TTMyYyE1xDnXfkwTZ38pCzHb4NS+f
         6RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735851543; x=1736456343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCu8j5qgaYDYPnaPdDgFFNsAqlm/hMgJljoqnUl2UNc=;
        b=hrAum7olrsLjoL0bLKUJJYamEVDdRl8nDwleimt7Epei9LOzMJfDIeHFlZBQAWuYOc
         b6UrGomGXU/xv9vBuZSIEu/AKc8sHY57lVoa3tNUt7XHHYRyir523p84rr3AHjdBE3Ti
         IpdnhRRj66C9DwbD1jm82/UkFh5CfetEuwhVOsT6FMclux0zTk11eQ1i1tosFq50kV3J
         sOfjKMh7WIyyaDTTsymeUoh/nYJh/nFPIw/DUfBm9TB+tZ3V29IAezWup0alPZkWfyZF
         T38kiIH9su2C0xPzyVRJhFHDMMdr4YDb5zPU1Ds76yLKlQ4ifDyMu5EBCT16ldyTCGhg
         5XPA==
X-Forwarded-Encrypted: i=1; AJvYcCV4AewCANTFpHZA2eumbbxFPQVhamUZOgtQsLJugtQPRhSvuejafeQJgjDCfGtjRqbzTk1Zu/KvmpqMZRKc@vger.kernel.org, AJvYcCWbjtI0N1c+0cbdN7LePI4FISBC+Ght8U8qV48qHiEKIRx66XsomPga8Y7evIMkaf4okAUUVpx5OpH7@vger.kernel.org, AJvYcCXZNFmbRlGcNdDJmFLuFQOzNitfCqhcRDpdlAzsZBTZ3safHBEUgUBGHHznopOSmzNV3wKAsPm1ZjZW8U6Pu9szx9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5jSLXzKfx8lPelQ149osJ+ezi0cwcxfWH90X1QJEtZ+TQWKm
	ajDesDYhOV4a+vxEDPPsXdqQ+OFV/+RSVrmwOmow7awBvQIXBH0T
X-Gm-Gg: ASbGncv4yOqdOEbrBOwgOUliBTAQEBqTZvLU38HEHz7ZsGhmu+sI84JJvqjUwev8N26
	klRvNtXzzcaQRmVRIhZggfD+afNHZzin8ntMeDGukcU9Xvh8ZylEt4T5N5onKBNXKSP8zD88vHc
	mAkZ5olEArZDRAN+a9Kd8OxAJ59IVjr/Ojv/LA7SrBDSU284d41Mbu6G85hgAzz2kKhwPbiX0KK
	/wOg+CFSyAabnYduSIXqXGoiml4KAFDYilFBg/FcDWPgN4943AO+g+SICT3h9MDE8se+nhWSf0e
	IcxsN0Teo6I=
X-Google-Smtp-Source: AGHT+IFzm80w4v7MGq7RShD43UwRC9a0uGe878X9IA/tQscJ5YnfdRRUF6GIlk32S2NPBCyvya6QAQ==
X-Received: by 2002:a05:6402:540b:b0:5d6:48ef:c19f with SMTP id 4fb4d7f45d1cf-5d81de1c28fmr111938896a12.29.1735851542509;
        Thu, 02 Jan 2025 12:59:02 -0800 (PST)
Received: from ivaylo-T580.. (85-118-76-61.mtel.net. [85.118.76.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f397sm19231026a12.22.2025.01.02.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 12:59:02 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] arm64: dts: exynos8895: add syscon nodes for peric0/1 and fsys0/1
Date: Thu,  2 Jan 2025 22:58:43 +0200
Message-ID: <20250102205846.223955-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add syscon nodes for peric0/1, typically used for USI, and fsys0/1,
typically used for PCI.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index 4fb9be850..5302a8c1b 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -228,6 +228,12 @@ cmu_peric0: clock-controller@10400000 {
 				      "usi1", "usi2", "usi3";
 		};
 
+		syscon_peric0: syscon@10420000 {
+			compatible = "samsung,exynos8895-peric0-sysreg", "syscon";
+			reg = <0x10420000 0x2000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK>;
+		};
+
 		serial_0: serial@10430000 {
 			compatible = "samsung,exynos8895-uart";
 			reg = <0x10430000 0x100>;
@@ -273,6 +279,12 @@ cmu_peric1: clock-controller@10800000 {
 				      "usi10", "usi11", "usi12", "usi13";
 		};
 
+		syscon_peric1: syscon@10820000 {
+			compatible = "samsung,exynos8895-peric1-sysreg", "syscon";
+			reg = <0x10820000 0x2000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK>;
+		};
+
 		serial_1: serial@10830000 {
 			compatible = "samsung,exynos8895-uart";
 			reg = <0x10830000 0x100>;
@@ -380,6 +392,12 @@ cmu_fsys0: clock-controller@11000000 {
 				      "ufs", "usbdrd30";
 		};
 
+		syscon_fsys0: syscon@11020000 {
+			compatible = "samsung,exynos8895-fsys0-sysreg", "syscon";
+			reg = <0x11020000 0x2000>;
+			clocks = <&cmu_fsys0 CLK_GOUT_FSYS0_SYSREG_FSYS0_PCLK>;
+		};
+
 		pinctrl_fsys0: pinctrl@11050000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x11050000 0x1000>;
@@ -398,6 +416,12 @@ cmu_fsys1: clock-controller@11400000 {
 			clock-names = "oscclk", "bus", "pcie", "ufs", "mmc";
 		};
 
+		syscon_fsys1: syscon@11420000 {
+			compatible = "samsung,exynos8895-fsys1-sysreg", "syscon";
+			reg = <0x11420000 0x2000>;
+			clocks = <&cmu_fsys1 CLK_GOUT_FSYS1_SYSREG_FSYS1_PCLK>;
+		};
+
 		pinctrl_fsys1: pinctrl@11430000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x11430000 0x1000>;
-- 
2.43.0

