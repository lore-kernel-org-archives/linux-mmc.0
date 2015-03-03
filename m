From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: Re: "Driver 'mmcblk' needs updating - please use bus_type methods"
Date: Tue, 03 Mar 2015 10:25:15 +0700
Message-ID: <87sidmsqxw.fsf@KB00016249.iskra.kb>
References: <1424275938.27541.113.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ispman.iskranet.ru ([62.213.33.10]:39400 "EHLO
	ispman.iskranet.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404AbbCCDbM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Mar 2015 22:31:12 -0500
In-Reply-To: <1424275938.27541.113.camel@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Minchev, Todor" <todor.minchev@intel.com>
Cc: linux-mmc@vger.kernel.org

> This has probably been reported already.
> 
> In 3.19 this started showing up in the dmesg log when the mmcblk driver
> gets loaded:
> 
> "Driver 'mmcblk' needs updating - please use bus_type methods"
> 
> Looks like it is caused by the re-factoring needed after the removal of
> struct mmc_driver. Both the mmc bus and the block driver register a
> shutdown and the two fail the driver_register sanity check resulting in
> the warning above.

I've also run into this recently and failed to come up with any elegant
solution. Of course the warning could be safely ignored, but it doesn't seem
right in the long run.

Something similar to removed mmc_driver really seems to be the best solution
here. Otherwise, the following workaround is probably the simplest one, but as
for me it is too ugly to submit it seriously.

---
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..6355df1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2546,7 +2546,6 @@ static struct device_driver mmc_driver = {
 	.pm		= &mmc_blk_pm_ops,
 	.probe		= mmc_blk_probe,
 	.remove		= mmc_blk_remove,
-	.shutdown	= mmc_blk_shutdown,
 };
 
 static int __init mmc_blk_init(void)
@@ -2566,6 +2565,15 @@ static int __init mmc_blk_init(void)
 	if (res)
 		goto out2;
 
+	/*
+	 * device_shutdown() calls bus_ops ->shutdown() if it's present
+	 * and falls back to device_driver ->shutdown() if it's not. This
+	 * motivates existence of a sanity check in driver_register() against
+	 * both ops being set at the same time. Work around this check
+	 * with deferred setting of device_driver ->shutdown().
+	 */
+	mmc_driver.shutdown = mmc_blk_shutdown;
+
 	return 0;
  out2:
 	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
