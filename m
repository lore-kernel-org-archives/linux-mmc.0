Received: from mail-m49215.qiye.163.com (mail-m49215.qiye.163.com [45.254.49.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC528C87C;
	Mon, 30 Mar 2026 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774841645; cv=none; b=nXQ4L0LqYf8NRLXZj4apXXBBZuyAF+XsW0GUvibubvm7SeyK+mR87mBsrxUzkoPZKYGsPq965istuQwHNk3/sN5KypWH4T0ZtKWDJp9ATZLVwC/Ugp+zQuGEsXFsqFNcCxwW7LRwGAf+eWfMwpZiFHvowNjirMxfOhOXZt3ZaFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774841645; c=relaxed/simple;
	bh=Q+HfbO6f83LJ1/d8EoI2vQJJKXt7nlIPOJgGmkxd7VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TpMZxqzo2c1ktm26Wug4LZ7Mcjm4aahKfP0RyVZbWnSI0eRnYdeHBhssjerUspdM+KEzeWs8PHE7OTl9jMKzOrk6HQhi40mmPdA3XPLDeYfQILvZYF2n3Vq0/WlJrEhc1cQnF9QsCq1iUeU28VvjqcQXSjy5LXnIVx7I0RhKj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FPw06S1O; arc=none smtp.client-ip=45.254.49.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FPw06S1O"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38c2332c2;
	Mon, 30 Mar 2026 11:28:46 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/4] mmc: block: Convert to use DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 30 Mar 2026 11:28:30 +0800
Message-Id: <1774841312-92409-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d3cc96aa309cckunmd82a3513dfee53
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0dH1ZKQh5CS0MfHxpKGh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FPw06S1OxkqnPIbCk+SSJdocR1N6ckS2hMxekdU/G2dGG8cfpAVXHrK2j005tVi/2UB05RAwyfTdpRPaLJtlbT51PuZ7qRYPH8o7x76aR7ReWSZ/GA/3GRuKiPpWW65q8Z3wlCPzX/4T6pwYk6Bpvgj2hvHuPP7f89Vh1LynJD8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=h8GM9ZlCZqEiNxBVPLaHC5mxpL3bB986XLR9Mkv/lW8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Convert to use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() to drop the
CONFIG_PM_SLEEP to handle the conditional compilation when PM support is
disabled. This allows the compiler to automatically optimize away the
unused code paths when CONFIG_PM_SLEEP is not selected.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 5032f7a..53c1b04 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3362,7 +3362,6 @@ static void mmc_blk_shutdown(struct mmc_card *card)
 	_mmc_blk_suspend(card);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mmc_blk_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -3388,14 +3387,13 @@ static int mmc_blk_resume(struct device *dev)
 	}
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(mmc_blk_pm_ops, mmc_blk_suspend, mmc_blk_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc_blk_pm_ops, mmc_blk_suspend, mmc_blk_resume);
 
 static struct mmc_driver mmc_driver = {
 	.drv		= {
 		.name	= "mmcblk",
-		.pm	= &mmc_blk_pm_ops,
+		.pm	= pm_sleep_ptr(&mmc_blk_pm_ops),
 	},
 	.probe		= mmc_blk_probe,
 	.remove		= mmc_blk_remove,
-- 
2.7.4

