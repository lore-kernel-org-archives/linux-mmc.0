Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B934253B
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887956; cv=none; b=DD1znZSCiSLtwffVpo3PZ6zoMsyZAW+pXqwqzIctvvTZNbwEBLSdSUerEFhp/1Y4Scyk4f4JkfKW1r5EL83sFcujQcJ2vihqPZP0rNBLhpmj8tAk0Yfh6Q3dPB3EsEx1hdo94AUp566Sh9UfPYgkQ26G90CEB4xaTQKhaue8GoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887956; c=relaxed/simple;
	bh=5RJcnVG38eumMLWtam/LoAgoNEDitoSORTIg3Q6pRto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MNN7pOQXZKf7R+4a0iIEtywIaeVAGEAKGs2BNlIEhPAUxG3Aoz6jQi3juuHWRGeScFrDsQ93Ri59Uwa90SedFji8gZCEWt3QYeKueo6J4Nira6/Sm0WkRCDu4wOy14fI+FHLhT5f95xlcj1cWwwAhqmNs9hHKw0lP4tlQc8VfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Mlgbb7wD; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Mlgbb7wD"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a7f0;
	Tue, 16 Dec 2025 19:50:24 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/12] dwmmc cleanup
Date: Tue, 16 Dec 2025 19:49:55 +0800
Message-Id: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b26ff4aee09cckunmc1d96abd3f991a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsfS1ZNTxgeSh5JT0kdSUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Mlgbb7wDRAngJJmbAx2s6Ix5Q/J64pBbrjhx+PytMB+V632Epe2hQWaDPFPmbg6EtVanllsgkf/Q2FPyljPoEAuTPQTaOhMqL+xbXZpF/SkpMCgtt93zhP/LbR+bsHMp43oNi+wht9IdQthC4xdsEs+c2EuVEEy67M29dL4Ms+0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=v79W/NmrVCv7dsd4iynR6rrSoZM39WeJSP0l50DCl5g=;
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

This series have been tested on the RK3588S/RK3399/RK3576 EVB platform.


Changes in v3:
- Separate a patch for mmc_regulator_set_ocr changes
- Elaborate more on reset changes

Changes in v2:
- Use helpers from regulator.c and remove check for mmc_regulator_set_ocr.
- add commit message
- make commit message clear that we remove two things
- remove a unused code
- Fix dma_set_mask_and_coherent mistake by code rebase
- fix compile warning

Shawn Lin (12):
  mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci and user helpers
    from core
  mmc: dw_mmc: Remove check before calling mmc_regulator_set_ocr()
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
 drivers/mmc/host/dw_mmc.c             | 464 +++++++++++++++-------------------
 drivers/mmc/host/dw_mmc.h             |  80 ++----
 9 files changed, 251 insertions(+), 362 deletions(-)

-- 
2.7.4

