Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4063AC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064F560FE3
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhDTNr3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:47:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53204 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhDTNr3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618926418; x=1650462418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ipml8iOydkUV2w1EzEnIa2R8H0R7xsUvGTaVaAgpxG8=;
  b=NeDEQcaIiBang4Nq59wPl5JsKK3lEfvSIPlO9BP7YQrVCZVD9O+myq7n
   /teWLxam+dTKDdpBdyIJYHZu1b8Mx+oU7r8i5MGP6MwyyOjHa3jau3Bm+
   yop58lC5QPwm7D4aRDx8IVJzjvwEZ7QOxxt1QynMmKAwTE9R+eoYFFQ7j
   BFljqu/gHpAmEUZ2u5ulGRUfHYBRWYLaThZZdzWs+xXeaGpIasaL7upzf
   wD7+pR5tNhBopf6VThp8/aXtiCjjCx2RVeqyH1YHbVU8zEX7pGMk4ssVz
   n9wgn3/rWhdvtMc8gcJsXyTmIHFcuUldyi5rrbMbvC3PEh78G+UrDKd/f
   g==;
IronPort-SDR: KBc8VeQWBVleVgW361+pD6t1gAHQmwa79VWMFxirsROckRR2GMrV/eaemFjjKjL8vMdlBAdLyQ
 +LotodBceEm8XXKTwtzKh715LZwo3uQy4y1VzVbADB9ERRt05Cr6ZW2RUo+mTGvQ8STJXXqwdU
 7B8wMduT51yyH1K48lUnBkgugmcuejxjVM4WwiQmOsNX6oGWXuFtdhkL75TBj2bEGM0WZbF4VO
 qpaupayCYjHkjmGlIPTBpqJnt6/BbvsnB5LC+JkMaLZh97rFTxkmqaCY8VAWr1WJSFjMZBd5nW
 ZCk=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="164889879"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 21:46:57 +0800
IronPort-SDR: dZZCk0Zd0HfCnJykZY5Sj4sE50IkL8LfoQAUb9w4qzbfgUy9v4HB5I060Ybk4GZf5N+66NpXfz
 fJ1AmP2fTEO3jzoOxfGJq88Qis3zxLjLof47W3BQbqY6JD5sBBwY/qxM7/Dn/y4btuPH1UcjWb
 vLodl/yeWbcKtVM3525iQRvai9chqYD/Nc6zx+LQRJOODnHUGwLFsC/3fYedOh514zMz+9KtVF
 pYX72k6krCrKn86w7sDuMYB98riR6rfBjHbcEcCQvQV1l805mIEkw2fCBtcVMV/9BR49uBw7yz
 zGGtYcwXaOu3yiIMNXmtKRnU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:27:37 -0700
IronPort-SDR: I/0onkIN50qRsxElpUknz1zAn5cHFyVbcY0cIz2vMw/8GTBrAStULyPV+X9r1e0HzK+xpVdk2R
 DuCmAWievpW/0UpmLbuAvGLmie6IcaZAk9iYqLjXq1Ulb7DWl1Ib5FtR62UwJff1FbEUKifRFl
 yQ/6/7bpATuUCl0mAK2UzuZEJjgdsHhm3Zzo2dmCeVE6n7AmHxVI30Ark99Rp6UWT1WK2NtFuq
 SC4k0H+0CIuJxqx8fEdQKTfQBVzYzWeOwxTN9pfwoj5a/tTVnfs2sjL9z6WXB1O3PRJfIypYAS
 YAU=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2021 06:46:57 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 2/2] mmc: block: Update ext_csd.cache_ctrl if it was written
Date:   Tue, 20 Apr 2021 16:46:41 +0300
Message-Id: <20210420134641.57343-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420134641.57343-1-avri.altman@wdc.com>
References: <20210420134641.57343-1-avri.altman@wdc.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 24e1ecbdd510..7e70f11e85e2 100644
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

