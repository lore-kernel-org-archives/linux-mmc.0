Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com [220.197.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C69F50F
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116199; cv=none; b=H1HxraxAgSh5dHZ8UTk/JvQIziX93JsIJcyzGAOMegtUpKxiPlP+qWQ7lYERPzFCnqyaJr3dfjTq2MZi4NiMDDMqKkk1pdSMnP2IlHLW2GK7sfMTLtZ0uPumA7JIHRvOYgGM8lmSj3yzRRpyhkLe685jO9Wc4TH6/yAKyk236MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116199; c=relaxed/simple;
	bh=RoNpPZ/iI9b+Z/WT73JXsS06moJ/ofFWWZ3WOeM9JBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JGDzJcblEbl+dKHOy7UHaKPB5fohtbEfl7TXZLe4S4zh6lzfy1RaNLk0/kHpu/fT8BcutgmGHPwBFcMKuzz/Ib/qEab3EoPIpfuUDhJ3bi7xwXqK3bhbRfzc6vXPo4L8WZkv0actmrH5mKV/zWw8baG9MJtsWKH2moRUD6GhA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=a+3u86xa; arc=none smtp.client-ip=220.197.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="a+3u86xa"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae366d64;
	Wed, 26 Nov 2025 08:16:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 04/13] mmc: dw_mmc: Remove unused header files and keep alphabetical order
Date: Wed, 26 Nov 2025 08:14:44 +0800
Message-Id: <1764116093-5430-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd84e03409cckunme6f559504dd1e1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1OHlYdTUoaTBlOGkJDQhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=a+3u86xa5Q1T6dgQpOGPoSdipV1r/jECqcJTPj2LCxnvARaB7FGPUq87RLZLoMo628aiDDIbzP4H8NF2/Wmhz99JwdFoC4Ey2qNea9onf4XX5Lpj/f6zOGoTWtNfVKHOd7jxUFIW1XtN4DIFHdkAXJgOWPF7Vc0HTUjH43AUqKM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=A7wA88J5tiFBaLkVj5Q8B9c322nhmWEpCyxgxSLB888=;
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

Changes in v2:
- add commit message

 drivers/mmc/host/dw_mmc.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1c352d2..0248c1d 100644
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

