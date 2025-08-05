Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994DA29C344;
	Tue,  5 Aug 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437809; cv=none; b=fuxqqIzPkF4LZgDGH/F0i9Jdrd+IJ/yAZNQRSLsA1saFnkXZVEOe8HaDoVnIir7tnsRYdKWDnNUXaWvp5rj9i6Ui4KtzacGPVH/9C7zvBLmiXAk+l7UU7MlPgBRMOTIlXuLhF+IScCcigebP65rlvvkeDMkF4a3C0ATLE8rS/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437809; c=relaxed/simple;
	bh=QoFut0sNVspIKBsVRbd5bf7YRdyQU5XMw1QWasF1wJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ij2QrvObLEqKGBHwDeTvXQZzTTiTWZOwqIX24QeBn6jfcD12ZNlhse7Oy1l5kdiZpKbHrIR7DsRQ7wta9Jj0TlCahFBHByvqJVl7ni87isKq6f6njH9iXGIZgRbe4cqp2lit8hhg5ROHxnenl71KJufItm0phRYVSEXsPqUXDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w2Qiwep7; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w2Qiwep7"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575NnpKh4185345;
	Tue, 5 Aug 2025 18:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754437791;
	bh=++94R41tQyeJMdud8WPd0oi+7jsV3EpN/nsCDMPrqME=;
	h=From:To:CC:Subject:Date;
	b=w2Qiwep7h4n2O+tFZMAhFUwlz/41MguqHiKzfPVXbZcznSLPSmM/1qapo2t2ePHRd
	 q2sEw508wmFZD0lmkDHgNuumaqBp0ChVC9QYUn3o4x30f+mL9tmz2y3K6HLs8FMJwi
	 K2hQnxAtXhioMzZMH9bM4wmlOx5Jn+xbGXVNqo/s=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575NnpPu3796004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 18:49:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 18:49:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 18:49:50 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575Nno6m2624898;
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
Subject: [PATCH 0/4] Add support for AM62P SR1.2
Date: Tue, 5 Aug 2025 18:49:46 -0500
Message-ID: <20250805234950.3781367-1-jm@ti.com>
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

This patch series adds support for the AM62P SR1.2 silicon revision by
adding logic in k3-socinfo to detect AM62P variants. Also update binding
doc to account for second register range GP_SW.

This also disables HS400 support for AM62P SR1.0 and SR1.1 in sdhci host
driver and enable by default for AM62P SR1.2.

Tested against AM62P SR1.2, SR1.1, SR1.0 and AM62X SK.
Log for AM62P SR1.2:
https://gist.github.com/jmenti/5d06c60a94104a476eda9371ab6c7f37

Judith Mendez (4):
  dt-bindings: hwinfo: Add second register range for GP_SW
  soc: ti: k3-socinfo: Add support for AM62P variants
  mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
  arm64: dts: ti: k3-am62p-j722s-common-wakeup: Add GP_SW reg range to
    chipid node

 .../bindings/hwinfo/ti,k3-socinfo.yaml        |  9 +-
 .../dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  3 +-
 drivers/mmc/host/sdhci_am654.c                | 16 ++++
 drivers/soc/ti/k3-socinfo.c                   | 82 +++++++++++++++++--
 4 files changed, 98 insertions(+), 12 deletions(-)

-- 
2.49.0

