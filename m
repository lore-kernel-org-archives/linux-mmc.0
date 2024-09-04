Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0911DC07C
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461680; cv=none; b=NSwgMhGGxZyqDnY0774JhiEIPiQf8cBnl8B/yWef5AtuzE+UpwD3F/VSrJmgNSNcglGHHeXd+O6fs5HEYlrKe8ccvHBD3sRN3U0U78S+XTHYiO0gwCqsDQcghM9O7mPSuCag4aw/Y3suOrKAsm9FnZ53XX8T84oWpR1FVNwtB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461680; c=relaxed/simple;
	bh=6B5qNYBBWXDzIWUXBlL8rLsSFcIl7KCzo59Rce5aQQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tfhdlIihztLEJn/vyr4/PIeTrBETNttzzVK0y66LdZgAYywhfGEBbvsb7Jn8chH0lH5r6CRzLI94+ypvtVVFVPYVJoebIwPm6NdfzvOgqh4dAOg4Bgn25C9RnkHVu14sE2iTk67O/IuyYtMwuSgN/eGuD0wXKZKbDJcRVyDEOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ndcpu+LS; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ndcpu+LS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461679; x=1756997679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6B5qNYBBWXDzIWUXBlL8rLsSFcIl7KCzo59Rce5aQQ8=;
  b=ndcpu+LSpHlKhpXRz5+uLBhs7dfXlfQgxDV26q5Wb0TeBd0PmRod3B74
   5Nrp+npX97BPf07P5Yrn09uPvVPk8KQ8E1xYgNg6c/+ggClVhOUhUEuc1
   0DptN+OG1SSRD844dM7xELQiS08z6MkVBgA4cPWMdmWZ/WQ96teESHuKs
   BEUX0VBDPARmj7nLgIS1ATmS1kJJnf9dZpHC3f9oogj9hloZ+PA6/BXZk
   haQ2zM6ZJSLPtSAZlrMZ02uuWNy2UOGrJ/OuXeaNwhfNfRt7Z/zfSRM++
   t3uZ2OIlycpHSSU1fhgKnopjB0LBG3swBONUEsTdc7cLwm2ue93WKERcM
   g==;
X-CSE-ConnectionGUID: kKIO8DWqTwWnuAiY1IwPng==
X-CSE-MsgGUID: YDp/y/kATcKelAOFhOfXCA==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="25915017"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:54:38 +0800
IronPort-SDR: 66d86690_pgAWnVDm5jlY9qbiu2QHOB7dFUAxw01MZSoba9/p6Elzw/P
 BD86qsmzrtz+Av9HjXQpnSplEXFAvPQXVqq/tmA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 06:54:24 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:54:36 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 0/9] Add SDUC Support
Date: Wed,  4 Sep 2024 17:52:47 +0300
Message-Id: <20240904145256.3670679-1-avri.altman@wdc.com>
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

 drivers/mmc/core/block.c    | 43 +++++++++++++++++++++++-------
 drivers/mmc/core/bus.c      |  4 ++-
 drivers/mmc/core/card.h     |  3 +++
 drivers/mmc/core/core.c     | 52 +++++++++++++++++++++++++------------
 drivers/mmc/core/core.h     | 16 +++++++++---
 drivers/mmc/core/mmc_test.c |  7 +++++
 drivers/mmc/core/sd.c       | 36 ++++++++++++++++---------
 drivers/mmc/core/sd.h       |  2 +-
 drivers/mmc/core/sd_ops.c   | 16 ++++++++++++
 drivers/mmc/core/sd_ops.h   |  1 +
 drivers/mmc/core/sdio.c     |  2 +-
 include/linux/mmc/card.h    |  2 +-
 include/linux/mmc/core.h    |  5 ++++
 include/linux/mmc/sd.h      |  4 +++
 14 files changed, 146 insertions(+), 47 deletions(-)

-- 
2.25.1

