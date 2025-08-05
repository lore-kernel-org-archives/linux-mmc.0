Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76E291C1B;
	Tue,  5 Aug 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437802; cv=none; b=rlNnLaysiGCy6BTxf/Ukf9Wei+SXr+s25bmFVwXB2BBRxRJsWs8zcrEQRczoHCvV/gINVqaa2Dxp/O5gxx14BVUimWnB9JL6+XbHjnOEeuqYqsYW/TTbNC8859MvnqrQ7mfxd+XD8aVqJoT1WU67cOMbIx8vQaje7H/JXdyLE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437802; c=relaxed/simple;
	bh=HDd/396e+RbMsI5D1J6ZQjO3zo16o+ODZTvSGHG19/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQzaWyuIGuZsX2y6w2cSSY10KiJii0X9ovockNj66Xa8DOS+TnThpPkx6gQ2kbutN7+/gUMpulYiYetz86SbiPklcjQFHTxjkG972bYNCdWVMcbkfx819H89HAjtVQO/wSrwb25e98hnT6CX97pWe9l9VmiwURFEV6iF/8nRnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ICKE89S8; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ICKE89S8"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575Nnprk388002;
	Tue, 5 Aug 2025 18:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754437791;
	bh=Gl7PKzkulptD9jdg8xbxrt81Qiymr7y0BydPiYTY5VY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ICKE89S83xU20iJr2JZfj7Ezr65u3Z7W+PWT7TVtKNyhrwimSL+2KitaZrmOsvZbb
	 oDJ3XW+4wyIEbdVF7jBsyqU3kWlDuNljyW+0KAD1P+frqQWFHRk7kW4b1h3sblsTvZ
	 raFFHzK2JFfYFGc2zRGUXj1x6cGNJST3cu5Z9Qp4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575Nnpn63796006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 18:49:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 18:49:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 18:49:50 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575Nno6q2624898;
	Tue, 5 Aug 2025 18:49:50 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am62p-j722s-common-wakeup: Add GP_SW reg range to chipid node
Date: Tue, 5 Aug 2025 18:49:50 -0500
Message-ID: <20250805234950.3781367-5-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805234950.3781367-1-jm@ti.com>
References: <20250805234950.3781367-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This adds GP_SW register range to k3-am62p-j722s-common-wakeup which
will be used to determine SoC revision.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index 6757b37a9de3..48778c49d8fc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
@@ -18,7 +18,8 @@ wkup_conf: bus@43000000 {
 
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
-			reg = <0x14 0x4>;
+			reg = <0x14 0x4>,
+			      <0x230 0x10>;
 			bootph-all;
 		};
 
-- 
2.49.0

