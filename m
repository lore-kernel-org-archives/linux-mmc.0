Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D78195804;
	Wed, 10 Jul 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634991; cv=none; b=pTdQNdI6Ij1DbhKC+f2eSSHSbsPR+iqI6ATAvRrqc3OyRtdZlQRyJCcXwPev1pJ+5jDg7Vf42rD/gBq5AjFoQl0oyj7O+ZYH9g6wE5dq2D1gve1yHm5LBFIMTiI3Pg7dh4g0Ap4A6NkU+O4I6Zgf+nkJOXFjdxHwYk8YqEZEpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634991; c=relaxed/simple;
	bh=sEpV/pgR7MWqeVR7wICs5wfW6eRxE/2XRev3rKrlris=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dU1WB3O7c8QYAoSe/kHQdyj6i+mjFJHTd1veRBEbHw71yWKBAtJPX3FHa/7xzDn6BYcoqPepXdifH0G87HcPM9eoj3KPQ2Hy96xSRaYWV0rpydvuC3mhEZCNB9nX4psQNariFfJwbQ41LXNX4zM81L/bzb6e7+T1BLMNM9P4Zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIlHVebE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIlHVebE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720634989; x=1752170989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sEpV/pgR7MWqeVR7wICs5wfW6eRxE/2XRev3rKrlris=;
  b=FIlHVebE7JIhPqTS9x83V7r2EmJpFuO+Ex1XtqIRkupPPzBYtqs+JmVn
   HOZmDvlrfwzf4r+nv3C0HDIo7AW+EJ8nDfegsMrOeB7QK7cLc9oHR6J1g
   gKAd9gUSmyJ1XbSvMvfEwfP05gWdoufT7tl+8UcAKUioPJ6pXGD2U0ggp
   gqBokcIdCK/tTXvZ/UFF4EMUSScKYLyvpBA3XoZMEr4+xEQ9esS/f4/ub
   22TRMMdU6TacHPiJ7ssvJA9RrqPB9RyJlzy4v8VDacTYv7Vs1UuVyqUZ/
   8UUbs9zcFSTGQe+Moz8OMsIK3fhtBN0hVxyvfRKXMnQ1l9GfdHE7pqJz1
   w==;
X-CSE-ConnectionGUID: 2tgrAU2LRradzGqBg9c3sA==
X-CSE-MsgGUID: YWJdzfX6QHiqwFHMY3bCvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18113581"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18113581"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 11:08:07 -0700
X-CSE-ConnectionGUID: iMI9jiccRrGXkJO1tbTBAg==
X-CSE-MsgGUID: R1zrt6xeQ46mjPtbi5wxyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="52898195"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 11:08:03 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE
Date: Wed, 10 Jul 2024 21:07:37 +0300
Message-Id: <20240710180737.142504-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

blk_queue_max_segment_size() ensured:

	if (max_size < PAGE_SIZE)
		max_size = PAGE_SIZE;

whereas:

blk_validate_limits() makes it an error:

	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
		return -EINVAL;

The change from one to the other, exposed sdhci which was setting maximum
segment size too low in some circumstances.

Fix the maximum segment size when it is too low.

Fixes: 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a20df9383b20..4b91c9e96635 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4708,6 +4708,21 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
 			host->max_adma = 65532; /* 32-bit alignment */
 			mmc->max_seg_size = 65535;
+			/*
+			 * sdhci_adma_table_pre() expects to define 1 DMA
+			 * descriptor per segment, so the maximum segment size
+			 * is set accordingly. SDHCI allows up to 64KiB per DMA
+			 * descriptor (16-bit field), but some controllers do
+			 * not support "zero means 65536" reducing the maximum
+			 * for them to 65535. That is a problem if PAGE_SIZE is
+			 * 64KiB because the block layer does not support
+			 * max_seg_size < PAGE_SIZE, however
+			 * sdhci_adma_table_pre() has a workaround to handle
+			 * that case, and split the descriptor. Refer also
+			 * comment in sdhci_adma_table_pre().
+			 */
+			if (mmc->max_seg_size < PAGE_SIZE)
+				mmc->max_seg_size = PAGE_SIZE;
 		} else {
 			mmc->max_seg_size = 65536;
 		}
-- 
2.34.1

