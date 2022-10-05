Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4AC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJEKUd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJEKUc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1A75CC2
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965232; x=1696501232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dGXSJEkacErT+CMoDEUiOkDAkmEkNZ8NLs8UbTLgyiE=;
  b=Fj47/nLHDukEA1AWp1r1ELCCw3/K/uDatB1YROlZfHbs+M1uD3bbRFHx
   uyImIjtLbYyh2rPHDxv4cazAy6XqQ3tkoh5cumJmYfiYow1axs1VMmmV4
   ls/9O9L7n9DWs/6ahZVqaxxGf9u9szIBq3+w9KSO2U+TH50+Ygx0hWaxE
   sLrbvJhMb8VRZF3lq5GFOSvWUBNjCpdRHURRYG6zmqV2JzbdfutnKAVS8
   IMsINe21FH4XNrcrEa7A/5cgvvgnIYv8tK1HDoANXUR0qRvXocWVkPxeW
   0cXc+8BfycQnV0cdOqy4mdvoa1ajvWoSnNcrpjFVUoJan1RHUTwNQ5ClO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110451"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110451"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605981"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605981"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 09/14] mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_bounce_block()
Date:   Wed,  5 Oct 2022 13:19:46 +0300
Message-Id: <20221005101951.3165-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

tifm_sd_bounce_block() calls functions that ultimate use kmap_atomic() to
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
 drivers/mmc/host/tifm_sd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index ed1685add446..d539f9b48422 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -264,16 +264,13 @@ static int tifm_sd_set_dma_data(struct tifm_sd *host, struct mmc_data *r_data)
 	unsigned int t_size = TIFM_DMA_TSIZE * r_data->blksz;
 	unsigned int dma_len, dma_blk_cnt, dma_off;
 	struct scatterlist *sg = NULL;
-	unsigned long flags;
 
 	if (host->sg_pos == host->sg_len)
 		return 1;
 
 	if (host->cmd_flags & DATA_CARRY) {
 		host->cmd_flags &= ~DATA_CARRY;
-		local_irq_save(flags);
 		tifm_sd_bounce_block(host, r_data);
-		local_irq_restore(flags);
 		if (host->sg_pos == host->sg_len)
 			return 1;
 	}
@@ -300,11 +297,9 @@ static int tifm_sd_set_dma_data(struct tifm_sd *host, struct mmc_data *r_data)
 	if (dma_blk_cnt)
 		sg = &r_data->sg[host->sg_pos];
 	else if (dma_len) {
-		if (r_data->flags & MMC_DATA_WRITE) {
-			local_irq_save(flags);
+		if (r_data->flags & MMC_DATA_WRITE)
 			tifm_sd_bounce_block(host, r_data);
-			local_irq_restore(flags);
-		} else
+		else
 			host->cmd_flags |= DATA_CARRY;
 
 		sg = &host->bounce_buf;
-- 
2.25.1

