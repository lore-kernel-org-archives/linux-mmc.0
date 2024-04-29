Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415EF13ADC
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375260; cv=none; b=fLiHN3DzMVAEdYLyqsOBn2p1K5a6Imisa0z4bKDUIPOQAui9m4Ggr8eOiNBih1EdqpT+p5M4YOlbhSmcpdmujK4EPU1Z3Rg3iVhkLoWZxQswP56cn7zPCjz03uYTCyK5Yl2DVywEZ/npo6C1PfazjHw6885dP7Lcj+egWw03PJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375260; c=relaxed/simple;
	bh=acgWjPIkZ4T1gAI0Z8tVj075vZgrmXAKrfsKztzUzbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FO3x5JpTryiV1nm6D7E7/TJwjU2OW1mRr75hLWVa4HDnORfdNndRCx6u9o7blStzXwOA7ta1Um0v+YJ1Wjx2/QjZEgCXW/OcCD8GQm9jgUJPmIKo6+nVcT+q/4MRl76mu2IoXpym7l6FNSb1HpG7WB8slscpfEHfbEejssavfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jIjIVvFR; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jIjIVvFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LFKUr
	eS/WtTHRsLVnLK7ITptsYQf0eR98emOlLuXrJg=; b=jIjIVvFR6Zu4quxwBoaJM
	rrjMSrLXJGO9M+M+LM47/4TTcV1F/hOauIEJK5cPxqPZDChxzIdp2tWINSvoASmT
	19tULtJmt4LJMgnFYceRjq0f1kBG9GNrC71AlerK1MktbDDSBMjSRfRCEVBg2POY
	ztRshU7x3Nntx+3bZz9Th4=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDn74EdSi9muFqGAA--.54647S2;
	Mon, 29 Apr 2024 15:19:58 +0800 (CST)
From: Felix Qin <xiaokeqinhealth@126.com>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Felix Qin <xiaokeqinhealth@126.com>
Subject: [PATCH v3 1/1] mmc: core: increase the timeout period of the ACMD41 command.
Date: Mon, 29 Apr 2024 15:19:55 +0800
Message-Id: <20240429071955.163282-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn74EdSi9muFqGAA--.54647S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4ktw48ur45tr4fWF43trb_yoWkKFg_Ar
	n5Xrn7WF1YkFy7tr10kwnYqFZ5twn3urn7ua13trZxCrWrJrWrW3Z3Zr9rZr13Wr1fZ3Zr
	Jas8tr1rX34fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKOzsJUUUUU==
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6BfP1WVLbGixXgABsh

Extensive testing has shown that some specific SD cards require an
increased command timeout to be successfully initialized.

More info:
Platform: Rockchip SoC + DW Multimedia host Controller
SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
Note: The SD card is custom-made by the customer in collaboration
with the wafer foundry.

Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>

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

