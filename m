Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F811198E65
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010684; cv=none; b=E8xjb6zLjMhqVFmcc2jFqfediO/LQto/kzf5Wwpfhf1u3t2CsY9RyaA4suqKPGDGuLDvY/tbLpAAoDiOt7wd3ZGF9fqv5Mp2S7BlnDWjirvRG4z52/6eHEW3OpHsGXj9C0Qn7EUN75eJVilbznp6eZ7QO+McZ5hHpiMWyCljQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010684; c=relaxed/simple;
	bh=ZEgObMbnv6e4XAH8wAQxCGBp478qeQKb/VSh+uWR0MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yxvr6HJfryVzsv/tf/LwJGGpl0styFFl4O/USP++qpEL3/Kg9IcTRZc5ZvfVQRZQs3mEbT/xhGuHfu/xrps3JNygiW31XjhMafwz0Kg2NNTwcv7PRiroxP2MMzpMF+/3jWBOfOTZp4S2uInasfgMxyTOKYMycGH4Fsn1p78KD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WSiYlgW4; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WSiYlgW4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010683; x=1754546683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZEgObMbnv6e4XAH8wAQxCGBp478qeQKb/VSh+uWR0MQ=;
  b=WSiYlgW4VzUI8sTglMOx5x004/sUNoLKUzqfJzGQoUSEUHoZrtmyrU8X
   0CcXRCK4Nt6OYxSZBKYd5RzmUMC73Go3HThApiDIBQUt/U3DJ55Ux+8ft
   54mS5eTEefsUVNoH4mW2vEJHQ76D8hU7RF5TNDVp8QykI7LaYh6CxRNzv
   BER2kT2O1VRvUZT0eYGLSI1eY9Q0cQ4KH9ngeKQ2nD8Ymy2wCYcdNfowM
   CEWW54ZnhDVCmLOCoB3ikOJ0wZAsB4Vvu4CqAKRK4Yck+Iy1bAiJNWYQG
   2Mr2oJzsiu5Rx4Gmxyn3Fd2PVHitvnRzhooS7UfHtu+B8Zufd/T47mtuF
   w==;
X-CSE-ConnectionGUID: fUy9D/I3Qmy3k05cgD9gMA==
X-CSE-MsgGUID: X3TBfgBARm2/laObiv/sGg==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039286"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:04:43 +0800
IronPort-SDR: 66b30080_3QvT3gzbXca0QqL2udo9YUPuKglR1TCfFakmu8Q9xnivA/F
 nPQlRm7NO1L0DzdmjRu1WwADIemdOyDxOYBDKng==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:05 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:04:42 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 01/10] mmc: sd: SDUC Support Recognition
Date: Wed,  7 Aug 2024 09:03:00 +0300
Message-Id: <20240807060309.2403023-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807060309.2403023-1-avri.altman@wdc.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
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

