Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48EAEA4
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620689; cv=none; b=QZEcIzxdKg6+fQ4xN667rlTpJu4hxAuPuBF4/GZ5W+ZIGYPOXUDb9m5zdH9eDX+bCR1dSUP3KZ+quAuO/grB412Hgd4nx7WrwxueYZLMOY2LLBmxx8oIKiDi+4h2ips0IRrB9VM3jpa6+aKGcTjmk4xc65YkBcQw6VdKEOfxgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620689; c=relaxed/simple;
	bh=OSRuQRkaXfIZCB34lkDpVYh7O6NYm8LaeRZiVsWtOdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1SlKQ/wBjptHW0EvBff07fxEuzv2mFELRflWUD26VvJNmSFbvVTs5H6n6R9UDZo8umkgS+OYHDRvhpMa/BBw/gqaiBNIx7Banx3vevZ4WbtKOGIwljl6NtYU9czxCJqHZOBQwsEPffn2veiHFmfvrf0qUnrJV5J2Kt3qSTK8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dtuZrxLj; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dtuZrxLj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620687; x=1755156687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OSRuQRkaXfIZCB34lkDpVYh7O6NYm8LaeRZiVsWtOdQ=;
  b=dtuZrxLjvwRhIOKrN5T0qy3/3KV+mbqPIJHr/6wl4EJgf2CaQ3Eh4EEZ
   f6qQ71HR6ciWSCJo/WP28XNRq/aV9JxTg/0yt5lZW63vI30J1dviKmwAG
   pqhizkRIGzgrBRUtYnT2/5LR9s01HkAq+I+aZmul5WWqnwx+eyj6vF8OO
   CgLu1owXz6XnWjB7jLGcXAk4DBEvVtE2XRLVbWNsMvc6hqzItY3uUxQLf
   5tHb/wsXAP/fQiJiKNZDQuAtRcXecHa/yUMCN+l1OOJU1kfJGmN86Re20
   YzIvS7EBZr/i8xp8p0l9ARGBwfK43Smc3hfnc8bTfByCPo94IZc/eko9g
   Q==;
X-CSE-ConnectionGUID: p60w2gNxSweswvCZ/RqrgA==
X-CSE-MsgGUID: ydbuvjLhRVy8U/xz7R65SQ==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="24957137"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:19 +0800
IronPort-SDR: 66bc4f44_KHB0XhsAs0Iq61HtWhRYXFRSKHPwzxxtnZrAKOsKHaCIgg/
 5g8+fqoPFNT0ONNpgvMN6KC0Dm7GeONejMm7+gA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:31:33 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:18 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 01/10] mmc: sd: SDUC Support Recognition
Date: Wed, 14 Aug 2024 10:29:25 +0300
Message-Id: <20240814072934.2559911-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACMD41 was extended to support the host-card handshake during
initialization.  The card expects that the HCS & HO2T bits to be set in
the command argument, and sets the applicable bits in the R3 returned
response.  On the contrary, if a SDUC card is inserted to a
non-supporting host, it will never respond to this ACMD41 until
eventually, the host will timed out and give up.

Tested-by: Ricky WU <ricky_wu@realtek.com>
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

