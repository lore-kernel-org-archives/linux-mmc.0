Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9E340A43
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066474; cv=none; b=UVnQZti/0nc6UtY+8DyAZ1dc43s3y34VB2MeRDTzungTQmhOO4YvaoD+L2b+uoxwv74k4klIxNcaTABS49+1TI5fOcB27SnZ2MOktnHibX846YiHC/9ToA6puGk/uM7m9/Nw9WGyRSAqNNdqMOvmCMt1MsiKwiMN6PyCgDnwi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066474; c=relaxed/simple;
	bh=bij08HCBVM54rSY5Jk53SAgHae8Q7ZtbesDeZjXKsU4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kXW6blgStRb13FiZv0lBLjBn7yqGE/xDhtQdSUlVkBKen1hy8uBTeqyVKYZLOau3YqPmngkfOqmu4gWqORgIUm1M5I8uT9iCy2GZTLvqPwlI1/CYm4FhAydofhS7LeMLBkiZW18fT8A/rTQKenaCJvM2E6smzKCG/GDa7b2G+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JKI4RO0D; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JKI4RO0D"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb230;
	Thu, 18 Dec 2025 22:00:58 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/18] dwmmc cleanup & improve round 2
Date: Thu, 18 Dec 2025 22:00:27 +0800
Message-Id: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b31c38d4509cckunm1f354c4b7010
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MZTVYfS0hMGh5NTh4eTU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JKI4RO0DbpxkJlMq/ehG6aow6Fb0yB2Mljm7Mekb9skAladjirvbMhhG0TTEDeWT/OjgCNkixkRBLgB2XV1rCM0uIesC8jNm4iTnYn/9eOfadZJ9RtsTyj6gvb0/5Rg4keI2/91UFv/vZVIvRI9dfv4NImKUn+Yv8FCDXoiwFyE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=RawG1UDq9Gcl6QPATzUXQyuMxfBlxynv52Rmc43tZKs=;
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
 drivers/mmc/host/dw_mmc-pci.c       |  29 ++----
 drivers/mmc/host/dw_mmc-pltfm.c     |   5 +-
 drivers/mmc/host/dw_mmc-rockchip.c  |   7 +-
 drivers/mmc/host/dw_mmc.c           | 197 ++++++++++++++++--------------------
 drivers/mmc/host/dw_mmc.h           |  72 ++-----------
 8 files changed, 117 insertions(+), 213 deletions(-)

-- 
2.7.4

