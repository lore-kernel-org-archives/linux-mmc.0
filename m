Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C645198E65
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010679; cv=none; b=P9twmrlDCkVbzyi4tKA7UvznwjEIMJdaAS8403pnGVwN3Szzl7mzlZAuXP1pIfq4sjRl+22//P+E8bLcQM0ynadb1l2+LRx90YPpIGF0MESUrzca/B7exLPW3WDQvgUFzeU3FtlUfuUjdCPjoOIzWnB/Rrodt/8vvsCXypvxeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010679; c=relaxed/simple;
	bh=Hgw5xp2dLVmNRh2SnpNhaDIIrRyZBGghcM6kxOHfXGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jArqNixf4fa0l2Hkz+Zf/VVUVSVAo9lgQfCXg+IGWwAIN87RlYWNjlmvJsCN97dv9h2TLD3133Y2yjKq7+UIaBEci9nV5WhE40xvOIGsnT0OJg09ZpehqEiUaLULsjsWqvrdJ2FFFhxvW2SS8ARE5WbWLHAzKLag2tzc+JVg+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I9b7pWOn; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I9b7pWOn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010677; x=1754546677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hgw5xp2dLVmNRh2SnpNhaDIIrRyZBGghcM6kxOHfXGk=;
  b=I9b7pWOnfNeeH2rqfCCSC/0noQ+pAmAQKobpw958FDB/YVxKD49v3Gwo
   1mXZpfwiJX8p2Gkpo5/ZS+NW7DvK/yibhfepLYQSvPWB2Ec0yNItgJ8k0
   IoKMq7/k6QBNNkikBWA79mg8skzEK/+9JDcAmxHDLNCLKMjRR+ATiRdM4
   sH0zKGhha6cCSN2ZIaLooMy1dEusdt1S/bUkYbwtS9k3T9HxjtWhYD9JQ
   Fb0z+ZZ6ItOGeUEHhFL1lySNJz9BkIcD6M8+6oWMa/jnpzrwlnypPabDS
   /CWaGYw5I1kYZCYKXXE4Uvl0rt6oRqnQJLOnp8lKpOSvu5G3hThTKrG63
   w==;
X-CSE-ConnectionGUID: h+Cn533MSvufW/tH+YP6tA==
X-CSE-MsgGUID: dl2rHLEgSQ2mNRbuWTTgsQ==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039276"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:04:36 +0800
IronPort-SDR: 66b3007a_9Mb0lpHtgHNA8gAnMf1/zvbMz6Fns9Ojm7tMmRV6CRC8aRB
 QHAUiUSbQeglikyKmJZ5I2FzrTEVvvC6uy/xHQg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:04:58 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:04:35 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 00/10] Add SDUC Support
Date: Wed,  7 Aug 2024 09:02:59 +0300
Message-Id: <20240807060309.2403023-1-avri.altman@wdc.com>
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

 drivers/mmc/core/block.c  | 45 +++++++++++++++++++++++++++++-------
 drivers/mmc/core/bus.c    |  4 +++-
 drivers/mmc/core/card.h   |  3 +++
 drivers/mmc/core/core.c   | 48 +++++++++++++++++++++++++++++++--------
 drivers/mmc/core/core.h   |  2 +-
 drivers/mmc/core/queue.h  |  1 +
 drivers/mmc/core/sd.c     | 16 +++++++++----
 drivers/mmc/core/sd_ops.c | 34 +++++++++++++++++++++++----
 drivers/mmc/core/sd_ops.h |  1 +
 drivers/mmc/host/sdhci.c  | 38 ++++++++++++++++++++++++++-----
 include/linux/mmc/card.h  |  2 +-
 include/linux/mmc/core.h  |  1 +
 include/linux/mmc/host.h  |  6 +++++
 include/linux/mmc/sd.h    |  4 ++++
 14 files changed, 169 insertions(+), 36 deletions(-)

-- 
2.25.1

