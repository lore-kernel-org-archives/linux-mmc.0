Received: from mail-m15573.qiye.163.com (mail-m15573.qiye.163.com [101.71.155.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360D221D96
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666161; cv=none; b=syaYzsZHtV7Oe2Bxw6xnV6RHA1kYJKJlScepnHkJGlQTpRrCOO/m84XZ6Yv8JIqvSnCZl8oD9KxEUQGvbhGoC3BnLTd6bAMImZZdGK3Um26eNneQAkxp9x+wH1W2GKxAFDwYw17ARnSCwDT5OB1theVqReQ9NsV6Z+QSzMlyk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666161; c=relaxed/simple;
	bh=sQglmWD2LBkMT1DFTP8P913wKDm8V9iLU8lOlV7tqSA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pjgB6pf+7xU/hDu0r8BbscML2xazg+soBsfbN6p3JKBgzViNLa6piT7HvE4i6SZZk/5HepXKVVjM4xkq1lzGHQXFEYJfXbbE487BFfo+adQV1N+1gf4sBWrlH+EFDrAz4468A+g6AcF8OPnGf/ATi2nrUe9qlq/oq82oqRIPDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UPfPcGDw; arc=none smtp.client-ip=101.71.155.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UPfPcGDw"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c1540f;
	Tue, 6 Jan 2026 10:17:21 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/18] dwmmc cleanup & improve round 2
Date: Tue,  6 Jan 2026 10:16:51 +0800
Message-Id: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b911832a109cckunmc69ba49b79b758
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04aQlYaGU5OGE4YGU9LTk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UPfPcGDwwKPRwq/4iHjxrJQ5C90m2szQ995qclm3ZEjF488hqaVGwdCPM4Dq7TOFeE3VAN3urIx0GW6anFoQ78NCx6rSK1y6YP64miXdNk3q4ORYeR4xyNhMnjDtqZi/ugSBY6xcswFyFSQrzijKPV7kA+XgMJ9TxFeCshFPvmw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=048iu6gKQAtp20D5W67As/Kv+O/k0mJhBIQ/qUGHRpc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


Hi Ulf & Jaehoon

This following patch series cleans up and improves the dw_mmc host controller
driver. The changes are as follows:

- Patch 1 fixes a potential error case.
- Patches 2-10 refactor the driver by gradually removing the struct dw_mci_board
  and integrating its members into the core struct dw_mci.
- Patches 11-14 perform general code cleanup, removing unused macros and improving
  the dw_mci_get_cd()function.
- Patch 15 simplifies regulator setup by removing a redundant check before
  mmc_regulator_set_vqmmc().
- Patch 16 improves the PCI variant driver (dw_mmc-pci).
- Patch 17 modernizes power management.
- The final patch (18) adds Host Software Queue support to the driver,
  which in testing has improved random I/O performance.

To facilitate review, all the changes are as small as possible.
Please help reivew them, thanks.


Changes in v2:
- fix compile error
- rebase

Shawn Lin (18):
  mmc: dw_mmc: Check return value of dma_ops->init() in resume
  mmc: dw_mmc: Remove dma_ops from struct dw_mci_board
  mmc: dw_mmc: Remove SDMMC_INT_ERROR
  mmc: dw_mmc: Remove assignment of pdata in dw_mci_pltfm_register()
  mmc: dw_mmc: Remove caps2 and pm_caps from struct dw_mci_board
  mmc: dw_mmc: Move rstc from struct dw_mci_board to struct dw_mci
  mmc: dw_mmc: Remove fifo_depth from struct dw_mci_board
  mmc: dw_mmc: Move detect_delay_ms from struct dw_mci_board to struct
    dw_mci
  mmc: dw_mmc: Remove bus_hz from struct dw_mci_board
  mmc: dw_mmc: Remove struct dw_mci_board
  mmc: dw_mmc: Remove redundant struct mmc_data forward declaration
  mmc: dw_mmc: Remove DW_MCI_SEND_STATUS and DW_MCI_RECV_STATUS macros
  mmc: dw_mmc: Improve dw_mci_get_cd()
  mmc: dw_mmc: Remove unused register access macros
  mmc: dw_mmc: Remove check before calling mmc_regulator_set_vqmmc()
  mmc: dw_mmc-pci: Use BAR_2 and pcim_iomap_region()
  mmc: dw_mmc-pltfm: use modern PM macros
  mmc: dw_mmc: Implement Host Software Queue support

 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/dw_mmc-bluefield.c |   2 +-
 drivers/mmc/host/dw_mmc-k3.c        |  17 +---
 drivers/mmc/host/dw_mmc-pci.c       |  30 +++---
 drivers/mmc/host/dw_mmc-pltfm.c     |   5 +-
 drivers/mmc/host/dw_mmc-rockchip.c  |   7 +-
 drivers/mmc/host/dw_mmc.c           | 197 ++++++++++++++++--------------------
 drivers/mmc/host/dw_mmc.h           |  75 +++-----------
 8 files changed, 121 insertions(+), 213 deletions(-)

-- 
2.7.4

