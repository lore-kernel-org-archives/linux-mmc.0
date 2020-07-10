Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238A8C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF57C2076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQwHVP5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJLIo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJLIn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:08:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F3C08C5CE;
        Fri, 10 Jul 2020 04:08:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k5so2466122pjg.3;
        Fri, 10 Jul 2020 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8O0SJiIJfP0hcr2bPL6Gp5kFAhLJphHNCRKgoNomCk=;
        b=vQwHVP5jS8iJIiVElm2NjGIXswygyZQ5FK2mQ7LBQRXpkVv6Chz3k/KwVJRxtRjwaB
         IREZXtd4S22b2xucTAx0qqXNqBh8lScaRfkJduXQ+KXGAkWRm+S2IBP1ixALTxnLm8zX
         mM6LGr7Wpjm0QUgydiNwA6tJAFvop5LJgscZza1CzKjSrajuN2o2TqnNEWnetwE+Afxa
         SsCF8+gxL9qNPpoXMpaX1n2mw/yIT6DpD8bMOWRnW26ne2QKUvrJXi+bjOh4lk/Es+GR
         i71ii8Ls+31UQK+sJzKRLD8OlSSAo2XFOaHFRDnpSbQI5OxAKMqoj+OZvXqEyyrPdgAs
         ix9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8O0SJiIJfP0hcr2bPL6Gp5kFAhLJphHNCRKgoNomCk=;
        b=sfVCNnos9j0UwPhC/Iwx551jZurjR/4UFUiETtd6y28XPs6uRVkE6AvBQnb0SMloR9
         /meJjs5ILhLDbNkweUNpzYHLuN5MuXOK0OahnXa7L66dPOE+1T4FsT+0+9MT9t7jhHno
         LN56TYW+IIo4qsELN+MaGoE5+zUhagov5jn1tWMoAp0e/AzomzZm3F5rZC7FN5OxX4TV
         msR35tO/HsyctvCYWbzo6DZ/hXA4ARmUDvL4IRFGkyNGixqHarXHvOS85bq41ytjp69u
         cBqczXVnhncW2Vp5tycs3DMDcBsm/lqvg3fu2mJLh6ITuzD0UT3mEhXt+22oKa6g0nvd
         /dZA==
X-Gm-Message-State: AOAM531IU2E4XmwUPuL8iWdZzE1jrb5PPDJXTecPITdeKbYJ2bUseTMK
        iP8aalcdM/lie9OPy1F8rfo=
X-Google-Smtp-Source: ABdhPJxdnXqTMaGuW7C48Nbs5ksP4+DEfMF6SarUMfxCAkZTK8hhxJvracW5aDAKNrNBOE2pX2Upjg==
X-Received: by 2002:a17:90b:2350:: with SMTP id ms16mr5242120pjb.127.1594379322892;
        Fri, 10 Jul 2020 04:08:42 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id u14sm6014851pfk.211.2020.07.10.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:08:42 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 06/21] mmc: core: UHS-II support, generate UHS-II SD command packet
Date:   Fri, 10 Jul 2020 19:09:25 +0800
Message-Id: <20200710110925.29231-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

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
index e2534f3446ce..dfe3a6df7645 100644
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
index a3b20ac6f315..6e26de429726 100644
--- a/drivers/mmc/core/uhs2.c
+++ b/drivers/mmc/core/uhs2.c
@@ -798,3 +798,73 @@ int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq)
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
2.27.0

