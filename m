Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BDFC4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJEKUd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJEKUa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77D74CC2
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965229; x=1696501229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iApiaRkX3NpLoiypUKfBaKPYNfGTMaXUbRmeNC2CZAg=;
  b=npZ4bSuoCHN0fwfMnBtOJPHuMJquI2sgy1U9yeluoZR/WdFxqIomE9Og
   hsXVm1EwTJtHlO+Lb/5ekHifsZpLFMzYdRPnYptB2AO3r0KfD039bGRyU
   aE+IbfZRwdZNli/FDGaRw42x7h8u0lTzfBFPuX5/sRv4rNGruVy+8Bgbs
   ouQXKJYVqpWhzW9xgk9zXGQy7YViDg673UWGbsXjaDkItDMpih13JLKKc
   Q5rb+WeZmJbTAIOkzibgnPl32GHWNlJAclgRNkyOSnJBbH2snFzkwBLsq
   SVO2KSj27Pesh4VCrC/xbrXR+UwwCrP/42FsWh2LNKthYF7OFJA3eH7vI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110448"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110448"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605974"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605974"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:27 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 08/14] mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_transfer_data()
Date:   Wed,  5 Oct 2022 13:19:45 +0300
Message-Id: <20221005101951.3165-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

tifm_sd_transfer_data() calls functions that ultimate use kmap_atomic() to
map pages.

A long time ago the kmap_atomic API required a slot to be provided which
risked the possibility that other code might use the same slot at the
same time. Disabling interrupts prevented the possibility of an interrupt
handler doing that. However, that went away with
commit 3e4d3af501cc ("mm: stack based kmap_atomic()").

When the second argument to kmap_atomic was removed by commit 482fce997e14
("mmc: remove the second argument of k[un]map_atomic()"),
local_irq_{save,restore}() should have been removed also.

Remove it now.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/tifm_sd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 63917070b1a7..ed1685add446 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -506,7 +506,6 @@ static void tifm_sd_card_event(struct tifm_dev *sock)
 	unsigned int host_status = 0;
 	int cmd_error = 0;
 	struct mmc_command *cmd = NULL;
-	unsigned long flags;
 
 	spin_lock(&sock->lock);
 	host = mmc_priv((struct mmc_host*)tifm_get_drvdata(sock));
@@ -570,9 +569,7 @@ static void tifm_sd_card_event(struct tifm_dev *sock)
 
 			if (host_status & (TIFM_MMCSD_AE | TIFM_MMCSD_AF
 					   | TIFM_MMCSD_BRS)) {
-				local_irq_save(flags);
 				tifm_sd_transfer_data(host);
-				local_irq_restore(flags);
 				host_status &= ~TIFM_MMCSD_AE;
 			}
 		}
-- 
2.25.1

