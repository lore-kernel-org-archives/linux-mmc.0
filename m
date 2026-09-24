Received: from mail-m127105.qiye.163.com (mail-m127105.qiye.163.com [115.236.127.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0A2D876F
	for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240803; cv=none; b=iFxycZaHlvyzZUzy4J1kfCE7yjymDGSyiKlFQGOv2WKRUrQs/fACDTbUSr8RfGWvMrn4LsJt1CazAOG9E719hLWbsXJwhOZuGD5jhn/3eTz2EzJ6A5q980KBE3BpdcfldfHjlJrIQ7DPmaJ6LeWIJHZPLqEm2g6BlHnaMG+Vfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240803; c=relaxed/simple;
	bh=o6N4S7NPxO/Ut6Vh4Q6RoepPtPcwAxvlrKfQS/YNuQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KTtDXCRDKjvlgdEZ6TOgd8A/Aoz9O4i7yxpspjkSOk0OCbwUDvHlg2opByVjYcjRo5ynm4H98j4tcN46gajlHk9TixCj41jTaJAy29QdICtIqxGzLHS5sRq8VrRMU06oaZNBHhqVn0bRuhruM1f/YP4iiql28kUkwiaCTVFKg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BlSfYSf8; arc=none smtp.client-ip=115.236.127.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BlSfYSf8"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f01e1b87;
	Thu, 24 Sep 2026 16:50:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] mmc: core: add mmc_send_tuning_timeout()
Date: Thu, 24 Sep 2026 16:50:22 +0800
Message-Id: <1790239823-139583-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790239823-139583-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790239823-139583-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0d29c3f4503a4kunm11feacd55405de
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUIeH1ZKHklISkJIQk
	1LQ05WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BlSfYSf8pl0lDDHELvsr++dVLOgOiS/TAnQ0+YMjRvy1ZQZDLyH1D5lXnDTpW/kdv+Jao2yr55g98FlfUQ/yb5tH9HnLPO6rdCtvblW3YmXqFChrPqZXYm28/3fIyAJS2hWXxatOvu621DHG2fXNa5v0LWJUbwTcnlXrVzUHj4k=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sruEtLMqlbgePRm762lKIDdTMJN72z82oizqShLTvfM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Add mmc_send_tuning_timeout() which takes the data timeout in
milliseconds, and turn mmc_send_tuning() into a thin wrapper keeping
the current 150 ms, so there is no behaviour change for the existing
callers.  This lets drivers pass a tighter timeout for software
tuning, e.g. hosts which scan the tuning window phase by phase.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/core/mmc_ops.c | 22 +++++++++++++++-------
 include/linux/mmc/host.h   |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index a952cc8..d59ff82f 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -673,7 +673,8 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
-int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
+int mmc_send_tuning_timeout(struct mmc_host *host, u32 opcode, int *cmd_error,
+			    u32 timeout_ms)
 {
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
@@ -707,12 +708,7 @@ int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 
-	/*
-	 * According to the tuning specs, Tuning process
-	 * is normally shorter 40 executions of CMD19,
-	 * and timeout value should be shorter than 150 ms
-	 */
-	data.timeout_ns = 150 * NSEC_PER_MSEC;
+	data.timeout_ns = timeout_ms * NSEC_PER_MSEC;
 
 	data.sg = &sg;
 	data.sg_len = 1;
@@ -740,6 +736,18 @@ int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
 	kfree(data_buf);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_send_tuning_timeout);
+
+int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
+{
+	/*
+	 * The eMMC and SD specs give the tuning process an overall
+	 * budget of 150 ms.  mmc_send_tuning() simply applies that as
+	 * the timeout of every single tuning command.  Drivers which
+	 * want a different timeout can use mmc_send_tuning_timeout().
+	 */
+	return mmc_send_tuning_timeout(host, opcode, cmd_error, 150);
+}
 EXPORT_SYMBOL_GPL(mmc_send_tuning);
 
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 198554e..032c018 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -753,6 +753,8 @@ static inline int mmc_card_uhs2_hd_mode(struct mmc_host *host)
 int mmc_sd_switch(struct mmc_card *card, bool mode, int group,
 		u8 value, u8 *resp);
 int mmc_send_status(struct mmc_card *card, u32 *status);
+int mmc_send_tuning_timeout(struct mmc_host *host, u32 opcode, int *cmd_error,
+			    u32 timeout_ms);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-- 
2.7.4

