Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0FBC5517A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3F42075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gub5R1xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgKFC2M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgKFC2K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:10 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D4C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:10 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so2766319pgb.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEz5g8KambMO+YomToeTwwGi5o4dVxKAW2kp+c3jt80=;
        b=Gub5R1xaOiX94jnd9N5AYGsvGulWLQdWqFYdB06uro+yz3o7zo2CZZUpWkUc1Xzz7Q
         /tVETsuky8k7M/cViaYLvp3fwpgWTHXqeCmBeYRyKQnJScg3++0Vca/rJV94FwozQqf/
         utbc8egF7m+o6JeZyYY8WZXi6mfii88rYUsCCTxkZYJ/e/MFX6Xf8aA/AAewNjcwXgCp
         ZV+6x3jRPMfQT/QYISJUGS3ffZl1Yi38vAT79sRSHG46dVsiUv5c+25qfWiSEEnSGxIP
         TRwFJ1HJGf29KsNA9lNpfWa2RrXFUkX7fj3pKNYjcBwqxpiaTSylSkYcrDNhjzoXXVKi
         QRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEz5g8KambMO+YomToeTwwGi5o4dVxKAW2kp+c3jt80=;
        b=MzbbiJyebhJ1WsxSiR81WNYSPzDcLfHUe4wEi0V0VsKqjVr1mK8h3tQAQ3z7E6zueh
         QG/1iZFVfojTcGoSwphhPxwSiIwq80gn5CrnTJsmNt5kObhoWCs6HNw5jQzb9YJLwQfe
         3tbiXymsuWUkAwlgfPpXxmRCIQfe+8pnatHS3DS56d1vhL8vve90roOMEmqTgXE2R0X5
         vgGwAvYK9nXGVx6Mow8wMxAzxTaZQUsLVv4rkwLzSIvaOEWx7F5OqQJY3Y5/1FoxombE
         4vWNn+4mIvyDL2M6yN7ljeGjADmwh5cQtUCCS7eRAjME3u1XbWe54UDPDT3/k1MYSQAr
         XHog==
X-Gm-Message-State: AOAM5319ePgykQ7b1RgwzzCq+pSjI52qeiY8TDpiP0D1dY64OhmaoTka
        z9N2A+aMq18iCF1W71iyH1cHhQ==
X-Google-Smtp-Source: ABdhPJwBBiJTlWClYKfpMqiTA57eplZx/9us6L3LtAMOGjpZ1I/ea2g2RI0i4Cewl4ckIH3T/tVcJQ==
X-Received: by 2002:aa7:8bdd:0:b029:18b:9cb:dead with SMTP id s29-20020aa78bdd0000b029018b09cbdeadmr5302005pfd.24.1604629689683;
        Thu, 05 Nov 2020 18:28:09 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:08 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 04/27] mmc: core: UHS-II support, try to select UHS-II interface
Date:   Fri,  6 Nov 2020 11:27:03 +0900
Message-Id: <20201106022726.19831-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The flow of "interface selection and initialization" was a bit modified
for UHS-II card. This commit follows the sequence defined in SD
specification (Part 1).
See section 7.2.3 in "UHS-II Simplified Addendum."

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/Makefile |   2 +-
 drivers/mmc/core/bus.c    |   5 +-
 drivers/mmc/core/core.c   |  33 +-
 drivers/mmc/core/sd.c     |  26 ++
 drivers/mmc/core/uhs2.c   | 809 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h   |  20 +
 6 files changed, 891 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 95ffe008ebdf..e2a90dc98afc 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,7 +8,7 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   slot-gpio.o regulator.o
+				   slot-gpio.o regulator.o uhs2.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
 obj-$(CONFIG_PWRSEQ_SD8787)	+= pwrseq_sd8787.o
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c2e70b757dd1..02dcdce54547 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -362,8 +362,9 @@ int mmc_add_card(struct mmc_card *card)
 	} else {
 		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
+			mmc_card_uhs2(card) ? "ultra high speed 2 " :
+			(mmc_card_uhs(card) ? "ultra high speed 1 " :
+			(mmc_card_hs(card) ? "high speed " : "")),
 			mmc_card_hs400(card) ? "HS400 " :
 			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4e12bd98fc08..a08cb1c0f6d2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -31,6 +31,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
@@ -41,6 +42,7 @@
 #include "host.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
+#include "uhs2.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -51,6 +53,7 @@
 #define SD_DISCARD_TIMEOUT_MS	(250)
 
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
+static const unsigned int uhs2_freqs[] = { 52000000, 26000000 };
 
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
@@ -2176,9 +2179,10 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 		if (!mmc_attach_sdio(host))
 			return 0;
 
-	if (!(host->caps2 & MMC_CAP2_NO_SD))
+	if (!(host->caps2 & MMC_CAP2_NO_SD)) {
 		if (!mmc_attach_sd(host))
 			return 0;
+	}
 
 	if (!(host->caps2 & MMC_CAP2_NO_MMC))
 		if (!mmc_attach_mmc(host))
@@ -2311,6 +2315,33 @@ void mmc_rescan(struct work_struct *work)
 		goto out;
 	}
 
