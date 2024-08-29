Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81518FC8C;
	Thu, 29 Aug 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926584; cv=none; b=VhCQjEtDDbW4wrobPZlDXV93ZHbolP+efQjTyqgopYLD0jwsnk1Jb73QR0zEjT+xH7OPMnOLNAMgh9JGLH/2TZZ5zKAW1B2TmBO5ZjmFSILIZlzQZyn1PoumUeSPerEGMSCQqIEK2yMSGc1vkjFhf5IdBEIl1Zeniym6J/7Dby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926584; c=relaxed/simple;
	bh=+sXmC7kyTGMKohOvh+2960PDmDNpZmnGORRSwgB2iKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpF8Kp66qxpG3/SyhE5Qq8ATIKizD79Pp8q7e7SLlBLg42SlP7gm5tUgf2GGJSQmsEwlciaMjF9me2BV/liO3fFwzbbgvDX8mCzvEUJPwMXzssYTaqRIQ4obAL4woI7BS6vNZuwy7B5ezMb+/Awny4GAk+Zfff2sB5hxIA96whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f12JufZB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f12JufZB"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714262f1bb4so398373b3a.3;
        Thu, 29 Aug 2024 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926582; x=1725531382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BiV+abCFUR4wsdfncjsvsUIyTpX7pruMJBcr6f4UWM=;
        b=f12JufZB6mpdUFuH731We6OdaB5onciSrclHUiV32PvXjedUIPS5arQV3t6VryKZzQ
         96zJ7NUM2SNILLEpyTsJ0BgGJ9ELCg2amjNNiHaKcKEjdl9XRn7a1x0iB0xp1tSPZ4Mb
         kUClN01ziNXgx+uMRv/AyHFOkN45UnnP3Xr89KJrJUof2dD6lueNrfmiZTqxtY/Ik2ld
         vTYhYxCcQzG9iw4rERUEJTVa96C89PqvbrGzQ2VBWqrfHTIIkGotdIKMHdI/skpQVLS8
         Wjmhz25pbG1piN/hcQDAwbK5ZO25d6kDaT0U56Y4KtviXgtTxE+FO4yxUZ0L3liBp2M6
         2g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926582; x=1725531382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BiV+abCFUR4wsdfncjsvsUIyTpX7pruMJBcr6f4UWM=;
        b=nC/J2kDY8a45+xtaAZoGJZ6OJdfNwthXqdVzzpfhZPTiRZOrJgF6Fu66lx5z+BLod3
         yW7qL6XvFgnLEPjhW1xr9wXXYFhsWr2/LznotAh5zcVBot5JlgA29d5vjxaE9NAQ3RzO
         nU1tve26zhiwBojfGdZwGwFU3eidOEKueK1LCZxCIGwA2yz9HTlzVySYxZkxTonlZwo0
         MnzGeEW//uKTjvav0NDYI+JictgH8AoVEqvT39dz2p3cjcYPwkpronK1EkbgHpi8vABz
         DQCdcon5VGyBF83TLQF2rzXKLcwEfDvXlXIbP61Ae1dIGPBql3R2pjH1jSqVK6UXdJul
         B7mA==
X-Forwarded-Encrypted: i=1; AJvYcCV3yO41Rp4Ux2WUFIlkq9p/C3j1x4sc6yRMhanVwCB0iYbggiJew46UnEN6as0p9TmppSoVkiYR/5YUliU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Wl/ot5FyWF7G3bzUdpNVks2vPw/rDxru603YFppcyW+ffj29
	ha14Fo4ckdmZgG0NY2LT5r4rfs4BENoepOpTaCb7SFpO6y9/EfKe
X-Google-Smtp-Source: AGHT+IG3rD1fX+44t3zwEYr9Jpai7R6nohc1AL6W+l/epqHFdld2dA+u/kkj1cRmfrNy9eCAHS9s/w==
X-Received: by 2002:a05:6a21:1706:b0:1c8:fe09:f8ce with SMTP id adf61e73a8af0-1cce1016036mr2132979637.32.1724926581503;
        Thu, 29 Aug 2024 03:16:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:16:21 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V19 08/22] mmc: sdhci: add UHS-II related definitions in headers
Date: Thu, 29 Aug 2024 18:15:25 +0800
Message-Id: <20240829101539.5058-9-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add UHS-II related definitions in sdhci.h and sdhci-uhs2.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V9:
 - Modify the commit message.

Updates in V8:
 - Use tabs instead of spaces.

Updates in V7:
 - Reorder values and positions of definitions.

Updates in V6:
 - Rename definitions.
 - Use BIT() GENMASK() instead of bitwise operations.

---

 drivers/mmc/host/sdhci-uhs2.h | 177 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  54 ++++++++++-
 2 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h

diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
new file mode 100644
index 000000000000..e993f41ffb7f
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller Interface driver
+ *
+ * Header file for Host Controller UHS2 related registers.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef __SDHCI_UHS2_H
+#define __SDHCI_UHS2_H
+
+#include <linux/bits.h>
+
+/* SDHCI Category C registers : UHS2 usage */
+
+#define  SDHCI_UHS2_CM_TRAN_RESP		0x10
+#define  SDHCI_UHS2_SD_TRAN_RESP		0x18
+#define  SDHCI_UHS2_SD_TRAN_RESP_1		0x1C
+
+/* SDHCI Category B registers : UHS2 only */
+
+#define SDHCI_UHS2_BLOCK_SIZE			0x80
+#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz)	((((dma) & 0x7) << 12) | ((blksz) & 0xFFF))
+
+#define SDHCI_UHS2_BLOCK_COUNT			0x84
+
+#define SDHCI_UHS2_CMD_PACKET			0x88
+#define  SDHCI_UHS2_CMD_PACK_MAX_LEN		20
+
+#define SDHCI_UHS2_TRANS_MODE			0x9C
+#define  SDHCI_UHS2_TRNS_DMA			BIT(0)
+#define  SDHCI_UHS2_TRNS_BLK_CNT_EN		BIT(1)
+#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT		BIT(4)
+#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE		BIT(5)
+#define  SDHCI_UHS2_TRNS_RES_R5			BIT(6)
+#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	BIT(7)
+#define  SDHCI_UHS2_TRNS_RES_INT_DIS		BIT(8)
+#define  SDHCI_UHS2_TRNS_WAIT_EBSY		BIT(14)
+#define  SDHCI_UHS2_TRNS_2L_HD			BIT(15)
+
+#define SDHCI_UHS2_CMD				0x9E
+#define  SDHCI_UHS2_CMD_SUB_CMD			BIT(2)
+#define  SDHCI_UHS2_CMD_DATA			BIT(5)
+#define  SDHCI_UHS2_CMD_TRNS_ABORT		BIT(6)
+#define  SDHCI_UHS2_CMD_CMD12			BIT(7)
+#define  SDHCI_UHS2_CMD_DORMANT			GENMASK(7, 6)
+#define  SDHCI_UHS2_CMD_PACK_LEN_MASK		GENMASK(12, 8)
+
+#define SDHCI_UHS2_RESPONSE			0xA0
+#define  SDHCI_UHS2_RESPONSE_MAX_LEN		20
+
+#define SDHCI_UHS2_MSG_SELECT			0xB4
+#define SDHCI_UHS2_MSG_SELECT_CURR		0x0
+#define SDHCI_UHS2_MSG_SELECT_ONE		0x1
+#define SDHCI_UHS2_MSG_SELECT_TWO		0x2
+#define SDHCI_UHS2_MSG_SELECT_THREE		0x3
+
+#define SDHCI_UHS2_MSG				0xB8
+
+#define SDHCI_UHS2_DEV_INT_STATUS		0xBC
+
+#define SDHCI_UHS2_DEV_SELECT			0xBE
+#define SDHCI_UHS2_DEV_SEL_MASK			GENMASK(3, 0)
+#define SDHCI_UHS2_DEV_SEL_INT_MSG_EN		BIT(7)
+
+#define SDHCI_UHS2_DEV_INT_CODE			0xBF
+
+#define SDHCI_UHS2_SW_RESET			0xC0
+#define SDHCI_UHS2_SW_RESET_FULL		BIT(0)
+#define SDHCI_UHS2_SW_RESET_SD			BIT(1)
+
+#define SDHCI_UHS2_TIMER_CTRL			0xC2
+#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK	GENMASK(7, 4)
+
+#define SDHCI_UHS2_INT_STATUS			0xC4
+#define SDHCI_UHS2_INT_STATUS_ENABLE		0xC8
+#define SDHCI_UHS2_INT_SIGNAL_ENABLE		0xCC
+#define SDHCI_UHS2_INT_HEADER_ERR		BIT(0)
+#define SDHCI_UHS2_INT_RES_ERR			BIT(1)
+#define SDHCI_UHS2_INT_RETRY_EXP		BIT(2)
+#define SDHCI_UHS2_INT_CRC			BIT(3)
+#define SDHCI_UHS2_INT_FRAME_ERR		BIT(4)
+#define SDHCI_UHS2_INT_TID_ERR			BIT(5)
+#define SDHCI_UHS2_INT_UNRECOVER		BIT(7)
+#define SDHCI_UHS2_INT_EBUSY_ERR		BIT(8)
+#define SDHCI_UHS2_INT_ADMA_ERROR		BIT(15)
+#define SDHCI_UHS2_INT_CMD_TIMEOUT		BIT(16)
+#define SDHCI_UHS2_INT_DEADLOCK_TIMEOUT		BIT(17)
+#define SDHCI_UHS2_INT_VENDOR_ERR		BIT(27)
+#define SDHCI_UHS2_INT_ERROR_MASK	       ( \
+		SDHCI_UHS2_INT_HEADER_ERR      | \
+		SDHCI_UHS2_INT_RES_ERR	       | \
+		SDHCI_UHS2_INT_RETRY_EXP       | \
+		SDHCI_UHS2_INT_CRC	       | \
+		SDHCI_UHS2_INT_FRAME_ERR       | \
+		SDHCI_UHS2_INT_TID_ERR	       | \
+		SDHCI_UHS2_INT_UNRECOVER       | \
+		SDHCI_UHS2_INT_EBUSY_ERR       | \
+		SDHCI_UHS2_INT_ADMA_ERROR      | \
+		SDHCI_UHS2_INT_CMD_TIMEOUT     | \
+		SDHCI_UHS2_INT_DEADLOCK_TIMEOUT)
+#define SDHCI_UHS2_INT_CMD_ERR_MASK	  ( \
+		SDHCI_UHS2_INT_HEADER_ERR | \
+		SDHCI_UHS2_INT_RES_ERR	  | \
+		SDHCI_UHS2_INT_FRAME_ERR  | \
+		SDHCI_UHS2_INT_TID_ERR	  | \
+		SDHCI_UHS2_INT_CMD_TIMEOUT)
+/* CRC Error occurs during a packet receiving */
+#define SDHCI_UHS2_INT_DATA_ERR_MASK	       ( \
+		SDHCI_UHS2_INT_RETRY_EXP       | \
+		SDHCI_UHS2_INT_CRC	       | \
+		SDHCI_UHS2_INT_UNRECOVER       | \
+		SDHCI_UHS2_INT_EBUSY_ERR       | \
+		SDHCI_UHS2_INT_ADMA_ERROR      | \
+		SDHCI_UHS2_INT_DEADLOCK_TIMEOUT)
+
+#define SDHCI_UHS2_SETTINGS_PTR			0xE0
+#define   SDHCI_UHS2_GEN_SETTINGS_POWER_LOW	BIT(0)
+#define   SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK	GENMASK(11, 8)
+#define   SDHCI_UHS2_FD_OR_2L_HD		0x0 /* 2 lanes */
+#define   SDHCI_UHS2_2D1U_FD			0x2 /* 3 lanes, 2 down, 1 up, full duplex */
+#define   SDHCI_UHS2_1D2U_FD			0x3 /* 3 lanes, 1 down, 2 up, full duplex */
+#define   SDHCI_UHS2_2D2U_FD			0x4 /* 4 lanes, 2 down, 2 up, full duplex */
+
+#define   SDHCI_UHS2_PHY_SET_SPEED_B		BIT(6)
+#define   SDHCI_UHS2_PHY_HIBERNATE_EN		BIT(12)
+#define   SDHCI_UHS2_PHY_N_LSS_SYN_MASK		GENMASK(19, 16)
+#define   SDHCI_UHS2_PHY_N_LSS_DIR_MASK		GENMASK(23, 20)
+
+#define   SDHCI_UHS2_TRAN_N_FCU_MASK		GENMASK(15, 8)
+#define   SDHCI_UHS2_TRAN_RETRY_CNT_MASK	GENMASK(17, 16)
+#define   SDHCI_UHS2_TRAN_1_N_DAT_GAP_MASK	GENMASK(7, 0)
+
+#define SDHCI_UHS2_CAPS_PTR			0xE2
+#define   SDHCI_UHS2_CAPS_OFFSET		0
+#define   SDHCI_UHS2_CAPS_DAP_MASK		GENMASK(3, 0)
+#define   SDHCI_UHS2_CAPS_GAP_MASK		GENMASK(7, 4)
+#define   SDHCI_UHS2_CAPS_GAP(gap)		((gap) * 360)
+#define   SDHCI_UHS2_CAPS_LANE_MASK		GENMASK(13, 8)
+#define   SDHCI_UHS2_CAPS_2L_HD_FD		1
+#define   SDHCI_UHS2_CAPS_2D1U_FD		2
+#define   SDHCI_UHS2_CAPS_1D2U_FD		4
+#define   SDHCI_UHS2_CAPS_2D2U_FD		8
+#define   SDHCI_UHS2_CAPS_ADDR_64		BIT(14)
+#define   SDHCI_UHS2_CAPS_BOOT			BIT(15)
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_MASK		GENMASK(17, 16)
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_RMV		0
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_EMB		1
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_EMB_RMV	2
+#define   SDHCI_UHS2_CAPS_NUM_DEV_MASK		GENMASK(21, 18)
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_MASK		GENMASK(23, 22)
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_SHIFT	22
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_P2P		0
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_RING		1
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_HUB		2
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_HUB_RING	3
+
+#define  SDHCI_UHS2_CAPS_PHY_OFFSET		4
+#define   SDHCI_UHS2_CAPS_PHY_REV_MASK		GENMASK(5, 0)
+#define   SDHCI_UHS2_CAPS_PHY_RANGE_MASK	GENMASK(7, 6)
+#define   SDHCI_UHS2_CAPS_PHY_RANGE_A		0
+#define   SDHCI_UHS2_CAPS_PHY_RANGE_B		1
+#define   SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK	GENMASK(19, 16)
+#define   SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK	GENMASK(23, 20)
+#define  SDHCI_UHS2_CAPS_TRAN_OFFSET		8
+#define   SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK	GENMASK(5, 0)
+#define   SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK	GENMASK(15, 8)
+#define   SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK	GENMASK(18, 16)
+#define   SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK	GENMASK(31, 20)
+
+#define  SDHCI_UHS2_CAPS_TRAN_1_OFFSET		12
+#define  SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK	GENMASK(7, 0)
+
+#define SDHCI_UHS2_EMBED_CTRL_PTR		0xE6
+#define SDHCI_UHS2_VENDOR_PTR			0xE8
+
+#endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f531b617f28d..e1013925e91e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -43,8 +43,23 @@
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
+/*
+ * Defined in Host Version 4.0.
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
+ * For example with SDIO, CMD52 (sub command) issued during CMD53 (main command).
+ */
+#define  SDHCI_CMD_SUB_CMD	0x04
+
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
@@ -65,6 +80,9 @@
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	0x00000001
 #define  SDHCI_DATA_INHIBIT	0x00000002
