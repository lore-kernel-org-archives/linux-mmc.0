Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBEFC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3082078B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUzNqglx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJLJl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJLJk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:09:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408FC08C5CE;
        Fri, 10 Jul 2020 04:09:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so2467966pjb.5;
        Fri, 10 Jul 2020 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrjk59egYvJ8GHaDhNEmPkttWVMBNW7KFE/O0I7RbgU=;
        b=QUzNqglxDyl3W9xbqV8HFvms4cTt5/YRCkZS92phePxV51mPGY+TrJlA9ypsn4OmZC
         lCJ+pedP1VdzY6ARlSGgCFTdM6VUCNZVNed1X1SFPiKUTE+si9US1A/mLiVb34Mbswkv
         V94vIPJnktj/GfcL+SDqgaE2jkT5L9gUaPzby5zkQduwJkJa0oeih8lJUVQjsVizxAHX
         4AZ5pLZUUeiIr+irJkUpIXV6QxsMSnUoRRDr/CDol15FoC+stLiLtvANhvSQ6iQULYx9
         jHNOAdd7NWylU00scfEoMWeR0uOL3pbmXARwa2i2b0x3fqmTL0etScB8irDGnkn+Dznm
         Km5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrjk59egYvJ8GHaDhNEmPkttWVMBNW7KFE/O0I7RbgU=;
        b=DXFgI+1wXrKbpxuO4nWn8maA2j++386XiSH/IvciVG6FbOWGJPLr6bFo/0CXrHnPvs
         W2c2Dg0C9BzZnM2JDsdRpVWulqQzFQ8IpyPWhcVFABp/D0RZAEYocP+MRwmirMivyBmC
         nqNNJS8FchnGL2rzGwS2VPHah1hCBP5GHIy7ffKyoUBJgwESBD8AhTLL5OwARsgkD1os
         7ahQhlx+br2SaGpskaMTOyMjG+gQ5IIpttxyLk/gnZfSZuzajuHLH78R6jTcdNXPNW3C
         JNUVmzMpxS7Ion0wwxyoSN9O0L2zPGVkwBs5Ij7H69+bsQhGR3ABaFEIQ7KLUBJmEANM
         iKBg==
X-Gm-Message-State: AOAM531z0bIpLqSMFkzi6yYt7PJb4V+gyQ4xEluVQkAeXzxeocS5BMjt
        UICY8Jn+Mw9d7smft5b7DW4=
X-Google-Smtp-Source: ABdhPJw/a5gbf91VCcLli/FguBYGyagoU4SbODthswhegCQysjUdJGCPBFwA+LM4Fwyh2fZukwLeyQ==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr5164493pju.193.1594379379647;
        Fri, 10 Jul 2020 04:09:39 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id y65sm5630152pfb.75.2020.07.10.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:09:39 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 09/21] mmc: sdhci: add UHS-II related definitions in headers
Date:   Fri, 10 Jul 2020 19:10:21 +0800
Message-Id: <20200710111021.29397-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Add UHS-II related definitions in shdci.h and sdhci-uhs2.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.h | 215 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  91 +++++++++++++-
 2 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h

diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
new file mode 100644
index 000000000000..a7f53f95d69a
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller
+ *  Interface driver
+ *
+ * Header file for Host Controller UHS2 related registers and I/O accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef __SDHCI_UHS2_H
+#define __SDHCI_UHS2_H
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/uhs2.h>
+
+/*
+ * UHS-II Controller registers
+ * 0x74 preset in sdhci.h
+ * 0x80
+ * 0x84-0xB4
+ * 0xB8-0xCF
+ * 0xE0-0xE7
+ */
+/* UHS2 */
+#define SDHCI_UHS2_BLOCK_SIZE	0x80
+#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz) \
+	((((dma) & 0x7) << 12) | ((blksz) & 0xFFF))
+
+#define SDHCI_UHS2_BLOCK_COUNT	0x84
+
+#define SDHCI_UHS2_CMD_PACKET	0x88
+#define  SDHCI_UHS2_CMD_PACK_MAX_LEN	20
+
+#define SDHCI_UHS2_TRANS_MODE	0x9C
+#define  SDHCI_UHS2_TRNS_DMA		0x0001
+#define  SDHCI_UHS2_TRNS_BLK_CNT_EN	0x0002
+#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT	0x0010
+#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE	0x0020
+#define  SDHCI_UHS2_TRNS_RES_R5		0x0040
+#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	0x0080
+#define  SDHCI_UHS2_TRNS_RES_INT_DIS	0x0100
+#define  SDHCI_UHS2_TRNS_WAIT_EBSY	0x4000
+#define  SDHCI_UHS2_TRNS_2L_HD		0x8000
+
+#define SDHCI_UHS2_COMMAND	0x9E
+#define  SDHCI_UHS2_COMMAND_SUB_CMD	0x0004
+#define  SDHCI_UHS2_COMMAND_DATA	0x0020
+#define  SDHCI_UHS2_COMMAND_TRNS_ABORT	0x0040
+#define  SDHCI_UHS2_COMMAND_CMD12	0x0080
+#define  SDHCI_UHS2_COMMAND_DORMANT	0x00C0
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_MASK	0x1F00
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT	8
+
+#define SDHCI_UHS2_RESPONSE	0xA0
+#define  SDHCI_UHS2_RESPONSE_MAX_LEN	20
+
+#define SDHCI_UHS2_MSG_SELECT	0xB4
+#define SDHCI_UHS2_MSG_SELECT_CURR	0x0
+#define SDHCI_UHS2_MSG_SELECT_ONE	0x1
+#define SDHCI_UHS2_MSG_SELECT_TWO	0x2
+#define SDHCI_UHS2_MSG_SELECT_THREE	0x3
+
+#define SDHCI_UHS2_MSG		0xB8
+
+#define SDHCI_UHS2_DEV_INT_STATUS	0xBC
+
+#define SDHCI_UHS2_DEV_SELECT	0xBE
+#define SDHCI_UHS2_DEV_SELECT_DEV_SEL_MASK	0x0F
+#define SDHCI_UHS2_DEV_SELECT_INT_MSG_EN	0x80
+
+#define SDHCI_UHS2_DEV_INT_CODE	0xBF
+
+#define SDHCI_UHS2_SW_RESET	0xC0
+#define SDHCI_UHS2_SW_RESET_FULL	0x0001
+#define SDHCI_UHS2_SW_RESET_SD		0x0002
+
+#define SDHCI_UHS2_TIMER_CTRL	0xC2
+#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT	4
+
+#define SDHCI_UHS2_ERR_INT_STATUS		0xC4
+#define SDHCI_UHS2_ERR_INT_STATUS_EN		0xC8
+#define SDHCI_UHS2_ERR_INT_SIG_EN		0xCC
+#define SDHCI_UHS2_ERR_INT_STATUS_HEADER	0x00000001
+#define SDHCI_UHS2_ERR_INT_STATUS_RES		0x00000002
+#define SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP	0x00000004
+#define SDHCI_UHS2_ERR_INT_STATUS_CRC		0x00000008
+#define SDHCI_UHS2_ERR_INT_STATUS_FRAME		0x00000010
+#define SDHCI_UHS2_ERR_INT_STATUS_TID		0x00000020
+#define SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER	0x00000080
+#define SDHCI_UHS2_ERR_INT_STATUS_EBUSY		0x00000100
+#define SDHCI_UHS2_ERR_INT_STATUS_ADMA		0x00008000
+#define SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT	0x00010000
+#define SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT	0x00020000
+#define SDHCI_UHS2_ERR_INT_STATUS_VENDOR	0x08000000
+#define SDHCI_UHS2_ERR_INT_STATUS_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+#define SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
+/* CRC Error occurs during a packet receiving */
+#define SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+
+#define SDHCI_UHS2_SET_PTR	0xE0
+#define   SDHCI_UHS2_GEN_SET_POWER_LOW		0x0001
+#define   SDHCI_UHS2_GEN_SET_N_LANES_POS	8
+#define   SDHCI_UHS2_GEN_SET_2L_FD_HD		0x0
+#define   SDHCI_UHS2_GEN_SET_2D1U_FD		0x2
+#define   SDHCI_UHS2_GEN_SET_1D2U_FD		0x3
+#define   SDHCI_UHS2_GEN_SET_2D2U_FD		0x4
+
+#define   SDHCI_UHS2_PHY_SET_SPEED_POS		6
+#define   SDHCI_UHS2_PHY_SET_HIBER_EN		0x00008000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_MASK	0x000F0000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS	16
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_MASK	0x00F00000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS	20
+
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_MASK	0x0000FF00
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_POS		8
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_MASK	0x00030000
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS	16
+
+#define   SDHCI_UHS2_TRAN_SET_1_N_DAT_GAP_MASK	0x000000FF
+
+#define SDHCI_UHS2_HOST_CAPS_PTR	0xE2
+#define  SDHCI_UHS2_HOST_CAPS_GEN_OFFSET	0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK	0x0000000F
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK	0x000000F0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP(gap)	((gap) * 360)
+#define SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT 4
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK	0x00003F00
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT	8
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2L_HD_FD	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D1U_FD	2
+#define    SDHCI_UHS2_HOST_CAPS_GEN_1D2U_FD	4
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D2U_FD	8
+#define   SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64	0x00004000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BOOT		0x00008000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK	0x00030000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT	16
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_RMV	0
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB_RMV	2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_MASK		0x003C0000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_SHIFT	18
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_MASK	0x00C00000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_SHIFT	22
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_P2P		0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_RING	1
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB		2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB_RING	3
+
+#define  SDHCI_UHS2_HOST_CAPS_PHY_OFFSET	4
+#define   SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK		0x0000003F
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK		0x000000C0
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT		6
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_A		0
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_B		1
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK	0x000F0000
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK	0x00F00000
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT	20
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET	8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK	0x0000003F
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK		0x0000FF00
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT		8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK	0x00070000
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK	0xFFF00000
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT	20
+
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET	12
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK	0x000000FF
+
+#define SDHCI_UHS2_TEST_PTR	0xE4
+#define  SDHCI_UHS2_TEST_ERR_HEADER	0x00000001
+#define  SDHCI_UHS2_TEST_ERR_RES	0x00000002
+#define  SDHCI_UHS2_TEST_ERR_RETRY_EXP	0x00000004
+#define  SDHCI_UHS2_TEST_ERR_CRC	0x00000008
+#define  SDHCI_UHS2_TEST_ERR_FRAME	0x00000010
+#define  SDHCI_UHS2_TEST_ERR_TID	0x00000020
+#define  SDHCI_UHS2_TEST_ERR_UNRECOVER	0x00000080
+#define  SDHCI_UHS2_TEST_ERR_EBUSY	0x00000100
+#define  SDHCI_UHS2_TEST_ERR_ADMA	0x00008000
+#define  SDHCI_UHS2_TEST_ERR_RES_TIMEOUT	0x00010000
+#define  SDHCI_UHS2_TEST_ERR_DEADLOCK_TIMEOUT	0x00020000
+#define  SDHCI_UHS2_TEST_ERR_VENDOR	0x08000000
+
+#define SDHCI_UHS2_EMBED_CTRL	0xE6
+#define SDHCI_UHS2_VENDOR	0xE8
+
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
+
+#endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0008bbd27127..ecf55394ea46 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -43,8 +43,27 @@
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
+/*
+ * Defined in Host Version 4.10.
+ * 1 - R5 (SDIO)
+ * 0 - R1 (Memory)
+ */
+#define  SDHCI_TRNS_RES_TYPE		0x40
+#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
+#define  SDHCI_TRNS_RES_INT_DIS		0x0100
+
 #define SDHCI_COMMAND		0x0E
 #define  SDHCI_CMD_RESP_MASK	0x03
