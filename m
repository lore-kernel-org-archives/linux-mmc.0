Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E38BC4742C
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D8B2075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oauzL997"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgKFC2D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgKFC2A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90251C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:00 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 72so2928337pfv.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rs2NQ2R/CLVrSaNrKWwfnKbi/NM9OhIMM6b7UCwNMFY=;
        b=oauzL997EnIdbtWHF7KM9CFf+BHq2IQLY8cnE+ju+BvYC6VLWfp9zsR9vm4stEKmcX
         SMxla/i5VC5/1shgNJwWdNJ92HBZJsk/MeRxOUSPt2fQ2FWZd/9wFDxeu+xkSerAi/rr
         XXhVaEcGWuZ8IHM6GObjpIzHT4XYvDULPvVOnu5VzRlsuI7b9ihMxh4ONsQizOP4k40m
         ZoRxIZTmFeGaVvNxdCTOT4OtO+ChuL6ZjJOiRiShosOB8AwVZAgB8EVQd7mrRZX0i/63
         19haQ8JCVcndSYAUxOyqz8xa3GUxr1omGRQWovQZRRSQWn9NaucAFeVQBSG/fYwxWpz4
         Fzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rs2NQ2R/CLVrSaNrKWwfnKbi/NM9OhIMM6b7UCwNMFY=;
        b=HvmnRvGQqYzHrj2ST4nOYI66rYd2BuwUPJyC+KzMJwTJQqrf4CfoqAm5F3KSp+flqb
         fhT47Q/NjY4cpWtc5cZBaldDNY3T0WLPP7P0oE0Df4KdiasPJ5wcugGIPDP0wSKZWpZn
         MBWmTKJZbQfDWIFweQsIY/OwHojdcGL21fls4cq4oXEjrEsK1mk8MwhXteTUJgbPFB7J
         BVEq0vvzzAcydg7IzMI8zjnV506V8yUZ7a2JkwvAkAiFTfE5TevEKtvaQRwfVv747dC9
         eh7YeOsbiWGMmN4mUMa7EhRhXaOntDlTRhamO+pdAGBj7jkrKZ3ZQhz9VsviGRVJtmHv
         HPgw==
X-Gm-Message-State: AOAM532kqNTpOfbiCwLHDZULv0LJSdplPO6c0vwlFpLH3D1QlOUzyaJr
        MlJ8N26bL31SvhWk62lEbS02HQ==
X-Google-Smtp-Source: ABdhPJy5L+9nNJ/MD3KULv8ADzmwm8YCiIkn3OJcPFy+vYZ6FveDehs+Levj/znUSAyms6+I/MZldg==
X-Received: by 2002:a17:90a:ab8e:: with SMTP id n14mr14118pjq.88.1604629679988;
        Thu, 05 Nov 2020 18:27:59 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:27:59 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 01/27] mmc: add UHS-II related definitions in public headers
