Received: from mail-m11878.qiye.163.com (mail-m11878.qiye.163.com [115.236.118.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1974C10D5;
	Wed, 30 Sep 2026 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767364; cv=none; b=fKH6LaPwNOzIQm7L7x3rJ6IbEHP2Bg7xhhsfrXDrMOulzgen7nwC9AiV0kPTX36Qj1ijttFHMNv6JhsyCTCa9wL6Rdb2FDu4IBfXiDsKAnY/s+wTW8VaHMGspKeoX6yJc1DfHFAY9KE7IxApIVD88TWf3nc1bvV74yIxQrrvAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767364; c=relaxed/simple;
	bh=HNLNkNnB+uimBeIDmwyGeswJ5Z+LFw0oy5d+ifD11lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oEBYIdaM5fF4itpDdjDd2ap+y2FZMdf3HPRQkZQkFu7oxuo2J7RrqBHYBg4pEl1yLNwhwtqyZjpqoiqhz7gV3kggQJKrwbBxvTYdy5L5iSE6/R/ACpQxj4HMBCegbMkAdIkT/fP+EvJzrYRqGdYR5KduPAnwGYOgbcKZI4dScG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZkCC/jh7; arc=none smtp.client-ip=115.236.118.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZkCC/jh7"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f96815d4;
	Wed, 30 Sep 2026 12:32:47 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-msm: Initialize the local ios in msm_toggle_vqmmc()
Date: Wed, 30 Sep 2026 12:32:30 +0800
Message-Id: <1790742751-245571-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0f09626d103a4kunm0766139d8bc9b2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQkpMGlYZTEMeQhpLQk
	kfSkhWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZkCC/jh7fUpr6OzCI5UKrgECKkiYCsktmLxAvKBG3u91W9yHtUetDtxlJ3IQ8RKINhHBN3hMBoTsO7M8heacA2pq6eqQbKl+g3zJQtJ8wqQsqQrQ7j52MnQOM30OxJ37Xq+025JATFpc6S9JhnwHpT1816qHJGsTOA0XIihv2so=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=JE0zDmeTxTFr8HX9ReQ+t9VWrkjJmNTfZeeeWnJnkAI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

msm_toggle_vqmmc() builds a local struct mmc_ios and only initializes
its signal_voltage, leaving vdd and the other members uninitialized
when passing it to mmc_regulator_set_vqmmc(). It happens to work
because the function only looks at signal_voltage today, but the next
patch makes mmc_regulator_set_vqmmc() honor ios->vdd when calculating
the 3.3V voltage range, which would read the uninitialized member.

Start the local ios from mmc->ios so that all members are valid.

Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index aecd425..32b1bcb 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1490,7 +1490,7 @@ static int msm_toggle_vqmmc(struct sdhci_msm_host *msm_host,
 			      struct mmc_host *mmc, bool level)
 {
 	int ret;
-	struct mmc_ios ios;
+	struct mmc_ios ios = mmc->ios;
 
 	if (msm_host->vqmmc_enabled == level)
 		return 0;
-- 
2.7.4

