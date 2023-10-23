Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2A7C004C0
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 13:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjJWNZW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJWNZF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 09:25:05 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F88170A
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698067395; x=1729603395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX2QT7XSaQaGHWlVuxvJpuzRAtfCOuekHhNcVZMqbGY=;
  b=oB07CDXe+XAYo50VV2Yc6TZX52R4fdk+r/N28feU6+Rr2M89HZe7FrdB
   KIDaosY+1X5AIaQoQq7oqqG7Gb06PN2MJF7rgdRf1cI0tI6YFNiUYdJIV
   D/qihsmvqL/qzwr0ni6wZfYKBhf92SPjCXXSkZQP7CWNwxjBRrsuFmRDF
   gV6qqmwP13y6Nk8Jk4HjU7VO0dmPXCmngGqvSL8iQLWk1offucZ0JRoNq
   V1rkz1INcMwWO21+K58z43kD6kNu6QGbEAp/Fml8PSaVORx2MaMiaRLJz
   vACQwGBAIemaOjZHEoPbP7rlVyLqKdnFQCibnaJhwDbSN9fKMiAMTRMRF
   A==;
X-CSE-ConnectionGUID: lq+sTpdLTn6vzDMBS192fw==
X-CSE-MsgGUID: Q+g/+0fEQ+ScjX+nLhdBxw==
X-IronPort-AV: E=Sophos;i="6.03,244,1694707200"; 
   d="scan'208";a="393864"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2023 21:23:15 +0800
IronPort-SDR: Ig6PjRrDmVHiNRlRff9ls+njXEJvLiiVX9anaypwrvIFNkFSB9ny6R6XDOnEt2PZVCD3gayh2e
 1TeBeh/VXn74l96OSdy2VcrU+a2TjA0YKuMb+J8eghv6WHMbYxv0vIXN3OC8yIb1O33v/slyVY
 yRxB/hkrKiIeSYs3Mb2luWcHDP6POtRptFp8lJBI9DX92WITvZmyMD39SEPk6/YyduwkU/pcje
 C3YyiNuzEX+KgiV8b4C5dod0YyJMILL/lWdP3bLKakKsbrJwVVtCW41HwiGtol8au1P6EjxHvd
 gPU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 05:29:29 -0700
IronPort-SDR: K0Y/CG+KyvI8xuYE8MNFynMXfYcGRcBgugY7/So7c7ebi81GS3in6n/4PGJP5eWR8SXKCQfFDe
 kG/h2X2O/wdXkJynP3RHzrCj3s9W30SUpeXgCdhrLvNJf02XfOBG/6ofXBpgFb7VKk2Sb4MY8d
 idrUT/wcfbenDkwj3MtOXhg2a1FXBiB1N3PSyR4u0kKeAU9fkrt0BAQ3Hmwt2ET9GqBnJ2F9wE
 1iynxtfOT1gd40CNfJI0Fv/KpLeyeXU9QKo2yJBIMLStlUJDqoWbx1ZfPNiJ1KH5o1LDm7qfVx
 o3c=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2023 06:23:13 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 1/2] mmc: core: Mark close-ended ffu in progress
Date:   Mon, 23 Oct 2023 16:21:27 +0300
Message-Id: <20231023132128.1871269-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132128.1871269-1-avri.altman@wdc.com>
References: <20231023132128.1871269-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Field Firmware Update (ffu) may use close-ended or open ended sequence.
Each such sequence is comprised of a write commands enclosed between 2
switch commands - to and from ffu mode. So for the close-ended case, it
will be: cmd6->cmd23-cmd25-cmd6.

Capture this sequence and make it available for the host modules, should
it is needed.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |  1 +
 include/linux/mmc/mmc.h  |  1 +
 3 files changed, 36 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..ee5ec4686582 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -96,6 +96,10 @@ static int max_devices;
 static DEFINE_IDA(mmc_blk_ida);
 static DEFINE_IDA(mmc_rpmb_ida);
 
+static unsigned int ffu_progress;
+#define MMC_FFU_START	BIT(0)	/* FFU in progress */
+#define MMC_FFU_SBC	BIT(1)	/* close-ended FFU in progress */
+
 struct mmc_blk_busy_data {
 	struct mmc_card *card;
 	u32 status;
@@ -464,6 +468,34 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 	return 0;
 }
 
+bool mmc_is_ffu_cmd(struct mmc_command *cmd)
+{
+	return ((ffu_progress & MMC_FFU_SBC) &&
+		cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK);
+}
+
+static void mmc_blk_ffu_progress(struct mmc_command *cmd)
+{
+	if (MMC_EXTRACT_INDEX_FROM_ARG(cmd->arg) != EXT_CSD_MODE_CONFIG &&
+	    ffu_progress == 0)
+		return;
+
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd->arg) == EXT_CSD_MODE_CONFIG) &&
+	    (cmd->opcode == MMC_SWITCH)) {
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd->arg);
+
+		if (value == 1)
+			ffu_progress = MMC_FFU_START;
+		else
+			ffu_progress = 0;
+
+		return;
+	} else if (ffu_progress == MMC_FFU_START &&
+		   cmd->opcode == MMC_SET_BLOCK_COUNT) {
+		ffu_progress |= MMC_FFU_SBC;
+	}
+}
+
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			       struct mmc_blk_ioc_data *idata)
 {
@@ -548,6 +580,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	    (cmd.opcode == MMC_SWITCH))
 		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
 
+	mmc_blk_ffu_progress(&cmd);
+
 	/* If it's an R1B response we need some more preparations. */
 	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
 	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2f445c651742..e2cb20f7c50c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -677,5 +677,6 @@ int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+bool mmc_is_ffu_cmd(struct mmc_command *cmd);
 
 #endif /* LINUX_MMC_HOST_H */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 6f7993803ee7..d4d10cabaa57 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -254,6 +254,7 @@ static inline bool mmc_ready_for_data(u32 status)
  */
 
 #define EXT_CSD_CMDQ_MODE_EN		15	/* R/W */
+#define EXT_CSD_MODE_CONFIG		30	/* R/W */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
-- 
2.42.0

