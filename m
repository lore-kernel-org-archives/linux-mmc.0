Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F028F507;
	Thu, 24 Apr 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517659; cv=none; b=TsiIczQ86RjKzbmC+XvpkCbsFZi0NjpY8SnjDMFC9ADxtiJ/D//urW5cmFnhwXjP28EfE3ZowxHJ7MqcO9X+Gj2pQECS4KDLSP1pFCD2RKT+CCMuQ8rFLtYCuucey4WZ6asYsV2sZkvvZfUBNXyQVuB8CB5qNibrGu7HhIK0450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517659; c=relaxed/simple;
	bh=K/yMHVvsMsYWBKNwbEHWLz10n1sEmxNndpQcj++yOM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mG+8QHCm9J7yqw02TxkVUCraR0n175mF3H9At/1L2wcSN0YvcNPapbC9IhZ+REHP1imdjxS3V1zQOL86pXzr+rUVKu66dIu642EnDD8pL38tadwHXvopIzK95bXmVYMc0HbRqOKO+Gk2ltXa72mMzeh2w0TiFqpvuVUKl9NPv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tmyZLkYq; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tmyZLkYq"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53OI0a0Z2714438
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745517636;
	bh=ByzxuZNtZvGBiMEU1x+258op4v/yxzWgvRbeyPhuoc4=;
	h=From:To:CC:Subject:Date;
	b=tmyZLkYqvIJXDSZpvbbgqGUvwt8sxZR0RdnF79hi6Gf2uURPiqrPdPvUWXMip/CDT
	 acurUJfdefq/rT5CY8yigkCjyM328Kr2ENye9OlNsEABoxPg9wqyjtjQLRVweAcyR7
	 WkY77AmhKztD0WJKs6IE23xcnKIrMhJsgO9tDaX4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53OI0a4Z114985
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Apr 2025 13:00:36 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 13:00:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 13:00:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53OI0ac8054845;
	Thu, 24 Apr 2025 13:00:36 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
Subject: [PATCH v4 0/2] Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA
Date: Thu, 24 Apr 2025 13:00:34 -0500
Message-ID: <20250424180036.1541568-1-jm@ti.com>
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

There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC and
Microcenter/Patriot SD cards on am62* Sitara K3 boards due to the HS200
initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
is optional for eMMC and only affects timing for host controllers using
ti,am62-sdhci compatible so far, add a new platform data structure for am62
compatible and append the new SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk.

This fix was previously merged in the kernel, but was reverted due
to the "heuristics for enabling the quirk"[0]. This issue is adressed
in this patch series by adding the quirk based on compatible string,
ensuring the quirk is never applied to devices with internal LDOs, then
V1P8_SIGNAL_ENA also has a voltage component tied to it.

Changes since v3 RESEND:
- apply the quirk based on compatible string instead of based on bus
  width or DT property
- rephrase commit descriptions and cover-letter descriptions based on
  new implementation.

Link to v3 RESEND:
https://lore.kernel.org/linux-mmc/8678d284-db12-451a-b789-2b75f9932f9f@ti.com
Link to v2:
https://lore.kernel.org/linux-mmc/20250417182652.3521104-1-jm@ti.com/
Link to v1:
https://lore.kernel.org/linux-mmc/20250407222702.2199047-1-jm@ti.com/

[0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/

Judith Mendez (2):
  mmc: sdhci: Add a quirk for suppressing V1P8_SIGNAL_ENA
  mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk to am62
    compatible

 drivers/mmc/host/sdhci.c       |  8 +++++---
 drivers/mmc/host/sdhci.h       |  2 ++
 drivers/mmc/host/sdhci_am654.c | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)


base-commit: 1be38f81251f6d276713c259ecf4414f82f22c29
-- 
2.49.0

