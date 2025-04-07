Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CD199235;
	Mon,  7 Apr 2025 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064831; cv=none; b=RvhlxDFAKkitRd6I8y+u95YEarLZUmj7+J6iQ7BFcNbpwsbhCznxMyKbZwA3YJEo2sxkDhMZBCnEnSMLqCKnrdyZUwVfP0+TuN3FrhJ9N9yX5b9Za3e9xP4KgTJlfQKPJ+4VkTKKS2Mc6fduhOuI2MR3NTsuFgT5r0+Cws0Fn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064831; c=relaxed/simple;
	bh=8vxtgFjplcFUtJXG4ul9cSfWBPurAuH67A1b9tZXa4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZqTzaZRBsnuvfhFMpkcyZz6HouifMVOrzQo/4O9n114NBO4d8nN/wq4JKo2qUWJK/7pw9j0PjJ4NOB1JF90gau2qGN7zmMCrhj8pqUO1k+k180UvlqDq/GSJmpBOClJB+LHRkjLt1gzG3Z3Tdl2XOvqISVWKtVVyPHeJ5u/ZunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u47PHR5t; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u47PHR5t"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 537MR2VQ984370
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 17:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744064822;
	bh=KfEZzRTeWtUnuAOOZ4Yf4u0OaURswnKGRy0cKmTlhis=;
	h=From:To:CC:Subject:Date;
	b=u47PHR5t6xs6YKroYzq7GybGuo5Pdkl2rdR4t+vkmLiWYqMTD4Luo/4W6SJGNfwt5
	 58HA5Mlitt/BnsWC4muK6fE4914l6eYoZ4yYDImiPLU3h+INzEArxk+xqjNj7gWAWr
	 LMNHJxlxG8JgrV8aZXiWBMxA45Uf6t93Esavtb0s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 537MR2rU026270
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Apr 2025 17:27:02 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Apr 2025 17:27:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Apr 2025 17:27:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 537MR228073249;
	Mon, 7 Apr 2025 17:27:02 -0500
From: Judith Mendez <jm@ti.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>
Subject: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
Date: Mon, 7 Apr 2025 17:27:00 -0500
Message-ID: <20250407222702.2199047-1-jm@ti.com>
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

For all TI devices, timing was closed For Legacy and HS modes in
half cycle timing, where data is launched on the negative edge of
clock and latched on the following positive edge of clock. The
switch to full cycle timing happens when any of HIGH_SPEED_ENA,
V1P8_SIGNAL_ENA, or UHS_MODE_SELECT is set.

Currently HIGH_SPEED_ENA is set for HS modes and violates timing
requirements for TI devices so add a .set_hs_ena callback in
sdhci_am654 driver so that HIGH_SPEED_ENA is not set for this mode.

There are eMMC boot failures seen with V1P8_SIGNAL_ENA with a
specific Kingston eMMC due to the sequencing when enumerating to
HS200 mode. Since V1P8_SIGNAL_ENA is optional for eMMC, do not
set V1P8_SIGNAL_ENA be default. This fix was previously merged in
the kernel, but was reverted due to the "heuristics for enabling
the quirk"[0]. The new implementation applies the quirk based-off of
bus width, which should not be an issue since there is no internal
LDO for MMC0 8bit wide interface and hence V1P8_SIGNAL_ENA should only
effect timing for MMC0 interface.

[0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/

Judith Mendez (2):
  PENDING: mmc: sdhci*: Add set_hs_ena to sdhci_ops
  mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch

 drivers/mmc/host/sdhci.c       | 55 +++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h       |  2 ++
 drivers/mmc/host/sdhci_am654.c | 48 +++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 20 deletions(-)

-- 
2.49.0

