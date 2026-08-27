Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9DF41B8F2;
	Thu, 27 Aug 2026 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822136; cv=none; b=kDjlU4kliuDBmIFQFkWHI6AKz/DQhANO1CfzxHr/0aJxm6SAFKMfcfxKcNQLgLNbV8eiFfOa9GTjV1Xh1isnrvN33d/Blc/1B5wBlA0CQlU55CE3b1ALVrYQEc8ebbVzudJKhJpyaAJ+KbldTbxrHQN/HDoPFfW1uEKDiTAmZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822136; c=relaxed/simple;
	bh=XCbu7ilYLhdP+tRkDk0OhlG3kuV6naKq+6AHp3nxe5Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tNBKRAwSCblbXqYzCkQorWP3/QoMSMjcxskfuykkPpuVKsDruJK92Ov2MZM5kIvLe5Px+67KxDovJIMjdmrsws4V2jXE9WKAlcaXMRqKo3qrC0HA3qYaBJN3RO1FGkeTShZFH97ZHbIX3IKK4x5pEmK/bkW92qfCHRUyf0d5I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=PSQQxKmM; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="PSQQxKmM"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTPS id 67R9EcQV079827
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 27 Aug 2026 17:14:38 +0800 (+08)
	(envelope-from xiaojie.li2@unisoc.com)
Received: from SHDLP.spreadtrum.com (zeshmbx09.spreadtrum.com [10.29.3.107])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4hVwmZ5GLHz2K4tL9;
	Thu, 27 Aug 2026 17:13:34 +0800 (CST)
Received: from zeshkernups02.spreadtrum.com (10.29.35.184) by
 zeshmbx09.spreadtrum.com (10.29.3.107) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 27 Aug 2026 17:14:37 +0800
From: Xiaojie Li <xiaojie.li2@unisoc.com>
To: Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Xiaojie.Li2@unisoc.com>, <Wenchao.Chen@unisoc.com>,
        <Rain.Zhang@unisoc.com>, <Yuelin.Tang@unisoc.com>,
        <cixi.geng@linux.dev>
Subject: [PATCH] mmc: core: Modify the CMD1 transmission interval
Date: Thu, 27 Aug 2026 17:14:36 +0800
Message-ID: <20260827091436.1339716-1-xiaojie.li2@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 zeshmbx09.spreadtrum.com (10.29.3.107)
X-MAIL:SHSQR01.spreadtrum.com 67R9EcQV079827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1787822088;
	bh=jCgLoZv8zqyMeIKn8YHg7wgDILHZdtAPRczDdROSP8E=;
	h=From:To:CC:Subject:Date;
	b=PSQQxKmMdnCfyu+PvKFoD8hPKizgkOmd8I/Be39kWpe2y7LHHgqloPUJSHfpahmLW
	 UlWI3MhaVBLmgbpU7X1VPcxkbDFRm09ubXO6UyPWxH5Pygi8d4dDCyq1XwmADhDVUU
	 HuGqfC1yAtNnlarYHjNy2Yr7q7VdWaoBk8NBjbpoLFqN601t0EtIx/8239uhg9/S6w
	 jcQBiNWYfs5WjEYFCcbxfboP12T31Ev+3OJ/JU2Bgm+opKpDLt3XMi4otjHk1FZMMP
	 61d6OoiuYgQKtfv6cXSgu6Mlmz40+r2n8b1DPywG8WsMs+M5PE2Uc4io024h1dhqPc
	 xnbEQswoNG5XA==

The current code's maximum udelay value is set to
64ms. Since it uses usleep_range(udelay, udelay*2),
this results in a maximum wait time of 128ms between
two consecutive CMD1 commands. For lower-performance eMMC chips,
local testing shows that compared to the old code which used
mmc_delay(10), the total time required to wait for the busy
bit in the CMD1 response to change has increased by approximately
300ms, negatively impacting the overall eMMC initialization time.