Date:   Fri,  6 Nov 2020 11:27:00 +0900
Message-Id: <20201106022726.19831-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add UHS-II support in public headers

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/mmc/card.h |   1 +
 include/linux/mmc/core.h |   6 +
 include/linux/mmc/host.h |  30 +++++
 include/linux/mmc/uhs2.h | 268 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 include/linux/mmc/uhs2.h

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 42df06c6b19c..c26eada7f62e 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -181,6 +181,7 @@ struct sd_switch_caps {
 #define SD_SET_CURRENT_LIMIT_400	1
 #define SD_SET_CURRENT_LIMIT_600	2
 #define SD_SET_CURRENT_LIMIT_800	3
+#define SD_SET_CURRENT_LIMIT_1000       4
 #define SD_SET_CURRENT_NO_CHANGE	(-1)
 
 #define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 29aa50711626..52cb628d03fd 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -7,6 +7,7 @@
 
 #include <linux/completion.h>
 #include <linux/types.h>
+#include <linux/mmc/uhs2.h>
 
 struct mmc_data;
 struct mmc_request;
@@ -109,6 +110,11 @@ struct mmc_command {
 	unsigned int		busy_timeout;	/* busy detect timeout in ms */
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
index c079b932330f..19a265190ad3 100644
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
 
@@ -173,6 +176,11 @@ struct mmc_host_ops {
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
@@ -265,6 +273,7 @@ struct mmc_pwrseq;
 
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
+	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 };
 
@@ -285,6 +294,7 @@ struct mmc_host {
 	u32			ocr_avail_sdio;	/* SDIO-specific OCR */
 	u32			ocr_avail_sd;	/* SD-specific OCR */
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
+	u32			ocr_avail_uhs2;	/* UHS2-specific OCR */
 #ifdef CONFIG_PM_SLEEP
 	struct notifier_block	pm_notify;
 #endif
@@ -292,6 +302,7 @@ struct mmc_host {
 	u32			max_current_330;
 	u32			max_current_300;
 	u32			max_current_180;
+	u32			max_current_180_vdd2; /* UHS2 vdd2 max curt. */
 
 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
@@ -310,6 +321,7 @@ struct mmc_host {
 #define MMC_VDD_33_34		0x00200000	/* VDD voltage 3.3 ~ 3.4 */
 #define MMC_VDD_34_35		0x00400000	/* VDD voltage 3.4 ~ 3.5 */
 #define MMC_VDD_35_36		0x00800000	/* VDD voltage 3.5 ~ 3.6 */
+#define MMC_VDD2_165_195	0x00000080	/* UHS2 VDD2 1.65 ~ 1.95 */
 
 	u32			caps;		/* Host capabilities */
 
@@ -343,6 +355,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_UHS2		(1 << 26)	/* Host supports UHS2 mode */
 #define MMC_CAP_DONE_COMPLETE	(1 << 27)	/* RW reqs can be completed within mmc_request_done() */
 #define MMC_CAP_CD_WAKE		(1 << 28)	/* Enable card detect wake */
 #define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
@@ -382,6 +395,17 @@ struct mmc_host {
 
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
@@ -578,6 +602,12 @@ static inline int mmc_card_uhs(struct mmc_card *card)
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
diff --git a/include/linux/mmc/uhs2.h b/include/linux/mmc/uhs2.h
new file mode 100644
index 000000000000..298ac7cd8904
--- /dev/null
+++ b/include/linux/mmc/uhs2.h
@@ -0,0 +1,268 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  linux/drivers/mmc/host/uhs2.h - UHS-II driver
+ *
+ * Header file for UHS-II packets, Host Controller registers and I/O
+ * accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef LINUX_MMC_UHS2_H
+#define LINUX_MMC_UHS2_H
+
+struct mmc_request;
+
+/* LINK Layer definition */
+/* UHS2 Header */
+#define UHS2_NATIVE_PACKET_POS	7
+#define UHS2_NATIVE_PACKET	(1 << UHS2_NATIVE_PACKET_POS)
+
+#define UHS2_PACKET_TYPE_POS	4
+#define UHS2_PACKET_TYPE_CCMD	(0 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_DCMD	(1 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_RES	(2 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_DATA	(3 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_MSG	(7 << UHS2_PACKET_TYPE_POS)
+
+#define UHS2_DEST_ID_MASK	0x0F
+#define UHS2_DEST_ID		0x1
+
+#define UHS2_SRC_ID_POS		12
+#define UHS2_SRC_ID_MASK	0xF000
+
+#define UHS2_TRANS_ID_POS	8
+#define UHS2_TRANS_ID_MASK	0x0700
+
+/* UHS2 MSG */
+#define UHS2_MSG_CTG_POS	5
+#define UHS2_MSG_CTG_LMSG	0x00
+#define UHS2_MSG_CTG_INT	0x60
+#define UHS2_MSG_CTG_AMSG	0x80
+
+#define UHS2_MSG_CTG_FCREQ	0x00
+#define UHS2_MSG_CTG_FCRDY	0x01
+#define UHS2_MSG_CTG_STAT	0x02
+
+#define UHS2_MSG_CODE_POS			8
+#define UHS2_MSG_CODE_FC_UNRECOVER_ERR		0x8
+#define UHS2_MSG_CODE_STAT_UNRECOVER_ERR	0x8
+#define UHS2_MSG_CODE_STAT_RECOVER_ERR		0x1
+
+/* TRANS Layer definition */
+
+/* Native packets*/
+#define UHS2_NATIVE_CMD_RW_POS	7
+#define UHS2_NATIVE_CMD_WRITE	(1 << UHS2_NATIVE_CMD_RW_POS)
+#define UHS2_NATIVE_CMD_READ	(0 << UHS2_NATIVE_CMD_RW_POS)
+
+#define UHS2_NATIVE_CMD_PLEN_POS	4
+#define UHS2_NATIVE_CMD_PLEN_4B		(1 << UHS2_NATIVE_CMD_PLEN_POS)
+#define UHS2_NATIVE_CMD_PLEN_8B		(2 << UHS2_NATIVE_CMD_PLEN_POS)
+#define UHS2_NATIVE_CMD_PLEN_16B	(3 << UHS2_NATIVE_CMD_PLEN_POS)
+
+#define UHS2_NATIVE_CCMD_GET_MIOADR_MASK	0xF00
+#define UHS2_NATIVE_CCMD_MIOADR_MASK		0x0F
+
+#define UHS2_NATIVE_CCMD_LIOADR_POS		8
+#define UHS2_NATIVE_CCMD_GET_LIOADR_MASK	0x0FF
+
+#define UHS2_DCMD_DM_POS	6
+#define UHS2_DCMD_2L_HD_MODE	(1 << UHS2_DCMD_DM_POS)
+#define UHS2_DCMD_LM_POS	5
+#define UHS2_DCMD_LM_TLEN_EXIST	(1 << UHS2_DCMD_LM_POS)
+#define UHS2_DCMD_TLUM_POS	4
+#define UHS2_DCMD_TLUM_BYTE_MODE	(1 << UHS2_DCMD_TLUM_POS)
+#define UHS2_NATIVE_DCMD_DAM_POS	3
+#define UHS2_NATIVE_DCMD_DAM_IO		(1 << UHS2_NATIVE_DCMD_DAM_POS)
+/*
+ * Per UHS2 spec, DCMD payload should be MSB first. There may be
+ * two types of data be assembled to MSB:
+ * 1. TLEN: Input block size for single read/write and number of blocks
+ * for multiple read/write to calculate TLEN as MSB first per spec.
+ * 2. SD command argument.
+ */
+static inline u32 uhs2_dcmd_convert_msb(u32 input)
+{
+	u32 ret = 0;
+
+	ret = ((input & 0xFF) << 24) |
+		(((input >> 8) & 0xFF) << 16) |
+		(((input >> 16) & 0xFF) << 8) |
+		((input >> 24) & 0xFF);
+	return ret;
+}
+
+#define UHS2_RES_NACK_POS	7
+#define UHS2_RES_NACK_MASK	(0x1 << UHS2_RES_NACK_POS)
+
+#define UHS2_RES_ECODE_POS	4
+#define UHS2_RES_ECODE_MASK	0x7
+#define UHS2_RES_ECODE_COND	1
+#define UHS2_RES_ECODE_ARG	2
+#define UHS2_RES_ECODE_GEN	3
+
+/* IOADR of device registers */
+#define UHS2_IOADR_GENERIC_CAPS		0x00
+#define UHS2_IOADR_PHY_CAPS		0x02
+#define UHS2_IOADR_LINK_CAPS		0x04
+#define UHS2_IOADR_RSV_CAPS		0x06
+#define UHS2_IOADR_GENERIC_SETTINGS	0x08
+#define UHS2_IOADR_PHY_SETTINGS		0x0A
+#define UHS2_IOADR_LINK_SETTINGS	0x0C
+#define UHS2_IOADR_PRESET		0x40
+
+/* SD application packets */
+#define UHS2_SD_CMD_INDEX_POS		8
+
+#define UHS2_SD_CMD_APP_POS		14
+#define UHS2_SD_CMD_APP			(1 << UHS2_SD_CMD_APP_POS)
+
+struct uhs2_command {
+	u16	header;
+	u16	arg;
+	u32	*payload;
+	u32	payload_len;
+	u32	packet_len;
+};
+
+struct uhs2_host_caps {
+	u32	dap;
+	u32	gap;
+	u32	maxblk_len;
+	u32	n_fcu;
+	u8	n_lanes;
+	u8	addr64;
+	u8	card_type;
+	u8	phy_rev;
+	u8	speed_range;
+	u8	can_hibernate;
+	u8	n_lss_sync;
+	u8	n_lss_dir;
+	u8	link_rev;
+	u8	host_type;
+	u8	n_data_gap;
+
+	u32	maxblk_len_set;
+	u32	n_fcu_set;
+	u8	n_lanes_set;
+	u8	n_lss_sync_set;
+	u8	n_lss_dir_set;
+	u8	n_data_gap_set;
+	u8	max_retry_set;
+};
+
+struct uhs2_card_prop {
+	u32	node_id;
+	u32	dap;
+	u32	gap;
+	u32	n_fcu;
+	u32	maxblk_len;
+	u8	n_lanes;
+	u8	dadr_len;
+	u8	app_type;
+	u8	phy_minor_rev;
+	u8	phy_major_rev;
+	u8	can_hibernate;
+	u8	n_lss_sync;
+	u8	n_lss_dir;
+	u8	link_minor_rev;
+	u8	link_major_rev;
+	u8	dev_type;
+	u8	n_data_gap;
+
+	u32	n_fcu_set;
+	u32	maxblk_len_set;
+	u8	n_lanes_set;
+	u8	speed_range_set;
+	u8	n_lss_sync_set;
+	u8	n_lss_dir_set;
+	u8	n_data_gap_set;
+	u8	pwrctrl_mode_set;
+	u8	max_retry_set;
+
+	u8	cfg_complete;
+};
+
+enum uhs2_act {
+	SET_CONFIG,
+	ENABLE_INT,
+	DISABLE_INT,
+	SET_SPEED_B,
+	CHECK_DORMANT,
+};
+
+/* UHS-II Device Registers */
+#define UHS2_DEV_CONFIG_REG	0x000
+
+/* General Caps and Settings registers */
+#define  UHS2_DEV_CONFIG_GEN_CAPS	(UHS2_DEV_CONFIG_REG + 0x000)
+#define   UHS2_DEV_CONFIG_N_LANES_POS	8
+#define   UHS2_DEV_CONFIG_N_LANES_MASK	0x3F
+#define   UHS2_DEV_CONFIG_2L_HD_FD	0x1
+#define   UHS2_DEV_CONFIG_2D1U_FD	0x2
+#define   UHS2_DEV_CONFIG_1D2U_FD	0x4
+#define   UHS2_DEV_CONFIG_2D2U_FD	0x8
+#define   UHS2_DEV_CONFIG_DADR_POS	14
+#define   UHS2_DEV_CONFIG_DADR_MASK	0x1
+#define   UHS2_DEV_CONFIG_APP_POS	16
+#define   UHS2_DEV_CONFIG_APP_MASK	0xFF
+#define   UHS2_DEV_CONFIG_APP_SD_MEM	0x1
+
+#define  UHS2_DEV_CONFIG_GEN_SET	(UHS2_DEV_CONFIG_REG + 0x008)
+#define   UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD	0x0
+#define   UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE	(0x1 << 31)
+
+/* PHY Caps and Settings registers */
+#define  UHS2_DEV_CONFIG_PHY_CAPS	(UHS2_DEV_CONFIG_REG + 0x002)
+#define   UHS2_DEV_CONFIG_PHY_MINOR_MASK	0xF
+#define   UHS2_DEV_CONFIG_PHY_MAJOR_POS		4
+#define   UHS2_DEV_CONFIG_PHY_MAJOR_MASK	0x3
+#define   UHS2_DEV_CONFIG_CAN_HIBER_POS		15
+#define   UHS2_DEV_CONFIG_CAN_HIBER_MASK	0x1
+#define  UHS2_DEV_CONFIG_PHY_CAPS1	(UHS2_DEV_CONFIG_REG + 0x003)
+#define   UHS2_DEV_CONFIG_N_LSS_SYN_MASK	0xF
+#define   UHS2_DEV_CONFIG_N_LSS_DIR_POS		4
+#define   UHS2_DEV_CONFIG_N_LSS_DIR_MASK	0xF
+
+#define  UHS2_DEV_CONFIG_PHY_SET	(UHS2_DEV_CONFIG_REG + 0x00A)
+#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_POS	6
+#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_A	0x0
+#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_B	0x1
+
+/* LINK-TRAN Caps and Settings registers */
+#define  UHS2_DEV_CONFIG_LINK_TRAN_CAPS	(UHS2_DEV_CONFIG_REG + 0x004)
+#define   UHS2_DEV_CONFIG_LT_MINOR_MASK		0xF
+#define   UHS2_DEV_CONFIG_LT_MAJOR_POS		4
+#define   UHS2_DEV_CONFIG_LT_MAJOR_MASK		0x3
+#define   UHS2_DEV_CONFIG_N_FCU_POS		8
+#define   UHS2_DEV_CONFIG_N_FCU_MASK		0xFF
+#define   UHS2_DEV_CONFIG_DEV_TYPE_POS		16
+#define   UHS2_DEV_CONFIG_DEV_TYPE_MASK		0x7
+#define   UHS2_DEV_CONFIG_MAX_BLK_LEN_POS	20
+#define   UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK	0xFFF
+#define  UHS2_DEV_CONFIG_LINK_TRAN_CAPS1	(UHS2_DEV_CONFIG_REG + 0x005)
+#define   UHS2_DEV_CONFIG_N_DATA_GAP_MASK	0xFF
+
+#define  UHS2_DEV_CONFIG_LINK_TRAN_SET	(UHS2_DEV_CONFIG_REG + 0x00C)
+#define   UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN	0x200
+#define   UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS	16
+
+/* Preset register */
+#define  UHS2_DEV_CONFIG_PRESET		(UHS2_DEV_CONFIG_REG + 0x040)
+
+#define UHS2_DEV_INT_REG	0x100
+
+#define UHS2_DEV_STATUS_REG	0x180
+
+#define UHS2_DEV_CMD_REG	0x200
+#define  UHS2_DEV_CMD_FULL_RESET	(UHS2_DEV_CMD_REG + 0x000)
+#define  UHS2_DEV_CMD_GO_DORMANT_STATE	(UHS2_DEV_CMD_REG + 0x001)
+#define   UHS2_DEV_CMD_DORMANT_HIBER	(0x1 << 7)
+#define  UHS2_DEV_CMD_DEVICE_INIT	(UHS2_DEV_CMD_REG + 0x002)
+#define  UHS2_DEV_CMD_ENUMERATE		(UHS2_DEV_CMD_REG + 0x003)
+#define  UHS2_DEV_CMD_TRANS_ABORT	(UHS2_DEV_CMD_REG + 0x004)
+
+#define UHS2_RCLK_MAX	52000000
+#define UHS2_RCLK_MIN	26000000
+
+#endif /* LINUX_MMC_UHS2_H */
-- 
2.28.0