+	if (host->caps & MMC_CAP_UHS2) {
+		/*
+		 * Start to try UHS-II initialization from 52MHz to 26MHz
+		 * (RCLK range) per spec.
+		 */
+		for (i = 0; i < ARRAY_SIZE(uhs2_freqs); i++) {
+			unsigned int freq = uhs2_freqs[i];
+			int err;
+
+			err = mmc_uhs2_rescan_try_freq(host,
+						       max(freq, host->f_min));
+			if (!err) {
+				mmc_release_host(host);
+				goto out;
+			}
+
+			if (err == UHS2_PHY_INIT_ERR)
+				/* UHS2 IF detect or Lane Sync error.
+				 * Try legacy interface.
+				 */
+				break;
+
+			if (freq <= host->f_min)
+				break;
+		}
+	}
+
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
 		unsigned int freq = freqs[i];
 		if (freq > host->f_max) {
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f054c449d46..54e155ff44ff 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -931,6 +931,20 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 		err = mmc_read_switch(card);
 		if (err)
 			return err;
+		if (host->flags & MMC_UHS2_INITIALIZED) {
+			u8 status[64];
+			/*
+			 * send CMD6 to set Maximum Power Consumption
+			 * to get better performance
+			 */
+			err = mmc_sd_switch(card, 0, 3,
+					    SD_SET_CURRENT_LIMIT_1000, status);
+			if (!err) {
+				err = mmc_sd_switch(card, 1, 3,
+						    SD_SET_CURRENT_LIMIT_1000,
+						    status);
+			}
+		}
 	}
 
 	/*
@@ -1073,6 +1087,11 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto free_card;
 
+	/* For UHS2, skip the UHS-I initialization. */
+	if ((host->flags & MMC_UHS2_SUPPORT) &&
+	    (host->flags & MMC_UHS2_INITIALIZED))
+		goto done;
+
 	/*
 	 * If the card has not been power cycled, it may still be using 1.8V
 	 * signaling. Detect that situation and try to initialize a UHS-I (1.8V)
@@ -1364,6 +1383,13 @@ int mmc_attach_sd(struct mmc_host *host)
 
 	rocr = mmc_select_voltage(host, ocr);
 
+	/*
+	 * Some cards have zero value of rocr in UHS-II mode. Assign host's ocr
+	 * value to rocr.
+	 */
+	if ((host->flags & MMC_UHS2_INITIALIZED) && !rocr)
+		rocr = host->ocr_avail;
+
 	/*
 	 * Can we support the voltage(s) of the card(s)?
 	 */
diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
new file mode 100644
index 000000000000..acb46b5b57ef
--- /dev/null
+++ b/drivers/mmc/core/uhs2.c
@@ -0,0 +1,809 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/core/uhs2.c - UHS-II driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *  Copyright (C) 2020 Genesys Logic, Inc.
+ *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *  Copyright (C) 2020 Linaro Limited
+ *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <asm/byteorder.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
+
+#include "uhs2.h"
+#include "mmc_ops.h"
+#include "sd_ops.h"
+#include "core.h"
+
+#define DBG(f, x...) \
+	pr_warn("[%s()]: " f, __func__, ## x)
+
+/**
+ * uhs2_cmd_assemble - assemble and build up uhs2 command
+ * @cmd:	MMC command
+ * @uhs2_cmd:	UHS2 command
+ * @header:	Value of packet header
+ * @arg:	Argument of packet
+ * @payload:	Payload of packet
+ * @plen:	Payload length
+ * @resp:	Buffer for response
+ * @resp_len:	Response buffer length
+ *
+ * resp is inputted outside which should be a variable created by caller
+ * so caller should handle it. For SD command, there is no uhs2_resp and
+ * response should be stored in resp of mmc_command.
+ */
+static void uhs2_cmd_assemble(struct mmc_command *cmd,
+			      struct uhs2_command *uhs2_cmd,
+			      u16 header, u16 arg,
+			      u32 *payload, u8 plen, u8 *resp, u8 resp_len)
+{
+	uhs2_cmd->header = header;
+	uhs2_cmd->arg = arg;
+	uhs2_cmd->payload = payload;
+	uhs2_cmd->payload_len = plen * sizeof(u32);
+	uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
+
+	cmd->uhs2_cmd = uhs2_cmd;
+	cmd->uhs2_resp = resp;
+	cmd->uhs2_resp_len = resp_len;
+
+	pr_debug("%s: uhs2_cmd: header=0x%x arg=0x%x\n",
+		 __func__, uhs2_cmd->header, uhs2_cmd->arg);
+	pr_debug("%s:           payload_len=%d packet_len=%d resp_len=%d\n",
+		 __func__, uhs2_cmd->payload_len, uhs2_cmd->packet_len,
+		cmd->uhs2_resp_len);
+}
+
+static int uhs2_dev_init(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u32 cnt;
+	u32 dap, gap, gap1;
+	u16 header = 0, arg = 0;
+	u32 payload[1];
+	u8 plen = 1;
+	u8 gd = 0, cf = 1;
+	u8 resp[6] = {0};
+	u8 resp_len = 6;
+	int err;
+
+	dap = host->uhs2_caps.dap;
+	gap = host->uhs2_caps.gap;
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_DEVICE_INIT >> 8);
+
+	/* need this for some cards */
+	cmd.busy_timeout = 1000;
+
+	for (cnt = 0; cnt < 30; cnt++) {
+		payload[0] = ((dap & 0xF) << 12) |
+			(cf << 11) |
+			((gd & 0xF) << 4) |
+			(gap & 0xF);
+
+		uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
+				  payload, plen, resp, resp_len);
+
+		DBG("Begin DEVICE_INIT, header=0x%x, arg=0x%x, payload=0x%x.\n",
+		    header, arg, payload[0]);
+
+		DBG("Sending DEVICE_INIT. Count = %d\n", cnt);
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
+			int i;
+
+			pr_warn("%s: DEVICE_INIT response is: ",
+				mmc_hostname(host));
+			for (i = 0; i < resp_len; i++)
+				pr_warn("0x%x ", resp[i]);
+			pr_warn("\n");
+		}
+
+		if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
+			pr_err("%s: DEVICE_INIT response is wrong!\n",
+			       mmc_hostname(host));
+			return -EIO;
+		}
+
+		if (resp[5] & 0x8) {
+			DBG("CF is set, device is initialized!\n");
+			host->group_desc = gd;
+			break;
+		}
+		gap1 = resp[4] & 0x0F;
+		if (gap == gap1)
+			gd++;
+	}
+	if (cnt == 30) {
+		pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
+		       mmc_hostname(host));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int uhs2_enum(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 payload[1];
+	u8 plen = 1;
+	u8 id_f = 0xF, id_l = 0x0;
+	u8 resp[8] = {0};
+	u8 resp_len = 8;
+	int err;
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_ENUMERATE >> 8);
+
+	payload[0] = (id_f << 4) | id_l;
+
+	DBG("Begin ENUMERATE, header=0x%x, arg=0x%x, payload=0x%x.\n",
+	    header, arg, payload[0]);
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
+			  resp, resp_len);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
+		int i;
+
+		pr_warn("%s: ENUMERATE response is: ", mmc_hostname(host));
+		for (i = 0; i < resp_len; i++)
+			pr_warn("0x%x ", resp[i]);
+		pr_warn("\n");
+	}
+
+	if (resp[3] != (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
+		pr_err("%s: ENUMERATE response is wrong!\n",
+		       mmc_hostname(host));
+		return -EIO;
+	}
+
+	id_f = (resp[4] >> 4) & 0xF;
+	id_l = resp[4] & 0xF;
+	DBG("id_f = %d, id_l = %d.\n", id_f, id_l);
+	DBG("Enumerate Cmd Completed. No. of Devices connected = %d\n",
+	    id_l - id_f + 1);
+	host->uhs2_dev_prop.node_id = id_f;
+
+	return 0;
+}
+
+static int uhs2_config_read(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 cap;
+	int err;
+
+	DBG("INQUIRY_CFG: read Generic Caps.\n");
+	header = UHS2_NATIVE_PACKET |
+		 UHS2_PACKET_TYPE_CCMD |
+		 host->uhs2_dev_prop.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CONFIG_GEN_CAPS >> 8);
+
+	DBG("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n",
+	    header, arg);
+	/* There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
+		int i;
+
+		pr_warn("%s: INQUIRY_CFG generic response is: ",
+			mmc_hostname(host));
+		for (i = 0; i < 2; i++)
+			pr_warn("0x%x ", cmd.resp[i]);
+		pr_warn("\n");
+	}
+
+	cap = cmd.resp[0];
+	DBG("Device Generic Caps (0-31) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.n_lanes = (cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
+					UHS2_DEV_CONFIG_N_LANES_MASK;
+	host->uhs2_dev_prop.dadr_len = (cap >> UHS2_DEV_CONFIG_DADR_POS) &
+					UHS2_DEV_CONFIG_DADR_MASK;
+	host->uhs2_dev_prop.app_type = (cap >> UHS2_DEV_CONFIG_APP_POS) &
+					UHS2_DEV_CONFIG_APP_MASK;
+
+	DBG("INQUIRY_CFG: read PHY Caps.\n");
+	arg = ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_PHY_CAPS >> 8);
+
+	DBG("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n",
+	    header, arg);
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
+		int i;
+
+		pr_warn("%s: INQUIRY_CFG PHY response is: ",
+			mmc_hostname(host));
+		for (i = 0; i < 2; i++)
+			pr_warn("0x%x ", cmd.resp[i]);
+		pr_warn("\n");
+	}
+
+	cap = cmd.resp[0];
+	DBG("Device PHY Caps (0-31) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.phy_minor_rev = cap &
+					UHS2_DEV_CONFIG_PHY_MINOR_MASK;
+	host->uhs2_dev_prop.phy_major_rev = (cap >>
+					UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
+					UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
+	host->uhs2_dev_prop.can_hibernate = (cap >>
+					UHS2_DEV_CONFIG_CAN_HIBER_POS) &
+					UHS2_DEV_CONFIG_CAN_HIBER_MASK;
+
+	cap = cmd.resp[1];
+	DBG("Device PHY Caps (32-63) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.n_lss_sync = cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+	host->uhs2_dev_prop.n_lss_dir = (cap >>
+					UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
+					UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+	if (host->uhs2_dev_prop.n_lss_sync == 0)
+		host->uhs2_dev_prop.n_lss_sync = 16 << 2;
+	else
+		host->uhs2_dev_prop.n_lss_sync <<= 2;
+
+	if (host->uhs2_dev_prop.n_lss_dir == 0)
+		host->uhs2_dev_prop.n_lss_dir = 16 << 3;
+	else
+		host->uhs2_dev_prop.n_lss_dir <<= 3;
+
+	DBG("INQUIRY_CFG: read LINK-TRAN Caps.\n");
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
+
+	DBG("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n",
+	    header, arg);
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
+		int i;
+
+		pr_warn("%s: INQUIRY_CFG Link-Tran response is: ",
+			mmc_hostname(host));
+		for (i = 0; i < 2; i++)
+			pr_warn("0x%x ", cmd.resp[i]);
+		pr_warn("\n");
+	}
+
+	cap = cmd.resp[0];
+	DBG("Device LINK-TRAN Caps (0-31) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.link_minor_rev = cap &
+					UHS2_DEV_CONFIG_LT_MINOR_MASK;
+	host->uhs2_dev_prop.link_major_rev = (cap >>
+					UHS2_DEV_CONFIG_LT_MAJOR_POS) &
+					UHS2_DEV_CONFIG_LT_MAJOR_MASK;
+	host->uhs2_dev_prop.n_fcu = (cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
+					UHS2_DEV_CONFIG_N_FCU_MASK;
+	host->uhs2_dev_prop.dev_type = (cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
+					UHS2_DEV_CONFIG_DEV_TYPE_MASK;
+	host->uhs2_dev_prop.maxblk_len = (cap >>
+					UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) &
+					UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
+
+	cap = cmd.resp[1];
+	DBG("Device LINK-TRAN Caps (32-63) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.n_data_gap = cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
+	if (host->uhs2_dev_prop.n_fcu == 0)
+		host->uhs2_dev_prop.n_fcu = 256;
+
+	return 0;
+}
+
+static int uhs2_config_write(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 nTry;
+	u32 payload[2];
+	u8 nMinDataGap;
+	u8 plen;
+	int err;
+	u8 resp[5] = {0};
+	u8 resp_len = 5;
+	/*
+	 * must long enough for RECV_SW_DIR == 2;
+	 * need lss_dir at least 4 for GL9755 device
+	 * max compitable gLssDir = 0
+	 */
+	u32 gLssDir = 0;
+
+	DBG("SET_COMMON_CFG: write Generic Settings.\n");
+	header = UHS2_NATIVE_PACKET |
+		 UHS2_PACKET_TYPE_CCMD | host->uhs2_dev_prop.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	if (host->uhs2_dev_prop.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
+	    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
+		/* Support HD */
+		DBG("Both Host and device support 2L-HD.\n");
+		host->flags |= MMC_UHS2_2L_HD;
+		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		host->uhs2_dev_prop.n_lanes_set =
+				UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		nMinDataGap = 1;
+	} else {
+		/* Only support 2L-FD so far */
+		host->flags &= ~MMC_UHS2_2L_HD;
+		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		host->uhs2_dev_prop.n_lanes_set =
+				UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		nMinDataGap = 3;
+	}
+
+	plen = 2;
+	payload[0] = host->uhs2_dev_prop.n_lanes_set <<
+		     UHS2_DEV_CONFIG_N_LANES_POS;
+	payload[1] = 0;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x\n", header, arg);
+	DBG("UHS2 write Generic Settings %08x %08x\n",
+	    payload[0], payload[1]);
+	DBG("flags=%08x dev_prop.n_lanes_set=%x host_caps.n_lanes_set=%x\n",
+	    host->flags,
+	    host->uhs2_dev_prop.n_lanes_set,
+	    host->uhs2_caps.n_lanes_set);
+
+	/*
+	 * There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	DBG("SET_COMMON_CFG: PHY Settings.\n");
+	arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_PHY_SET >> 8);
+
+	for (nTry = 0; nTry < 2; nTry++) {
+		plen = 2;
+
+		if (host->uhs2_caps.speed_range ==
+			UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
+			host->flags |= MMC_UHS2_SPEED_B;
+			host->uhs2_dev_prop.speed_range_set =
+				UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
+			DBG("set dev_prop.speed_range_set to SPEED_B\n");
+		} else {
+			host->uhs2_dev_prop.speed_range_set =
+				UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
+			host->flags &= ~MMC_UHS2_SPEED_B;
+			DBG("set dev_prop.speed_range_set to SPEED_A\n");
+		}
+
+		payload[0] = host->uhs2_dev_prop.speed_range_set <<
+				UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
+
+		host->uhs2_dev_prop.n_lss_sync_set =
+			(min(host->uhs2_dev_prop.n_lss_sync,
+			host->uhs2_caps.n_lss_sync) >> 2) &
+			UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+		host->uhs2_caps.n_lss_sync_set =
+			host->uhs2_dev_prop.n_lss_sync_set;
+
+		if (nTry) {
+			host->uhs2_dev_prop.n_lss_dir_set =
+				(max(host->uhs2_dev_prop.n_lss_dir,
+				host->uhs2_caps.n_lss_dir) >> 3) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+			host->uhs2_caps.n_lss_dir_set =
+				host->uhs2_dev_prop.n_lss_dir_set;
+			payload[1] = (host->uhs2_dev_prop.n_lss_dir_set <<
+				UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+				host->uhs2_dev_prop.n_lss_sync_set;
+		} else {
+			host->uhs2_caps.n_lss_dir_set =
+				(host->uhs2_dev_prop.n_lss_dir >> 3) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+			host->uhs2_dev_prop.n_lss_dir_set =
+				((host->uhs2_caps.n_lss_dir >> 3) + 1) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+		}
+
+		if (!gLssDir) {
+			host->uhs2_dev_prop.n_lss_dir_set = 0;
+		} else {
+			host->uhs2_dev_prop.n_lss_dir_set =
+				max((u8)gLssDir,
+				    host->uhs2_dev_prop.n_lss_dir_set);
+		}
+
+		payload[1] = (host->uhs2_dev_prop.n_lss_dir_set <<
+				UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+				host->uhs2_dev_prop.n_lss_sync_set;
+		payload[0] = cpu_to_be32(payload[0]);
+		payload[1] = cpu_to_be32(payload[1]);
+
+		DBG("UHS2 SET PHY Settings  %08x %08x\n",
+		    payload[0], payload[1]);
+		DBG("host->flags=%08x dev_prop.speed_range_set=%x\n",
+		    host->flags,
+		    host->uhs2_dev_prop.speed_range_set);
+		DBG("dev_prop.n_lss_sync_set=%x host_caps.n_lss_sync_set=%x\n",
+		    host->uhs2_dev_prop.n_lss_sync_set,
+		    host->uhs2_caps.n_lss_sync_set);
+		DBG("dev_prop.n_lss_dir_set=%x host_caps.n_lss_dir_set=%x\n",
+		    host->uhs2_dev_prop.n_lss_dir_set,
+		    host->uhs2_caps.n_lss_dir_set);
+
+		DBG("Begin SET_COMMON_CFG header=0x%x arg=0x%x\n",
+		    header, arg);
+		DBG("\t\tpayload[0]=0x%x payload[1]=0x%x\n",
+		    payload[0], payload[1]);
+
+		resp_len = 4;
+		memset(resp, 0, sizeof(resp));
+
+		uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
+				  payload, plen, resp, resp_len);
+
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		if (!(resp[2] & 0x80))
+			break;
+
+		DBG("%s: %s: UHS2 SET PHY Settings fail, res= 0x%x!\n",
+		    mmc_hostname(host), __func__,  resp[2]);
+	}
+
+	DBG("SET_COMMON_CFG: LINK-TRAN Settings.\n");
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
+
+	plen = 2;
+
+	if (host->uhs2_dev_prop.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
+		host->uhs2_dev_prop.maxblk_len_set =
+			UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
+	else
+		host->uhs2_dev_prop.maxblk_len_set =
+			min(host->uhs2_dev_prop.maxblk_len,
+			    host->uhs2_caps.maxblk_len);
+	host->uhs2_caps.maxblk_len_set = host->uhs2_dev_prop.maxblk_len_set;
+
+	host->uhs2_dev_prop.n_fcu_set =
+		min(host->uhs2_dev_prop.n_fcu,
+		    host->uhs2_caps.n_fcu);
+	host->uhs2_caps.n_fcu_set = host->uhs2_dev_prop.n_fcu_set;
+
+	host->uhs2_dev_prop.n_data_gap_set =
+		max(nMinDataGap, host->uhs2_dev_prop.n_data_gap);
+
+	host->uhs2_caps.n_data_gap_set = host->uhs2_dev_prop.n_data_gap_set;
+
+	host->uhs2_caps.max_retry_set = 3;
+	host->uhs2_dev_prop.max_retry_set = host->uhs2_caps.max_retry_set;
+
+	payload[0] = (host->uhs2_dev_prop.maxblk_len_set <<
+			UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
+			(host->uhs2_dev_prop.max_retry_set <<
+			UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
+			(host->uhs2_dev_prop.n_fcu_set <<
+			UHS2_DEV_CONFIG_N_FCU_POS);
+	payload[1] = host->uhs2_dev_prop.n_data_gap_set;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	DBG("Begin SET_COMMON_CFG header=0x%x arg=0x%x\n", header, arg);
+	DBG("\t\tpayload[0]=0x%x payload[1]=0x%x\n", payload[0], payload[1]);
+
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	DBG("SET_COMMON_CFG: Set Config Completion.\n");
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	plen = 2;
+	payload[0] = 0;
+	payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x, payload[0] = 0x%x.\n",
+	    header, arg, payload[0]);
+	resp_len = 5;
+	memset(resp, 0, sizeof(resp));
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
+			  resp, resp_len);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* Set host Config Setting registers */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, SET_CONFIG)) {
+		pr_err("%s: %s: UHS2 SET_CONFIG fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int uhs2_go_dormant(struct mmc_host *host, bool hibernate)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 payload[1];
+	u8 plen = 1;
+	int err;
+
+	/* Disable Normal INT */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, DISABLE_INT)) {
+		pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
+		host->uhs2_dev_prop.node_id;
+
+	arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
+
+	if (hibernate)
+		payload[0] = UHS2_DEV_CMD_DORMANT_HIBER;
+
+	DBG("Begin GO_DORMANT_STATE, header=0x%x, arg=0x%x, payload=0x%x.\n",
+	    header, arg, payload[0]);
+	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* Check Dormant State in Present */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, CHECK_DORMANT)) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	if (host->ops->uhs2_disable_clk)
+		host->ops->uhs2_disable_clk(host);
+
+	return 0;
+}
+
+static int uhs2_change_speed(struct mmc_host *host)
+{
+	int err;
+
+	/* Change Speed Range */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, SET_SPEED_B)) {
+		pr_err("%s: %s: UHS2 SET_SPEED fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	err = uhs2_go_dormant(host, false);
+	if (err) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* restore sd clock */
+	mdelay(5);
+	if (host->ops->uhs2_enable_clk)
+		host->ops->uhs2_enable_clk(host);
+
+	/* Enable Normal INT */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, ENABLE_INT)) {
+		pr_err("%s: %s: UHS2 ENABLE_INT fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	if (!host->ops->uhs2_detect_init ||
+	    host->ops->uhs2_detect_init(host)) {
+		pr_err("%s: %s: uhs2_detect_init() fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * mmc_uhs2_rescan_try_freq - select UHS2 interface
+ * @host: MMC host
+ * @freq: Bus speed
+ *
+ * Try to select UHS2 interface and initialize the bus for a given
+ * frequency, @freq.
+ *
+ * Return:	0 on success, non-zero error on failure
+ */
+int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq)
+{
+	int err = -EIO;
+
+	host->flags |= MMC_UHS2_SUPPORT;
+	host->f_init = freq;
+
+	pr_debug("%s: %s: trying to init card at %u Hz\n",
+		 mmc_hostname(host), __func__, host->f_init);
+
+	mmc_power_up(host, 0);
+	if (!host->ops->uhs2_detect_init ||
+	    host->ops->uhs2_detect_init(host)) {
+		pr_err("%s: fail to detect UHS2!\n", mmc_hostname(host));
+		err = UHS2_PHY_INIT_ERR;
+		goto init_fail;
+	}
+
+	if (uhs2_dev_init(host)) {
+		pr_err("%s: UHS2 DEVICE_INIT fail!\n", mmc_hostname(host));
+		goto init_fail;
+	}
+
+	if (uhs2_enum(host)) {
+		pr_err("%s: UHS2 ENUMERATE fail!\n", mmc_hostname(host));
+		goto init_fail;
+	}
+
+	if (uhs2_config_read(host)) {
+		pr_err("%s: UHS2 INQUIRY_CONFIG fail!\n", mmc_hostname(host));
+		goto init_fail;
+	}
+
+	if (uhs2_config_write(host)) {
+		pr_err("%s: UHS2 SET_COMMON_CONFIG fail!\n",
+		       mmc_hostname(host));
+		goto init_fail;
+	}
+
+	mmc_delay(10);
+
+	/* Change to Speed Range B if it is supported */
+	if (host->flags & MMC_UHS2_SPEED_B)
+		if (uhs2_change_speed(host)) {
+			pr_err("%s: UHS2 uhs2_change_speed() fail!\n",
+			       mmc_hostname(host));
+			goto init_fail;
+		}
+
+	host->flags |= MMC_UHS2_INITIALIZED;
+
+	mmc_send_if_cond(host, host->ocr_avail);
+
+	/* On market, only can some SD cards support UHS-II so only call SD
+	 * attach process here.
+	 */
+	if (!(host->caps2 & MMC_CAP2_NO_SD)) {
+		err = mmc_attach_sd(host);
+		if (!err)
+			return 0;
+	} else {
+		err = -EIO;
+	}
+
+init_fail:
+	mmc_power_off(host);
+	if (host->flags & MMC_UHS2_INITIALIZED)
+		host->flags &= ~MMC_UHS2_INITIALIZED;
+	host->flags &= ~MMC_UHS2_SUPPORT;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mmc_uhs2_rescan_try_freq);
diff --git a/drivers/mmc/core/uhs2.h b/drivers/mmc/core/uhs2.h
new file mode 100644
index 000000000000..e3389d4dda3b
--- /dev/null
+++ b/drivers/mmc/core/uhs2.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  driver/mmc/core/uhs2.h - UHS-II driver
+ *
+ * Header file for UHS-II packets, Host Controller registers and I/O
+ * accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef MMC_UHS2_H
+#define MMC_UHS2_H
+
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+
+#define UHS2_PHY_INIT_ERR	1
+
+int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq);
+
+#endif /* MMC_UHS2_H */
-- 
2.28.0

