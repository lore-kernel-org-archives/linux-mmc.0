Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496A201266;
	Tue,  1 Apr 2025 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508686; cv=none; b=h71G3a2PKt7lexvU0bfLtTvkYbCQOIz3ZSFJzSBSPUm45aOLif/GhkgjssInpPaZb+5Q2UqOYBC4ptbRCWLk3SeToTJ8mvqkHRDzRyItOg5Yq5kmuDEx7yA45/jvEqe6T/ABbj/ykdX6wX9VVFB7EKx+pl92d0TeP+W+H/00WvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508686; c=relaxed/simple;
	bh=1dB6vMoeG9NxkQ32fN8guBf+8If7k9F5IrEVO2t6XwY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Bu+PLJJrMkL4DcHUvLI7277uxmPerc5qdVTYSql2nB9gHORWPeS0kwLqq9l9qvx1W1KYqGUe1+Z671KlgrQIk1+MyBSmT9EG2ejLZkXSyzmNkGdfY8NjPTWG9epU8VMpYaG3FNfpHQqiTjVtNoEMnyzncUVTD3DZVcP+9B4G68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZRmj55VtFz5B1Jc;
	Tue,  1 Apr 2025 19:58:01 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 531Bvmo9004249;
	Tue, 1 Apr 2025 19:57:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 1 Apr 2025 19:57:51 +0800 (CST)
Date: Tue, 1 Apr 2025 19:57:51 +0800 (CST)
X-Zmail-TransId: 2af967ebd4bf489-ba3de
X-Mailer: Zmail v1.0
Message-ID: <20250401195751834zbm34YDvwPeQf7ooZBCdh@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ulf.hansson@linaro.org>
Cc: <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <feng.wei8@zte.com.cn>, <u.kleine-koenig@baylibre.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbWM6IGFsY29yOiBVc2Ugc3RyX3JlYWRfd3JpdGUoKSBoZWxwZXI=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 531Bvmo9004249
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EBD4C9.001/4ZRmj55VtFz5B1Jc

From: Feng Wei <feng.wei8@zte.com.cn>

Remove hard-coded strings by using the str_read_write() helper.

Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/mmc/host/alcor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index b6b6dd677ae5..24abd3a93da9 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>

 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -208,7 +209,7 @@ static void alcor_trf_block_pio(struct alcor_sdmmc_host *host, bool read)
 	len = min(host->sg_miter.length, blksize);

 	dev_dbg(host->dev, "PIO, %s block size: 0x%zx\n",
-		read ? "read" : "write", blksize);
+		str_read_write(read), blksize);

 	host->sg_miter.consumed = len;
 	host->blocks--;
-- 
2.25.1
