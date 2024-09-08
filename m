Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFED14EC66
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790930; cv=none; b=hcFKCjb73COX7WyyNVL0ERdEJlbDWAe5GzULbtxB+yUkyWAKB/mhgDJj/DMZENDeDqHYkbFQjjidWtByTKompZR3hVr4xsYNbUBVU83R9hs0BznyiXDRLbYQfH9G/zChcA++LVEoiGi+1G0FeBFTjRhsWqii5trion3H4+QszPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790930; c=relaxed/simple;
	bh=ySPUle5m2pJ0gniDR31n5O4DDGl/QSdoQ9wO08WGFNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bArPsHyV3uYZ6brOIvGFN/cXYz7zLC20Xck8BPNANLrLiACZRd0HHQlNejkb7tFkKgg6wcIxsfWcFk4K4E6VPk1M4HAUbDMVzxump/pYQX1jamtdCAL8RLPaW/HPbDziYneuTpFmwfdZrzoUIhDRifGmSOb4kb4nNIhPV9fisqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TAXF+cvv; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TAXF+cvv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790929; x=1757326929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ySPUle5m2pJ0gniDR31n5O4DDGl/QSdoQ9wO08WGFNs=;
  b=TAXF+cvvmeGDKN0k1b4Ex1S4wM8d6Nlk4LTcwRPw97rNX6pF1MbCCpli
   iuhC9rixX6+jCWgLIB3qFMU52JEvoXuPH9MykJ3kh/WIFeVfuEEaO+0lY
   yf38CVHVkOB4JxMQps739eKn2TlOelt/hia3m2y2YxnAqiE8/PuzqqPTs
   /W8ghnTBo6uOVWXIA3LhzKIGG+syD4o5naGpquqGki3rWyC7t+nPTsk4B
   XGfxJmT8C8ftwf4A4G/mVULc5Pc4GqbgjxRopXalmdy/liQGYktGva5nj
   HHP1xvNOqckhpDMsHyOVOsvHjcj5KrOWGmbtj2raQZ20vFwrPlSPh3V2Q
   w==;
X-CSE-ConnectionGUID: Yzbkf/3cTBmpIcl3ryvlkg==
X-CSE-MsgGUID: /n7Ax/xQTbqqTtc1RoUfYw==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="26168367"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:02 +0800
IronPort-SDR: 66dd6def_UTlY4r50n49u9pP8MIoQT9E1SPPQdyCracUQ4aQSh31uLQA
 7OfuVz7tMci7aTcAZCef5kvQXu+SxXw7KBZ3f4A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:11 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:00 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 00/10] Add SDUC Support
Date: Sun,  8 Sep 2024 13:20:08 +0300
Message-Id: <20240908102018.3711527-1-avri.altman@wdc.com>
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
Changes in v7:
 - Minimizes the padding further in mmc_command (Christian)
 - Set the SD_OCR_2T when enabling SDUC (Adrian)
 - Remove unnecessary casting (Adrian)
 - Remove redundant else and switch patches 3 & 4 (Adrian)
 - Add patch to prevent HSQ from enabling (Adrian)
 - Remove redundant variable and make use of clamp_val (Adrian)

Changes in v6:
 - Remove Ricky's tested-by tag - the series has changed greatly
 - Call mmc_send_ext_addr from mmc_start_request (Adrian)

Changes in v5:
 - leave out the mask in mmc_send_ext_addr (Adrian)
 - leave out close-ended SDUC support
 - remove 500msec write delay as there is no busy indication (Adrian)
 - disable mmc-test for SDUC
 - move enabling SDUC to the last patch (Adrian)

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

Avri Altman (10):
  mmc: sd: SDUC Support Recognition
  mmc: sd: Add Extension memory addressing
  mmc: core: Don't use close-ended rw for SDUC
  mmc: core: Add open-ended Ext memory addressing
  mmc: core: Allow mmc erase to carry large addresses
  mmc: core: Add Ext memory addressing for erase
  mmc: core: Adjust ACMD22 to SDUC
  mmc: core: Disable SDUC for mmc_test
  mmc: core: Prevent HSQ from enabling for SDUC
  mmc: core: Enable SDUC

 drivers/mmc/core/block.c    | 37 +++++++++++++++++++++-------
 drivers/mmc/core/bus.c      |  4 +++-
 drivers/mmc/core/card.h     |  3 +++
 drivers/mmc/core/core.c     | 48 +++++++++++++++++++++++++------------
 drivers/mmc/core/core.h     | 16 +++++++++----
 drivers/mmc/core/mmc_test.c |  6 +++++
 drivers/mmc/core/sd.c       | 38 +++++++++++++++++++----------
 drivers/mmc/core/sd.h       |  2 +-
 drivers/mmc/core/sd_ops.c   | 16 +++++++++++++
 drivers/mmc/core/sd_ops.h   |  1 +
 drivers/mmc/core/sdio.c     |  2 +-
 include/linux/mmc/card.h    |  2 +-
 include/linux/mmc/core.h    |  5 ++++
 include/linux/mmc/sd.h      |  4 ++++
 14 files changed, 139 insertions(+), 45 deletions(-)

-- 
2.25.1

