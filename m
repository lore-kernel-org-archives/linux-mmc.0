From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] mmc: bfin_sdh: fix alloc size for private data
Date: Tue, 11 Jan 2011 22:39:35 -0500
Message-ID: <1294803575-24087-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54583 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932743Ab1ALDbm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jan 2011 22:31:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The bfin_sdh driver allocates the wrong size for the private data
in the mmc_host.  The first parameter of mmc_alloc_host should be
the size of the local driver struct rather than the common mmc_host.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/mmc/host/bfin_sdh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index bac7d62..9193e06 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -462,7 +462,7 @@ static int __devinit sdh_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	mmc = mmc_alloc_host(sizeof(*mmc), &pdev->dev);
+	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
 		goto out;
-- 
1.7.4.rc1

