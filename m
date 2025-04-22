Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0B244684;
	Tue, 22 Apr 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354676; cv=none; b=U4z1Pq7EPQ4uCRH8pOq150ytynZAJqRN0tY8gwt3ZwbfevFt6ywUI0JSRq3PWL5LJX6a6icmd+bZ/nnt7Z/7Jf5zAYBaSGxlcg7bF9BOxh4yZPTGl8bRSUHW3g8IrgeaTxH8S4rHUbzhXDw2ubIXp7d3JzL7vZ/cC5G540S7zI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354676; c=relaxed/simple;
	bh=7UhV5M7N6WMuUJtg+Ac2IlfdfF0Q0K73JxJC+wAiqCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZpHYtToegdurYjmGbu5RyW/n+rcA2jnkeWBB6IKUy5ONT6um7keFpo26CUv/IL1cCukkxF7fTGoi54SWcmlJsT5l2Hir/82NJzlkiBH13b3qe7jUpxZKDsBP1Y5V+j6N0uo8IAI01+FXPKGUob1qwDXzZlcKOHpjF4rXAlHNvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ODB9f3DN; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ODB9f3DN"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MKiEdr1992457
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 15:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745354654;
	bh=zcYMv7ggKAyiW015uopgtq2tD/sZdZ+LxTka+zsTdkE=;
	h=From:To:CC:Subject:Date;
	b=ODB9f3DNdMsSQXuD/PUb+vEq7Vc1mREH8AWwcCg3cKk3ZZCcOOiLaP1PQHMpvXmMW
	 hbT3WBuAhPs4rsqgwiPaKpuVW997XbL1S4GxXHEGd42u5QflwAJDeWuSXAAiHd+MVh
	 i4DVFFUznadNI9/qWeGGvANGzUfgJ2o+rmwIlCkk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MKiE67024616
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 15:44:14 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 15:44:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 15:44:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MKiDWh061619;
	Tue, 22 Apr 2025 15:44:13 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth
 Menon <nm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Hiago De Franco
	<hialgofranco@gmail.com>
Subject: [PATCH v3 0/3] Add ti,suppress-v1p8-ena
Date: Tue, 22 Apr 2025 15:44:10 -0500
Message-ID: <20250422204413.272679-1-jm@ti.com>
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

There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC
and Microcenter/Patriot SD cards on Sitara K3 boards due to the HS200
initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
is optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
For SD cards we shall parse DT for ti,suppress-v1p8-ena property to
determine whether to suppress V1P8_SIGNAL_ENA. Add new ti,suppress-v1p8-ena
to am62x, am62ax, and am62px SoC dtsi files since there is no internal LDO
tied to sdhci1 interface so V1P8_SIGNAL_ENA only affects timing.

This fix was previously merged in the kernel, but was reverted due
to the "heuristics for enabling the quirk"[0]. This issue is adressed
in this patch series by adding optional ti,suppress-v1p8-ena DT property
which determines whether to apply the quirk for SD.

Changes since v2:
- Include patch 3/3
- Reword cover letter
- Reword binding patch description
- Add fixes/cc tags to driver patch
- Reorder patches according to binding patch first

Link to v2:
https://lore.kernel.org/linux-mmc/20250417182652.3521104-1-jm@ti.com/
Link to v1:
https://lore.kernel.org/linux-mmc/20250407222702.2199047-1-jm@ti.com/

[0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/

Judith Mendez (3):
  dt-bindings: mmc: sdhci-am654: Add ti,suppress-v1p8-ena
  mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
  arm64: dts: ti: k3-am62*: add ti,suppress-v1p8-ena

 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  5 +++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  1 +
 .../dts/ti/k3-am62p-j722s-common-main.dtsi    |  1 +
 drivers/mmc/host/sdhci_am654.c                | 32 +++++++++++++++++++
 5 files changed, 40 insertions(+)


base-commit: 1be38f81251f6d276713c259ecf4414f82f22c29
-- 
2.49.0

