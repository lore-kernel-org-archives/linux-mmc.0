Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com [220.197.32.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF21547E7
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634583; cv=none; b=jtJ5IGK2upZwzLZ6NXk9yEhtk9PM8GQQVCFse+iFpTKmlC/yHj9WJBb6OtyBNu2Rpb795IgtWhKdsDGSdBMTMcVvHP8s7vSAzHX+RdnICnizsqBb/XFPLt3Gnodox67ymVkHMsh13i+QhCYf+PVg4/J5FYDddnTHiiLqvO5fk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634583; c=relaxed/simple;
	bh=ckjGkipDjs15YcK7PIRq4g1iNEmI5Guipe+z4CGTWws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TqMvB5vsnhSIgxqhJkLVeYjF8lHom4ZQoYBCfm9nXBsV2eRWeWeuahj9U10rbNbzuXi0AReLC/xmDka/nkrQy4byXyPgr0woA7nU2sjIWPGiATVLpYSDe2SHtV61L9w4CIPcWdL8S7kfzxkZk0NfgyUS9yScti9cA3qFr3VwNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=calz9+X0; arc=none smtp.client-ip=220.197.32.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="calz9+X0"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a495998e;
	Thu, 20 Nov 2025 18:29:35 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/13] dw_mmc cleanup 
Date: Thu, 20 Nov 2025 18:29:12 +0800
Message-Id: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aa0cff83109cckunma871e903175036
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU8fGlZKHkpMQh5NT0wfGh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=calz9+X01Eh9pLUjwRUazEj4Wt4rFLNEQajagQOxhTZlsNWBw59u4mRjhjjTAlfodWFJjx37tb2hp5kpJ+FSF8fVefFYktnAfT81BEsro8tt1VhxUYkj3JnF/h9AH9kTGioCmBefbujMUODLK8hbg/LFvgSalVGwl1wCTAVgGdY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=KY8RbojBWVhkmKn4VKrp63aa376THU4GkZ2aDp03GwY=;
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



Shawn Lin (13):
  mmc: dw_mmc: Remove unused struct dma_pdata
  mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
  mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci
  mmc: dw_mmc: Remove unused header files and keep alphabetical order
  mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct
    dw_mci
  mmc: dw_mmc: Let glue drivers to use struct dw_mci as possible
  mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
  mmc: dw_mmc: Remove id from dw_mci_slot
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
 drivers/mmc/host/dw_mmc.c             | 606 ++++++++++++++--------------------
 drivers/mmc/host/dw_mmc.h             |  83 ++---
 9 files changed, 297 insertions(+), 461 deletions(-)

-- 
2.7.4

