Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD74C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 01:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AB7206F7
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 01:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCMBL0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:11:26 -0400
Received: from 97-93-29-23.dhcp.snlo.ca.charter.com ([97.93.29.23]:54444 "EHLO
        skomatineni-linux.nvidia.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbgCMBL0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 21:11:26 -0400
Received: by skomatineni-linux.nvidia.com (Postfix, from userid 1000)
        id 402D0104006E; Mon,  9 Mar 2020 17:13:27 -0700 (PDT)
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        baolin.wang@linaro.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, bradleybolen@gmail.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     skomatineni@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v1 1/3] mmc: core: Add capability for hosts supporting long HW busy wait
Date:   Mon,  9 Mar 2020 17:13:23 -0700
Message-Id: <1583799205-8442-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some mmc operation like SLEEP_AWAKE and cache flush through SWITCH
command takes longer time and for host controllers supporting HW
busy detection, core driver converts R1B type to R1 type response
for these commands if operation time is more than HW busy timeout
and uses SW poll for busy state.

This patch adds a host capability MMC_CAP2_LONG_WAIT_HW_BUSY for
hosts supporting long or infinite busy wait of HW busy detection
for these long mmc operations and prevents core driver from
converting R1B to R1 response type.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/core/mmc.c     | 3 ++-
 drivers/mmc/core/mmc_ops.c | 3 ++-
 include/linux/mmc/host.h   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c2abd41..5aea3a6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1916,7 +1916,8 @@ static int mmc_sleep(struct mmc_host *host)
 	 * from doing hw busy detection, which is done by converting to a R1
 	 * response instead of a R1B.
 	 */
-	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout)) {
+	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout) &&
+	    !(host->caps2 & MMC_CAP2_LONG_WAIT_HW_BUSY)) {
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 	} else {
 		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aa0cab1..251b4c7 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -579,7 +579,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	 * the host to avoid HW busy detection, by converting to a R1 response
 	 * instead of a R1B.
 	 */
-	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
+	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout) &&
+	    !(host->caps2 & MMC_CAP2_LONG_WAIT_HW_BUSY))
 		use_r1b_resp = false;
 
 	cmd.opcode = MMC_SWITCH;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 6aaa15e..1cda4dd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -371,6 +371,7 @@ struct mmc_host {
 #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
 #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
+#define MMC_CAP2_LONG_WAIT_HW_BUSY (1 << 27)	/* Host can support long busy timeout, do not convert R1B to R1 response */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
-- 
2.7.4

