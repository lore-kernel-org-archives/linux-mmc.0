Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043D01FC8
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372864; cv=none; b=fdFbYgb31Bn/5ZC8nTwCAi8aareFLbJDcj+53XLCQj7oHMxUSn1hlbQqeGbbeLOHqieXQrMovScP42mFZ1Nl+D5fbwFR+Fx0/gdEq3EtsbgOJ3xMrPesFp3ADeI8xlIWOI7LRcFzoVeoks+IH5A6m6IMGGj3nFn3qMlbWW6R6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372864; c=relaxed/simple;
	bh=zaT6fQf8V+LpebGEDJMpMnz1P6O1Txk0B/aCb04na1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NcRcIS9cQHQbzfQ1gi3slj9AzYfZnLUEc63ep/uVVD67lqfhZ28Ur6kBdvAHyR+w5raoyedIszdK3+VXEAyYAFl3/wCyB+phasz3klN+qUbxbiK7kTqR2KE8SXm+f9SkneFVeZlMURY470pj4eLlSMVuRkducr8C7Dsa5Ydazps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XS1JaTfO; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XS1JaTfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Psw5I
	ZXfl/XB2Lr6erq0quB6/qzYKEgIDzRya1kxXdc=; b=XS1JaTfOBZbgTxJXDAefJ
	7xc+RCgQaL048AiHQ9FzRkW+Wfy/3uUehfwk54bXeb4xJCDRUZT4rMB2fDCtJI7m
	UgWY9mE11BrJLsMbOANezfGAEgJ6Z1kGGklu9D1xWnPP1O3HtjxX4nO31azlbGzP
	qxLcEG5pjSkkdMFQJfSzLk=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wDXH1J7QC9mF7n3Aw--.55296S2;
	Mon, 29 Apr 2024 14:38:52 +0800 (CST)
From: Felix Qin <xiaokeqinhealth@126.com>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Felix Qin <xiaokeqinhealth@126.com>,
	Avri Altman <avri.altman@wdc.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3 1/1] mmc: core: increase the timeout period of the ACMD41 command.
Date: Mon, 29 Apr 2024 14:38:47 +0800
Message-Id: <20240429063847.162247-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH1J7QC9mF7n3Aw--.55296S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1rJw4xCw17AFyDWr4rZrb_yoW8JFWkpF
	1jgryjkrWxXa13A3W8Wa1q934Fg3WvkFWjkFZavw1rZF4rGr1YgrZI9a4YyF9rZ3yUuF9F
	vrnIvw1UuF909F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRaNtxUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimgDP1WVLbIMlkQAAs1

Extensive testing has shown that some specific SD cards require an
increased command timeout to be successfully initialized.

More info:
Platform: Rockchip SoC + DW Multimedia host Controller
SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
Note: The SD card is custom-made by the customer in collaboration
with the wafer foundry.

Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>

---
v2: Add more info
v3: Based on the __mmc_poll_for_busy API for modification
---
 drivers/mmc/core/sd_ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 3ce1ff336826..a1c028303ba7 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -19,8 +19,13 @@
 #include "sd_ops.h"
 #include "mmc_ops.h"
 
+/*
+ * Extensive testing has shown that some specific SD cards
+ * require an increased command timeout to be successfully
+ * initialized.
+ */
 #define SD_APP_OP_COND_PERIOD_US	(10 * 1000) /* 10ms */
-#define SD_APP_OP_COND_TIMEOUT_MS	1000 /* 1s */
+#define SD_APP_OP_COND_TIMEOUT_MS	2000 /* 2s */
 
 struct sd_app_op_cond_busy_data {
 	struct mmc_host *host;
-- 
2.34.1

