Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B325B313;
	Tue, 24 Jun 2025 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803168; cv=none; b=OsRuN3Avw6j7isYgEeicvaPHmzy66Gx60ULTQIOLaF9rMn/qrUe3oB0DaHqqMCQpLaxeTv+SErF7KZ5GEIIsQ1xqye7r/RI4GBrnSc8T90s4mBzK6i4VEIULVlvBiFNiCu/HfVjHP40IElZFbGHZHxPUU27Mw0v8KJDWg8103RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803168; c=relaxed/simple;
	bh=2MjRU/ayQyqD2mx0PyDKDNA6DcuITZbDsRfobVCl/Uc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZB6Rde4psVrJ3e+RdOzYRenGa3eDC3mkKbJPFniN9ho3+5hwRRnZ4GbdxRjuZ/ydcVXJnl32uJnJ0V3rHrsEFEcTyQ0CbquAwwlH8dyIMmVM5mn4RQaNd4vRPk0i2C6BO69352Nb1nmmCuvumO49IgvxeLQsZYaZwautJ1/V+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JgE1WtSN; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JgE1WtSN"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55OMCV5a1669410;
	Tue, 24 Jun 2025 17:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750803151;
	bh=9+TWzMrm54xfZ0RWb5/Dm+shOivo1lObaYOF3smCwj4=;
	h=From:To:CC:Subject:Date;
	b=JgE1WtSN9PhyKQdfZ59E1u6JrAuHkGJ40AHaSUh2sgThXcI8Nj5D3lDRwqllD5qn5
	 +FWUSlWCATUURND5C3RApKRZV7HJssEpXwokEWN0zY/IydEHhXN+6RcN8NtKrfL/mI
	 EhBy7NBE1iJu0+tbfztgZ4tK9K/FpQNbMuVlcCyg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55OMCUrk1942543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 24 Jun 2025 17:12:30 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 24
 Jun 2025 17:12:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 24 Jun 2025 17:12:30 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55OMCU9J2248346;
	Tue, 24 Jun 2025 17:12:30 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian
 Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 0/3] Workaround for Errata i2312
Date: Tue, 24 Jun 2025 17:12:27 -0500
Message-ID: <20250624221230.1952291-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch series includes fix for Errata i2312 [0].

Also include fixes for removing eMMC HS DDR support for am62
SK which has been descoped as per datasheet [1] and enabling internal
pullups for AM62 SK and AM62SIP SK, as per JESD84 spec recommendations.

[0] https://www.ti.com/lit/pdf/sprz487
[1] https://www.ti.com/lit/gpn/am625

Judith Mendez (3):
  mmc: sdhci_am654: Workaround for Errata i2312
  arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
  arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      | 25 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  1 -
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 25 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 ------------------
 drivers/mmc/host/sdhci_am654.c                |  9 ++++---
 5 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.49.0

