Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF7C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 05:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2F161104
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 05:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhDTFyd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 01:54:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50509 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhDTFyc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 01:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618898042; x=1650434042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZvCgV9eVozx0O2riMmwZl8ZdBJ84xKKq5cbsop8x1Ws=;
  b=C1JDFUbMafufuOcPaHUVdGRsnbNMEobYf5MPZozGQCsroKwrugGR4VK0
   VE0LZDBeOrNNTQYjvN9k0PFx32qIGZaOThiqHoxlReKUGLsQVdpJfHZgc
   NufGOpIPvsaDXDhlPNZeZHqD3cf7e4Je7h4YHovTVshV/P+ka9GgpkoqG
   HHxAWk1oyqDZHCGN4KI+UL5DILmCys6IGmN1GXRq4je8VaeTRGNlkI256
   N9WckJkfJRHtqB2l2R/u0OiQwXacMb+H9fOcBIQMcDqpc4S90IQmoLD1O
   f8XMTnRN0QKEVQT8H9S+RVuEuQQfYNcKZQgBOLX/skXbbpIcCkPZJkbFR
   w==;
IronPort-SDR: rvOgPxmw97kUcWLv//lQt5Wz4qtQg2DP1WCNflEX9s5dfbjJxNnQ113nmF0DjNZAc1OD813msJ
 8eWMhzkbLpyR3cbiFr/5AfdmVbWwWTppPjV9KNV5R1vKSNgh0KlBKayIDNAVj3Moas/46AzITB
 qonUOd34Ls22nLrt4/TSxIswoxYfupwuxGxAQVcyl9UZ+ZpVvCX3vYbU4qoVUJ3QbRS7Nb16dg
 l9Xn4Q1bazmvNFnCEsr08UTDpcQrnvr3iySbi0DWosdr0k2ALDxhNthRHBUELGTZWrmxHv/BUy
 KTw=
X-IronPort-AV: E=Sophos;i="5.82,236,1613404800"; 
   d="scan'208";a="166063859"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 13:54:01 +0800
IronPort-SDR: TC1piOpen1fkFj8UXC2tZt/YKuA1/szdPzK9Vw9ZKxP7YrYJE3glnF2f48VlKoL/x5mSeO+wuZ
 j19Env1vpS52FW2A+n2Ag8Ah792QEWTogSXNFZYFmtMFONajxjguGvr0/W0kF8N/jwAiJ7sCxC
 oE552T3z1sb1aFLRmURtev3nsD+nArXgqj/MRely//Ri+l/YYde6cbuHOutx+1MKmh13luh498
 4WBQRQazODfllOeYS/Nwk4GBgOY49YRC3pN+1Dwe92HwmBNfKy5P5lUHlL61Km4Phx0e6AcXgv
 1F4MgREPp6vY7AMM5j6WNG9R
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 22:34:41 -0700
IronPort-SDR: brC9mzmUaNmjcemcaXfMYkx3U9LhKqXystImI44IstD23P/GMQk6tROmxcUCtRQyuhA7aSf1wX
 a0Lq0rEUs2763lrxvgJJT5d5p9EjLR4Gt1zwG1sOCJHhchmtdsGgkeaLYmZv9366wcsoYdm6/D
 lWtJBaW9PCo/Gqa1/GEb2tOflz3OyuSnGTTHGjqQg95qsgoLgvOrjXwLnBVca2UTa2YdEVz4lh
 o0+FONwCXMCuobyJ/8rLnpD0lQ2YnXECCaqcsATT7G33R0NwbSpQoEFCG9qlwqt/TfeaK9frcW
 7yk=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Apr 2021 22:53:59 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 2/2] mmc: block: Update ext_csd.cache_ctrl if it was written
Date:   Tue, 20 Apr 2021 08:53:06 +0300
Message-Id: <20210420055306.4858-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420055306.4858-1-avri.altman@wdc.com>
References: <20210420055306.4858-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The cache function can be turned ON and OFF by writing to the CACHE_CTRL
byte (EXT_CSD byte [33]).  However,  card->ext_csd.cache_ctrl is only
set on init if cache size > 0.

Fix that by explicitly setting ext_csd.cache_ctrl on ext-csd write.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 5b6501fc9fb7..8b07ed5e08de 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -572,6 +572,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
 	}
 
+	/*
+	 * Make sure to update CACHE_CTRL in case it was changed. The cache
+	 * will get turned back on if the card is re-initialized, e.g.
+	 * suspend/resume or hw reset in recovery.
+	 */
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1;
+
+		card->ext_csd.cache_ctrl = value;
+	}
+
 	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
-- 
2.25.1

