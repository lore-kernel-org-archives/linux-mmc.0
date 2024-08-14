Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8D54F8C
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620672; cv=none; b=ClB7UyY7LzQc/SxDLtOl3sGFleeGMOqXjOr8lpTJGKBedZCygTotg4dQL1NACcI3gA7jz4jkhokYgXYI1XCVpy5o/j8d6J1ynJd0JVuKfQArAGmBiz7Ps91Qz8r75HZk3tazSGnRZkWvyUxo6a+Vo/Now9qih1PMcqrPDiYXh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620672; c=relaxed/simple;
	bh=MQVUWySMSuSNhEV1m4vMyD334XjzoKaDQq2vOd/nNpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DQBeQJXxOrzn7bTkj3pq2bFVMezGyKRREn4CVnuPyplk0h1I4ZPTaIexk8ap1JS0EAsOjXfeTGnNZ8PK8yQFlsINtioI8xS8pRrQb2kl/olQmKZ0pb1gg2v3MHGMll/q/LseXO/vVEJWb186pngJfQ08SWqCxKrms0igmXRxgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=URxjGwBx; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="URxjGwBx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620670; x=1755156670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQVUWySMSuSNhEV1m4vMyD334XjzoKaDQq2vOd/nNpc=;
  b=URxjGwBx+PVtqtRAojz0TEME6F8FiA4cw8dyprIaq4EJcvmg6CbyerAC
   sjjwvKr99g2g2ASxHWcCgVGxtglogCq2yDeTCssLqUiE0dT+thjJLCCou
   5DYTQagV5GnK5b3ZvjQjnJn2GMTmbG777lfa1WCxgTjBJco7UYyzy58x+
   935bpXLozUZoDb7HR7NQ4/pxhT7kWF84ZBNsioNkEYWmEiIEersnI+ss5
   3S6crtYFssHYGWgTPwaxQNoDwBYy3fBY1AhY/1oEXDejV5Q9VDQFnw+JJ
   Ul8jdf2r9Y7q1Oa97KAZvPKbyHDPAUEuXtpvPhC2l0cfMJVWxrQj+bgLu
   g==;
X-CSE-ConnectionGUID: 9jp9KOedT1ObRwHsPEV1OA==
X-CSE-MsgGUID: ntwShZC1QTaB/pLMSX0ATA==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="23625068"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:07 +0800
IronPort-SDR: 66bc4f38_5nDoeovK+/LvJMgRbHcTMcz6xrFwf+3J2qlkOMFZ4lAkIM4
 HbloQPJX2cFrepcAd+1OZTkWoboAioPWOYjvMXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:31:20 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:05 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 00/10] Add SDUC Support
Date: Wed, 14 Aug 2024 10:29:24 +0300
Message-Id: <20240814072934.2559911-1-avri.altman@wdc.com>
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
  mmc: sd: Add SD CSD version 3.0
  mmc: sd: Add Extension memory addressing
  mmc: core: Add open-ended Ext memory addressing
  mmc: host: Always use manual-cmd23 in SDUC
  mmc: core: Add close-ended Ext memory addressing
  mmc: host: Add close-ended Ext memory addressing
  mmc: core: Allow mmc erase to carry large addresses
  mmc: core: Add Ext memory addressing for erase
  mmc: core: Adjust ACMD22 to SDUC

 drivers/mmc/core/block.c  | 62 ++++++++++++++++++++++++++++++++------
 drivers/mmc/core/bus.c    |  4 ++-
 drivers/mmc/core/card.h   |  3 ++
 drivers/mmc/core/core.c   | 63 ++++++++++++++++++++++++++++-----------
 drivers/mmc/core/core.h   | 14 +++++++--
 drivers/mmc/core/queue.h  |  1 +
 drivers/mmc/core/sd.c     | 16 ++++++----
 drivers/mmc/core/sd_ops.c | 34 ++++++++++++++++++---
 drivers/mmc/core/sd_ops.h |  1 +
 drivers/mmc/host/sdhci.c  | 38 +++++++++++++++++++----
 include/linux/mmc/card.h  |  2 +-
 include/linux/mmc/core.h  |  1 +
 include/linux/mmc/host.h  |  6 ++++
 include/linux/mmc/sd.h    |  4 +++
 14 files changed, 204 insertions(+), 45 deletions(-)

-- 
2.25.1

