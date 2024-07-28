Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4DBA34
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154420; cv=none; b=Ois9KrbTu7i6in+n8x3ieAyj2YUSWeoF7XeinglH0kNxHwo6GUxrvc8/U+r/tR4Z0VzWQDnV2VadHtBhH3CzDCozZfGB+yY0wSUknpGEQDls0oJwsDWes+x2oolU+MWKHc9gWZAqRUku7LTUIpyIs29ywMBHM6RNxRw6yFSRezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154420; c=relaxed/simple;
	bh=X0/a+BX4U/emCOb0S9LS+gkDCOcQajRM/sLCLXaTzMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdQd60ByGogKYJ4y9qGiFvnG+ehSBPikcbsx2JRM3zM5dGjpiBwKwzCzvmguFS05NY36RU4AWsDkcVmJellmmIKCf06CA2VUscuuskixbnktFj8E0qr2CnRDBQMO6vkSVzSit0i04ehcKbjYxPoZ4A87WOtsx2TtR//5pGZWJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Rt0Bh8fw; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rt0Bh8fw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154418; x=1753690418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0/a+BX4U/emCOb0S9LS+gkDCOcQajRM/sLCLXaTzMw=;
  b=Rt0Bh8fw5gxhpp4Z9ifNBUwDgCQkU+26KFkF84J0G02zzRe6ImlIR039
   PBAcFr3Neyi9xYomrfJsdNx7lyZ+KEpADJdQs1jCfv55Il4HC8TQeSkjg
   5mgvl+RrptSPiC6PDFDZJW77UlNTTkDuJMYBsKiNyiFlPluGnA7M0wc+K
   pKt4TUANKR7oH1uE2LZFekD5TxdYTAR+WMMsjmELLqkRLsupGBWIpJb1z
   D+O2z5GdPvJ+c91gOVXAqtXj9dupZrZER6YK/z8BIG6VnC77DCmWTxjHv
   9bNWKR4cCs24hN366a+hLDWa16APeSeFDd6VRS84ZdowKylttH8nDkSfJ
   w==;
X-CSE-ConnectionGUID: mjXM694HQxeZfhIfCgoZog==
X-CSE-MsgGUID: c4t9wfUGTlGLEercYQ3mlA==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="23160001"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:30 +0800
IronPort-SDR: 66a5f111_0OAUMtfLf72/y4xYV9tV20J+aQb0yzLRK+0c8zg2w+EFVEs
 WuUpu3+usIXb/KNdn15UGByOt5otnPFi23KSsQg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:19:45 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:29 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 03/10] mmc: sd: Add Extension memory addressing
Date: Sun, 28 Jul 2024 11:11:47 +0300
Message-Id: <20240728081154.1782120-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240728081154.1782120-1-avri.altman@wdc.com>
References: <20240728081154.1782120-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore, 38
bits are required to access the entire memory space of all sectors.
Those extra 6 bits are to be carried by CMD22 prior of sending
read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and CMD33.

CMD22 will carry the higher order 6 bits, and must precedes any of the
above commands even if it targets sector < 2TB.

No error related to address or length is indicated in CMD22 but rather
in the read/write command itself.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd_ops.c | 14 ++++++++++++++
 drivers/mmc/core/sd_ops.h |  1 +
 include/linux/mmc/sd.h    |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 7f6963dac873..25b299d91cfc 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -199,6 +199,20 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	return 0;
 }
 
+int mmc_send_ext_addr(struct mmc_host *host, u8 ext_addr)
+{
+	struct mmc_command cmd = {};
+
+	if (!mmc_card_is_sduc(host))
+		return 0;
+
+	cmd.opcode = SD_ADDR_EXT;
+	cmd.arg = ext_addr & 0x3F;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	return mmc_wait_for_cmd(host, &cmd, 0);
+}
+
 static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
 			      u32 *resp)
 {
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 7667fc223b74..0db081f2355c 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
 int mmc_app_send_scr(struct mmc_card *card);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
+int mmc_send_ext_addr(struct mmc_host *host, u8 ext_addr);
 
 #endif
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 865cc0ca8543..af5fc70e09a2 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -15,6 +15,9 @@
 #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
 #define SD_SWITCH_VOLTAGE         11  /* ac                      R1  */
 
+/* Class 2 */
+#define SD_ADDR_EXT		 22   /* ac   [5:0]              R1  */
+
   /* class 10 */
 #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */
 
-- 
2.25.1

