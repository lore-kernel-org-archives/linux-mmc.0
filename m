Return-Path: <SRS0=zEeD=26=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB84C32771
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97246206ED
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfNqxbwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgAIJNo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:13:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgAIJNn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2020 04:13:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so3087121pfb.3;
        Thu, 09 Jan 2020 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqDsLNhtHSIHGhQiEDBjDopbKzdEsy6WnRJA/WOwF8s=;
        b=bfNqxbwLulwnB7ovW01Fbc47QgGlS8+7gNV1zqUpls8dXgz19q34q9gHAclH2c2Wkd
         /dZRyFL7cYMnY+KzhzYiLPNKDNL5raDykS+u72AVOOcl6OFjF70kx1WzXzSAEH94ZgFY
         HwOVjsreGST3zsDthQ5LAfn+w6KJLD5Gl3TB5OQkahQ8cRx4xDt8tJULcD3St2niH8H/
         uYF+KsRsPapftuse32xeMzDiMNlHL6N7JmXU9G7cPmL1gqlI5Te5vtHA6mcTNq3Tbtpg
         P6oIrkvpr+zl3oqi0UFFcGGh7e6DdMqX0h+f/wi8Bmj6bZHHO8DMO4NVwNhp57g+gds6
         WzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqDsLNhtHSIHGhQiEDBjDopbKzdEsy6WnRJA/WOwF8s=;
        b=A/O0tqhKS8LyQDZfWYNJDEcicNlbqgJpjsrpxnAAru/f6QYRJxAuuEnw52jLdLibIp
         yLFNRHZFIu9pmaiBxAyR7jGhNdgS0hoKZ6SrZsnhvof8nr/WfTTwtQ9qqZm+8Fbc59u1
         0seFuU6sQ397ZI6/DhiwsviGv8Sinf8CizGsx1XPc3CaEPjlgoMlXJthizhTI69VAUft
         tfH6HKJXziUof6blNauzvd6JrIo/sKm0K9tZbiuSvIyTmTz2DcXpQAZ/3OZzawg2rqpo
         RsQ125YSmsHBUsd2+7MuQuyuNWK22ia/Q/Ukuy1UmwDtFgh1kNnuGNMOYeuQksJSdPVi
         WM+A==
X-Gm-Message-State: APjAAAW48yPqC28qi6ezV8MjIVWQzPNupT3rrV9Iyr+SPcfPJelwdNzg
        ctqxyVqRLymzVkQAxIHYrW4=
X-Google-Smtp-Source: APXvYqwb8DBYx/dLiDqVmhat2ATuO33hRnqOp+WcD+JS4DLFWGeLDUhc6kyvsy7YW3CDEmOjUNzlrA==
X-Received: by 2002:a62:7c54:: with SMTP id x81mr9812667pfc.180.1578561222602;
        Thu, 09 Jan 2020 01:13:42 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id m3sm6707916pfh.116.2020.01.09.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:13:42 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH v2 1/6] mmc: Add UHS-II support in public headers
