From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/4] mmc: sdhci-s3c: revert
 "fix missing clock for gpio card-detect"
Date: Tue, 25 Jun 2013 10:20:58 +0900
Message-ID: <51C8F07A.9060709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12306 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab3FYBU4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jun 2013 21:20:56 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOX00KHID295570@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Jun 2013 10:20:55 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>

Fixed the warning message.(clk_disable/enable didn't pair)

[    2.110000] ------------[ cut here ]------------
[    2.110000] WARNING: at drivers/clk/clk.c:780 clk_disable+0x18/0x24()
[    2.110000] Modules linked in:
[    2.110000] CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 3.10.0-rc1-00313-g60e5410-dirty #26
[    2.110000] Workqueue: pm pm_runtime_work
[    2.110000] [<c0015824>] (unwind_backtrace+0x0/0x138) from [<c0012868>] (show_stack+0x10/0x14)
[    2.110000] [<c0012868>] (show_stack+0x10/0x14) from [<c00247fc>] (warn_slowpath_common+0x4c/0x68)
[    2.110000] [<c00247fc>] (warn_slowpath_common+0x4c/0x68) from [<c0024834>] (warn_slowpath_null+0x1c/0x24)
[    2.110000] [<c0024834>] (warn_slowpath_null+0x1c/0x24) from [<c03de910>] (clk_disable+0x18/0x24)
[    2.110000] [<c03de910>] (clk_disable+0x18/0x24) from [<c03b93fc>] (sdhci_s3c_runtime_suspend+0x50/0x64)
[    2.110000] [<c03b93fc>] (sdhci_s3c_runtime_suspend+0x50/0x64) from [<c02bfd54>] (pm_generic_runtime_suspend+0x2c/0x40)
[    2.110000] [<c02bfd54>] (pm_generic_runtime_suspend+0x2c/0x40) from [<c02c41d8>] (__rpm_callback+0x34/0x70)
[    2.110000] [<c02c41d8>] (__rpm_callback+0x34/0x70) from [<c02c423c>] (rpm_callback+0x28/0x88)
[    2.110000] [<c02c423c>] (rpm_callback+0x28/0x88) from [<c02c466c>] (rpm_suspend+0xec/0x628)
[    2.110000] [<c02c466c>] (rpm_suspend+0xec/0x628) from [<c02c5b60>] (__pm_runtime_suspend+0x5c/0x74)
[    2.110000] [<c02c5b60>] (__pm_runtime_suspend+0x5c/0x74) from [<c02c026c>] (pm_generic_runtime_idle+0x44/0x4c)
[    2.110000] [<c02c026c>] (pm_generic_runtime_idle+0x44/0x4c) from [<c02c41d8>] (__rpm_callback+0x34/0x70)
[    2.110000] [<c02c41d8>] (__rpm_callback+0x34/0x70) from [<c02c4d20>] (rpm_idle+0x104/0x2b8)
[    2.110000] [<c02c4d20>] (rpm_idle+0x104/0x2b8) from [<c02c5cc0>] (pm_runtime_work+0x88/0x98)
[    2.110000] [<c02c5cc0>] (pm_runtime_work+0x88/0x98) from [<c003ef38>] (process_one_work+0x138/0x43c)
[    2.110000] [<c003ef38>] (process_one_work+0x138/0x43c) from [<c003f664>] (worker_thread+0x134/0x3e0)
[    2.110000] [<c003f664>] (worker_thread+0x134/0x3e0) from [<c0045118>] (kthread+0xa4/0xb0)
[    2.110000] [<c0045118>] (kthread+0xa4/0xb0) from [<c000ead8>] (ret_from_fork+0x14/0x3c)
[    2.110000] ---[ end trace 3c3a259d4aa3ba0a ]--

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index cfcacc3..f1d5965 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -373,27 +373,18 @@ static struct sdhci_ops sdhci_s3c_ops = {
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
-#ifdef CONFIG_PM_RUNTIME
-	struct sdhci_s3c *sc = sdhci_priv(host);
-#endif
 	unsigned long flags;
 
 	if (host) {
 		spin_lock_irqsave(&host->lock, flags);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
-#ifdef CONFIG_PM_RUNTIME
-			clk_prepare_enable(sc->clk_io);
-#endif
 			host->flags &= ~SDHCI_DEVICE_DEAD;
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		} else {
 			dev_dbg(&dev->dev, "card removed.\n");
 			host->flags |= SDHCI_DEVICE_DEAD;
 			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-#ifdef CONFIG_PM_RUNTIME
-			clk_disable_unprepare(sc->clk_io);
-#endif
 		}
 		tasklet_schedule(&host->card_tasklet);
 		spin_unlock_irqrestore(&host->lock, flags);
-- 
1.7.9.5
