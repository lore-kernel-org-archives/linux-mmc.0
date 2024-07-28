Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E780C13B
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154466; cv=none; b=SLYBZTb3s0CeKFkG+7LhTlQAMgTXwCerH7qgDBoWLkWXN3vc8tfxzFfi3zf31C2wEw9xXYwaIlj7vzO9O/fF3B0KXKmiRyQocSJ779Sj11yLoN+OdhllMqLMhrb3jrKj7ofqAJJ9iHlHJyEcqh7yBuisSoI/QbIAjnXQ1uIRuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154466; c=relaxed/simple;
	bh=ZEgObMbnv6e4XAH8wAQxCGBp478qeQKb/VSh+uWR0MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H0zNkALctJHhUgavq5b7vh3vCZdB1eAReah1wdWd2FRD7ByvwienmPNTD/ci+PKRFfOlBasTCuwZvJcCgNkadgGH8vF1NtmGEjX2pOiB+Gx6mzBpkJ9om040DFeBkl24Z/K68V45Wm1hwzZJlcl73UoKpYvy7QE6Xuylj9kGlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nQerns0S; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nQerns0S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154464; x=1753690464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZEgObMbnv6e4XAH8wAQxCGBp478qeQKb/VSh+uWR0MQ=;
  b=nQerns0S44T72rat8bGIlhvOadBhl13rUfENuGaTDJjjI/QKk8JiwPoB
   o3ZtD7MowOsDMPHv2RqfRmVlrle++vyCsSbM+XKroNAY49zTdUVkLISVq
   UEh9bXDnWjJssFvYJRvFrQs1JekUzYem5RNwF62OOUYSbyQ5WoXYc7GUF
   xe1SatghSb4hFF6QmPAaDiXlvzYStrHcjeP5c8M2oBUu3c2c9lAPZvntZ
   n48JvGeSGtum+JVGa9iLpE7P9VaeU0S8AlXd3QyHX5zrargqO+OBrbACJ
   NJ9nIOkIwPFKlv/fk0m5dilYC4d9qCJYSJvTzagDIBeivQE+T4MotbrK/
   g==;
X-CSE-ConnectionGUID: Cy5lsA0pQqaossaF7n+ZjQ==
X-CSE-MsgGUID: HO5Nx/4IRQqg9PTRz+ShmA==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22256097"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:18 +0800
IronPort-SDR: 66a5f104_ybCAqaAP/PgDqF0/viYR1PcjsFEKlg86UwfaALsixQEETv7
 VRDVgu7H5p8MVgV9KaIja1fcpnaJI6rLvlABZ8g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:19:33 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:17 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 01/10] mmc: sd: SDUC Support Recognition
Date: Sun, 28 Jul 2024 11:11:45 +0300
Message-Id: <20240728081154.1782120-2-avri.altman@wdc.com>
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

ACMD21 was extended to support the host-card handshake during
initialization.  The card expects that the HCS & HO2T bits to be set in
the command argument, and sets the applicable bits in the R3 returned
response.  On the contrary, if a SDUC card is inserted to a
non-supporting host, it will never respond to this ACMD21 until
eventually, the host will timed out and give up.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd_ops.c | 19 +++++++++++++++----
 include/linux/mmc/host.h  |  6 ++++++
 include/linux/mmc/sd.h    |  1 +
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 8b9b34286ef3..7f6963dac873 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -168,12 +168,16 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		.cmd = &cmd
 	};
 	int err;
+	u32 sduc_arg = SD_OCR_CCS | SD_OCR_2T;
 
 	cmd.opcode = SD_APP_OP_COND;
+	cmd.arg = ocr;
+
 	if (mmc_host_is_spi(host))
-		cmd.arg = ocr & (1 << 30); /* SPI only defines one bit */
+		cmd.arg &= (1 << 30); /* SPI only defines one bit */
 	else
-		cmd.arg = ocr;
+		cmd.arg |= sduc_arg;
+
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
 	err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
@@ -182,8 +186,15 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	if (err)
 		return err;
 
-	if (rocr && !mmc_host_is_spi(host))
-		*rocr = cmd.resp[0];
+	if (!mmc_host_is_spi(host)) {
+		if (rocr)
+			*rocr = cmd.resp[0];
+
+		if ((cmd.resp[0] & sduc_arg) == sduc_arg)
+			host->caps2 |= MMC_CAP2_SD_SDUC;
+		else
+			host->caps2 &= ~MMC_CAP2_SD_SDUC;
+	}
 
 	return 0;
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 88c6a76042ee..a9c36a3e1a10 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -427,6 +427,7 @@ struct mmc_host {
 #define MMC_CAP2_CRYPTO		0
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_SD_SDUC	(1 << 29)	/* SD over 2TB */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
@@ -638,6 +639,11 @@ static inline int mmc_card_uhs(struct mmc_card *card)
 		card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
 }
 
+static inline int mmc_card_is_sduc(struct mmc_host *host)
+{
+	return host->caps2 & MMC_CAP2_SD_SDUC;
+}
+
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 6727576a8755..865cc0ca8543 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -36,6 +36,7 @@
 /* OCR bit definitions */
 #define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
 #define SD_ROCR_S18A		SD_OCR_S18R  /* 1.8V switching accepted by card */
+#define SD_OCR_2T		(1 << 27)    /* HO2T/CO2T - SDUC support */
 #define SD_OCR_XPC		(1 << 28)    /* SDXC power control */
 #define SD_OCR_CCS		(1 << 30)    /* Card Capacity Status */
 
-- 
2.25.1

