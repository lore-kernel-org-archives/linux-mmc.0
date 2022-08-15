Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A5C00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 07:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbiHOHdl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHOHdj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 03:33:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27831183AD
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660548819; x=1692084819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZOsqDs1y2TB8CObDHbvMu/N5FecGKSYTKMtllmsB2H4=;
  b=SUWhJqXOHE4Cw8wRYK/jvUqvfIzsb10zNnPZVvO6UwHusUtsFQGEmpor
   CjnB9S76aWoIAXYbRFq9eBGFoIoGJ4kDKePA33F5V8jJgYKJXDwTIEiiB
   Zz+yxMstBhzN6XGzslDbKfmFf+fQOLk789zM0eYlobbUZDs1xpKMlFfRf
   8Iyfj+lvWVokdshl2y/xghjy1Lf2l+aSwAQZ+5IDexZFd3c0eLzUjousw
   twAQY2OFVGQz7UYWNzcUxPwZjEoO900FGFui0dGchbmnf/vU55M2jksRu
   m70nNFVtz9mxkRrEXBIkg1nbHiAVu4L4M2awyClahLP7aFORbt3DuRgLi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290663306"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="290663306"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="603108088"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:33:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Seunghui Lee <sh043.lee@samsung.com>,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH 2/2] mmc: sd: Fix inconsistent sd3_bus_mode with failed voltage switch
Date:   Mon, 15 Aug 2022 10:33:21 +0300
Message-Id: <20220815073321.63382-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815073321.63382-1-adrian.hunter@intel.com>
References: <20220815073321.63382-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If re-initialization results is a different signal voltage, because the
voltage switch failed previously but not this time (or vice versa), then
sd3_bus_mode will be inconsistent with the card because the SD_SWITCH
command is done only upon first initialization.

Fix by always reading SD_SWITCH information during re-initialization
which also means it does not need to be re-read later for the 1.8V
fixup workaround.

Note, brief testing showed SD_SWITCH took about 1.8ms to 2ms which added
about 1% to 1.5% to the re-initialization time, so not particularly
significant.

Reported-by: Seunghui Lee <sh043.lee@samsung.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sd.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index bc84d7dfc8e1..06aa62ce0ed1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -949,15 +949,16 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 
 		/* Erase init depends on CSD and SSR */
 		mmc_init_erase(card);
-
-		/*
-		 * Fetch switch information from card.
-		 */
-		err = mmc_read_switch(card);
-		if (err)
-			return err;
 	}
 
+	/*
+	 * Fetch switch information from card. Note, sd3_bus_mode can change if
+	 * voltage switch outcome changes, so do this always.
+	 */
+	err = mmc_read_switch(card);
+	if (err)
+		return err;
+
 	/*
 	 * For SPI, enable CRC as appropriate.
 	 * This CRC enable is located AFTER the reading of the
@@ -1480,26 +1481,15 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (!v18_fixup_failed && !mmc_host_is_spi(host) && mmc_host_uhs(host) &&
 	    mmc_sd_card_using_v18(card) &&
 	    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
-		/*
-		 * Re-read switch information in case it has changed since
-		 * oldcard was initialized.
-		 */
-		if (oldcard) {
-			err = mmc_read_switch(card);
-			if (err)
-				goto free_card;
-		}
-		if (mmc_sd_card_using_v18(card)) {
-			if (mmc_host_set_uhs_voltage(host) ||
-			    mmc_sd_init_uhs_card(card)) {
-				v18_fixup_failed = true;
-				mmc_power_cycle(host, ocr);
-				if (!oldcard)
-					mmc_remove_card(card);
-				goto retry;
-			}
-			goto cont;
+		if (mmc_host_set_uhs_voltage(host) ||
+		    mmc_sd_init_uhs_card(card)) {
+			v18_fixup_failed = true;
+			mmc_power_cycle(host, ocr);
+			if (!oldcard)
+				mmc_remove_card(card);
+			goto retry;
 		}
+		goto cont;
 	}
 
 	/* Initialization sequence for UHS-I cards */
-- 
2.25.1

