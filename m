Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B939EC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 27 May 2022 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354377AbiE0Ry3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 May 2022 13:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354369AbiE0Ry1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2022 13:54:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94810C964A;
        Fri, 27 May 2022 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653674066; x=1685210066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CHu2ARZrBEpywEV6kKypue4Tegb6NHNgGRwZVdWVwRE=;
  b=q5yaiy/gIwkkY1QsNeVuXHzbHQzTdaU08vksFKu9a/6iidLkXH5kLUIK
   sOpxJTu5oko9S8b2msiC6vvoSDP2WtEZj6xUQIPsZilLgczHk85yldsWV
   TVDExR2u72JtN1jaB8iUB5pNAe0EcXF3KDQmDnNkSpAncyjF24WtWfLzD
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2022 10:54:26 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 May 2022 10:54:24 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 27 May 2022 23:24:01 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id E0C241846; Fri, 27 May 2022 23:23:59 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, shawn.lin@rock-chips.com,
        yoshihiro.shimoda.uh@renesas.com, digetx@gmail.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V8 1/5] mmc: core: Capture eMMC and SD card errors
Date:   Fri, 27 May 2022 23:23:52 +0530
Message-Id: <1653674036-21829-2-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add changes to capture eMMC and SD card errors.
This is useful for debug and testing.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  | 10 +++++++++-
 include/linux/mmc/host.h | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4b70cbf..ef53a25 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -943,9 +943,11 @@ int mmc_execute_tuning(struct mmc_card *card)
 	}
 
 	/* Only print error when we don't check for card removal */
-	if (!host->detect_change)
+	if (!host->detect_change) {
 		pr_err("%s: tuning execution failed: %d\n",
 			mmc_hostname(host), err);
+		mmc_debugfs_err_stats_inc(host, MMC_ERR_TUNING);
+	}
 
 	return err;
 }
@@ -2244,6 +2246,12 @@ void mmc_rescan(struct work_struct *work)
 		if (freqs[i] <= host->f_min)
 			break;
 	}
+
+	/*
+	 * Ignore the command timeout errors observed during
+	 * the card init as those are excepted.
+	 */
+	host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
 	mmc_release_host(host);
 
  out:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c193c50..eb8bc5b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -93,6 +93,25 @@ struct mmc_clk_phase_map {
 
 struct mmc_host;
 
+enum mmc_err_stat {
+	MMC_ERR_CMD_TIMEOUT,
+	MMC_ERR_CMD_CRC,
+	MMC_ERR_DAT_TIMEOUT,
+	MMC_ERR_DAT_CRC,
+	MMC_ERR_AUTO_CMD,
+	MMC_ERR_ADMA,
+	MMC_ERR_TUNING,
+	MMC_ERR_CMDQ_RED,
+	MMC_ERR_CMDQ_GCE,
+	MMC_ERR_CMDQ_ICCE,
+	MMC_ERR_REQ_TIMEOUT,
+	MMC_ERR_CMDQ_REQ_TIMEOUT,
+	MMC_ERR_ICE_CFG,
+	MMC_ERR_CTRL_TIMEOUT,
+	MMC_ERR_UNEXPECTED_IRQ,
+	MMC_ERR_MAX,
+};
+
 struct mmc_host_ops {
 	/*
 	 * It is optional for the host to implement pre_req and post_req in
@@ -501,6 +520,7 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
+	u32			err_stats[MMC_ERR_MAX];
 	unsigned long		private[] ____cacheline_aligned;
 };
 
@@ -635,6 +655,12 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
 	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 }
 
+static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
+					     enum mmc_err_stat stat)
+{
+	host->err_stats[stat] += 1;
+}
+
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

