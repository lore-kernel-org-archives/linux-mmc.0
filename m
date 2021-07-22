Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0B5C07E9D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A12608FC
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhGVDVR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhGVDVQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39857C061575;
        Wed, 21 Jul 2021 21:01:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p17so2993886plf.12;
        Wed, 21 Jul 2021 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfPohfF8CCjf5NRmHnHw+657LUcYbypd6xF6SZHF37I=;
        b=P029c22MDerUqTiWjwF8Mrf3LmxufU+EKl0bWZhACiC7GKGHDfiaI2/LIVRXtL+sTf
         C6q83vdCnEgJy02Tn/gZfC1uf8Zpx6MGHSKgO6BL4HQokeu6JUXwqgFbcHyKiTzUGa3L
         Xj3pKnrQARMpWNYveJ6hU52Brjocf+/odlHYSdCNS7rGnWd7/7zvnbGmvUAwGhSX3U7Z
         L2gSYcsIBhAd0dXqUfV26MG+9zcuKpcKAbVRYosAObnI6BaCs9N3cuOvjKzpydp8mWHV
         lhd+PIP2wLKp4j93RI9crNV0KdwfFCE18p/rz6kodfj9eji0ymN24fid8nlcszy+U8uj
         GaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfPohfF8CCjf5NRmHnHw+657LUcYbypd6xF6SZHF37I=;
        b=jeT2RanR0FldKa9lVH59E0X/HDcWS/DzeoF8X6eoONFQm9Bpt2lMwd5SEGAhypmD7M
         sZI2epc9VVPrTWPjzuwFMPxRqCdNTy0gfaSE5iDgt5fW1ouEP1dEwPB0/b/r4SOTKecK
         mjNzTGZNdAS4HnATlHdXbIbSj8VjPiOoA6ZDmvE8See8T0W2MGAbV2Co1R8RJZmNL0uT
         Mbob9YCAddsmSqbbc8Efjp0RHKw7kzn5YidcQCA5n4zg4cCV78YOI+cNE+f0foTP4tYV
         eakR8jfT3hoy2S3iRUlNT7Ykn/uXEc3YDY2KFiRqejvg+g5eI2Vs4TsVGH9jecSFninJ
         1/LQ==
X-Gm-Message-State: AOAM531O6jb3flFLE+KrhgZ7SMyzGvUPm78rML3YIc1v6SxBX1+IGJgV
        M0oQtq6O+bY+bbWRRkfozAHFe7Le4IjvHA==
X-Google-Smtp-Source: ABdhPJwVbE6wTsDNuITv9ld/T5p7mxMu3nbjO/hLseUCDSmi/1VEcqPGfRdGwzLezcmXPge4cXfU7w==
X-Received: by 2002:a63:e74c:: with SMTP id j12mr17896226pgk.121.1626926510663;
        Wed, 21 Jul 2021 21:01:50 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:01:50 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 01/29] mmc: add UHS-II related definitions in public headers
Date:   Thu, 22 Jul 2021 12:00:56 +0800
Message-Id: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
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
 include/linux/mmc/host.h |  31 +++++
 include/linux/mmc/uhs2.h | 268 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 include/linux/mmc/uhs2.h

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9ad35dd6012..4551a1280ee4 100644
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
index ab19245e9945..b698aa9cdb09 100644
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
index c7e7b43600e9..89a9e0e12f07 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -16,10 +16,12 @@
 #include <linux/mmc/pm.h>
 #include <linux/dma-direction.h>
 #include <linux/keyslot-manager.h>
+#include <linux/mmc/uhs2.h>

 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
 	unsigned short	vdd;
+	unsigned short	vdd2;			/* UHS2 VDD2 power supply */
 	unsigned int	power_delay_ms;		/* waiting for stable power */

 /* vdd stores the bit number of the selected voltage range from below. */
@@ -63,6 +65,7 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_HS400	10
 #define MMC_TIMING_SD_EXP	11
 #define MMC_TIMING_SD_EXP_1_2V	12
+#define MMC_TIMING_UHS2		13

 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */

@@ -190,6 +193,12 @@ struct mmc_host_ops {

 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	/* UHS2 interfaces */
+	int	(*uhs2_detect_init)(struct mmc_host *host);
+	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
+	void    (*uhs2_disable_clk)(struct mmc_host *host);
+	void    (*uhs2_enable_clk)(struct mmc_host *host);
 };

 struct mmc_cqe_ops {
@@ -282,6 +291,7 @@ struct mmc_pwrseq;

 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
+	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 };

@@ -302,10 +312,12 @@ struct mmc_host {
 	u32			ocr_avail_sdio;	/* SDIO-specific OCR */
 	u32			ocr_avail_sd;	/* SD-specific OCR */
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
+	u32			ocr_avail_uhs2;	/* UHS2-specific OCR */
 	struct wakeup_source	*ws;		/* Enable consume of uevents */
 	u32			max_current_330;
 	u32			max_current_300;
 	u32			max_current_180;
+	u32			max_current_180_vdd2; /* UHS2 vdd2 max curt. */

 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
@@ -324,6 +336,7 @@ struct mmc_host {
 #define MMC_VDD_33_34		0x00200000	/* VDD voltage 3.3 ~ 3.4 */
 #define MMC_VDD_34_35		0x00400000	/* VDD voltage 3.4 ~ 3.5 */
 #define MMC_VDD_35_36		0x00800000	/* VDD voltage 3.5 ~ 3.6 */
+#define MMC_VDD2_165_195	0x00000080	/* UHS2 VDD2 1.65 ~ 1.95 */

 	u32			caps;		/* Host capabilities */

@@ -357,6 +370,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_UHS2		(1 << 26)	/* Host supports UHS2 mode */
 #define MMC_CAP_DONE_COMPLETE	(1 << 27)	/* RW reqs can be completed within mmc_request_done() */
 #define MMC_CAP_CD_WAKE		(1 << 28)	/* Enable card detect wake */
 #define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
@@ -403,6 +417,17 @@ struct mmc_host {

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
@@ -603,6 +628,12 @@ static inline int mmc_card_uhs(struct mmc_card *card)
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
2.32.0