Date:   Thu,  9 Jan 2020 17:14:04 +0800
Message-Id: <085ce316d536fef5d19184f0f2b71c478fe3a709.1578560282.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560282.git.benchuanggli@gmail.com>
References: <cover.1578560282.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add UHS-II support in public headers

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/core.h |  6 ++++++
 include/linux/mmc/host.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index cf3780a6ccc4..988f46638317 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -180,6 +180,7 @@ struct sd_switch_caps {
 #define SD_SET_CURRENT_LIMIT_400	1
 #define SD_SET_CURRENT_LIMIT_600	2
 #define SD_SET_CURRENT_LIMIT_800	3
+#define SD_SET_CURRENT_LIMIT_1000       4
 #define SD_SET_CURRENT_NO_CHANGE	(-1)
 
 #define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b7ba8810a3b5..cd294a1c31c6 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -7,6 +7,7 @@
 
 #include <linux/completion.h>
 #include <linux/types.h>
+#include <linux/mmc/uhs2.h>
 
 struct mmc_data;
 struct mmc_request;
@@ -112,6 +113,11 @@ struct mmc_command {
 
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
+
+	struct uhs2_command	*uhs2_cmd;	/* UHS2 command */
+	u8			*uhs2_resp;	/* UHS2 native cmd resp */
+	u8			uhs2_resp_len;	/* UHS2 native cmd resp len */
+	u8			uhs2_tmode0_flag; /* UHS2 transfer mode flag */
 };
 
 struct mmc_data {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..3d6a7c9b534f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -15,10 +15,12 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/pm.h>
 #include <linux/dma-direction.h>
+#include <linux/mmc/uhs2.h>
 
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
 	unsigned short	vdd;
+	unsigned short	vdd2;			/* UHS2 VDD2 power supply */
 	unsigned int	power_delay_ms;		/* waiting for stable power */
 
 /* vdd stores the bit number of the selected voltage range from below. */
@@ -60,6 +62,7 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_DDR52	8
 #define MMC_TIMING_MMC_HS200	9
 #define MMC_TIMING_MMC_HS400	10
+#define MMC_TIMING_UHS2		11
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -169,6 +172,11 @@ struct mmc_host_ops {
 	 */
 	int	(*multi_io_quirk)(struct mmc_card *card,
 				  unsigned int direction, int blk_size);
+	/* UHS2 interfaces */
+	int	(*uhs2_detect_init)(struct mmc_host *host);
+	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
+	void    (*uhs2_disable_clk)(struct mmc_host *host);
+	void    (*uhs2_enable_clk)(struct mmc_host *host);
 };
 
 struct mmc_cqe_ops {
@@ -261,6 +269,7 @@ struct mmc_pwrseq;
 
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
+	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 };
 
@@ -281,12 +290,14 @@ struct mmc_host {
 	u32			ocr_avail_sdio;	/* SDIO-specific OCR */
 	u32			ocr_avail_sd;	/* SD-specific OCR */
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
+	u32			ocr_avail_uhs2;	/* UHS2-specific OCR */
 #ifdef CONFIG_PM_SLEEP
 	struct notifier_block	pm_notify;
 #endif
 	u32			max_current_330;
 	u32			max_current_300;
 	u32			max_current_180;
+	u32			max_current_180_vdd2; /* UHS2 vdd2 max curt. */
 
 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
@@ -305,6 +316,7 @@ struct mmc_host {
 #define MMC_VDD_33_34		0x00200000	/* VDD voltage 3.3 ~ 3.4 */
 #define MMC_VDD_34_35		0x00400000	/* VDD voltage 3.4 ~ 3.5 */
 #define MMC_VDD_35_36		0x00800000	/* VDD voltage 3.5 ~ 3.6 */
+#define MMC_VDD2_165_195	0x00000080	/* UHS2 VDD2 1.65 ~ 1.95 */
 
 	u32			caps;		/* Host capabilities */
 
@@ -336,6 +348,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_UHS2		(1 << 26)	/* Host supports UHS2 mode */
 #define MMC_CAP_DONE_COMPLETE	(1 << 27)	/* RW reqs can be completed within mmc_request_done() */
 #define MMC_CAP_CD_WAKE		(1 << 28)	/* Enable card detect wake */
 #define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
@@ -374,6 +387,17 @@ struct mmc_host {
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
+	struct uhs2_host_caps	uhs2_caps;	/* UHS2 host capabilities */
+	struct uhs2_card_prop	uhs2_dev_prop;	/* UHS2 device properties */
+	u32			group_desc;	/* UHS2 property */
+	int			flags;
+#define MMC_UHS2_SUPPORT	(1 << 0)
+#define MMC_UHS2_INITIALIZED	(1 << 1)
+#define MMC_UHS2_2L_HD		(1 << 2)
+#define MMC_UHS2_APP_CMD	(1 << 3)
+#define MMC_UHS2_SPEED_B	(1 << 4)
+#define MMC_SUPPORT_ADMA3	(1 << 5)
+
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_segs;	/* see blk_queue_max_segments */
@@ -566,6 +590,12 @@ static inline int mmc_card_uhs(struct mmc_card *card)
 		card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_card *card)
+{
+	return (card->host->flags & MMC_UHS2_SUPPORT) &&
+		(card->host->flags & MMC_UHS2_INITIALIZED);
+}
+
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
-- 
2.24.1