+
+#define  SDHCI_DAT_4_TO_7_LVL_MASK	0x000000F0
+
 #define  SDHCI_DOING_WRITE	0x00000100
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
@@ -80,6 +98,15 @@
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
 #define  SDHCI_CMD_LVL		0x01000000
 
+/* Host Version 4.10 */
+
+#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
+#define  SDHCI_CMD_NOT_ISSUED_ERR	0x08000000
+#define  SDHCI_SUB_CMD_STATUS		0x10000000
+#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
+#define  SDHCI_UHS2_LANE_SYNC		0x40000000
+#define  SDHCI_UHS2_IF_DETECT		0x80000000
+
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
@@ -117,7 +144,7 @@
 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
 #define  SDHCI_DIVIDER_HI_SHIFT	6
-#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_MASK		0xFF
 #define  SDHCI_DIV_MASK_LEN	8
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
@@ -146,6 +173,10 @@
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
@@ -160,6 +191,9 @@
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
 #define  SDHCI_INT_TUNING_ERROR	0x04000000
 
+/* Host Version 4.0 */
+#define  SDHCI_INT_RESP_ERR	0x08000000
+
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
 
@@ -186,6 +220,9 @@
 #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
 #define  SDHCI_AUTO_CMD_INDEX	0x00000010
 
