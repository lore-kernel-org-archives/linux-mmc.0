Return-Path: <SRS0=iaiu=2E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A0C43603
	for <linux-mmc@archiver.kernel.org>; Sat, 14 Dec 2019 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF6320724
	for <linux-mmc@archiver.kernel.org>; Sat, 14 Dec 2019 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="O/OM243A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLNR7B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 14 Dec 2019 12:59:01 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:57047 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfLNR7A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 14 Dec 2019 12:59:00 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47ZwJd3QbBz5H;
        Sat, 14 Dec 2019 18:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1576346338; bh=HWrFuqsLN2e7ZXc4wXhIDuUG2FViqtH35TVxEiCSjXY=;
        h=Date:From:Subject:To:Cc:From;
        b=O/OM243AzrpUrlSBhD7DCEQPql1bf+wE76TBP8BvOLvFpzEcsHjy/p24m21fMR7tO
         Rp4gT22K9SWZSPwzarculQCEnmuENy+FU/sUKtZVDuUWtQARdgohjRXNjqKgFDdeUJ
         HbrHe+8U1QpmzTAFPO2+nolir88H1PiuwHMf7WM1PlySjbX1Kh1wgQkedKchOwNELh
         8JD/B4iOPDxtMW4frX7F1iuUI0E/SyiAw6nToOKil29YpnuXrHc+V4T9/vCjcsnMzH
         MiKoNsEBNi0MXbPaEhJ0cdwnLez/IaxUY1dYdPf8zpXwAT2QNOSJ6WKDImFK78Z+bs
         1wFks2d57AIQQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 14 Dec 2019 18:58:56 +0100
Message-Id: <fb942066b18940c863573ccb3fc09031d7f920d3.1576346084.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: core: avoid blocking CPU for long BKOPS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since the timeout for a command might be 10 minutes (fallback), don't
eat all CPU power spinning for completion (triggering lockup detector).
Implement delay with exponential backoff and a one second limit.

