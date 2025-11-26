Received: from mail-m155110.qiye.163.com (mail-m155110.qiye.163.com [101.71.155.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985147A6B
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116120; cv=none; b=ezcoYb1qu0w6PZ9tnNl2QJ3HmXfXqSnGzPIf/RWk+97cZvBKuaDwTB3kqlnVKceN7qi+iQ2p9G1riAYnvEE5e3KUYEPlEyeKPOus3pIwNkwa1jAziH5iahb0xLoy+a3AC+7tn+EoT8X28J+gFKPzM2sV1QpGb/zzLMhSzrDhYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116120; c=relaxed/simple;
	bh=F8+v028UCoq5aZX1OGiYjyI0AIUBOxAcizCNiTummPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V06+0NaTytjMZrUFb2DhKaKkjfEYKWhWn0n1pDDUj/z0MVCUNfMHvQXQnBr5GtAGMc0dFEBhfMK1TBLIrL/JrNQOeh2y5w8/vRrMD5zVkkU0e2eIzaDofewgIYOd/9AbQtbnPjL7OXaOZLWztBCQ8YdN2/Z1WO7AEUH3WkU4wBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ILH7Gvr0; arc=none smtp.client-ip=101.71.155.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ILH7Gvr0"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae34126c;
	Wed, 26 Nov 2025 08:15:05 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/13] dwmmc cleanup
Date: Wed, 26 Nov 2025 08:14:40 +0800
Message-Id: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9abd8388af09cckunme6f559504dcdf2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5MT1ZNQxkaHkpJQ0saTh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ILH7Gvr0oy/aeGjEQWLtvrBkupthL9dhkK8ggpeOFpaADaolKQa6v8T+BGcNyXBWnwsDMAfDHtPJhC7FAmXrEZ4Wu9pJA5J3L8tSS6t+NSeVWD8OU3+3aqS+1YzDvin73gwrbjLyHH1K1L98JwchKrIH/63p++Y32SUaR+1+vjQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=TsLjNukJ732glSglDtSdw28EVVb4S7q8R0ckWFxFx4U=;
	h=date:mime-version:subject:message-id:from;


Hi Ulf & Jaehoon

As you can see, dw_mmc is likely one of the most complex and difficult-to-read
host driver at present. It maintains various states and bottom-half scheduling,
containing a significant amount of redundant code—including a multi-slot mechanism
that has been unsupported for over a decade.

Jaehoon attempted to remove cur_slot more than ten years ago, but the driver still
retains the slot structure and the associated queue mechanism designed to support
multiple slots. This has made the already complex code even harder to read and maintain.

The first four patches aim to eliminate some of the redundant code, while the remaining
patches are intended to ultimately remove the dw_mci_slot variable. To facilitate review
and minimize the risk of regression, each patch is designed to accomplish a single,
clear objective.

This series have been tested on the RK3588S EVB1 platform.


Changes in v2:
- Fix sparse warning
- Use helpers from regulator.c and remove check for mmc_regulator_set_ocr.
- add commit message
- make commit message clear that we remove two things
- remove a unused code
- Fix dma_set_mask_and_coherent mistake by code rebase
- fix compile warning

Shawn Lin (13):
  mmc: dw_mmc: Remove unused struct dma_pdata
  mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
  mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci and user helpers
    from core
  mmc: dw_mmc: Remove unused header files and keep alphabetical order
  mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct
    dw_mci
  mmc: dw_mmc: Let glue drivers to use struct dw_mci as possible
  mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
  mmc: dw_mmc: Remove id and ctype from dw_mci_slot
  mmc: dw_mmc: Remove sdio_id from struct dw_mci_slot
  mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct
    dw_mci
  mmc: dw_mmc: Remove mrq from struct dw_mci_slot
  mmc: dw_mmc: Remove queue from dw_mci
  mmc: dw_mmc: Remove struct dw_mci_slot

 drivers/mmc/host/dw_mmc-exynos.c      |   9 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c |   6 +-
 drivers/mmc/host/dw_mmc-hi3798mv200.c |  17 +-
 drivers/mmc/host/dw_mmc-k3.c          |  21 +-
 drivers/mmc/host/dw_mmc-pltfm.c       |   2 +-
 drivers/mmc/host/dw_mmc-rockchip.c    |   9 +-
 drivers/mmc/host/dw_mmc-starfive.c    |   5 +-
 drivers/mmc/host/dw_mmc.c             | 621 ++++++++++++++--------------------
 drivers/mmc/host/dw_mmc.h             |  83 ++---
 9 files changed, 302 insertions(+), 471 deletions(-)

-- 
2.7.4

