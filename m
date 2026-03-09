Received: from mail-m15589.qiye.163.com (mail-m15589.qiye.163.com [101.71.155.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D41A5BB4
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773031496; cv=none; b=mFN39s7u1M6AOewDSlA6iLiJ6587ybRPOxXLOLeOKmudLTJVbpjl53eGFHy6Azz3tMRXuaA3/ziprvyx0kO3HsZ6pFt2zUA2bbDqPafMwayS0ylUEH2k+EuJf/YTN+Db0y9vqwEsgR0mn1Oxh2kqw+V0xo3m6vtzBOUMMMvYzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773031496; c=relaxed/simple;
	bh=DWHHC52ShcZZ2dkpnQAyCSnD56AXvoa03MV2xOZ6/Ls=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fmnRaG57Sg1eb6fwFGBDv8Bb2qZDV3R8NBBMzHladwJhG/tm76p7klCeYkIHHnMvV8VT7WbXhwBazdSEbtoX01TgpdTTMG3qi8gbVQ4Qp7WYfOGqiuNFhVoDQbihuW7IC5kBGC/7WxXXD8tWaOKydLSnIg1mXTFEWlRTqMfR2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ifAx1XCU; arc=none smtp.client-ip=101.71.155.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ifAx1XCU"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3631478c1;
	Mon, 9 Mar 2026 11:29:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Add phase map support in dw_mmc-rockchip
Date: Mon,  9 Mar 2026 11:29:00 +0800
Message-Id: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9cd0a42e8709cckunm2100c80115ef20f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgYQlZOTksfTx1PH08aGUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ifAx1XCUUTp7JGc2wKs/wD6z0HoueiEFbiR/iCKmYFVe9ThqDU68cTjAvhz2eCoprgQS7aRPKz88eCXzqWi1X8D/F3SGMefKbelUUhZAmYf55epQTYn49hFJg8JgziGyIHjhMZV3nXmvSM42+jY0VPGn8NgH1/CC5/CA/bQrAfU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ySVjGdAZL4+L3jsqvqxUzJxN/UQZm9vJ85CDgZhbqzM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


Hi Ulf and Jeahoon,

Currently, in dw_mmc-rockchip, the rockchip,default-sample-phase is only used
for some lower speed sampling, while the output-phase configurations are fixed
based on timing settings for all SoCs and boards.

Subsequent validation shows that this approach fails to achieve optimal timing
performance on many chips and development boards, failing to meet test requirements.
Since different timing profiles demand distinct phase configurations, we introduce
phase map support to dw_mmc-rockchip to address this issue.

Additionally, given that dw_mmc-hi3798mv200 already utilizes phase map functionality,
we avoid reinventing the wheel by moving the phase map parsing logic into the core
dw_mmc framework (similar to how mmc_of_parse() is implemented), rather than duplicating
code in the rockchip driver.

This change maintains backward compatibility: the original default_sample_phase and fixed
drv phase configurations for different modes are preserved, with phase map values taking
precedence when configured.



Shawn Lin (3):
  mmc: dw_mmc: Add parsing mmc_clk_phase_map support
  mmc: dw_mmc-hi3798mv200: Using phase map from dw_mmc core
  mmc: dw_mmc-rockchip: Add phase map support

 drivers/mmc/host/dw_mmc-hi3798mv200.c | 11 ++++-------
 drivers/mmc/host/dw_mmc-rockchip.c    | 27 ++++++++++++++++++---------
 drivers/mmc/host/dw_mmc.c             |  2 ++
 drivers/mmc/host/dw_mmc.h             |  2 ++
 4 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.7.4

