Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF33C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Mar 2022 13:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiCBNFA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbiCBNE5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2022 08:04:57 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B446BC334B;
        Wed,  2 Mar 2022 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646226255; x=1677762255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Ei9xZmq+zF939bmO9VvFSVHK064S9yezB1LXtbk8v3g=;
  b=iPp9oQWR8fMPAmS7XBS1t3Bgpglx+GZ3PKHSfZQyZJQsFRDcx5G9B1ZM
   JKSJuXk2LpAIrp969WmM9lrnyXfM4XjULqOLkzV6L1XYGbKKaq9v51anu
   pkFcoetCgSQEUr6y09Oq7apO/Er6CDUWrZDegha6wcvopWcThSvb9A9MY
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 05:04:14 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Mar 2022 05:04:13 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 Mar 2022 18:33:56 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 807EC587B; Wed,  2 Mar 2022 18:33:55 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, quic_riteshh@quicinc.com,
        asutoshd@quicinc.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V4 4/7] mmc: debugfs: Add debug fs error state entry for mmc driver
Date:   Wed,  2 Mar 2022 18:33:44 +0530
Message-Id: <1646226227-32429-5-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add debug fs entry error state to query eMMC and SD card errors statistics.
If any errors occurred in eMMC and SD card driver level then
err_state value will be set to 1.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/core/debugfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index db0988c..7d78eac 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -222,6 +222,19 @@ static int mmc_clock_opt_set(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
+static int mmc_err_state_get(void *data, u64 *val)
+{
+	struct mmc_host *host = data;
+
+	if (!host)
+		return -EINVAL;
+
+	*val = host->err_state ? 1 : 0;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
 
 static int mmc_err_stats_show(struct seq_file *file, void *data)
 {
@@ -293,6 +306,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
 				   &mmc_clock_fops);
 
+	debugfs_create_file("err_state", 0600, root, host,
+		&mmc_err_state);
 	debugfs_create_file("err_stats", 0600, root, host,
 		&mmc_err_stats_fops);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

