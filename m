Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2046DC0032E
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Oct 2023 11:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjJYLci (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Oct 2023 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjJYLce (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2023 07:32:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E810A
        for <linux-mmc@vger.kernel.org>; Wed, 25 Oct 2023 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698233551; x=1729769551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX2QT7XSaQaGHWlVuxvJpuzRAtfCOuekHhNcVZMqbGY=;
  b=QZg1In8/GiVkxgKFf01z2wMSWgWZ9oV5qNh8qHbfpegR59o3NH1ref/l
   WTCTv64CnTr+Ao+Ax3QDnlCtGqfJ8HzIw+OfhG9tETyAHiL3MyVo3Cxir
   OrNwGG6a/7biStfKIcxJk/Zp8734hRZXrN0y1T5nqoWBnyAEP3UomKvsX
   H6hvzfaI2D6z2nOnD3Odh6dVs6wH0ZYV4mAyq584IUm3uZrKjm1duZ+g+
   DI1VSZbApHlYgm0+ZkZjOZ8R6cMygn84nH0JTo07aixnNvsbV3KJrZyY1
   M4PGHUvZbmoFjCLaJ0spqFwOvRnrrjZzTk7sC7mpt9dBYdI5rFQPLWEQj
   w==;
X-CSE-ConnectionGUID: Or3O3trVTXOfxyykUIxV8g==
X-CSE-MsgGUID: VPGH31keRnuL7/84M9BWUw==
X-IronPort-AV: E=Sophos;i="6.03,250,1694707200"; 
   d="scan'208";a="597347"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2023 19:32:31 +0800
IronPort-SDR: mq+94rODAAJKtHvYZtHVM+Qe6w/M4Fti1yBt0iqmKjxmAeMMzcTzyJM36vyfRBISe/1zbPjMuj
 f2/linMlQs7gUhekz10+mMLvcM2bbfhkfwxs4kFg/fZrgZdYS/ilvdhEgOyuguDBezAS0+3wC2
 pxI6jXx+Zcd1oTO/kbx74CGdHikEOzrH5xFzQl0OzgBnwjNVTHA3XhaU72ykjlX+gwmm/g5U4i
 Gop4K1NSaSoc1EVJqc7dvj/hO6+rJUc1lzrw4PJJ54f/BQGqca0XSV1Ci5kGlWR8869SjvQbIA
 fyA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 03:38:42 -0700
IronPort-SDR: rQ3DddXVai906K9mTeg4WcCrxMp3dJ3wjBszVGjsCiqGltVVeEsXDnWFCvG7+Y9N4NtJZDIKhi
 A2uRucUlIqZAO5In/u6Zv1XOaKRQ4+y/n83ucBRia+w+igwFFNNv587CCoxvC6wsZAyH5j2bSW
 UL9/jO1HDOma5DacTpJZEMxyi+I24VA0Gsncew8zHz7OqpOjev4A7DHdVK4ICg4xDdrfaxMsO1
 5CHqeVLAFKUWvbTZ5HOk8PNGE2TPFg0X5N9WLpaUHzdin+nuLqntPJdv9AZtCize/e+hUIw1fU
 AiY=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2023 04:32:30 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 1/2] mmc: core: Mark close-ended ffu in progress
Date:   Wed, 25 Oct 2023 14:30:34 +0300
Message-Id: <20231025113035.1881418-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025113035.1881418-1-avri.altman@wdc.com>
References: <20231025113035.1881418-1-avri.altman@wdc.com>
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

