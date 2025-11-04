Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com [45.254.49.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB497262E
	for <linux-mmc@vger.kernel.org>; Tue,  4 Nov 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246042; cv=none; b=Tab0kGa5zt/C19g+szO5virW6ceQTTVsSMQPzvkrcUsWuBHSRs47ZL9kj8qGl/GLXMlJ0zva2CFQ8mHVcPJqTwiW7LKXt98m3Yl46gNOJrfYBk2AGVcv7TJd8BHShoDDhNo9BRcrw/4OayDnvlofhEVXY/2Euu76czGkNKppKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246042; c=relaxed/simple;
	bh=Qoi1RgYlj927wgOQDd54dm6lKU6/V8egXR9tWtWv9fI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=adL/i599TFqRGVmVyz236JUeI5XwIp45FoeHJ5K4VUh2kLDrLtERyGBJ6Nls8WB5jqggDM+QH+NvuJeodDsXAnXjZpsUFDn7j/g/KlV/dSqg6jQe/7YWRDRKRQi/KDSqzR4Y5m5+RwHJDbmsSS5Huef0goCDgPAz8NIxnRSdxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hC9kP7Yj; arc=none smtp.client-ip=45.254.49.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hC9kP7Yj"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2851c98a1;
	Tue, 4 Nov 2025 16:42:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: debugfs: Allow more host caps to be moodified
Date: Tue,  4 Nov 2025 16:41:53 +0800
Message-Id: <1762245713-68815-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a4e07b6d409cckunmfa83a355b6c975
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxLQ1ZCGUweSEIdSU5CSBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hC9kP7YjJv6iw5sGpF/6DYPfuZkc34aWRlXFaPN1qiYrb1aajhOSP5lw2/V5pScLpyI+jykoqa9L53k4kRAbwFE0rTg8uXx7+D++2fP6e/eZ7bvrQdph9n/HIeRxasE8xj853H9oKd9jvvcAaSP55vfbKVxennUTiLsz7oS0j9A=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=a/IB2P+vaWj6lg/qBzYBZ4QsfztaGYiLIK9g5oWaLd0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

This makes various signal and function tests more convenient
without the need to modify the DTB.

/sys/kernel/debug/mmc0# echo $(($(cat caps) | (1 << 7))) > caps
/sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
/sys/kernel/debug/mmc0# echo auto > /sys/bus/mmc/devices/mmc0\:0001/power/control

// Disable 8-bit support
echo $(($(cat caps) & ~(1 << 6))) > caps
// Enable 8-bit support
echo $(($(cat caps) | (1 << 6))) > caps
// Disable 4-bit support
echo $(($(cat caps) & ~(1 << 0))) > caps
// Enable 4-bit support
echo $(($(cat caps) | (1 << 0))) > caps
// Disable CMD23 support
echo $(($(cat caps) & ~(1 << 30))) > caps
// Enable CMD23 support
echo $(($(cat caps) | (1 << 30))) > caps
// Disable CMD23 support
echo $(($(cat caps) & ~(1 << 30))) > caps
// Enable CMD23 support
echo $(($(cat caps) | (1 << 30))) > caps
// Disable CQE support
echo $(($(cat caps2) & ~(1 << 23))) > caps2
// Enable CQE support
echo $(($(cat caps2) | (1 << 23))) > caps2
// Disable CQE DCMD support
echo $(($(cat caps2) & ~(1 << 24))) > caps2
// Enable CQE DCMD support
echo $(($(cat caps2) | (1 << 24))) > caps2

/sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
/sys/kernel/debug/mmc0# cat ios

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/debugfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index f10a4dc..91ea00a 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -315,7 +315,10 @@ static int mmc_caps_set(void *data, u64 val)
 		      MMC_CAP_SD_HIGHSPEED |
 		      MMC_CAP_MMC_HIGHSPEED |
 		      MMC_CAP_UHS |
-		      MMC_CAP_DDR;
+		      MMC_CAP_DDR |
+		      MMC_CAP_4_BIT_DATA |
+		      MMC_CAP_8_BIT_DATA |
+		      MMC_CAP_CMD23;
 
 	if (diff & ~allowed)
 		return -EINVAL;
@@ -327,7 +330,10 @@ static int mmc_caps_set(void *data, u64 val)
 
 static int mmc_caps2_set(void *data, u64 val)
 {
-	u32 allowed = MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V;
+	u32 allowed = MMC_CAP2_HSX00_1_8V |
+		      MMC_CAP2_HSX00_1_2V |
+		      MMC_CAP2_CQE |
+		      MMC_CAP2_CQE_DCMD;
 	u32 *caps = data;
 	u32 diff = *caps ^ val;
 
-- 
2.7.4

