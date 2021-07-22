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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E55BC63793
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188CF61241
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhGVDVb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhGVDV3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCDAC061575;
        Wed, 21 Jul 2021 21:02:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y3so3012491plp.4;
        Wed, 21 Jul 2021 21:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grqvWstToZdU1j24UPoQskvD093nWq2s/JMON7jHKtg=;
        b=vaO9oiOAtYPhf6+JV5KVEKRwuWPcKfUfhofeZ9Em3FIM2J5JksGrexLpx4Q7WB7YIV
         HbR0k6gOwdU3ITgJUAU1TAXNnI4L3WLA8urVWPrYPPjWodPfak+6aPcSVrfYfP1k+1PE
         iGNAt3B4F79n/aMbg7ah2Or1X5kfdmUSuB6sE+t/ERb96zri3yuz0RfE7dd9CRwI9P+c
         8WPXML6t8d5oT/GneMs7hJJ0t7OrO7t6KyEZ+0qLvoofFI8BYOxzRC7IJlTQecM01mh4
         25UjZVz+8B8EPDc7JYymaE61lQjzmmwZNA3zkok7JKJmzRktIU6+DmXeT5Fm7ne+EuGc
         C6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grqvWstToZdU1j24UPoQskvD093nWq2s/JMON7jHKtg=;
        b=YOthoKGcucSpWc3xsLjE8QGiHCO8pO2AYpFKtZiJjUjZRhmspxFyiiKKX58rzzkBgD
         pvJyeC2k161EpWtRPWjojrAdxD9xlSTtxqbTmDt2Hws3rsVmWn+xhOBl1g+vCRk4wYxa
         SdRCpNPYIh/Q1NRvBjR3E7MrX0mE8yq2CFCB2zUJsXAIrbbPl3DzstGkEC4TV3DIkKht
         nUHAaEoGXcwIBbi+weQBOmtEMXCk9aipA29AnMxeX1nNmF1FC7RIE2dcVnweBR6uiwy5
         ENiwUBTmoZ8atVx87Pyho+rD+DJiHbNNBijadISRwyqo6OEMlY/pkGzS4PSreTn+Oc72
         khJQ==
X-Gm-Message-State: AOAM531vRiLKaH3BymVKZmyqWghz4rbr9gNdShtjk9EM1CQbREBtGt0l
        nrbpD5UD44bDgZFtfxuTY1s=
X-Google-Smtp-Source: ABdhPJy14stfb0YEBrNLc/Qb5dT9yVl22mgg0Dl5ZNMHcncwoxbPYqck1MvmS8IJUAGRN6NLGBIikg==
X-Received: by 2002:a63:3704:: with SMTP id e4mr39032195pga.310.1626926523940;
        Wed, 21 Jul 2021 21:02:03 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:03 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 06/29] mmc: core: UHS-II support, generate UHS-II SD command packet
Date:   Thu, 22 Jul 2021 12:01:01 +0800
Message-Id: <20210722040124.7573-6-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In SD-TRAN protocol, legacy SD commands should be "encapsulated" in SD
packets as described in SD specification.
Please see section 7.1 and 7.2.1 in "UHS-II Simplified Addendum."

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/core.c | 18 +++++++++++
 drivers/mmc/core/uhs2.c | 70 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h |  1 +
 3 files changed, 89 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 300812c69e13..d53722c21f29 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -338,6 +338,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)

 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;

 	init_completion(&mrq->cmd_completion);
@@ -355,6 +357,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
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

@@ -434,6 +443,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;

 	/*
@@ -454,6 +465,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
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
diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
index acb46b5b57ef..1f6d0e0cf355 100644
--- a/drivers/mmc/core/uhs2.c
+++ b/drivers/mmc/core/uhs2.c
@@ -807,3 +807,73 @@ int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq)
 	return err;
 }
 EXPORT_SYMBOL_GPL(mmc_uhs2_rescan_try_freq);
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
diff --git a/drivers/mmc/core/uhs2.h b/drivers/mmc/core/uhs2.h
index e3389d4dda3b..48486ba21062 100644
--- a/drivers/mmc/core/uhs2.h
+++ b/drivers/mmc/core/uhs2.h
@@ -16,5 +16,6 @@
 #define UHS2_PHY_INIT_ERR	1

 int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq);
+int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq);

 #endif /* MMC_UHS2_H */
--
2.32.0

