Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBA4C4332E
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5063964FC7
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhCDAAO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:19204 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240998AbhCCKcL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Mar 2021 05:32:11 -0500
IronPort-SDR: Izo0VTZKsLwt5whglQsRsRGn9Qi70p9fs/ZChP0fGe4WRGHS0btmmAS7Dz5FV7mbq8g5o0BUh7
 NAxoKnQb7/ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="187267614"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="187267614"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:26:04 -0800
IronPort-SDR: qNbxjsDkiRVoqar4NBzDqkpqO1Kn7BSrNbmjqI94a0PD3dc4jVzQ2Vf7fhesD6Px5nqfh2+mB1
 GYWk6brSUYqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="406385750"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2021 01:26:02 -0800
Subject: [PATCH] mmc: mmc: Fix partition switch time
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Paul Fertser <fercerpav@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
 <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp>
 <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
 <20210223093247.GA2059@home.paul.comp>
 <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
 <20210223111926.GC2059@home.paul.comp>
 <CAPDyKFp=XhnoD0re3kwM-yt4URK4vc7UnJE_+oKnqierMuKJ5g@mail.gmail.com>
 <c9adeaa3-8833-fe2b-cea8-50b645db0a9d@intel.com>
 <CAPDyKFrWOs7xO1f+miz4cQznHcYQL+sunpzOW3Jg6P0rFOSS1g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <168bbfd6-0c5b-5ace-ab41-402e7937c46e@intel.com>
Date:   Wed, 3 Mar 2021 11:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrWOs7xO1f+miz4cQznHcYQL+sunpzOW3Jg6P0rFOSS1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Avoid the following warning by always defining partition switch time:

 [    3.209874] mmc1: unspecified timeout for CMD6 - use generic
 [    3.222780] ------------[ cut here ]------------
 [    3.233363] WARNING: CPU: 1 PID: 111 at drivers/mmc/core/mmc_ops.c:575 __mmc_switch+0x200/0x204

Reported-by: Paul Fertser <fercerpav@gmail.com>
Fixes: 1c447116d017 ("mmc: mmc: Fix partition switch timeout for some eMMCs")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0d80b72ddde8..8741271d3971 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -423,10 +423,6 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 
 		/* EXT_CSD value is in units of 10ms, but we store in ms */
 		card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
-		/* Some eMMC set the value too low so set a minimum */
-		if (card->ext_csd.part_time &&
-		    card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
-			card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
 
 		/* Sleep / awake timeout in 100ns units */
 		if (sa_shift > 0 && sa_shift <= 0x17)
@@ -616,6 +612,17 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.data_sector_size = 512;
 	}
 
+	/*
+	 * GENERIC_CMD6_TIME is to be used "unless a specific timeout is defined
+	 * when accessing a specific field", so use it here if there is no
+	 * PARTITION_SWITCH_TIME.
+	 */
+	if (!card->ext_csd.part_time)
+		card->ext_csd.part_time = card->ext_csd.generic_cmd6_time;
+	/* Some eMMC set the value too low so set a minimum */
+	if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
+		card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
+
 	/* eMMC v5 or later */
 	if (card->ext_csd.rev >= 7) {
 		memcpy(card->ext_csd.fwrev, &ext_csd[EXT_CSD_FIRMWARE_VERSION],
-- 
2.17.1