Although the current code sends the CMD1 command fewer times than
the old version, the total waiting time is significantly longer.
To address this, it's proposed to modify the CMD1 sending interval
to follow a pattern like 4ms, 6ms, 8ms, 10ms, 10ms, etc., effectively
capping the longest single wait at 10ms. Local testing confirms that
this approach can bring the total time waiting for the busy state
change very close to the performance level of the old code.

The eMMC chip used for testing: manfid= 0x00009b, name= Y0S128, mdt= 2022-10
The eMMC part number is: YMEC8B0TE2A2C3

Signed-off-by: Xiaojie Li <xiaojie.li2@unisoc.com>
---
 drivers/mmc/core/mmc_ops.c | 85 ++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index a952cc8265af..3076666cf2ca 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -189,64 +189,51 @@ int mmc_go_idle(struct mmc_host *host)
 	return err;
 }
 
-static int __mmc_send_op_cond_cb(void *cb_data, bool *busy)
-{
-	struct mmc_op_cond_busy_data *data = cb_data;
-	struct mmc_host *host = data->host;
-	struct mmc_command *cmd = data->cmd;
-	u32 ocr = data->ocr;
-	int err = 0;
-
-	err = mmc_wait_for_cmd(host, cmd, 0);
-	if (err)
-		return err;
-
-	if (mmc_host_is_spi(host)) {
-		if (!(cmd->resp[0] & R1_SPI_IDLE)) {
-			*busy = false;
-			return 0;
-		}
-	} else {
-		if (cmd->resp[0] & MMC_CARD_BUSY) {
-			*busy = false;
-			return 0;
-		}
-	}
-
-	*busy = true;
-
-	/*
-	 * According to eMMC specification v5.1 section 6.4.3, we
-	 * should issue CMD1 repeatedly in the idle state until
-	 * the eMMC is ready. Otherwise some eMMC devices seem to enter
-	 * the inactive mode after mmc_init_card() issued CMD0 when
-	 * the eMMC device is busy.
-	 */
-	if (!ocr && !mmc_host_is_spi(host))
-		cmd->arg = cmd->resp[0] | BIT(30);
-
-	return 0;
-}
-
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
 	struct mmc_command cmd = {};
+	unsigned int udelay = MMC_OP_COND_PERIOD_US;
+	unsigned int udelay_max = 10000;
+	unsigned long timeout = jiffies + msecs_to_jiffies(MMC_OP_COND_TIMEOUT_MS) + 1;
 	int err = 0;
-	struct mmc_op_cond_busy_data cb_data = {
-		.host = host,
-		.ocr = ocr,
-		.cmd = &cmd
-	};
 
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	err = __mmc_poll_for_busy(host, MMC_OP_COND_PERIOD_US,
-				  MMC_OP_COND_TIMEOUT_MS,
-				  &__mmc_send_op_cond_cb, &cb_data);
-	if (err)
-		return err;
+	while (!time_after(jiffies, timeout)) {
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err)
+			break;
+
+		if (mmc_host_is_spi(host)) {
+			if (!(cmd.resp[0] & R1_SPI_IDLE))
+				break;
+		} else {
+			if (cmd.resp[0] & MMC_CARD_BUSY)
+				break;
+		}
+
+		/*
+		 * According to eMMC specification v5.1 section 6.4.3, we
+		 * should issue CMD1 repeatedly in the idle state until
+		 * the eMMC is ready. Otherwise some eMMC devices seem to enter
+		 * the inactive mode after mmc_init_card() issued CMD0 when
+		 * the eMMC device is busy.
+		 */
+		if (!ocr && !mmc_host_is_spi(host))
+			cmd.arg = cmd.resp[0] | BIT(30);
+
+		usleep_range(udelay, udelay + 1000);
+
+		if (udelay < udelay_max)
+			udelay += 2000;
+		else
+			udelay = udelay_max;
+	}
+
+	if (time_after(jiffies, timeout))
+		err = -ETIMEDOUT;
 
 	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
-- 
2.34.1

