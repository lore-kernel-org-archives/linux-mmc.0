Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FEEC5
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191641; cv=none; b=u3brfz7jvwYAqbllT+KLmc9YwNwtrEDf1BXtiLY79Lhyu4BJX+QtMXYpvDIFJqfHcMJP/QUaJgzMNT5SNO3yl1al3DgQ/QhOAg+S/nXRA7Gu2iw/V4iPGjfgDT8YpBlQVJZ4uh4BkppsToVEYmcpUOyKnLZWv7qXjfda5jy8q9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191641; c=relaxed/simple;
	bh=nNXQ+UKfU5JdnWRYM7AotWuX5OQ3dMFhfc5ycpvmxZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YVReI8K7xZlvI3756bcc3QSUnRtiUoe4UxXjaXjcnOUaQHOQZDVW5KhdOo5QUYUrsORQsRkY4Dyse6RxP/NzCkps2Lrfj7sSUHG8xfoF7jIDMBOLNp1g6vGhTEWzQd5McFrLtQGfMNUdvXcGBy0EZsoqjUQ83CRa8/mhejbGJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ICFGhgTY; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ICFGhgTY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191635; x=1759727635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nNXQ+UKfU5JdnWRYM7AotWuX5OQ3dMFhfc5ycpvmxZE=;
  b=ICFGhgTY/lJ85Hb9SfOtu/NCpTI8r0Ckv07uFHyybirAxcsivFSNbIq8
   KQELVu65/IPO291t6D6VQ2NCBH62qHCupq7w3/szAHjdYtuIE1wfcULFf
   F4BbKzj9KDb5MZ5tAbFXAZJw4u8ijBb41Phfaqepo478T6RcdwNNbEZlf
   RxU0u+4ySyNqgGQbdY/b5ORPkTQPjCxmUkxLnDyJUjdoGJbJPklZG1Ba7
   kYrjeD/gFwpAGNJfTUeL5DjDq9KDZwb/t3Ql4ivW1VbX41/ck4ydtS+/5
   5c8DDaCO9pks8YK7c58t8s+JAlhI5rSLS5ffLzMMH4SG7o2KytrpeUIng
   w==;
X-CSE-ConnectionGUID: wloxYhR1RPmGgxwMESqCyQ==
X-CSE-MsgGUID: uisIcb24TfiVwUmvRCg7TA==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="29406949"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:13:48 +0800
IronPort-SDR: 67020f8f_5S2/Ye1Eb662o1BMuNRq+cPgkodUmpJ76CLkXoj9Ze2DZk3
 MhHqakcdkyYqClLU8PtmnTTutRqcE7Kferd1n9g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:18:23 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:13:46 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 00/10] Add SDUC Support
Date: Sun,  6 Oct 2024 08:11:38 +0300
Message-Id: <20241006051148.160278-1-avri.altman@wdc.com>
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
Changes in v8:
 - Attend some final comments (Ulf)

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
 drivers/mmc/core/sd_ops.c   | 15 ++++++++++++
 drivers/mmc/core/sd_ops.h   |  1 +
 drivers/mmc/core/sdio.c     |  2 +-
 include/linux/mmc/card.h    |  2 +-
 include/linux/mmc/core.h    |  4 ++++
 include/linux/mmc/sd.h      |  4 ++++
 14 files changed, 137 insertions(+), 45 deletions(-)

-- 
2.25.1