+
+/*
+ * Host Version 4.10 adds this bit to distinguish a main command or
+ * sub command.
+ * CMD53(SDIO) - main command
+ * CMD52(SDIO) - sub command which doesn't have data block or doesn't
+ * indicate busy.
+ */
+#define  SDHCI_CMD_SUB_CMD	0x04
+
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
@@ -60,11 +79,19 @@
 
 #define SDHCI_RESPONSE		0x10
 
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_OFFSET	0x10
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_SIZE	4
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_OFFSET	0x18
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_SIZE	8
+
 #define SDHCI_BUFFER		0x20
 
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	0x00000001
 #define  SDHCI_DATA_INHIBIT	0x00000002
+
+#define  SDHCI_DATA_HIGH_LVL_MASK	0x000000F0
+
 #define  SDHCI_DOING_WRITE	0x00000100
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
@@ -80,6 +107,13 @@
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
 #define  SDHCI_CMD_LVL		0x01000000
 
+#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
+#define  SDHCI_CMD_NOT_ISSUE_ERR	0x08000000
+#define  SDHCI_SUB_CMD_STATUS		0x10000000
+#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
+#define  SDHCI_UHS2_LANE_SYNC		0x40000000
+#define  SDHCI_UHS2_IF_DETECT		0x80000000
+
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
@@ -100,6 +134,11 @@
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
 
