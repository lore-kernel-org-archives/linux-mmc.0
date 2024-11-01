Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E116130B;
	Fri,  1 Nov 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456092; cv=none; b=sWNRRufsVNmUHkpsDkkceOouX9wK1ZwYsTUr31VBy4tIXKGfm2yp1pzSG1e3wenU4+oQnvznb283mJyrEg7kIqcaplapPZX9aC8IB3NjvDUby6e+7N7lhgQTuAtcYS8vnsI/Wn5fTExYsyCsfbwHodDmDWttWF71MIK0HJUgHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456092; c=relaxed/simple;
	bh=ve3K/lXNYQwypP2f7KcCRz8bMHtlMdKOO3fvsCfZ1JA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS2unwYiyvZsIwlotm8CXuy4iLPf1H+WXzBSuzxRbQgyApAxPMFF606p+d/yzw9VGYoXvpq0foDW70hDzDkoGkB6hI8m/1mAiTvp4PuGdSZ/BuafWWfrsZpLRGut65fr0d8ERgByHHm1leIFexef7c45TkG1ffQ6IaI93bCxG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7hzPvKE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7hzPvKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730456091; x=1761992091;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ve3K/lXNYQwypP2f7KcCRz8bMHtlMdKOO3fvsCfZ1JA=;
  b=c7hzPvKEhUR4RyBHgIXz9K9ObUkPO5Im2X1j7oMofxHPdSDGLHh9EYH0
   e71c8pPHV1gJ1+TbFLSa0YM9YrYCfrrleNmxoYr+pyNn8prEmh4VuH5pV
   ZMBylegvepHMRVkd25Wv5mkgHty9rmO/1ACk8k04mApk00p6OOOM9Z13Y
   uhKFKEARH9ar3BMmM/v76tQmgqwy4clzy7HI3bK3BlnA0OGYxbTLwo7Pv
   HrsmQZqj8UIL6tr9Jjr5VTSHX8VuMjZM4F8GNxOIco19aKyPU0NEijS1j
   yb1eTZdSTxGJJeY1c70CI1jMSKTalSEH+x7iA/J5NeMbitqbijQqEZTeJ
   g==;
X-CSE-ConnectionGUID: XeCnhqjdShaOaz5CphRJxg==
X-CSE-MsgGUID: DQS6nwKsTsOTw1IbCAeCpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41615780"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="41615780"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:14:48 -0700
X-CSE-ConnectionGUID: M2i3My2CRS+BN4LjNPRqNA==
X-CSE-MsgGUID: dac6a0PDSCStgMuSt2Y2fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83737451"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 01 Nov 2024 03:14:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AC06893; Fri, 01 Nov 2024 12:14:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for exporting PM functions
Date: Fri,  1 Nov 2024 12:11:31 +0200
Message-ID: <20241101101441.3518612-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from ugly ifdeffery to using EXPORT_PM_FN_NS_GPL()
for exporting PM functions. This helps cleaning up the other
SDHCI drivers in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci.c | 14 ++++----------
 drivers/mmc/host/sdhci.h |  2 --
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4a7733a8ad2..2214280ca5fb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3733,8 +3733,6 @@ EXPORT_SYMBOL_GPL(sdhci_thread_irq);
  *                                                                           *
 \*****************************************************************************/
 
-#ifdef CONFIG_PM
-
 static bool sdhci_cd_irq_can_wakeup(struct sdhci_host *host)
 {
 	return mmc_card_is_removable(host->mmc) &&
@@ -3814,8 +3812,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
 
 	return 0;
 }
-
-EXPORT_SYMBOL_GPL(sdhci_suspend_host);
+EXPORT_PM_FN_GPL(sdhci_suspend_host);
 
 int sdhci_resume_host(struct sdhci_host *host)
 {
@@ -3853,8 +3850,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 	return ret;
 }
-
-EXPORT_SYMBOL_GPL(sdhci_resume_host);
+EXPORT_PM_FN_GPL(sdhci_resume_host);
 
 int sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
@@ -3876,7 +3872,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
+EXPORT_PM_FN_GPL(sdhci_runtime_suspend_host);
 
 int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 {
@@ -3927,9 +3923,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
-
-#endif /* CONFIG_PM */
+EXPORT_PM_FN_GPL(sdhci_runtime_resume_host);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd0e35a80542..4ee2695b0202 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -874,12 +874,10 @@ irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
-#ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
 int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
-#endif
 
 void sdhci_cqe_enable(struct mmc_host *mmc);
 void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);
-- 
2.43.0.rc1.1336.g36b5255a03ac

