Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EF6C4742C
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAE22075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooA1pST3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKFC2S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgKFC2R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:17 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC4C0613CF
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:16 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so2942323pfp.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNtXnwKCsgjnlMDm3C3sL4M5crM/sRzajvYLm7BnyWI=;
        b=ooA1pST3WCb9ca/isQjXCxdBpxqer2SfhDXzYQCcf9XEf6JNRYzZBku1HVjfwGRQvO
         iQuW6hey4urO33lUeeUH27o0c/ENEhW4740fCLE8SXJfPqbc5iDJR/bdTPmjnS2ir8KG
         6IZ20Uv6XWvcrJOagMpovBeyVBI7MympuvfgpujR/UszxlwTvJuXQxDhsZJSHIH7Dkqr
         pr7xXJA/WJrp7jPsd/TkKXkruDUay4J+WRHOyxNqXC6rAuqo27f/E3UnKAz0mwdQi7cr
         eosEtqX1spdXReQ+O6oD5Us6ZIUWyHfg+EToIG56ZcUsgSaOQmyhZuYK/7JeXWXMznbG
         Aurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNtXnwKCsgjnlMDm3C3sL4M5crM/sRzajvYLm7BnyWI=;
        b=Rhz92lAz2zgpSqz4X+ZJ8U5KoYlpr6rWIsYlXfkqfT9cfMu/OuU+aSagqljp7ymCrA
         /8MGaOuEYVbPO4d2qVnGM61iWOeNttnQ7mFr0bUoAUhQB+2ylruyGxw2nhHRcrYjV9N4
         SoESHw8/K1HKMukZpy6XZsPMh2rGlmzkmTrxRKfsWvypuwJfIeoPMKnoqQG3oOGQfQXp
         wXzrGLrTRuMbgBMUka8OzCSv2d9iaFJEPGW3mXpxWnyW6y3Ox8Hn+zGZEy/5APinA+zw
         rREJ9XO0+gFllrrMMDU/uBKzNV47Yjb9s2HLe2rCSA1SR5Kdb/2am8kebjzwQeKMc6fm
         OTnA==
X-Gm-Message-State: AOAM532+lenBJBGjxpvGPqCFQakUEJvBXwG5RmoID9ZZC+GibxST2yN0
        lsV7jnmLpiReYK9D+5Qt3EARQQ==
X-Google-Smtp-Source: ABdhPJwiT+iUaQzdOp2J1B5Z7gvZzHPMj7ENBj4gEjhFEqJ1MgAdCBmuwLo+EkJ5wWfYa5sq4YpMSA==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr5025097pgi.337.1604629695765;
        Thu, 05 Nov 2020 18:28:15 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:15 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 06/27] mmc: core: UHS-II support, generate UHS-II SD command packet
Date:   Fri,  6 Nov 2020 11:27:05 +0900
Message-Id: <20201106022726.19831-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
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
index a08cb1c0f6d2..ac43e93033e6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -337,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	init_completion(&mrq->cmd_completion);
@@ -354,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
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
 
@@ -433,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	/*
@@ -453,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
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
2.28.0

