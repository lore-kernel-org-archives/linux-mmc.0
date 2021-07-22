Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60BBC64981
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E1461222
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhGVDWV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhGVDWM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA641C061799;
        Wed, 21 Jul 2021 21:02:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso2391005pjb.1;
        Wed, 21 Jul 2021 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WbyGO24ezxGAFQ8Kmtz7FAIEG0xpefmuLWdx5Osp6o=;
        b=YYLrabcCnVQygJMgP+NolRJk2gKGKPBKwcJuTfcrsLX7G/3v1k+PpKy2tMGY4NuF8F
         dS4agyXPr5R+WPIjFdjRgNQmXTm41O+q7WDBdbYHPgQjz11JtRv7es5XRXdIujNfiwGp
         ZPMlYJOedpehw4mriCqwGFMvXeDil9nf50N7j8gHz5lRmhE7VqCaKBrITJQjlOfEiLWX
         yDquRH9q1J+YAnYchnPj4uOVM0XWJDr8R5psFGP2xi83rXBUsiGJlNj3qIW1+JoTOIR6
         fVCP8ac79PcUYXMaEgNZksmBHFR0lX7Tji0Lck4bp0dAbzuRMKoGJa72A2OWXMTkIb0j
         j8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WbyGO24ezxGAFQ8Kmtz7FAIEG0xpefmuLWdx5Osp6o=;
        b=ZsZFQc9Ua/FlzlgNH5waTy5CIdfn8KvjnzfVkpjiZ/5mIcXkYgzdBWGGXf1DmBhXi6
         kfOtTTYfbnKA0tizt8zxwMRIn/5/+QsHEFwFNhfLuFY3DxXGZKPcrzpD4Ir5F3Pi/QIf
         6Jnb/rnHUKlRnWfqBF5mL3puv3eydxSQcHgDsMzt/AMNGhihsZJQU7M7WF/6Ml0q5BwA
         Mu47LStuzRdnYLIS7SKqR2k4mgDySLTFWf/WSbt7/Fi9Kt7DaZ1YezNY3Hq++EsQ0Fqk
         3NzjpTT9mUMrdQe39fKxjrgPmmjmwfFkDWL16cmulyACa3M1y/8+O/N+lb7TMyZAdg3m
         pPyg==
X-Gm-Message-State: AOAM531LJMghjy/Vk2VDuS16S5eiTGhlfgiNhRTKPfszqzgggUtiQioU
        +WXxUFB8ef5bXQ15/K7xk0k=
X-Google-Smtp-Source: ABdhPJw95O01eIxEyxQQjTUu54UgJiWNCkqpCkR5zZr4xAv5Yy/Tmmp0MlmqBuGQLlNcGEUj1WRkRw==
X-Received: by 2002:a17:902:ecce:b029:12b:1c81:2741 with SMTP id a14-20020a170902ecceb029012b1c812741mr30380444plh.3.1626926567147;
        Wed, 21 Jul 2021 21:02:47 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:46 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Subject: [RFC PATCH v3.2 29/29] mmc: core: Apply Ulf's patch for supporting UHS-II card
Date:   Thu, 22 Jul 2021 12:01:24 +0800
Message-Id: <20210722040124.7573-29-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

1. mmc: core: core.c: Modify definition name from MMC_TIMING_UHS2 to MMC_TIMING_SD_UHS2.
2. mmc: core: bus.c: Apply Ulf's coding style to function mmc_add_card().
3. mmc: core: sd_uhs2.c: Move functions from uhs2.c to corespondding functions in sd_uhs2.c and remove uhs2.c from kernel source code.

Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/core/Makefile     |    2 +-
 drivers/mmc/core/core.c       |    2 +-
 drivers/mmc/core/sd.c         |    2 +-
 drivers/mmc/core/sd.h         |    1 +
 drivers/mmc/core/sd_uhs2.c    | 1157 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h       |    1 +
 drivers/mmc/host/sdhci-uhs2.c |    5 +++++
 include/linux/mmc/uhs2.h      |    1 +
 8 files changed, 1171 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 3d3a55bc7e45..10f1c3ca5e4a 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,7 +8,7 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   slot-gpio.o regulator.o uhs2.o
