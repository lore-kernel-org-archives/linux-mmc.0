Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904EC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Feb 2022 06:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiBPGFR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Feb 2022 01:05:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBPGFQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2022 01:05:16 -0500
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 22:05:04 PST
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7EC155C11
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2022 22:05:04 -0800 (PST)
Received: from localhost.localdomain (36-229-230-216.dynamic-ip.hinet.net [36.229.230.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E8A1340E38;
        Wed, 16 Feb 2022 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644990915;
        bh=PU5eTj/ytMNtCk92Lx1FCuQEXOf60kKz6t5NLgZnyoA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KDeGtw3iZzZ+JLQOk5mRXPFokOCssu5UQ7CXb6dfG1mUeUHPhBkO5EzIM0VSCaXdx
         NvLRW/i15FkQKT3DX5n9M0/U6StZ8Cme1Wn7K/0JYPYNrrqilxXBqB6GKT1NE3GjZk
         P9qMdUzQGh4/pleQKyQYtN3eRhfoYlQ2E8lJVkEwtOR+nZ3GefLqO7281DBD3OHUZK
         39RytLWqhdtWWhQdzq0AhRHPXu4SU8nvspfwAp92kHfcw7mSvJ4rgX8P1NlafYM1GF
         W9WjOtWkkTisLl9J9ej23FbzAksbtB27wlmXU1DU4peG5knZYoO6ydrIPsZxRQihXo
         akoLDEiObWDzw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ulf.hansson@linaro.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: rtsx: Let MMC core handle runtime PM
Date:   Wed, 16 Feb 2022 13:54:31 +0800
Message-Id: <20220216055435.2335297-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since MMC core handles runtime PM reference counting, we can avoid doing
redundant runtime PM work in the driver. That means the only thing
commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") misses is
to always enable runtime PM, to let its parent driver enable ASPM in the
runtime idle routine.

Fixes: 7499b529d97f ("mmc: rtsx: Use pm_runtime_{get,put}() to handle runtime PM")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 2a3f14afe9f83..265b3889f9d72 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -823,7 +823,6 @@ static void sd_request(struct work_struct *work)
 	}
 
 	mutex_lock(&pcr->pcr_mutex);
-	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -860,8 +859,6 @@ static void sd_request(struct work_struct *work)
 			data->bytes_xfered = data->blocks * data->blksz;
 	}
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 finish:
@@ -1093,7 +1090,6 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		return;
 
 	mutex_lock(&pcr->pcr_mutex);
-	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1127,8 +1123,6 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	rtsx_pci_switch_clock(pcr, ios->clock, host->ssc_depth,
 			host->initial_mode, host->double_clk, host->vpclk);
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 }
 
@@ -1144,7 +1138,6 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
 		return -ENOMEDIUM;
 
 	mutex_lock(&pcr->pcr_mutex);
-	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1154,8 +1147,6 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
 	if (val & SD_WRITE_PROTECT)
 		ro = 1;
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return ro;
@@ -1173,7 +1164,6 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 		return cd;
 
 	mutex_lock(&pcr->pcr_mutex);
-	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1183,8 +1173,6 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	if (val & SD_EXIST)
 		cd = 1;
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return cd;
@@ -1282,7 +1270,6 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 		return err;
 
 	mutex_lock(&pcr->pcr_mutex);
-	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1312,8 +1299,6 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
 			SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return err;
@@ -1334,7 +1319,6 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return err;
 
 	mutex_lock(&pcr->pcr_mutex);
-	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1367,8 +1351,6 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		err = sd_change_phase(host, DDR50_RX_PHASE(pcr), true);
 
 out:
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return err;
-- 
2.34.1