+/* VDD2 - UHS2 */
+#define  SDHCI_VDD2_POWER_ON		0x10
+#define  SDHCI_VDD2_POWER_180		0xA0
+#define  SDHCI_VDD2_POWER_120		0x80
+
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
 #define SDHCI_WAKE_UP_CONTROL	0x2B
@@ -110,7 +149,7 @@
 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
 #define  SDHCI_DIVIDER_HI_SHIFT	6
-#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_MASK		0xFF
 #define  SDHCI_DIV_MASK_LEN	8
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
@@ -139,6 +178,10 @@
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
 #define  SDHCI_INT_RETUNE	0x00001000
+
+/* Host Version 4.10 */
+#define  SDHCI_INT_FX_EVENT	0x00002000
+
 #define  SDHCI_INT_CQE		0x00004000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
@@ -152,6 +195,9 @@
 #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
 
+/* Host Version 4.0 */
+#define  SDHCI_INT_RESPONSE_ERROR	0x08000000
+
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
 
@@ -178,6 +224,9 @@
 #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
 #define  SDHCI_AUTO_CMD_INDEX	0x00000010
 
+/* Host Version 4.10 */
+#define  SDHCI_ACMD_RESPONSE_ERROR	0x0020
+
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
 #define   SDHCI_CTRL_UHS_SDR12		0x0000
@@ -186,6 +235,7 @@
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
+#define   SDHCI_CTRL_UHS_2		0x0007 /* UHS-2 */
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -194,9 +244,12 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_UHS2_INTERFACE_EN	0x0100 /* UHS-2 */
+#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
 #define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
+#define  SDHCI_CTRL_ASYNC_INT_EN	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -217,11 +270,13 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define SDHCI_CAPABILITIES_1	0x44
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_SUPPORT_UHS2	0x00000008 /* UHS-2 support */
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
@@ -230,19 +285,28 @@
 #define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
 #define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
 #define  SDHCI_CAN_DO_ADMA3	0x08000000
+#define  SDHCI_SUPPORT_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */
+#define  SDHCI_RSVD_FOR_VDD2    0x20000000 /* Rsvd for future VDD2 */
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_MAX_CURRENT		0x48
+#define SDHCI_MAX_CURRENT_1		0x4C
 #define  SDHCI_MAX_CURRENT_LIMIT	GENMASK(7, 0)
 #define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
 #define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
 #define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
+#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	GENMASK(7, 0) /* UHS2 */
 #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
 
 #define SDHCI_SET_ACMD12_ERROR	0x50
+/* Host Version 4.10 */
+#define SDHCI_SET_ACMD_RESPONSE_ERROR	0x20
 #define SDHCI_SET_INT_ERROR	0x52
+/* Host Version 4.10 */
+#define SDHCI_SET_INT_TUNING_ERROR	0x0400
+#define SDHCI_SET_INT_RESPONSE_ERROR	0x0800
 
 #define SDHCI_ADMA_ERROR	0x54
 
@@ -259,10 +323,16 @@
 #define SDHCI_PRESET_FOR_SDR104        0x6C
 #define SDHCI_PRESET_FOR_DDR50 0x6E
 #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
+
+/* TODO: 0x74 is used for UHS2 in 4.10. How about HS400? */
+/* UHS2 */
+#define SDHCI_PRESET_FOR_UHS2  0x74
 #define SDHCI_PRESET_DRV_MASK		GENMASK(15, 14)
 #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
 #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -653,6 +723,25 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 };
 
+struct sdhci_uhs2_ops {
+	/* UHS-2 support */
+	void	(*reset)(struct sdhci_host *host, u16 mask);
+	void	(*set_timeout)(struct sdhci_host *host);
+	void	(*set_transfer_mode)(struct sdhci_host *host,
+				     struct mmc_command *cmd);
+	void	(*send_command)(struct sdhci_host *host,
+				struct mmc_command *cmd);
+	void	(*finish_command)(struct sdhci_host *host);
+	void	(*do_set_ios)(struct sdhci_host *host, struct mmc_ios *ios);
+	int	(*do_detect_init)(struct sdhci_host *host);
+	int	(*do_set_reg)(struct sdhci_host *host, enum uhs2_act act);
+	void	(*irq)(struct sdhci_host *host);
+	int	(*add_host)(struct sdhci_host *host, u32 caps1);
+	void	(*remove_host)(struct sdhci_host *host, int dead);
+};
+
+extern struct sdhci_uhs2_ops sdhci_uhs2_ops;
+
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
 
 static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
-- 
2.27.0

