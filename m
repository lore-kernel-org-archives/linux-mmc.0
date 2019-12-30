Return-Path: <SRS0=mt+k=2U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB0C2D0C2
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD892053B
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmkgALDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfL3LiZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:38:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43872 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfL3LiZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2019 06:38:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so14521645pli.10;
        Mon, 30 Dec 2019 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OH2GbOWHr2bht6gAmkrVmHykETmjDXXGJ+YbuhjB4E=;
        b=RmkgALDTMkvmqcCLoGRITjNWsvdDEUsG90mFrHGLnH5iDFL5t9qWhF8ttHsPtEEfVk
         W+4tJ/r1ie2nnsKTOdWwMkjBLf3ElJPvNGC5fZwtdlq4OjjnKa5MsJaTQY1vQI1x+6Kn
         Fixcb0zCbbN2FSVy1bEODa1eAIaYEkmb6y7xEH2+WYJeRt4RII/Bfl5cbz9ELEsuHEOc
         EMsc6cEmmOGS/AG2+ur5j3Xv50M3oFKQnoz++T4kQdKP0yMAuGaMOnbfUk0hLcWscuGb
         iLb2gmlWjSRrQfCpC+LWIEdiBGo2nTij9O8L+Mc0QX00SsJ/iQSWhxDqC+9PGrPcMbQO
         VKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OH2GbOWHr2bht6gAmkrVmHykETmjDXXGJ+YbuhjB4E=;
        b=F8uURhwRZQBh28lOxtJ6eNg/Kbxf1khOExI7EODXGjYAtftlINqWdP/Yw0Ht7cRld3
         FVaF6cRLFVeYSHC14vKflwZBo+B9vTKitHmX2lV8HHljaVNvrL0QdTrxUPpwd/POjaB7
         dSMJFsHl1fYPLprK9z1r8Z/bBXMhWQLHVC0NB6lVC8LT7Huv3KT5CYka5GSuv94XuvVJ
         +0UYbopXF6SwMBi7OUtIJJtd1DVOTuM/merpCzfOJA4LnRABhbv055F8UgAqHYVTcIVf
         EqRvxJRksS11p1yc8/QoV1A09H/L5pJHuHZ+7CnQaY8MrCgStOIv/aoVqdSahdnk8Tn2
         w7RA==
X-Gm-Message-State: APjAAAU3sRGZV/eClO4zmqhY16iBoi2PROVsp3fjrTElIbVeYv3SN6Jh
        R9ISYj40DVDSQMtTpXbmmGcLBDq+
X-Google-Smtp-Source: APXvYqwKh290SGLNPqfYqy6Z0/nj0bAxV6JayEfwH4tt0ftPGyGHAEPcBqT7GUx8gNfjk6fItmFs/Q==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr68041747plo.28.1577705904341;
        Mon, 30 Dec 2019 03:38:24 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id i3sm49196117pfo.72.2019.12.30.03.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 03:38:23 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC,PATCH 1/6] mmc: Add UHS-II support in public headers
Date:   Mon, 30 Dec 2019 19:38:33 +0800
Message-Id: <20191230113833.37905-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
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
 include/linux/mmc/card.h |  2 ++
 include/linux/mmc/core.h |  6 ++++++
 include/linux/mmc/host.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9b6336ad3266..e12a2f533236 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -180,6 +180,8 @@ struct sd_switch_caps {
 #define SD_SET_CURRENT_LIMIT_400	1
 #define SD_SET_CURRENT_LIMIT_600	2
 #define SD_SET_CURRENT_LIMIT_800	3
+#define SD_SET_CURRENT_LIMIT_1000       4
+
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

