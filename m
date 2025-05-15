Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E2202C21;
	Thu, 15 May 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312932; cv=none; b=Pms93iynNMY9bfRSHGvhLrHgLUr4y5FzE09B9abB9x/IJi1ebyhRcVLsyeAh0sGKs/KiS1Wpx2AtKd0NBnLMvQJ09kr1FeGDn7d3/LeAGkfUroldXyuhnWnN6yFUTAoQ7zIYWcpRDhZKFkhDcIyOOcbFM3q8R87MYOdwA1+Aiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312932; c=relaxed/simple;
	bh=ZR3WdUbWZLeQrUI8wKbo2+rwQSFFBMnJtnNbwQA1EVc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=FX/sebAuM35l24UilNJX9wNGrKiWrN5u/9JDsokYXWGGRVi0qyhJGP/i5lcSxzEvjtH+XOABkuWocWzkG1CmhWnWjAh9CtrijpA0g0UdcYzhg+x+k846tXUR1uDvZLeng2BRr40RWgFjSMNqRUy3Bq2p0IWWovLuJlP0EdLKp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Zyqbb3T1xz8R03d;
	Thu, 15 May 2025 20:42:03 +0800 (CST)
Received: from njb2app07.zte.com.cn ([10.55.22.95])
	by mse-fl1.zte.com.cn with SMTP id 54FCfvOW029395;
	Thu, 15 May 2025 20:41:57 +0800 (+08)
	(envelope-from long.yunjian@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid201;
	Thu, 15 May 2025 20:42:01 +0800 (CST)
Date: Thu, 15 May 2025 20:42:01 +0800 (CST)
X-Zmail-TransId: 2afe6825e11940d-aafa2
X-Mailer: Zmail v1.0
Message-ID: <20250515204201502Kzmj4I6k5Fv2FjqyEjF6n@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <long.yunjian@zte.com.cn>
To: <ulf.hansson@linaro.org>
Cc: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>, <wahrenst@gmx.net>,
        <u.kleine-koenig@baylibre.com>, <fang.yumeng@zte.com.cn>,
        <linux-mmc@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ouyang.maochun@zte.com.cn>, <mou.yi@zte.com.cn>,
        <xu.lifeng1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBtbWM6IGJjbTI4MzU6IFVzZSBzdHJfcmVhZF93cml0ZSgpIGhlbHBlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54FCfvOW029395
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6825E11B.002/4Zyqbb3T1xz8R03d

From: Yumeng Fang <fang.yumeng@zte.com.cn>

Remove hard-coded strings by using the str_read_write() helper.

Signed-off-by: Yumeng Fang <fang.yumeng@zte.com.cn>
---
 drivers/mmc/host/bcm2835.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index e5f151d092cd..def054ddd256 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -44,6 +44,7 @@
 #include <linux/scatterlist.h>
 #include <linux/time.h>
 #include <linux/workqueue.h>
+#include <linux/string_choices.h>

 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -391,8 +392,7 @@ static void bcm2835_transfer_block_pio(struct bcm2835_host *host, bool is_read)

 				if (time_after(jiffies, wait_max)) {
 					dev_err(dev, "PIO %s timeout - EDM %08x\n",
-						is_read ? "read" : "write",
-						edm);
+						str_read_write(is_read), edm);
 					hsts = SDHSTS_REW_TIME_OUT;
 					break;
 				}
@@ -435,12 +435,12 @@ static void bcm2835_transfer_pio(struct bcm2835_host *host)
 		      SDHSTS_CRC7_ERROR |
 		      SDHSTS_FIFO_ERROR)) {
 		dev_err(dev, "%s transfer error - HSTS %08x\n",
-			is_read ? "read" : "write", sdhsts);
+			str_read_write(is_read), sdhsts);
 		host->data->error = -EILSEQ;
 	} else if ((sdhsts & (SDHSTS_CMD_TIME_OUT |
 			      SDHSTS_REW_TIME_OUT))) {
 		dev_err(dev, "%s timeout error - HSTS %08x\n",
-			is_read ? "read" : "write", sdhsts);
+			str_read_write(is_read), sdhsts);
 		host->data->error = -ETIMEDOUT;
 	}
 }
-- 
2.25.1
