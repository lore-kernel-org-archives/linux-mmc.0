Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFD7C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Mar 2022 13:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiCBNE7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242034AbiCBNE5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2022 08:04:57 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FCC249E;
        Wed,  2 Mar 2022 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646226255; x=1677762255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HZxY7+ZsrGw8oObNGY8X+cyJQXGArfCk6MTvsHYl7TY=;
  b=QT27cEtQTXNLa2RuougvwBHc+fOkYkoARx0rKAsmsQm7SfDpHfZXn4ae
   ms3wJdgEIXndWHpC/cX/IKS+sY8wKaut1MBDPGbfftZdD731j2uO72AJm
   WksoVduVPQp7GBnqY+bnnfuvtpBlsVV/k+NOChVWkc4DRlOjutkxHRF/N
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 05:04:14 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Mar 2022 05:04:13 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 Mar 2022 18:33:57 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id C80A8587B; Wed,  2 Mar 2022 18:33:56 +0530 (IST)
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
Subject: [PATCH V4 5/7] mmc: core: Set error state for mmc driver
Date:   Wed,  2 Mar 2022 18:33:45 +0530
Message-Id: <1646226227-32429-6-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If any errors observed in eMMC and SD card set error state.

User can read error state value and confirm any errors observed or not,
error state set means error obeserved and vice versa.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 include/linux/mmc/host.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3b7f1e5..28baa07 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -518,6 +518,7 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 	u32                     err_stats[MMC_ERR_MAX];
+	bool			err_state;
 
 	unsigned long		private[] ____cacheline_aligned;
 };
@@ -653,6 +654,11 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
 	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 }
 
+static inline void mmc_debugfs_err_stats_enable(struct mmc_host *host)
+{
+	host->err_state = true;
+}
+
 static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
 		enum mmc_err_stat stat) {
 	host->err_stats[stat] += 1;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

