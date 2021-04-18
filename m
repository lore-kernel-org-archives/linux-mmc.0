Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DEC433B4
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Apr 2021 06:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE30C61207
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Apr 2021 06:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhDRGBB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Apr 2021 02:01:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20872 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhDRGA6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Apr 2021 02:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618725630; x=1650261630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILy/1Ka5cRDk4OaWwBFmwqsPK2xE2M4mVMhdCRatg5E=;
  b=ZmIvw1wVD3M0ktO+z77ue0EIVUk3H3hIKuItBoj4pXCKFUQC2tYFF4S8
   bzrZW9NLTEjG0E/CroL98I2CGzrimCtyr8AGzcFiMrKmeTZdfQhfkDz+K
   Oe7H0SpnLHOx1LFuuwhYkhk313FtewxFA8WSTOX+2MlLl2OIUVWYg9d9J
   /mV3a/D/XBj5nrsh8ezXngU/TD9A7yyD+illWjvr3tAtAcCDPbGkebwKy
   pJiWHLy0L3N6IGojz4EM4Yn8xTPKRJuzgruQuMXAm7Zcf20a6WB6a2K66
   6hTUt9dwB4Puep5n0MFhcoBuYXP6yYHwpDQaoKpHxxvJljcdQGYl6/9Yc
   w==;
IronPort-SDR: HgHwxLmavdS4hymMN/PG9SPVCaBF01QIbNKGKVCH5xbfZpehW4YQB/FmcnlrJr8pf5Uulh09sD
 GjGsdTtXdPr4j0OlvUsTKe8BNl+X9YvfqEC0J9KdVQdpSGfZUg3qCQ8owynIL5Rwxxh7r97x+9
 OUUXIXUhypMv7iLcPgYF0lGiIRr8ENrHqvzu7uP6NIy/NbmqAVU1bdLOtVIK7divROGUbS1PEx
 td5f8iVy9mIKTBIfrux1l1VVClnql6TQj39qSPjrlFwW4k/dwqptlRADtTJuMoy8IS1C0IQRyE
 Cbc=
X-IronPort-AV: E=Sophos;i="5.82,231,1613404800"; 
   d="scan'208";a="165325940"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 14:00:30 +0800
IronPort-SDR: s5VEf+h1tfIFhADcOGlYrMya5ufLkqficZSZ8qLi9+b55AjvelViMaegxOOhuSEjQmfMAsEi28
 lo4esMpChsNhHnKkh6v6PDzxAj7v5ILDqbXA/HmZiFliuE6lS4gI2/PQG6PwP7xWKc/FJ3ur0K
 wb4Q3YTo+c65dKnkkkuwzDGr8sYGYavro12yuWfH4W+B8D7JRxHkq56MF7x+XzRhbV7Re8GFfl
 AqS8tZLhNuBc8I5u2ZnKwlWIGnI8hMbb3wOfvABDhl4snBvqJe7poFfSy0p3trPb+0vROAu3+h
 2v68HjEPzyBImYTmZDNuqtF2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 22:41:17 -0700
IronPort-SDR: 6uvZh02vxWp+6R7jRXQrNcr8pbxoVEP+QIOLZ/0/tAi7DzZrPR+LWngIYjHlEiJ67yrKYbgWUH
 keoSm6+JGA3gybd/dLs/TnUYpdAnEabcd6stPVgmdeJ+AiHTVHIX0hASUlzJaCkEd2ihgu6LC5
 opzMvL+xRCgDyYrf+u5n7k9pPVQJ2uD6MzrGsR/UJw1EH5tFWShf+jWNIMdODmE+bUtMDX4HpL
 HULceDUWv59gt1RLuBxdrC8TOFCEscKWI9gPUX1d4u+2prNHD+5NOHS+bxfLbTcMPEwy9/ODUu
 fW0=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Apr 2021 23:00:29 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 2/2] mmc: block: Update ext_csd.cache_ctrl if it was written
Date:   Sun, 18 Apr 2021 08:59:53 +0300
Message-Id: <20210418055953.26959-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210418055953.26959-1-avri.altman@wdc.com>
References: <20210418055953.26959-1-avri.altman@wdc.com>
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
index 6800feb70c92..0372702231ce 100644
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

