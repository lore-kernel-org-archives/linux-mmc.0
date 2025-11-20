Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com [220.197.32.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD872D2497
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636770; cv=none; b=oWAvNHkPu9IDlFCatVVyOWpDG6HB1yHby1v+T/sUdAg57kU3KOR1D/fo2GUQz+sNA3XJ3FixnwqaehPGwBDbY4Oy/Xky7CMdDFoFif9N7UO/v26pyaaBGGe/1rVgWZzktmgfMYhdTlV4Bju3l/S0a26gGM1Er7cetETBfgXSkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636770; c=relaxed/simple;
	bh=JNEi3CjR4/+5Bic7zEcHOSN8eCizOkMA/JfDIvU6MKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VLbZpY4R3hS2DRA7DANDoSRIwKtDGsf0/nmkvom9aoh2gYI/bHpjFjMzB0AyYwQchWBPNKy10I9plWCBVI2B5uoUpe9mwl25HX41qZuEvBc9RMy5fqoEOhoMRMlwBxDfd41/vD1gNgQ7FGdP3q1JRkJ3CXfCsjVxRg2tynFBh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KudG7OsK; arc=none smtp.client-ip=220.197.32.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KudG7OsK"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4959a14;
	Thu, 20 Nov 2025 18:30:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 04/13] mmc: dw_mmc: Remove unused header files and keep alphabetical order
Date: Thu, 20 Nov 2025 18:29:16 +0800
Message-Id: <1763634565-183891-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9aa0d0cc5709cckunma871e9031751f0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5IT1YeT0xNTUhMGUNIT0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KudG7OsKnG6Dw5xdScXBR49FAjmkiZGQqZ4lOPsJNiZ4a8L3n3+B4zVN61LLoYAlfjyXwFgn4ArEgpumfDQn7ighvywNSHlwRzH12WWToKQaXz9NruZUQNKoJm3ICanLHN+K1BLIeNk7vFXLCa9sQc0WHU4/xc6m34mNYsLLfUQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=kcU8IbEiZuGHhpW5RmcWcpd2mEdEM+dEEjpGfHtLOqE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ebbf1a6..2e2d492 100644
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

