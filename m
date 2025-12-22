Received: from mail-m32114.qiye.163.com (mail-m32114.qiye.163.com [220.197.32.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D829283C9E
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387505; cv=none; b=VF8JGXwVwZ4CnRvgFv6Hnb1SGUaG1TXAaqXD3kQOMQ+Y4R27OHwmfe71JX4fdv7rpdbf4Y4tkpM+p+iPVbk0T9fXEDc5/jicgWaPlG5Uyi0NCdnglUcBrQqHpdZxe5JEqsJx9n+fpoZ9R2PnNvQOYNgfQN0AO9XpZ4YREB4b4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387505; c=relaxed/simple;
	bh=c/FXv7a5bdRrBMYuCOmRHFDKogduB6QMOBxhYkkkp30=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CYXIyjR9Cyy9xUTM3Cm7j2L9utRSbGM9KGvvF3k4rHV6zJEEncD2EUGV603laDhb92aDnxTA3R3fN3CEmlczGW+sQNtwGaXz56v+hArZvH18myQxUoZVCoh4QNptZ2TZaDgAeDE3OMm6wEwAXIDUnoGVmTLLuwRKO3WpH/xY/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EOPPGYHz; arc=none smtp.client-ip=220.197.32.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EOPPGYHz"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e1915ea7;
	Mon, 22 Dec 2025 15:11:31 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in HS200/HS400 mode
Date: Mon, 22 Dec 2025 15:11:25 +0800
Message-Id: <1766387485-205480-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b44e6217109cckunm4bed3a38233852
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0dSlYaTR1IHktDTRkaGUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EOPPGYHzk6kLsXnLNj40NzjhyqJTQtEaSmUoUDCDYJ2gArpMLAp+zEGE09V7EmlIDwuStV+0Yo3ynDzJ0bxHqCdW+p4xLIfO8EK9Rj6Mx3ifpMt3VHOs3u0SgKwJ/htu5QTKk7A5oiAZonwm/7R0gq/U7UXQOslf42z34ADTjOA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=epFuvGNMnq8DZa8S9kytiEiXcwWoqxCo6P+b2a8XwfU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

When operating in HS200 or HS400 timing modes, reducing the clock frequency
below 52MHz will lead to link broken as the Rockchip DWC MSHC controller
requires maintaining a minimum clock of 52MHz in these modes.

Add a check to prevent illegal clock reduction through debugfs:

root@debian:/# echo 50000000 > /sys/kernel/debug/mmc0/clock
root@debian:/# [   30.090146] mmc0: running CQE recovery
mmc0: cqhci: Failed to halt
mmc0: cqhci: spurious TCN for tag 0
WARNING: drivers/mmc/host/cqhci-core.c:797 at cqhci_irq+0x254/0x818, CPU#1: kworker/1:0H/24
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0H Not tainted 6.19.0-rc1-00001-g09db0998649d-dirty #204 PREEMPT
Hardware name: Rockchip RK3588 EVB1 V10 Board (DT)
Workqueue: kblockd blk_mq_run_work_fn
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cqhci_irq+0x254/0x818
lr : cqhci_irq+0x254/0x818
...

Fixes: c6f361cba51c ("mmc: sdhci-of-dwcmshc: add support for rk3588")
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-dwcmshc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 51949cd..204830b 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -739,6 +739,13 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	sdhci_writel(host, extra, reg);
 
 	if (clock <= 52000000) {
+		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
+		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
+			dev_err(mmc_dev(host->mmc),
+				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
+			return;
+		}
+
 		/*
 		 * Disable DLL and reset both of sample and drive clock.
 		 * The bypass bit and start bit need to be set if DLL is not locked.
-- 
2.7.4

