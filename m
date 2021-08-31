Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893FDC432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3160FD8
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbhHaLDk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbhHaLDj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2021 07:03:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3AC061575
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:02:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c17so16319352pgc.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmZTnrOMxBDgt4cGcXQVG9wwsxscOXCYsV93obDxsgo=;
        b=KTte24YGYTLmsnnsAtTwSPEn7hE584xB6zZczfPo6Bc9d4RGaHI4z6gDFbkBgCD2Rr
         E8JPs487aRHl8RZLVV6fshGN8n6wc5C0fmayX1UpwCdxdXCchOb/LEHLVQqNXE/UrSdT
         8FfNw813fstNv5J+Nd1ooAerq3UhBujaaHJM8UDLA+UfM58EiJYIN2F8W8dPrdHFaVC9
         /4LhCcsPbEgpPa1rl1Rx9YpG6nvFEwQhQLrdD/qApmxw+JpyWJe8DiDMzKX4p5AF/36r
         /YtR3YhQpM5Ia60qdl3hO3fK4p0z/LLQBth78mGOb5GUpAjJSzOp8Q0kk80Gaj24Kl1R
         0Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmZTnrOMxBDgt4cGcXQVG9wwsxscOXCYsV93obDxsgo=;
        b=Yugm0H5IFv4Jmh0oC4Z0Kiq3enZpIfu7NrKR0PsKQno3egiRywoBXMWfGzT39c+MTD
         iBJgidk7ktIYKKLMPQ8V0NtdCA187gksJEWbsiAQ4C65hyiEO05brDYKdeo/GIx+Z9GG
         p/0TLkBXJlTwAe+sQeXyBty+QMLqhoK/rKz+79dgE40v8O0ZeXE5onRO9ruK1kXWQFKl
         ZXP1uwcQl97v7VptdHQerdkd16Ph1L0qoBPa38CJgKkyi47Ubsfgailf1RE/KkDYeZO2
         itEA3zhzI33+msqYWYf2+PyhPqF5BKWoWuYqHvgkxeH8lKQoOX4wy+8Kv2AiOrdrE5vh
         JAHw==
X-Gm-Message-State: AOAM530bo8N9Trsw79CVA3aQZb75NYis2dZFYQXqJ2intanLJMcM3JuQ
        iqh/TDvP+t9pHhBm/UepX2g=
X-Google-Smtp-Source: ABdhPJy5p+daJ8W2ut6+1DIuC1txgO123+iX/LtHM8n9KG8YvU076/N87C2P5rP/1DyfSR705Ua3YA==
X-Received: by 2002:a63:471d:: with SMTP id u29mr13676131pga.196.1630407764056;
        Tue, 31 Aug 2021 04:02:44 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id p17sm2506829pjg.54.2021.08.31.04.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:02:43 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: [PATCH 7/7] mmc: core: Support UHS-II card access
Date:   Tue, 31 Aug 2021 19:02:39 +0800
Message-Id: <20210831110239.50833-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

From: Jason Lai <jason.lai@genesyslogic.com.tw>

Provide a function to transform legacy SD command packet into UHS-II
SD-TRAN DCMD packet. Each host controller can assign their own request
function in struct mmc_host_ops to process UHS-II command packet.

Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/core/core.c    | 26 ++++++++++++-
 drivers/mmc/core/sd_uhs2.c | 78 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/sd_uhs2.h |  3 +-
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 19b409179..33e15e43f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -31,6 +31,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/sd_uhs2.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
@@ -42,6 +43,7 @@
 #include "host.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
+#include "sd_uhs2.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -335,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	init_completion(&mrq->cmd_completion);
@@ -352,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
+	if (host->flags & MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		uhs2_prepare_sd_cmd(host, mrq);
+	}
+
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
@@ -431,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	/*
@@ -451,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		goto out_err;
 
+	if (host->flags & MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		uhs2_prepare_sd_cmd(host, mrq);
+	}
+
 	err = host->cqe_ops->cqe_request(host, mrq);
 	if (err)
 		goto out_err;
@@ -899,8 +919,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	host->ios.chip_select = mode;
-	mmc_set_ios(host);
+	if (!(host->flags & MMC_UHS2_INITIALIZED)) {
+		host->ios.chip_select = mode;
+		mmc_set_ios(host);
+	}
 }
 
 /*
diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index d9ceee20d..f6c3abec9 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -659,8 +659,8 @@ static int sd_uhs2_config_write(struct mmc_host *host)
 	payload[1] = cpu_to_be32(payload[1]);
 
 	pr_debug("Begin SET_COMMON_CFG, ");
-	pr_debug("header=0x%x, arg=0x%x, payload[0] = 0x%x.\n",
-	         header, arg, payload[0]);
+	pr_debug("header=0x%x, arg=0x%x, payload[0] = 0x%x.\n",
+		 header, arg, payload[0]);
 	resp_len = 5;
 	memset(resp, 0, sizeof(resp));
 	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
@@ -997,6 +997,80 @@ static int sd_uhs2_hw_reset(struct mmc_host *host)
 	return 0;
 }
 
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
 static const struct mmc_bus_ops sd_uhs2_ops = {
 	.remove = sd_uhs2_remove,
 	.alive = sd_uhs2_alive,
diff --git a/drivers/mmc/core/sd_uhs2.h b/drivers/mmc/core/sd_uhs2.h
index 743ec0157..b745e8f5c 100755
--- a/drivers/mmc/core/sd_uhs2.h
+++ b/drivers/mmc/core/sd_uhs2.h
@@ -15,6 +15,7 @@
 
 #define UHS2_PHY_INIT_ERR	1
 
-int mmc_attach_sd_uhs2(struct mmc_host *host)
+int mmc_attach_sd_uhs2(struct mmc_host *host);
+int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq);
 
 #endif /* MMC_UHS2_H */
-- 
2.32.0

