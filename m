Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517712F5BE
	for <linux-mmc@vger.kernel.org>; Tue, 16 Apr 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280489; cv=none; b=ZpkZXDYI70qMy4RvnhwoY/EhZbPVX5DLcxhkCyWzQFzh2T54i2ijYGVc1q6BhDDyZesFpMH9lA8u65Bqx/wzGYL8R2KvlmZOxGrhuf1eRm6zbtSfDn6MTRTYNWU922fI2TqrYzPq0t7Aj/Ea+hzN1Dz2pE38lc6zsD/ZJoRnmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280489; c=relaxed/simple;
	bh=x2E8ogT+mYhPFtUxiSoqoy9197FO+1ZvBBItFkjXVNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxqVX1O0GQZ1Di5+3uLlJx1KWWZVuRGO6Ul6K8K0LT8azcCW1QTfqf/4pclocJbOALIJBD0zffWUO22g44wn62MKH18SoNKEc2XK+6ge9kU0QPmoVojyR26NdafrZz2iKST9Zj0ZyyKwg+69pewV6OlXqW7vGbjz7Cay6+U/osA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hY2OthoQ; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hY2OthoQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iJ/aZ
	Ls0HvdPE7ZuxzfdP95VtdfXBWrgMrVHUkU4Wgc=; b=hY2OthoQJLZgQ883aZGNn
	tgoqOg2AT+z55CQtiAQRJbCMAE5TC9/qpj2T7PNsxcF/CdnrF0zTJrph5V/mWBUn
	jurWSH2hW3W1G1T8PgTrZV/xFTBui0zsRS9v+pA9inSk63Ot4AHzTdHnYakl9mFR
	dS6SvucaP86vOJ8iBoD9WY=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnr7NHkh5mDag6BA--.51692S2;
	Tue, 16 Apr 2024 22:59:21 +0800 (CST)
From: Felix Qin <xiaokeqinhealth@126.com>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Felix Qin <xiaokeqinhealth@126.com>
Subject: [PATCH] mmc: core: increase the number of retries of the ACMD41
Date: Tue, 16 Apr 2024 22:59:12 +0800
Message-Id: <20240416145912.114409-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr7NHkh5mDag6BA--.51692S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrGF4DurWrtr18WF17Jrb_yoW8XFWxpr
	45WryjkFnrJay3AFyxGa1q9343W3WIkFWUKrykZw10vF15u3s8WrZrAFW5tFyUZayUuFZa
	qF9Iqw13GFya9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNLvKcUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimgnC1WVLa6ZAMwAAsU

Extensive testing has shown that a few specific SD cards require
an increase in the number of command retries to successfully
initialize.

Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
---
 drivers/mmc/core/sd_ops.c | 4 ++--
 drivers/mmc/core/sd_ops.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index a59cd592f06e..b3b6e8725b80 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -127,7 +127,7 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		cmd.arg = ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	for (i = 100; i; i--) {
+	for (i = SD_APP_OP_COND_RETRIES; i; i--) {
 		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
 		if (err)
 			break;
@@ -147,7 +147,7 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 
 		err = -ETIMEDOUT;
 
-		mmc_delay(10);
+		mmc_delay(SD_APP_OP_COND_INTERVAL);
 	}
 
 	if (!i)
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 7667fc223b74..80c5c836ccd1 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -10,6 +10,14 @@
 
 #include <linux/types.h>
 
+/*
+ * Extensive testing has shown that a few specific SD cards require
+ * an increase in the number of command retries to successfully
+ * initialize.
+ */
+#define SD_APP_OP_COND_RETRIES  200
+#define SD_APP_OP_COND_INTERVAL 10	/* millisecond */
+
 struct mmc_card;
 struct mmc_host;
 
-- 
2.34.1

