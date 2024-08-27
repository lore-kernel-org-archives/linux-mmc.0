Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA41B4C29
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761530; cv=none; b=swFOGYGOZbncd2EXOqDUfCuPJxZIsCBFoROs9Y85YY+ZODq2fXih3VcxvefVK1ro9FCZTdFJ91i7hK1mG1kWHVKPbAHc6fMjwOQkFSCJlq4277p/K5k9GmtmrzJa4OBQIBGLanA9xt9+jcTHIzfHxy3L5Yis4aE074VHAhFzcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761530; c=relaxed/simple;
	bh=lJp5sMgDCbo6dVohB9EqVCi9ISLOXAM22iB+4We7xeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uPMayu9BXzHUnr8Q7jB2l8HVtLdjvnCoD5Nu/CZuMq67XOXPUMVXr7fJbv8oQ0In/wue2odmLkDYuyLOlsebVbef8IUy3vhdd4JNhUqIqE7Hs0K5E0sIw8M8NAyc9vwXM4Pksm37aVVyF0OqvNIaya9zAYmDlRntlHl19bIwrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lyp4M5/s; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lyp4M5/s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761527; x=1756297527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lJp5sMgDCbo6dVohB9EqVCi9ISLOXAM22iB+4We7xeE=;
  b=lyp4M5/sPW9+U/uycN4BHkq3UFi6qMlcWGf4mN+N0ZUb/4iRAReKtwo8
   VgLnAnC7eF3Kw79Q3OZOTIDl8FcxBJzBK++3ZfNtTBVK79i8hY0fRGKlF
   Xqbd0ivZBK7lOsD0GjL0vMPmvvlhqXGSqrTr1+wcyxB1Vjm5OnklXXrUj
   ThdkKKt6QJQkMbchfa3ZLkVUYfX1OS1HKSWo172G4WhTPrRPZBPDjkuyW
   6n4umci0zyerKqGPwGtTVtnv014DqNlqyerb4TpbTZgKbhsQsUyUH9n9p
   KGIqIn5qsYPDbUinzsT0eHoZEgOR0i7fw6b9JGW/BMZUYqy6HFQ/5RkfT
   A==;
X-CSE-ConnectionGUID: Qqp0v30PTpSq4FD/nzNeFw==
X-CSE-MsgGUID: 9DrlrSnSTdmYP3WsJsmmgg==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="26066768"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:25:21 +0800
IronPort-SDR: 66cdb79e_C8Gie14Pz7lfDwEetjHTVyz9Xy8v0Z2jccZ3wDpeP7sJyw2
 09aUaPo8SjJYAoKPhfHJLnz9vWurODBSdUy2bFQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:25:18 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:25:19 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 0/9] Add SDUC Support
Date: Tue, 27 Aug 2024 15:23:33 +0300
Message-Id: <20240827122342.3314173-1-avri.altman@wdc.com>
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

Avri Altman (9):
  mmc: sd: SDUC Support Recognition
  mmc: sd: Add Extension memory addressing
  mmc: core: Add open-ended Ext memory addressing
  mmc: core: Don't use close-ended rw for SDUC
  mmc: core: Allow mmc erase to carry large addresses
  mmc: core: Add Ext memory addressing for erase
  mmc: core: Adjust ACMD22 to SDUC
  mmc: core: Disable SDUC for mmc_test
  mmc: core: Enable SDUC

 drivers/mmc/core/block.c    | 43 ++++++++++++++++++++++++++---------
 drivers/mmc/core/bus.c      |  4 +++-
 drivers/mmc/core/card.h     |  3 +++
 drivers/mmc/core/core.c     | 45 +++++++++++++++++++++++--------------
 drivers/mmc/core/core.h     | 16 +++++++++----
 drivers/mmc/core/mmc_test.c |  7 ++++++
 drivers/mmc/core/sd.c       | 36 +++++++++++++++++++----------
 drivers/mmc/core/sd.h       |  2 +-
 drivers/mmc/core/sd_ops.c   | 16 +++++++++++++
 drivers/mmc/core/sd_ops.h   |  1 +
 drivers/mmc/core/sdio.c     |  2 +-
 include/linux/mmc/card.h    |  2 +-
 include/linux/mmc/sd.h      |  4 ++++
 13 files changed, 134 insertions(+), 47 deletions(-)

-- 
2.25.1

