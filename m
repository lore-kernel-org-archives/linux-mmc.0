Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4912356BA;
	Tue, 18 Feb 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904523; cv=none; b=Y/j4TOLZtM7fZdZ6uVZrXCA7uoCaTIDqcRjmQnq1bpArPfgBY9uhhPUUk2b9LJ+ILuk4G9EGvvgBbSiOn4eoC46TEvcB3/EKBITeQtd071ixhN3y2jCinIizo9CmADppzbkyc0gba50ET7nwJUqCyb0X/g7j+8yNb9pVljRB2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904523; c=relaxed/simple;
	bh=YMTJWxXHh330br82br0etxC3kz7eh2nyIwBII22BIRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=drCMeISNWQQdB5F4FrYo+zvl2Tyz1ZL3rYmeEvEAVbKZoyZRG1wzlnpWTAvCpKkRIUUWm40BoC2GhuU2V6/+PSQ2yXeAb2aOUNy9bVM6d9QklcQAA2zgxLZaDhfho9TOIE2O0NDU6fXoC8sZxWqv6aGx9WGEFFNT6gt+JWqZqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=T0CsyKyQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="T0CsyKyQ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4A15B25B65;
	Tue, 18 Feb 2025 19:48:33 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YTEc64bV_CrT; Tue, 18 Feb 2025 19:48:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739904512; bh=YMTJWxXHh330br82br0etxC3kz7eh2nyIwBII22BIRg=;
	h=From:Subject:Date:To:Cc;
	b=T0CsyKyQz5J0X18a0h/L2r9JpQBQ9dSb3Buwpn/I2t+BHgx/HbyiIBHNRaC0uyLCW
	 eLtM7XxUZ+6H0dwkZv1D0VbEM3YWMMdU/lioM7PzaEzPm26nyMrGwbYtvVQD0RBV1Y
	 j4R7q2jmQ4RqmI+GlKklaj3viHSTzYYmZehubCAwram4QPjAcggyufwv3nQywn3cq0
	 ma4BQlasjNdpgdwGOYLcpiD2QDpQnYnrRFAhDJ4OGu8u2igCRxNM2JuZjSTbL5T5/d
	 M7jDvs2rHfzPErekjpqqTDT9Ub9CaF0E2OdA0fOjJluf0IWM91hxXVe7jpp67di0iY
	 IhbDt5IIhpnmw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/3] Introduce DW MMC support for Exynos7870
Date: Wed, 19 Feb 2025 00:17:46 +0530
Message-Id: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPVtGcC/13MQQqDMBCF4avIrJsSY2xCV96juNBx1FmYlESCI
 t69qdBNl/+D9x0QKTBFeBYHBEoc2bsc6lYAzp2bSPCQG5RUtVSyErTtzkdjjRTLgsLUfYe1rdA
 +NOTTO9DI2wW+2twzx9WH/fJT+V1/lP6nUimkQGtwRKN60l0zcAzer3cfJmjP8/wAsEEUxa4AA
 AA=
X-Change-ID: 20250203-exynos7870-mmc-75bac583c864
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739904507; l=1253;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=YMTJWxXHh330br82br0etxC3kz7eh2nyIwBII22BIRg=;
 b=LZPho8AvHLw3wEQKSAqT37sfbjzg/HU7eUsKTXf8nEcvsTjTTnCilhT8CRmn1576PNG64Mnco
 jJWN2rpJhc1Aa8CzVfZUXxM57Y7EhyZiteNSLIeS/o74LQuhm3lGYre
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

This series adds support for SMU and non-SMU variants of Exynos7870 DW
MMC controllers.

Some DW MMC controllers require two 32-bit r/w from a 64-bit FIFO,
the series implements that feature as well.

This patch series is a part of Exynos7870 upstreaming.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- Take over ownership of patches by the co-author, upon their request.
- Link to v1: https://lore.kernel.org/r/20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org

---
Kaustabh Chakraborty (3):
      dt-bindings: mmc: samsung,exynos-dw-mshc: add exynos7870 support
      mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
      mmc: dw_mmc: add exynos7870 DW MMC support

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |  2 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 41 +++++++++-
 drivers/mmc/host/dw_mmc.c                          | 94 +++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                          | 27 +++++++
 4 files changed, 161 insertions(+), 3 deletions(-)
---
base-commit: e5d3fd687aac5eceb1721fa92b9f49afcf4c3717
change-id: 20250203-exynos7870-mmc-75bac583c864

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

