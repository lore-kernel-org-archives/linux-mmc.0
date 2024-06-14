Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169431822ED
	for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2024 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352074; cv=none; b=B0Owb1Bffm7zX6ukZfRJiCrTDENxPzX1YDyMTTyEuLWR3hbtPJcmOXwwx8JLj33MFyOyH3kwRPZLK3bnRqkoTNcMVmDdYEt1dpgK5ofQR86bYyamnAAnlEigaST+5pKMsSzNRyGv13ttHx9ja1yHtitYipOhIc18AVNzNXu2DZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352074; c=relaxed/simple;
	bh=2Jgzn52VI9RvW2t9/Q/EcfgKWriCNRmEivCXkjx38Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDLjxuH2vmGBZ4kowQImSLEmfVP2xD/eO/gghDD7LQHX7xQ6hebO20QK3f08Joqy0Iohmmbr4HHCWvmIB2ODMBj8DW0WviYSYb8JDke2FTqboH9MOter+J6hYheq7uhQDtNBDv2puCpfYG9H6yO1X6Ga8l7oObuu9ji/d9qFv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpyVowAs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpyVowAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718352073; x=1749888073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Jgzn52VI9RvW2t9/Q/EcfgKWriCNRmEivCXkjx38Vo=;
  b=WpyVowAsmPm+hJbVX/LhEpiulq3L7bYMKcRlV9ct484ST6Ma2tU0JAAK
   TWEohe01L5KnPzB+LUJBNmkTMwiaFf7wpH0X5uUMANqLLLwRD75xlAHNp
   +CfUxzFyLpe1wU7ibRWhP5TKBr+2Q6bxwfyiUKb8QiQ7me0wdcnrN0cRy
   DIjqW7CpmdYTRaNWFrCfEgIhQQ4VDmZykuvS722ZNYwjl3qLSetqnsoT1
   KNgT+dRupCm+9ABe3ar7nbR/O6zQyybb5/gKFnPQJ5NBAFtvBi6VX1EKO
   IK93V7uaMYdPiUz0Dl83ipoAPfh9ZjuubI1H1c+2NrHbVBdoO46oRmdj1
   A==;
X-CSE-ConnectionGUID: Lgm9MPQjR36BANXc1yoLNA==
X-CSE-MsgGUID: 4t1sYf5rScOWZIYCmgaU7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14962014"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="14962014"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:13 -0700
X-CSE-ConnectionGUID: CtPIXErUQBuhUmNhQrXzVg==
X-CSE-MsgGUID: 6uD8/aL6RJiagt1e+n3hsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45382881"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.10])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:11 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [PATCH 2/3] mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()
Date: Fri, 14 Jun 2024 11:00:50 +0300
Message-Id: <20240614080051.4005-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614080051.4005-1-adrian.hunter@intel.com>
References: <20240614080051.4005-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

sdhci_check_ro() can call mmc_gpio_get_ro() while holding the sdhci
host->lock spinlock. That would be a problem if the GPIO access done by
mmc_gpio_get_ro() needed to sleep.

However, host->lock is not needed anyway. The mmc core ensures that host
operations do not race with each other, and asynchronous callbacks like the
interrupt handler, software timeouts, completion work etc, cannot affect
sdhci_check_ro().

So remove the locking.

Fixes: 6d5cd068ee59 ("mmc: sdhci: use WP GPIO in sdhci_check_ro()")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 81b81d7bb3d8..112584aa0772 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2516,11 +2516,8 @@ EXPORT_SYMBOL_GPL(sdhci_get_cd_nogpio);
 static int sdhci_check_ro(struct sdhci_host *host)
 {
 	bool allow_invert = false;
-	unsigned long flags;
 	int is_readonly;
 
-	spin_lock_irqsave(&host->lock, flags);
-
 	if (host->flags & SDHCI_DEVICE_DEAD) {
 		is_readonly = 0;
 	} else if (host->ops->get_ro) {
@@ -2535,8 +2532,6 @@ static int sdhci_check_ro(struct sdhci_host *host)
 		allow_invert = true;
 	}
 
-	spin_unlock_irqrestore(&host->lock, flags);
-
 	if (is_readonly >= 0 &&
 	    allow_invert &&
 	    (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT))
-- 
2.34.1

