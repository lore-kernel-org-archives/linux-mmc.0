Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ECCC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 May 2022 07:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiERHCw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 May 2022 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiERHCv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2022 03:02:51 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E549C89;
        Wed, 18 May 2022 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652857369; x=1684393369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8ghzeDCX0+Bcke44IcV9bQAIyZcIT41ZtLh4wGuim6U=;
  b=Kg25GiiW5gS/Rn68zn8D2I4JxoNUgeGh00UGUFQQh3+2i3A64Jg6p/OW
   /yK1wKfuficVzboW0tDd+uiSnhH5Aj+Nau5HE+zhzXTQWsiOTbxpmx6KX
   me34FvmQ9CERSdn7keKIZsgzJzxsiaYN43LL+LbDzUsEgm82UjdKeAiTG
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 00:02:49 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 May 2022 00:02:47 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 18 May 2022 12:32:30 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 5971A177B; Wed, 18 May 2022 12:32:28 +0530 (IST)
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
Subject: [PATCH V6 5/5] mmc: cqhci: Capture eMMC and SD card errors
Date:   Wed, 18 May 2022 12:32:20 +0530
Message-Id: <1652857340-6040-6-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
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
---
 drivers/mmc/host/cqhci-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 31f8412..7f25cca 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -822,8 +822,15 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc), status);
 
 	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
-	    cmd_error || data_error)
+	    cmd_error || data_error) {
+		if (status & CQHCI_IS_RED)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_RED);
+		if (status & CQHCI_IS_GCE)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_GCE);
+		if (status & CQHCI_IS_ICCE)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_ICCE);
 		cqhci_error_irq(mmc, status, cmd_error, data_error);
+	}
 
 	if (status & CQHCI_IS_TCC) {
 		/* read TCN and complete the request */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