+				   slot-gpio.o regulator.o sd_uhs2.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
 obj-$(CONFIG_PWRSEQ_SD8787)	+= pwrseq_sd8787.o
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9413dea60612..2624d7b30cd2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1349,7 +1349,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 			host->ios.chip_select = MMC_CS_HIGH;
 		else
 			host->ios.chip_select = MMC_CS_DONTCARE;
-		host->ios.timing = MMC_TIMING_SD_UHS2;
+		host->ios.timing = MMC_TIMING_UHS2;
 	} else {
 		mmc_pwrseq_pre_power_on(host);

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index f984d5a9301a..93e741e3b5a3 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1014,7 +1014,7 @@ static bool mmc_sd_card_using_v18(struct mmc_card *card)
  * In the case of a resume, "oldcard" will contain the card
  * we're trying to reinitialise.
  */
-static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
+int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	struct mmc_card *oldcard)
 {
 	struct mmc_card *card;
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 1af5a038bae9..4fbd990d33e5 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -9,6 +9,7 @@ extern struct device_type sd_type;
 struct mmc_host;
 struct mmc_card;

+int mmc_sd_init_card(struct mmc_host *host, u32 ocr, struct mmc_card *oldcard);
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
 int mmc_sd_get_csd(struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
new file mode 100644
index 000000000000..55853202cbea
--- /dev/null
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -0,0 +1,1157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * Support for SD UHS-II cards
+ */
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
+#include "core.h"
+#include "bus.h"
+#include "sd_ops.h"
+#include "sd.h"
+#include "mmc_ops.h"
+#include "uhs2.h"
+
+#define DBG(f, x...) \
+	pr_warn("[%s()]: " f, __func__, ## x)
+
+//static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
+
+/* This function is part of sdhci_uhs2_set_ios() in sdhci-uhs2.c
+static int sd_uhs2_set_ios(struct mmc_host *host)
+{
+	struct mmc_ios *ios = &host->ios;
+
+	return host->ops->uhs2_set_ios(host, ios);
+}
+*/
+
+/* This function is part of mmc_power_up() in core.c
+static int sd_uhs2_power_up(struct mmc_host *host)
+{
+	host->ios.vdd = fls(host->ocr_avail) - 1;
+	host->ios.clock = host->f_init;
+	host->ios.timing = MMC_TIMING_SD_UHS2;
+	host->ios.power_mode = MMC_POWER_UP;
+
+	return sd_uhs2_set_ios(host);
+}*/
+
+/* This function is part of mmc_power_off() in core.c
+static void sd_uhs2_power_off(struct mmc_host *host)
+{
+	host->ios.vdd = 0;
+	host->ios.clock = 0;
+	host->ios.timing = MMC_TIMING_LEGACY;
+	host->ios.power_mode = MMC_POWER_OFF;
+
+	sd_uhs2_set_ios(host);
+}
+*/
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
+/*
+ * Do the early initialization of the card, by sending the device init broadcast
+ * command and wait for the process to be completed.
+ */
+static int sd_uhs2_dev_init(struct mmc_host *host)
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
+/*
+ * Run the enumeration process by sending the enumerate command to the card.
+ * Note that, we currently support only the point to point connection, which
+ * means only one card can be attached per host/slot.
+ */
+//static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)	// node_id had been saved in host->uhs2_dev_prop.node_id
+static int sd_uhs2_enum(struct mmc_host *host)
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
+/*
+ * Read the UHS-II configuration registers (CFG_REG) of the card, by sending it
+ * commands and by parsing the responses. Store a copy of the relevant data in
+ * card->uhs2_config.
+ */
+//static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
+static int sd_uhs2_config_read(struct mmc_host *host)
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
+/*
+ * Based on the card's and host's UHS-II capabilities, let's update the
+ * configuration of the card and the host. This may also include to move to a
+ * greater speed range/mode. Depending on the updated configuration, we may need
+ * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
+ *
+ * In the final step, let's check if the card signals "config completion", which
+ * indicates that the card has moved from config state into active state.
+ */
+//static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
+static int sd_uhs2_config_write(struct mmc_host *host)
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
+/*
+ * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
+ * commands/requests to be backwards compatible through the legacy SD protocol.
+ * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
+ * be set through a legacy CMD6. Note that, the power limit that becomes set,
+ * survives a soft reset through the GO_DORMANT_STATE command.
+ */
+static int sd_uhs2_legacy_init(struct mmc_host *host)
+{
+	int err;
+	u32 ocr, rocr;
+
+	WARN_ON(!host->claimed);
+
+	// Jason test
+	mmc_go_idle(host);
+	mmc_delay(10);
+
+	err = mmc_send_if_cond(host, host->ocr_avail);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD8 fail!\n", mmc_hostname(host), __func__);
+		//return err;
+	}
+
+	err = mmc_send_app_op_cond(host, 0, &ocr);
+	if (err)
+		return err;
+
+	if (host->ocr_avail_sd)
+		host->ocr_avail = host->ocr_avail_sd;
+
+	/*
+	 * Some SD cards claims an out of spec VDD voltage range. Let's treat
+	 * these bits as being in-valid and especially also bit7.
+	 */
+	ocr &= ~0x7FFF;
+
+	rocr = mmc_select_voltage(host, ocr);
+
+	/*
+	 * Some cards have zero value of rocr in UHS-II mode. Assign host's ocr
+	 * value to rocr.
+	 */
+	if (!rocr)
+		rocr = host->ocr_avail;
+
+	/*
+	* Can we support the voltage(s) of the card(s)?
+	*/
+	if (!rocr) {
+		pr_err("%s: UHS2: there is no valid OCR.\n", mmc_hostname(host));
+		return -EINVAL;
+	}
+
+	/*
+	 * Detect and init the card.
+	 */
+	err = mmc_sd_init_card(host, rocr, NULL);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/*
+ * Run the phy initialization sequence, which mainly relies on the UHS-II host
+ * to check that we reach the expected electrical state, between the host and
+ * the card.
+ */
+static int sd_uhs2_phy_init(struct mmc_host *host)
+{
+	if (!host->ops->uhs2_detect_init ||
+	    host->ops->uhs2_detect_init(host)) {
+		pr_err("%s: fail to detect UHS2!\n", mmc_hostname(host));
+		return UHS2_PHY_INIT_ERR;
+	}
+	return 0;
+}
+
+static void sd_uhs2_remove(struct mmc_host *host)
+{
+	mmc_remove_card(host->card);
+	host->card = NULL;
+}
+
+static int sd_uhs2_alive(struct mmc_host *host)
+{
+	return mmc_send_status(host->card, NULL);
+}
+
+static void sd_uhs2_detect(struct mmc_host *host)
+{
+	int err;
+
+	mmc_get_card(host->card, NULL);
+	err = _mmc_detect_card_removed(host);
+	mmc_put_card(host->card, NULL);
+
+	if (err) {
+		sd_uhs2_remove(host);
+
+		mmc_claim_host(host);
+		mmc_detach_bus(host);
+		mmc_power_off(host);
+		mmc_release_host(host);
+	}
+}
+
+static int sd_uhs2_suspend(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_resume(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_runtime_suspend(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_runtime_resume(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_shutdown(struct mmc_host *host)
+{
+	return 0;
+}
+
+
+/**
+ * sd_uhs2_hw_reset - invoke SW reset
+ * @host: MMC host
+ *
+ * Invoke SW reset, depending on a bit in @mask and wait for completion.
+ */
+static int sd_uhs2_hw_reset(struct mmc_host *host)
+{
+	int err = 0;
+
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, UHS2_SW_RESET)) {
+		pr_err("%s: %s: UHS2_SW_RESET fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	return err;
+}
+
+static int sd_uhs2_attach(struct mmc_host *host)
+{
+	int err;
+
+	err = sd_uhs2_phy_init(host);
+	if (err)
+		return err;
+
+	err = sd_uhs2_init_card(host);
+	if (err)
+		return err;
+
+	mmc_release_host(host);
+	err = mmc_add_card(host->card);
+	if (err) {
+		mmc_remove_card(host->card);
+		host->card = NULL;
+		mmc_detach_bus(host);
+		mmc_claim_host(host);
+		return err;;
+	}
+
+	mmc_claim_host(host);
+
+	/* TODO: Is this the right place? */
+	if (host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+
+	return 0;
+}
+
+/**
+ * uhs2_prepare_sd_cmd - prepare for SD command packet
+ * @host:	MMC host
+ * @mrq:	MMC request
+ *
+ * Initialize and fill in a header and a payload of SD command packet.
+ * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
+ * advance.
+ *
+ * Return:	0 on success, non-zero error on failure
+ */
+int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct uhs2_command *uhs2_cmd;
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 0;
+
+	cmd = mrq->cmd;
+	header = host->uhs2_dev_prop.node_id;
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		header |= UHS2_PACKET_TYPE_DCMD;
+	else
+		header |= UHS2_PACKET_TYPE_CCMD;
+
+	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->flags & MMC_UHS2_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->flags &= ~MMC_UHS2_APP_CMD;
+	}
+
+	uhs2_cmd = cmd->uhs2_cmd;
+	payload = uhs2_cmd->payload;
+	plen = 2; /* at the maximum */
+
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC &&
+	    !cmd->uhs2_tmode0_flag) {
+		if (host->flags & MMC_UHS2_2L_HD)
+			arg |= UHS2_DCMD_2L_HD_MODE;
+
+		arg |= UHS2_DCMD_LM_TLEN_EXIST;
+
+		if (cmd->data->blocks == 1 &&
+		    cmd->data->blksz != 512 &&
+		    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+		    cmd->opcode != MMC_WRITE_BLOCK) {
+			arg |= UHS2_DCMD_TLUM_BYTE_MODE;
+			payload[1] = uhs2_dcmd_convert_msb(cmd->data->blksz);
+		} else {
+			payload[1] = uhs2_dcmd_convert_msb(cmd->data->blocks);
+		}
+
+		if (cmd->opcode == SD_IO_RW_EXTENDED) {
+			arg &= ~(UHS2_DCMD_LM_TLEN_EXIST |
+				UHS2_DCMD_TLUM_BYTE_MODE |
+				UHS2_NATIVE_DCMD_DAM_IO);
+			payload[1] = 0;
+			plen = 1;
+		}
+	} else {
+		plen = 1;
+	}
+
+	payload[0] = uhs2_dcmd_convert_msb(cmd->arg);
+	pr_debug("%s: %s: sd_cmd->arg = 0x%x, payload[0]= 0x%x.\n",
+		 mmc_hostname(host), __func__, cmd->arg, payload[0]);
+
+	uhs2_cmd_assemble(cmd, uhs2_cmd, header, arg, payload, plen, NULL, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uhs2_prepare_sd_cmd);
+
+static const struct mmc_bus_ops sd_uhs2_ops = {
+	.remove = sd_uhs2_remove,
+	.alive = sd_uhs2_alive,
+	.detect = sd_uhs2_detect,
+	.suspend = sd_uhs2_suspend,
+	.resume = sd_uhs2_resume,
+	.runtime_suspend = sd_uhs2_runtime_suspend,
+	.runtime_resume = sd_uhs2_runtime_resume,
+	.shutdown = sd_uhs2_shutdown,
+	.hw_reset = sd_uhs2_hw_reset,
+};
+
+/*
+ * Allocate the data structure for the mmc_card and run the UHS-II specific
+ * initialization sequence.
+ */
+int sd_uhs2_init_card(struct mmc_host *host)
+{
+//	struct mmc_card *card;
+//	u32 node_id;
+	int err = -EIO;
+
+	if (sd_uhs2_dev_init(host)) {
+		pr_err("%s: UHS2 DEVICE_INIT fail!\n", mmc_hostname(host));
+		return err;
+	}
+
+	if (sd_uhs2_enum(host))
+	{
+		pr_err("%s: UHS2 ENUMERATE fail!\n", mmc_hostname(host));
+		return err;
+	}
+
+	if (sd_uhs2_config_read(host)) {
+		pr_err("%s: UHS2 INQUIRY_CONFIG fail!\n", mmc_hostname(host));
+		return err;
+	}
+
+	if (sd_uhs2_config_write(host)) {
+		pr_err("%s: UHS2 SET_COMMON_CONFIG fail!\n", mmc_hostname(host));
+		return err;
+	}
+
+	mmc_delay(10);
+
+	/* Change to Speed Range B if it is supported */
+	if (host->flags & MMC_UHS2_SPEED_B) {
+		if (uhs2_change_speed(host)) {
+			pr_err("%s: UHS2 uhs2_change_speed() fail!\n",
+			       mmc_hostname(host));
+			return err;
+		}
+	}
+
+	host->flags |= MMC_UHS2_INITIALIZED;
+
+	mmc_attach_bus(host, &sd_uhs2_ops);
+
+	if (sd_uhs2_legacy_init(host)) {
+		pr_err("%s: sd_uhs2_legacy_init: error %d.\n", mmc_hostname(host), err);
+		mmc_detach_bus(host);
+		return err;
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
+	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
+		pr_info("mmc_attach_sdio\n");
+	if (!(host->caps2 & MMC_CAP2_NO_SD))
+		pr_info("mmc_attach_sd\n");
+
+	mmc_power_up(host, 0);
+
+	err = sd_uhs2_attach(host);
+	if (err) {
+		pr_err("%s: sd_uhs2_attach fail!\n", mmc_hostname(host));
+		goto init_fail;
+	}
+	else
+		return 0;
+
+//--------------------------------------------------------------------------------------
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
index 48486ba21062..d05a4c28df3e 100644
--- a/drivers/mmc/core/uhs2.h
+++ b/drivers/mmc/core/uhs2.h
@@ -16,6 +16,7 @@
 #define UHS2_PHY_INIT_ERR	1

 int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq);
+int sd_uhs2_init_card(struct mmc_host *host);
 int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq);

 #endif /* MMC_UHS2_H */
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 3dd81c89d8f1..a5af2bd950f8 100644--
--- a/drivers/mmc/host/sdhci-uhs2.c2.32.0
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -545,6 +545,10 @@ static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
 	case CHECK_DORMANT:
 		err = sdhci_uhs2_check_dormant(host);
 		break;
+	case UHS2_SW_RESET:
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+		/* FIXED IT : Modify return type of sdhci_uhs2_reset()? */
+		err = 0;
+		break;
 	default:
 		pr_err("%s: input action %d is wrong!\n",
 		       mmc_hostname(host->mmc), act);
diff --git a/include/linux/mmc/uhs2.h b/include/linux/mmc/uhs2.h
index 298ac7cd8904..ef249098b46f 100644
--- a/include/linux/mmc/uhs2.h
+++ b/include/linux/mmc/uhs2.h
@@ -189,6 +189,7 @@ enum uhs2_act {
 	DISABLE_INT,
 	SET_SPEED_B,
 	CHECK_DORMANT,
+	UHS2_SW_RESET,
 };

 /* UHS-II Device Registers */