[158480.011769] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [fsck.f2fs:962]
[158480.014911] Modules linked in: brcmfmac brcmutil cfg80211 mmc_block sdhci_tegra cqhci sdhci_pltfm sdhci pwrseq_simple pwrseq_emmc mmc_core
[158480.018291] CPU: 3 PID: 962 Comm: fsck.f2fs Not tainted 5.5.0-rc1-next-20191209mq-00173-g716e74177313-dirty #95
[158480.021479] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[158480.024934] PC is at sdhci_card_busy+0x28/0x44 [sdhci]
[158480.028858] LR is at __mmc_switch+0x180/0x330 [mmc_core]
[158480.032449] pc : [<af03b118>]    lr : [<af009fcc>]    psr: 60000013
[158480.036004] sp : e79c9b38  ip : ee01dfd0  fp : 00f23d31
[158480.039339] r10: 00000000  r9 : 0000e020  r8 : b0c04900
[158480.042939] r7 : e763e000  r6 : 00000000  r5 : ee189000  r4 : ee189000
[158480.044909] r3 : f002b600  r2 : af03b0f0  r1 : ee01db00  r0 : 1fe70000
[158480.046857] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[158480.048870] Control: 10c5387d  Table: b76ac04a  DAC: 00000055
[158480.050807] CPU: 3 PID: 962 Comm: fsck.f2fs Not tainted 5.5.0-rc1-next-20191209mq-00173-g716e74177313-dirty #95
[158480.052913] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[...]
[158480.098604] [<b0101ab8>] (__irq_svc) from [<af03b118>] (sdhci_card_busy+0x28/0x44 [sdhci])
[158480.101406] [<af03b118>] (sdhci_card_busy [sdhci]) from [<af009fcc>] (__mmc_switch+0x180/0x330 [mmc_core])
[158480.104348] [<af009fcc>] (__mmc_switch [mmc_core]) from [<af00a3bc>] (mmc_run_bkops+0xdc/0x114 [mmc_core])
[158480.107209] [<af00a3bc>] (mmc_run_bkops [mmc_core]) from [<af067d88>] (mmc_blk_mq_complete_prev_req.part.4+0x8c/0x21c [mmc_block])
[158480.110043] [<af067d88>] (mmc_blk_mq_complete_prev_req.part.4 [mmc_block]) from [<af067f94>] (mmc_blk_rw_wait+0x7c/0x11c [mmc_block])
[158480.112914] [<af067f94>] (mmc_blk_rw_wait [mmc_block]) from [<af068c34>] (mmc_blk_mq_issue_rq+0x318/0x898 [mmc_block])
[158480.115733] [<af068c34>] (mmc_blk_mq_issue_rq [mmc_block]) from [<af069608>] (mmc_mq_queue_rq+0x124/0x244 [mmc_block])
[158480.118466] [<af069608>] (mmc_mq_queue_rq [mmc_block]) from [<b04560b0>] (__blk_mq_try_issue_directly+0x118/0x1a0)
[158480.121200] [<b04560b0>] (__blk_mq_try_issue_directly) from [<b04571c0>] (blk_mq_request_issue_directly+0x40/0x5c)
[158480.123980] [<b04571c0>] (blk_mq_request_issue_directly) from [<b0457228>] (blk_mq_try_issue_list_directly+0x4c/0xc0)
[158480.126780] [<b0457228>] (blk_mq_try_issue_list_directly) from [<b045bc70>] (blk_mq_sched_insert_requests+0x1b0/0x234)
[158480.129601] [<b045bc70>] (blk_mq_sched_insert_requests) from [<b04570a8>] (blk_mq_flush_plug_list+0x318/0x3f0)
[158480.132446] [<b04570a8>] (blk_mq_flush_plug_list) from [<b044bcb0>] (blk_flush_plug_list+0xc0/0xc8)
[158480.135292] [<b044bcb0>] (blk_flush_plug_list) from [<b044bcec>] (blk_finish_plug+0x34/0x4c)
[158480.138113] [<b044bcec>] (blk_finish_plug) from [<b024104c>] (read_pages+0x60/0x150)
[158480.140988] [<b024104c>] (read_pages) from [<b0241338>] (__do_page_cache_readahead+0x1fc/0x20c)
[158480.143893] [<b0241338>] (__do_page_cache_readahead) from [<b02361f8>] (generic_file_read_iter+0x9ac/0xd28)
[158480.146818] [<b02361f8>] (generic_file_read_iter) from [<b02b6920>] (__vfs_read+0x128/0x1a8)
[158480.149695] [<b02b6920>] (__vfs_read) from [<b02b6a34>] (vfs_read+0x94/0x11c)
[158480.152638] [<b02b6a34>] (vfs_read) from [<b02b6d34>] (ksys_read+0x50/0xbc)
[158480.155601] [<b02b6d34>] (ksys_read) from [<b0101000>] (ret_fast_syscall+0x0/0x50)
[158480.158490] Exception stack(0xe79c9fa8 to 0xe79c9ff0)
[158480.161430] 9fa0:                   00000003 01bec3b8 00000003 01bec3b8 00001000 00000000
[158480.164422] 9fc0: 00000003 01bec3b8 00000000 00000003 01bec3b8 01bdf178 a6fc3f70 00000000
[158480.167385] 9fe0: a6f95074 aecadaf8 a6f82c58 a6ef2284

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/core/mmc_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 09113b9ad679..e3005e5b9509 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -20,6 +20,7 @@
 #include "mmc_ops.h"
 
 #define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
+#define MMC_MAX_POLL_MS		(1000) /* 1 second */
 
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
@@ -454,6 +455,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	struct mmc_host *host = card->host;
 	int err;
 	unsigned long timeout;
+	unsigned int wait_ms;
 	u32 status = 0;
 	bool expired = false;
 	bool busy = false;
@@ -473,6 +475,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	}
 
 	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
+	wait_ms = 1;
 	do {
 		/*
 		 * Due to the possibility of being preempted while polling,
@@ -482,6 +485,11 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 
 		if (host->ops->card_busy) {
 			busy = host->ops->card_busy(host);
+			if (busy && !expired) {
+				mmc_delay(wait_ms);
+				if (wait_ms < MMC_MAX_POLL_MS)
+					wait_ms *= 2;
+			}
 		} else {
 			err = mmc_send_status(card, &status);
 			if (retry_crc_err && err == -EILSEQ) {
-- 
2.20.1

