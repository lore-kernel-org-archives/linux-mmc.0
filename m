Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603DBA20
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154464; cv=none; b=Dp+xyfVZGJp0Szf51fj4rVm121iu2udSNKreRe7IwDxRgsgfVtJ51fvHlZ6FScUYB9LSya8RbJZmtImtXA6Fl2wnH+u2WEDq6xpqj9nOaPMKHoXfM6HXgUaVtrj2zvRbwTPs4CsukNX1FTXfm8NOGoCyWKwaRguWsZ0DOkrtHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154464; c=relaxed/simple;
	bh=bberpaHDxRjxBqgdbZ6qk/txqF9t3Ob757DlMckQS6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hQOeCtTPm6BT5+6G5iEeA2XeTx2sqbkncfIxB0caQVgioEH2FgtCxMcDtZTNiDN2moqz6uszhl7huXYeDFgJHWhWu8OmmkazzsAPmfj0bOSLM2h7RBIjaQId3T/LldHLtp8CVIM0r9Mqjd/K9lUAA2UdhERXV9OKRIZNl7nxl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DNBmisKJ; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DNBmisKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154462; x=1753690462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bberpaHDxRjxBqgdbZ6qk/txqF9t3Ob757DlMckQS6o=;
  b=DNBmisKJJvJ2W4VZW/Omn9eAlrT4vcBVedZTkUhr5MShSA8CnClztL0B
   DxFpU9o/6v8/CJVkvu2BTzahjb3Fyv0L4ClbEM7UGnZ8GmZIdelhr4aBd
   dUUdvADHkMsW5I/foWwGm8usJnYK3X21rYH2sR+1XL2cFQ79nxs8vhNgf
   XX74HTe2uTIzLf7MDSFbCJlxIuN+kbIEyu4JHYFPKl53txbQmuDoFaX1G
   Z1LDfS4NHza+/a907I9WTGXWjm0GpI4Ew65xPwEcH7c2wlrNqd/ytjq10
   prrL0yNciHZVlQMo8oPdjhm6FlKQAL9cWsuPi7YKSm2PrFf+ydGwax6u4
   A==;
X-CSE-ConnectionGUID: WOQnrwbuS0u4oVKp8xV1bw==
X-CSE-MsgGUID: CPEueodTSGqI/kDpJj4TnQ==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22256096"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:13 +0800
IronPort-SDR: 66a5f0ff_CubcsRibkXS0tQFtv7hBs5uUDmmMNHCcaMPRhhyJOjb8IyO
 sO7bPFiZ/eWeJBdfgY1yklZIOJHodZRl4saQZzQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:19:28 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:12 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 00/10] Add SDUC Support
Date: Sun, 28 Jul 2024 11:11:44 +0300
Message-Id: <20240728081154.1782120-1-avri.altman@wdc.com>
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

 drivers/mmc/core/block.c  | 47 ++++++++++++++++++++++++++++------
 drivers/mmc/core/bus.c    |  4 ++-
 drivers/mmc/core/card.h   |  3 +++
 drivers/mmc/core/core.c   | 54 +++++++++++++++++++++++++++++++--------
 drivers/mmc/core/core.h   |  2 +-
 drivers/mmc/core/queue.h  |  1 +
 drivers/mmc/core/sd.c     | 16 ++++++++----
 drivers/mmc/core/sd_ops.c | 33 +++++++++++++++++++++---
 drivers/mmc/core/sd_ops.h |  4 +++
 drivers/mmc/host/sdhci.c  | 38 ++++++++++++++++++++++-----
 include/linux/mmc/card.h  |  2 +-
 include/linux/mmc/core.h  |  1 +
 include/linux/mmc/host.h  |  6 +++++
 include/linux/mmc/sd.h    |  4 +++
 14 files changed, 179 insertions(+), 36 deletions(-)

-- 
2.25.1