+/* Host Version 4.10 */
+#define  SDHCI_AUTO_CMD_RESP_ERR	0x0020
+
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
 #define   SDHCI_CTRL_UHS_SDR12		0x0000
@@ -194,6 +231,7 @@
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
+#define   SDHCI_CTRL_UHS2		0x0007
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -202,9 +240,12 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_UHS2_ENABLE		0x0100
+#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
 #define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
+#define  SDHCI_CTRL_ASYNC_INT_ENABLE	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -227,11 +268,13 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define SDHCI_CAPABILITIES_1	0x44
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_SUPPORT_UHS2	0x00000008
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
@@ -240,6 +283,7 @@
 #define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
 #define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
 #define  SDHCI_CAN_DO_ADMA3	0x08000000
+#define  SDHCI_CAN_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_MAX_CURRENT		0x48
@@ -247,11 +291,14 @@
 #define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
 #define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
 #define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
+#define SDHCI_MAX_CURRENT_1		0x4C
+#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	GENMASK(7, 0) /* UHS2 */
 #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
 
 #define SDHCI_SET_ACMD12_ERROR	0x50
+/* Host Version 4.10 */
 #define SDHCI_SET_INT_ERROR	0x52
 
 #define SDHCI_ADMA_ERROR	0x54
@@ -270,10 +317,15 @@
 #define SDHCI_PRESET_FOR_SDR104        0x6C
 #define SDHCI_PRESET_FOR_DDR50 0x6E
 #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
+
+/* UHS2 */
+#define SDHCI_PRESET_FOR_UHS2  0x74
 #define SDHCI_PRESET_DRV_MASK		GENMASK(15, 14)
 #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
 #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
-- 
2.25.1

