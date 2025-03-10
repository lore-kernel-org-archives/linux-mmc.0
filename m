Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431501B4153
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586154; cv=none; b=PDMtZyu3dxusMtUn/bYjC+Dxkv7A3M7Vc1aoEo/MysotXYRENxXShB+NrnKCNLvE5lJ4UjpiyCdmh8L35dIXD/XIOj48WNMBZUm2SXc8PVWEIopM9X0BK7sFGtHpt80xM3gl58oYlwCUjH4QxmGONz6ZIEezUlX9DxMfZnrDXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586154; c=relaxed/simple;
	bh=MHFwlEfGN+fifQDA2AtkuofQok5Bg+qNZI4xG3WHSwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CnkB5rLDzDutoMVA8aDJwlCwhluKV6SR6zRXQEa3MwsA37tgw2Fc97ClDCj2Ny48Zn3RyjEP+cp6++S3sB5+mgvzIuMSULI4RQwKvtL0S17ytH8eAT5ha7ZH1bzcj7hmFqwHbyth+re7qFLG3ZDd1WOJV8q6Yjyn4FxLNGo9lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=rnuq3pgu; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="rnuq3pgu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586153; x=1773122153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MHFwlEfGN+fifQDA2AtkuofQok5Bg+qNZI4xG3WHSwA=;
  b=rnuq3pgu1ltsyCSTvFZva0sm7V0FGGg2RN4k5pAf4MuCs1HdJybp9W3i
   JiTc6qPUrvjBBd/F+LaRkUynHwZtZEmFPBcrWSoYbVnNVWb5KSkAa5HcP
   Ea1ybZLOBFyHaVxxiBLNArd1Cdy3zONJFpo0EIXjw9H/oRgczWefiJovL
   MaM87FPZ02LGaYlagPKGO6RD/mHcxqE2HGe/3dbXwfx+Ee3TjngOyA4xg
   fKTb0F5noJHcqI8F5I/3Ohj1v4uozbn8AR8ZVbUa//Wt+QOrn9Li9a7KW
   6pW/qUn9fBxzoCTbXjq9r6Z9X29fnIcbvXzO4DaNfYeCHwMqCEZyEiwgf
   g==;
X-CSE-ConnectionGUID: qb9yPMC0SNeD61BpOnWPaA==
X-CSE-MsgGUID: pR7l1pscRd2txH677wDMrQ==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="46164393"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:55:52 +0800
IronPort-SDR: 67ce7114_iIkEQgnhVSZuzmZ8m5+hdknqB6zDSZJ8il0KpSeaHegWtEz
 8/yeggFAVnjOliPb/8Hpifia9mANgZISVczr0sw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:56:52 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:55:51 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 0/7] mmc-utils: lsmmc: Registers value as an argument 
Date: Mon, 10 Mar 2025 07:52:24 +0200
Message-Id: <20250310055231.304728-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary change allows the utility to accept register values as
arguments instead of reading them from their sysfs paths. This
enhancement improves flexibility, particularly in scenarios where
register values are obtained without access to the actual platform.
Patches 1 through 5 are preparatory cleanups and refactors to set the
stage for the main change in patch 6.

Avri Altman (7):
  mmc-utils: lsmmc: Break early in scr read
  mmc-utils: lsmmc: Remove redundant argument checks in do_read_<reg>
  mmc-utils: lsmmc: Pass program name to usage function
  mmc-utils: lsmmc: Update HOWTO to include CSD and CID read commands
  mmc-utils: lsmmc: Refactor register processing
  mmc-utils: lsmmc: Allow getting registers value as an argument
  mmc-utils: lsmmc: Update docs to include new options

 docs/HOWTO.rst |  14 +++-
 lsmmc.c        | 211 ++++++++++++++++++++++++++++++++-----------------
 mmc.1          |  18 ++++-
 3 files changed, 167 insertions(+), 76 deletions(-)

-- 
2.25.1

