Received: from mail-m10208.netease.com (mail-m10208.netease.com [154.81.10.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B94334CA
	for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2026 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239865; cv=none; b=bdHvDVWrafhngV+JRr/MwgRxyM/9PkNEBYUXpRZl4gEcFG1mPByupPAzRbTAySar1Uo8fEflCY7T97xRP6YhRwI6QqZqEukKuNB9jpzg/lcOTgQyS1zeDNmDsN2E/WL9rbcFYoRvVtWr2PIF3BaTm9Ylkng1bB4bc/7KPal9dFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239865; c=relaxed/simple;
	bh=aC7TbN92mtd7diA4SSvvymp7Fuzm1wVvZJpyooXmzIA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=m9RQNyn495dBAalP5R/dDnXldQ4RmoTxbPk3ZiHHRbJ4NPuWGOp5jjhM2sWu49kHJcvXNGPb5v8s9ty2Rw6P6Uk2RZkx+qrAX0IHK6ypoO5k+ux6HohcTC3mLEX3wLXl33OLVSXHkuhp9kyvG63Bld+pOKknNvUaYNAGwUZGyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IV+LFnnd; arc=none smtp.client-ip=154.81.10.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IV+LFnnd"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f01e1b71;
	Thu, 24 Sep 2026 16:50:47 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/2] Add mmc_send_tuning_timeout() and use it in dw_mmc-rockchip
Date: Thu, 24 Sep 2026 16:50:21 +0800
Message-Id: <1790239823-139583-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0d29c30d603a4kunm11feacd55405a7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQkhPQlZNQhhCTUsdHk
	0dQh5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IV+LFnnd31T9ych4OGRCyuz3V/pE/6svu548dtAP/Pv+CFcqQVq3YCe6mA2RHyGCA05tYHdTgwGHOqEfPxnkJgyPXJrUD7C2fj0YEtLdUV1qj8FBPQVttw10SkS4XLOJ0bJdxqNSxlXyK5hk6I1Luwga/E+/9x5bktPK3nHOcR8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1l6ScudUKR/MxhyEGDAKQAZvdVOzve1sqQv9S4LEbrc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


The tuning specs guarantee that a *sequence* of 40 tuning commands
completes within 150 ms, exclusive of any host overhead:

  eMMC, JESD84-B51B 6.6.5.1 "Sampling Tuning Sequence for HS200":

    "The Device is guaranteed to complete a sequence of 40 times CMD21
     executions within 150 ms. This is exclusive of any host overhead."

  SD Physical Layer Specification Version 4.00:

    "The card shall complete a sequence of 40 times CMD19 executions
     in no more than 150ms. The tuning process is normally shorter than
     40 executions of CMD19, and therefore should be shorter than
     150 ms."

mmc_send_tuning() however applied that 150 ms as the data timeout of
every single CMD19/CMD21, i.e. 40x the per-execution budget implied
by the specs (150 ms / 40 = 3.75 ms of device time, excluding host
overhead).

The data timeout only matters for tuning commands where the device
never returns the tuning block at all; a wrong sampling phase
normally fails fast with a CRC error instead.  Waiting 150 ms per
such test makes software phase scanning painfully slow.  With
dw_mmc-rockchip HS200 eMMC the TMOUT register saturates at ~112 ms
for the requested 150 ms, and dw_mmc-rockchip's execute_tuning() scans every
phase of the tuning window, stalling that long on each phase that
misses the window.  Multi-second boot slowdowns have been reported[1].

This also increases the cost of runtime re-tuning, not just the tuning
performed at enumeration time.  So this series introduces a new helper
for host drivers to provide their own timeout for each tuning command.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=221781


Changes in v2:
- Let drivers provide the timeout via a new mmc_send_tuning_timeout()
  instead of shortening the default for everybody, as suggested by
  Adrian, so it is less likely to cause a regression.
- Split into two patches; mmc_send_tuning() keeps its current
  behaviour (150 ms) and dw_mmc-rockchip opts in with 5 ms.

Shawn Lin (2):
  mmc: core: add mmc_send_tuning_timeout()
  mmc: dw_mmc-rockchip: use a tighter per-command tuning timeout

 drivers/mmc/core/mmc_ops.c         | 22 +++++++++++++++-------
 drivers/mmc/host/dw_mmc-rockchip.c |  2 +-
 include/linux/mmc/host.h           |  2 ++
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.7.4

