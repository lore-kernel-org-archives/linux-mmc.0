Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F51E520E;
	Thu,  7 Aug 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607108; cv=none; b=JkNjI+eHRpWNIBKFBeL/6VKjQcof9nf4I+2Qv3W2RNM2lbLrrFmV7xM9M/FSHCRbsfvnIcoOyW/VuJPz0eF/Yfk/dCX2OL+ydMi2KeZePLes6b8Hag93JLVUtMCt7vy3H/7ezTqMj5B7HPY3kOPDM6p+UwbMQrUCFNif/vRFetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607108; c=relaxed/simple;
	bh=na2QU6FWDELkYVoPgCkWkalJvPfa5WbFf4KfIP57n0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=alMgtKaZrCKKjKETeA1lI20dvZTHHzhPiZDVLdaguekO5x9TBYR/+ORk6zZSk1S/E4ysQAzHmYk9CP1563mUvYI3kIBjtFZ93xXkGra9mlLU7NMWfo2NS3wulkZArlGwd9YXPNLdXSMihLEsJWsijY2T687jOp8MmB4A2og02gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wClrZvay; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wClrZvay"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 577Mpc5X410651;
	Thu, 7 Aug 2025 17:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754607098;
	bh=ZOY+VD/ZDT6Ubghvl2iEKCAJZ/RRCH2WxMpO8jS3lDY=;
	h=From:To:CC:Subject:Date;
	b=wClrZvayjyvXYXPm+dvkgIp4el+7u5hKIQFk1qeFmpDGsq+DXEu9MpuwI95FlG53M
	 snUR2x/UVNZBir4NUHOoN9Apbz2nFaE4O7VXDErAvVqncY67o3PH1orwIllLtPLhzG
	 9LxWGXANeEXcp9/h5dVE8fArPc5ka+IVjRjaV7M0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 577MpcCn477040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 7 Aug 2025 17:51:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 7
 Aug 2025 17:51:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 7 Aug 2025 17:51:38 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 577MpcBj2086622;
	Thu, 7 Aug 2025 17:51:38 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 0/2] Add support for AM62P SR1.2
Date: Thu, 7 Aug 2025 17:51:36 -0500
Message-ID: <20250807225138.1228333-1-jm@ti.com>
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
adding logic in k3-socinfo to detect AM62P variants.

This also disables HS400 support for AM62P SR1.0 and SR1.1 in sdhci host
driver and enable by default for AM62P SR1.2.

Tested against AM62P SR1.2, SR1.1, SR1.0 and AM62X SK.
Log for AM62P SR1.2:
https://gist.github.com/jmenti/3d605dcd9445c2fac86c626bfa519103

Changes since v1:
- Drop binding and DT patches 
- Move disable HS400 print to sdhci_am654_init & only print if caps are
  already enabled, according to Andrew's review
- Completely refactor/change patch 2/4 for k3-socinfo to not add a new
  item to reg property, find GP_SW as an offset of JTAG ID. This approach
  is based off-of Krzysztof's review.

Link to v1:
https://lore.kernel.org/linux-mmc/20250805234950.3781367-1-jm@ti.com

Judith Mendez (2):
  soc: ti: k3-socinfo: Add support for AM62P variants
  mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1

 drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
 drivers/soc/ti/k3-socinfo.c    | 27 +++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

--
2.49.0

