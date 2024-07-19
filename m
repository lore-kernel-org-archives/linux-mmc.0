Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288246444;
	Fri, 19 Jul 2024 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367230; cv=none; b=ra72rH3pQSVp8y8V1hinu3ts5n1qznb9FlleUToH7bTHmxpzZ20LxRJQpWoILRahkxC9oBjQ4kGAdYR9mUgv1lNF2IxFEyZ1j9RifDWBhLsodOFSUryqBxL4y+Te0GgFWdF6F/2p2MjCMoo9C76OvfCNQluRPOK3yoRrjrafMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367230; c=relaxed/simple;
	bh=Ui4JdZdhYe/R+P21rObK4HF8jfZm3mjt8VmpAS+Cf3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTl0G1cH3UOvGNbuhnI89NmlLHdaUHikb2YXDJxr3qCTUZjsV4woRxQld53fqv1cfxBxE97//FT6y+fqytEiwmrT3LN7FEuwiGD8wku1cgLmTGovlav27Ify1jCESducFNNCk01/so2+Gxa+LmmdO36t+CMliRS5WI81mOmGm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tn5agpD0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tn5agpD0"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J5XPH30148364, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721367205; bh=Ui4JdZdhYe/R+P21rObK4HF8jfZm3mjt8VmpAS+Cf3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tn5agpD0oQFDs71XYWaVfQGdXf/Oo5mIi2fkOmvxVR6Ydp3KEQpbhgg8xhrpd3y8J
	 g1ldyuoS3dI2M+pImMsHwjjAcePWPusUWLbMvr/80hv8bUwKqn+hOH9zrvPEAMKkOn
	 FitpKlHj0sWKQhH0KH6Ui/yuEcjE9a8r+bi/bXKGp9BjblP2dUtx6K/x5/SlX0UIvP
	 4t1JBuNM0waJi4lqMZZZYqpv0CajG3qeeixQqcUYPGUoUqcOiVS3W6JtFje//tlpmB
	 fsyUWlhiOuySxaYtUaZx0anxKSjACkgpkXjCxvIplsUJWmqFK4Lzhm5sOn3UZmTM+N
	 z9Pk0RaBWXPOA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J5XPH30148364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 13:33:25 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 13:33:25 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 13:33:25 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <ricky_wu@realtek.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ricardo@marliere.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
Subject: [PATCH 1/4] mmc: core: some definitions and type modifications for SDUC
Date: Fri, 19 Jul 2024 13:33:11 +0800
Message-ID: <20240719053314.1636649-2-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719053314.1636649-1-ricky_wu@realtek.com>
References: <20240719053314.1636649-1-ricky_wu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Modified some type from "unsigned int" to "unsigned long long"
because SDUC need more bits address
Add some definitions for support SDUC
Add pointer ae(Address extension) to know support SDUC or not

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/core/card.h  | 3 +++
 drivers/mmc/core/core.h  | 6 +++---
 drivers/mmc/core/host.h  | 5 +++++
 drivers/mmc/core/queue.h | 1 +
 include/linux/mmc/card.h | 2 +-
 include/linux/mmc/core.h | 1 +
 include/linux/mmc/host.h | 1 +
 include/linux/mmc/sd.h   | 5 +++++
 8 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index b7754a1b8d97..9b7f6804851f 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -23,11 +23,13 @@
 #define MMC_CARD_SDXC		(1<<3)		/* card is SDXC */
 #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
 #define MMC_STATE_SUSPENDED	(1<<5)		/* card is suspended */
+#define MMC_CARD_SDUC		(1<<6)		/* card is SDUC */
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
+#define mmc_card_ultra_capacity(c) ((c)->state & MMC_CARD_SDUC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
 
@@ -35,6 +37,7 @@
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
+#define mmc_card_set_ultra_capacity(c) ((c)->state |= MMC_CARD_SDUC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
 #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 37091a6589ed..6c927ee60cef 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -116,15 +116,15 @@ bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
-int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
+int mmc_erase(struct mmc_card *card, unsigned long long from, unsigned long long nr,
 		unsigned int arg);
 int mmc_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 int mmc_can_discard(struct mmc_card *card);
 int mmc_can_sanitize(struct mmc_card *card);
 int mmc_can_secure_erase_trim(struct mmc_card *card);
-int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
-			unsigned int nr);
+int mmc_erase_group_aligned(struct mmc_card *card, unsigned long long from,
+			unsigned long long nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..82381ad76fe0 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -89,5 +89,10 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_host_sduc(struct mmc_host *host)
+{
+	return host->caps2 & MMC_CAP2_SDUC;
+}
+
 #endif
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 9ade3bcbb714..448caff7eae4 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -40,6 +40,7 @@ struct mmc_blk_ioc_data;
 struct mmc_blk_request {
 	struct mmc_request	mrq;
 	struct mmc_command	sbc;
+	struct mmc_command	ae;
 	struct mmc_command	cmd;
 	struct mmc_command	stop;
 	struct mmc_data		data;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f34407cc2788..8943ca0c4991 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -35,7 +35,7 @@ struct mmc_csd {
 	unsigned int		wp_grp_size;
 	unsigned int		read_blkbits;
 	unsigned int		write_blkbits;
-	unsigned int		capacity;
+	unsigned long long	capacity;
 	unsigned int		read_partial:1,
 				read_misalign:1,
 				write_partial:1,
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2c7928a50907..781999a7a1f2 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -142,6 +142,7 @@ struct mmc_data {
 struct mmc_host;
 struct mmc_request {
 	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
+	struct mmc_command	*ae;		/* ADDR_EXT for SDUC */
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
 	struct mmc_command	*stop;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 88c6a76042ee..763fb6771653 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -427,6 +427,7 @@ struct mmc_host {
 #define MMC_CAP2_CRYPTO		0
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_SDUC		(1 << 29)
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 6727576a8755..5173d7d54923 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -15,6 +15,9 @@
 #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
 #define SD_SWITCH_VOLTAGE         11  /* ac                      R1  */
 
+  /* class 2 */
+#define SD_ADDR_EXT               22  /* ac   [5:0] extended addr R1  */
+
   /* class 10 */
 #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */
 
@@ -36,6 +39,8 @@
 /* OCR bit definitions */
 #define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
 #define SD_ROCR_S18A		SD_OCR_S18R  /* 1.8V switching accepted by card */
+#define SD_OCR_HO2T   (1 << 27)    /* Over 2TB Supported Host */
+#define SD_ROCR_CO2T    SD_OCR_HO2T  /* Over 2TB Card */
 #define SD_OCR_XPC		(1 << 28)    /* SDXC power control */
 #define SD_OCR_CCS		(1 << 30)    /* Card Capacity Status */
 
-- 
2.25.1

