Received: from mx.olsak.net (unknown [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6EC2E54D6;
	Tue,  8 Jul 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994710; cv=none; b=iT2tBJsBDoIgHPH0Oe55UOeXvdR7cjBMxlrmkObWqj3Yy7yyI3ym3NNuc0J1LqTnGtVz6Qh7iI9O+qyx55iTs6kjaDjUb6rZgZpuIt/EpP93p3X4yvFFUxhy0deirYp0ngqzq7Wh8wMO43tirTiWvw8yGL6KCX1f7uwYfosvOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994710; c=relaxed/simple;
	bh=woWeKJnpRztvRK6bKdssmWxs/ctbwt85zMIAynkGfrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byCodW6CEb6iWPfZgrwALqKR4GljISXoiqfdZCpGoWLGiceaJt0VslbIZpMu/bORxmu+luirTaZl+zYjaPPGl/vSZny1CFQa46Ff+s7Ru04hcA15KIQgaadi//lV4kZpjKtWYOnCh0DOF4wreYVbU5SCCSe/A6oDsaX8LRzpkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Mz/4tHpM; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Mz/4tHpM"
DKIM-Signature: a=rsa-sha256; bh=vg1k+N1CjHljh4O4O+1NZ5dq3O9FqJdzDpBsXrHQCJU=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1751994605; v=1; x=1752426605;
 b=Mz/4tHpMmeaAh8Ocf9jwkYrQgSGVnfZNVUPblzd0Uvp7YdVUJeZH8SzH02irPNBgon78FknZ
 Ng1qpX2LUoP9tsNrFki9jwUfEQP/msKAUaVtBoTU3dAB8mycye1/A4lfs6FrRL9wGY8JYvbJMcl
 g5m1wS5MCKtRH34QgtFdOk839IvHoYI59C+D/7nZPTfoXq8HPiru2Otvt1x0kM9FwAAxmHToVoP
 T0DiKhPSObrcbGRGRv6cZ1AmS/w/aLgYaND2L6ImMADo4lfTDKyf5592lHyx/PXtVLn7oSqR9Ui
 ULy6tFACEHwuaRAEEzQ8NjRh0M7gIXDQDCZzVmLV0sLfw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id b4c8048d; Tue, 08 Jul 2025 19:10:05 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Tue, 08 Jul 2025 19:09:50 +0200
Subject: [PATCH v16 5/5] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250708-pxa1908-lkml-v16-5-b4392c484180@dujemihanovic.xyz>
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
 soc@lists.linux.dev, linux-mmc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=woWeKJnpRztvRK6bKdssmWxs/ctbwt85zMIAynkGfrM=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm5AY9DePkKj5dxOBRnhx5PqY4P2DmHSauyhym35aCdP
 veZlk0dpSwMYlwMsmKKLLn/Ha/xfhbZuj17mQHMHFYmkCEMXJwCMJGZ9owM8xedZlJ89Xiy3KNk
 wYkSHmH7+b12uL5eGtNiK9emd/rHJUaGRQu+sCTMmLGrw9nGL1n04wPr5wcOPjE/UZDtJHOye+s
 6XgA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add myself as the maintainer for Marvell PXA1908 SoC support.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v16:
- Update email
- Fix device tree path
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a1918beec113b576cf28b76151745ef..a886d791e753588f55807737ce02355400133188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2787,6 +2787,14 @@ F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 
+ARM/Marvell PXA1908 SOC support
+M:	Duje Mihanović <duje@dujemihanovic.xyz>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/marvell/mmp/
+F:	drivers/clk/mmp/clk-pxa1908*.c
+F:	include/dt-bindings/clock/marvell,pxa1908.h
+
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>

-- 
2.50.0

