Received: from mail-m3287.qiye.163.com (mail-m3287.qiye.163.com [220.197.32.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638F35502F
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886198; cv=none; b=tLD5B6WSWj8Pw4QP6QnjjG78lG1pW7NzTDBCd1TqH2DRvAlYonuxLslyB2EOBSDdO0BXRGxUYPd6xMmJovG10WYytZrq16Xk0HUcJvxqrmJssne8PZnxwHOUwQ1Iad1K0W9tkhjw/PRxzpmDe7sjzdv7B5unA2Mx24pu7G0KYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886198; c=relaxed/simple;
	bh=R8is2RiVga35cp2vINYh8M5N0Ky+JNWMdiubt50+USw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=l8VUwpYp1Wm1UM90iUo3Hbb2GfqlsQeEw7RtWH/DTe7XfNmMxSJQCvXZ2umuN2U/ihJuIs1opXgBR8yzX/GPYsC6hoKMPUWPXVT4uAEuRYhdwg/9j7m81hPDlRWaNOGTkz0llhhVAA2KROSEu1AqlNVAO4n9D50XoCm9HMZuQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KYUAjO+H; arc=none smtp.client-ip=220.197.32.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KYUAjO+H"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a84b;
	Tue, 16 Dec 2025 19:51:16 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 03/12] mmc: dw_mmc: Remove unused header files and keep alphabetical order
Date: Tue, 16 Dec 2025 19:49:58 +0800
Message-Id: <1765885807-186577-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b27001a8f09cckunmc1d96abd3f9a57
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkpITlYeShlIH0xPH0lCQxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KYUAjO+HCqizLXPTHm6TF0C03P5p8OB4bsoBJVHEBIvN2Emm+45wp2jxSZlwgmAziAmzKH/L9H6S3WHQ/pCBfxUpaJtSQhUgwjWEMRqnkZc7yhs1Q5rTnnWY8H1Kc92EtAoUr+FaM/ITEFV+F3xu4u0NmzeTP3M0Do9I+vyrlEw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sW95Q4MYm4kpGXSHxvIl/3MiryYpWSI+y0EsVW9LemY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Some header files are not needed and they are out of order, this patch
remove unused header files and re-order them alphabetically.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2:
- add commit message

 drivers/mmc/host/dw_mmc.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fe20ea62..3ea2839 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -7,35 +7,28 @@
  * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
  */
 
-#include <linux/blkdev.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
-#include <linux/ioport.h>
-#include <linux/ktime.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/prandom.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/ktime.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
-#include <linux/bitops.h>
-#include <linux/regulator/consumer.h>
-#include <linux/of.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 
 #include "dw_mmc.h"
 
-- 
2.7.4

