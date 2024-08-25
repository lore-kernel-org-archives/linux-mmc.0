Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607257C8D
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571805; cv=none; b=ct7JJ/XpuvoPi1+uNWBnp2kk72vYQ2obDZYlqO6515P+Np31HDwk3aGEoouHumip1WhmwI9BvRbOstc7XC+O0yf8SC+4fATFw94uC3kapTHLOC1N/H506KRtTP81nfULEazo6AwFplHggUm9Z8B6dHzIeqkkToT39bEHCcehCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571805; c=relaxed/simple;
	bh=YJsyDOcYL2REidJtdIW+Ya3g3vEHjFAHFvg0n7qiPVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uSIb8G/eycVuPLRHJOX7iLAVNLh3IwA4EHrkA+7e5y7cIAMfuA6+/t3raZ6OZ5xUr/anlqx/ys5Pql3/dytTNDbITbSuFc0Zm+7gOtQc5Isa7NudDA84ZDkis6zgQjLOdnNhD5pvUlvwRMxXuTBZZcyt3u4+0m6hc0PQsUWyEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ppmRzd4G; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ppmRzd4G"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571804; x=1756107804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YJsyDOcYL2REidJtdIW+Ya3g3vEHjFAHFvg0n7qiPVk=;
  b=ppmRzd4GZu7LtpGnQNj7Nzs6ROXdQ3urK+NPIn6UI+R6DHysJRbT95cw
   URvs8TIsLaj+9GqxLBurwjBejtI0+NkFv1oSKNJ0DkR7OmVqdpC0XHJ1/
   rxX8miCluOudXMs9mtvobBfgkvSYa3sihDr56NmoC3bz3wNbV7b6Wkegf
   GLR3FKXH0E/mqoAWehWl2o2/LtsEMhjb1rhyI2Ei8XUe+HIUMajC85gnf
   jGPWcZwjgkAJn9TY1d6yF6q/XgA4GSMHVKERpYhe3Xw1exukLe0G5D5jo
   sMnMMjVGWCduPDLEP8U8RD5VEvPLwn11AlRbB5GW2NaLF7QgOEl88wifZ
   Q==;
X-CSE-ConnectionGUID: ADP70JelRiaTwLHvQHXnLQ==
X-CSE-MsgGUID: /LJ3f/1JT5STULrZVAzHIw==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100411"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:18 +0800
IronPort-SDR: 66cad3d9_Dl/bfUZ2RFUSjAWcFsMV75kYGBga4vK/MKxA8hsNubwZD6W
 LLnqYZ4w4IZ7xx7bL1Jut5vaWxJg0h/jDR6qbKw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:48:57 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:16 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 0/9] Add SDUC Support
Date: Sun, 25 Aug 2024 10:41:32 +0300
Message-Id: <20240825074141.3171549-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
cards support capacity larger than 2TB and up to including 128TB. Thus,
the address range of the card expands beyond the 32-bit command
argument. To that end, a new command - CMD22 is defined, to carry the
extra 6-bit upper part of the 38-bit block address that enable access to
128TB memory space.

SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II – Same
as SDXC.

The spec defines several extensions/modifications to the current SDXC
cards, which we address in patches 1 - 10.  Otherwise requirements are
out-of-scope of this change.  Specifically, CMDQ (CMD44+CMD45), and
Extension for Video Speed Class (CMD20).

First publication of SDUC was in [1].  This series was developed and
tested separately from [1] and does not borrow from it.

[1] https://lwn.net/Articles/982566/

---
Changes in v4:
 - Squash patches 1 & 2 (Ulf)
 - Amend SD_OCR_2T to SD_OCR_CCS in mmc_sd_get_cid (Ulf)
 - Use card state instead of caps2 (Ricky & Ulf)
 - Switch patches 5 & 6 (Ulf)

Changes in v3:
 - Some more kernel test robot fixes
 - Fix a typo in a commit log (Ricky WU)
 - Fix ACMD22 returned value
 - Add 'Tested-by' tag for the whole series (Ricky WU)

Changes in v2:
 - Attend kernel test robot warnings

---

Avri Altman (9):
  mmc: sd: SDUC Support Recognition
  mmc: sd: Add Extension memory addressing
  mmc: core: Add open-ended Ext memory addressing
  mmc: core: Add close-ended Ext memory addressing
  mmc: host: Always use manual-cmd23 in SDUC
  mmc: host: Add close-ended Ext memory addressing
  mmc: core: Allow mmc erase to carry large addresses
  mmc: core: Add Ext memory addressing for erase
  mmc: core: Adjust ACMD22 to SDUC

 drivers/mmc/core/block.c  | 56 ++++++++++++++++++++++++++++------
 drivers/mmc/core/bus.c    |  4 ++-
 drivers/mmc/core/card.h   |  3 ++
 drivers/mmc/core/core.c   | 63 ++++++++++++++++++++++++++++-----------
 drivers/mmc/core/core.h   | 14 +++++++--
 drivers/mmc/core/queue.h  |  1 +
 drivers/mmc/core/sd.c     | 36 ++++++++++++++--------
 drivers/mmc/core/sd.h     |  2 +-
 drivers/mmc/core/sd_ops.c | 16 ++++++++++
 drivers/mmc/core/sd_ops.h |  1 +
 drivers/mmc/core/sdio.c   |  2 +-
 drivers/mmc/host/sdhci.c  | 40 +++++++++++++++++++++----
 include/linux/mmc/card.h  |  2 +-
 include/linux/mmc/core.h  |  1 +
 include/linux/mmc/sd.h    |  4 +++
 15 files changed, 195 insertions(+), 50 deletions(-)

-- 
2.25.1

