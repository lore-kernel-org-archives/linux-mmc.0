Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACE2D0295;
	Tue, 22 Apr 2025 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354688; cv=none; b=JTliZdkw0AOxZRl4vGPG3+7heQtvESpw4emJRjuhD0ELl9CIT4tbiXWSY7VYK0+0glIJjmY/kew4mFPMhFa/B3jOSg94e0MHaGorvG6tl4biMacYDlqyBN07+P5UT35m9R3zqDspw0E0FyWJGiopku2YitXA1b+uKIn/i0c/zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354688; c=relaxed/simple;
	bh=dROXq7MGD8SnzKaeA5JRhYPc0bHQiWBBS3c+LKff70g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMognVtWGDdQu/GBST0yB+vPyCNeQL4Ac81hq35Yhrt0edKi8St28HRpMhQaLD7fO/mwsLfJB4HaUhRJH5WhRvDBHUNi1V2176zAvXMhqlpcYEA+RznC04BOb7sXumBGXsfk+8vDIxIgVI+B8iwRF054PNMtYCUBNvwhgVtI60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=edIEKSPj; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="edIEKSPj"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MKiF7W1321609
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 15:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745354655;
	bh=x4pJOvfSWdXFtA3Vu2W/bJKu8o1yhDi/KoiZOv1/400=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=edIEKSPjuHIoBR6RUfHe3jlB1lFQwoIPFJF1KYi/gWK3RlGj2s/D5v/NKBY1iPwh1
	 xHIxetoi7jpI1Tj8UtBpVpmW1av+tyvYyj1bPWSi4DtmhWI7WxpRM3L1jq2h3+nPNc
	 WKO1qSNtq4ORhq8Qf2z5y1iTHH+AvY2+OGWsfG6A=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MKiEId064581
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 15:44:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 15:44:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 15:44:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MKiDWk061619;
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
Subject: [PATCH v3 3/3] arm64: dts: ti: k3-am62*: add ti,suppress-v1p8-ena
Date: Tue, 22 Apr 2025 15:44:13 -0500
Message-ID: <20250422204413.272679-4-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422204413.272679-1-jm@ti.com>
References: <20250422204413.272679-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add ti,suppress-v1p8-ena flag to sdhci1 nodes to suppress
V1P8_SIGNAL_ENA.

On am62x, am62ax, and am62px SoCs, there is no internal LDO
tied to sdhci1 interface so V1P8_SIGNAL_ENA only affects timing.
Suppress V1P8_SIGNAL_ENA since it causes init failures across
Microcenter/Patriot SD cards and Kingston eMMC on am62* SK boards.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 1 +
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 7d355aa73ea2..a61153b0af32 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -586,6 +586,7 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,suppress-v1p8-ena;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index a1daba7b1fad..44d973caf200 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -606,6 +606,7 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,suppress-v1p8-ena;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 6e3beb5c2e01..c4304dae9757 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -604,6 +604,7 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,suppress-v1p8-ena;
 		status = "disabled";
 	};
 
-- 
2.49.0

