Received: from mx.olsak.net (unknown [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A62E542F;
	Tue,  8 Jul 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994710; cv=none; b=KzaHTT0xydp+PaZXoM7yjYDDguFTF4G1/zziGdAkiLXnFFhYD99HSeh+ZkwMdz84MmQbZURjjeR4bCBfgXMwwtUSA7X6Qpv6wBgbwtlnJZluR88xvv321x7C3kIo/1XDAfgmlkaVR8XHztsM09Jq63wPAZ5grMpWttd/Qni8+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994710; c=relaxed/simple;
	bh=9NGI2J7Fw6nRPJV9SJV2GZ5jc3YN5DXq0M2eQqaNt6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YEOQ9Hh0NpZWEi4fJOEEpluh1w06mD56WQA9z2QIYWzniFXEBQJD0L7wURUewm/HxIn/bWqQ3+ZVnHBNza0VgpS4cVNu7W2Xc1Stbqtuyu3z7RvjH+ybLrSeqSF8MqfxcIW0XWWOEvccbvPQ0u4pnspMScDsruotoK8zG98Bgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=cNx/Mx4f; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="cNx/Mx4f"
DKIM-Signature: a=rsa-sha256; bh=wxRK07a4qzIkQDxq5Q17ibY4wC7AQZd7p4t/xCAI5n0=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1751994602; v=1; x=1752426602;
 b=cNx/Mx4f5mw+wfvKuvG/l3a9Doy21xFyyRQ3+YysZAHTImk5FlPbt7lOl/i0e6umnsjodcdT
 Md/JGcZ5afMn+if2T9yLDj/svKLpLFB6Z2MEyPZznw6bI83ZZrl8fo7UVGw8APNdguKNXu0z2vI
 mKYHO1DqWbNheuazV7vt/HDKSThx7l9yFrchAu+WPDpD1Ak+hJXIEmZE32sR4WkEJZecoeDHb1H
 bL73uED0WiLbjn8/H22+uMwVOGTmwBhihHgoJWex8++HuXPHJ/yVx2LcDPtUIkacGiXtZw84saj
 437e5PZWMzh+APxYPdTe+Nfwv8y+sC83sGT1V/1nSAmgw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 04664ba4; Tue, 08 Jul 2025 19:10:02 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Tue, 08 Jul 2025 19:09:48 +0200
Subject: [PATCH v16 3/5] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250708-pxa1908-lkml-v16-3-b4392c484180@dujemihanovic.xyz>
References: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
In-Reply-To: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 soc@lists.linux.dev, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=9NGI2J7Fw6nRPJV9SJV2GZ5jc3YN5DXq0M2eQqaNt6s=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm5AY/led5OuMB0cPU8uTjZqbYbLWatTj9m+L7k6InQ6
 qsfL0wp7ShlYRDjYpAVU2TJ/e94jfezyNbt2csMYOawMoEMYeDiFICJMBxlZDhY79j4KyzC8soi
 AfFnvuv3VCc2leT9ZO0zEmdljrhy5iDDL2YnW+vKOfLWEd/OlFkbLBVl/b+g6c9qxdmdPE+9WDa
 9ZAQA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add ARCH_MMP configuration option for Marvell PXA1908 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a541bb029aa4e1bee095ab3f44e3a52294905616..74a8e1c113dfc04c28cf06cc58cb45911d69f757 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -178,6 +178,14 @@ config ARCH_MESON
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+config ARCH_MMP
+	bool "Marvell MMP SoC Family"
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  This enables support for Marvell MMP SoC family, currently
+	  supporting PXA1908 aka IAP140.
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON

-- 
2.50.0

