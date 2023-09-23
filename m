Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C4CCE7A89
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Sep 2023 17:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjIWRjA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 23 Sep 2023 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIWRi7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Sep 2023 13:38:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E657124
        for <linux-mmc@vger.kernel.org>; Sat, 23 Sep 2023 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695490733; x=1727026733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=169pu1xICr15ZlWPDA1eyVoqKwmjBpMmXL77YoeCmb4=;
  b=BnfQINbmlr4S8j0TKZDlSVEaTmSWZPAd0GqhZP80snZ7re4QOXOporyq
   qRzz2F9gdU4g/1BDFp9sTSQZAedzlR1mjmtc0YZVIQ+AQBBTYTq+CYFy5
   nkchleQa1WHo0e/g9ibn5szD4/ibsUYRBBp1ehyYWjJ89529jJfA9bNdS
   pq/qcDJuFojexLvnxsX/v6/0IoLuq6mg11TKCm+akLdNfi2Ncz8LY5i2j
   1fL/DjR2f6r55QJB5Y0KWidkghg4kWLFZqY0s8Amc+ZM6aRIJzfcoeKd3
   7AXBKcktOys5F9QAL/96RzfXeYN2DYBbViT4DHcqBr4TIHtc5vrnR/Qo5
   A==;
X-CSE-ConnectionGUID: 3076itzcRbq70FiW0BnLLg==
X-CSE-MsgGUID: CBDElc93QIq1zsa6S2gY2g==
X-IronPort-AV: E=Sophos;i="6.03,171,1694707200"; 
   d="scan'208";a="242913934"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2023 01:38:52 +0800
IronPort-SDR: h6D/14yosj2VmLX1ofESp6Hnl9enzfFWEoSyMYe0dzVjgpGGRPbjTPxxeJipoTq0F/zaRWgkgj
 266zfz3q2IYt8wiKmXiouo8hNPIRlXYk9pMFx/fyR3qSs6ncJcbC9EXGz9CIcVz7rLcQrTw1Yp
 A75F2AXE6UaGuhdTOzMDBLv4lneE7AKeBTNzqa6r6mrWSH6Ipz9PRXS3udsEhOw8990PEoUz91
 ME7HVAoYVyHIHFEW6NM7co+alCeWqdjTeg1plK7H7JbTxNrCKQtIrxz6x6YZgRa3iy67ABvZxd
 05g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2023 09:45:43 -0700
IronPort-SDR: kMgdFnMx7dTZzahAS74WZTULT7NMhhpmvUz9rib/Nt82Cp1z5vFF4PItavL9SSyxe/kAtP72pQ
 Vwvbw1XD65cNjWlbUYdAw002tpQTGWEA0Ymfr6s9LnbJfvPQl9cOC2biUkbbwo6VuYFUbjC5Se
 V0XHG65rc1lq+JxjJbgipoZlc8TO4gHK+Kuv/6bvFAx1hYtw8UW/LIDMAV48/q6U9qy4qg7KRS
 V7FDQcygYSgcvKKdabKRP0I2q4oKSwpA5cVkpT4zVvbvxRM0ppVY2f1EybTmrRqbsCbFy6UYo/
 D/w=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2023 10:38:53 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc: Capture correct oemid
Date:   Sat, 23 Sep 2023 20:37:28 +0300
Message-Id: <20230923173728.1781844-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The OEMID is an 8-bit binary number that identifies the Device OEM
and/or the Device contents (when used as a distribution media either on
ROM or FLASH Devices).  It occupies bits [111:104] in the CID register:
see the eMMC spec JESD84-B51 paragraph 7.2.3.

So it is 8 bits, and has been so since ever - this bug is so ancients I
couldn't even find its source.  The furthest I could go is to commit
335eadf2ef6a (sd: initialize SD cards) but its already was wrong.  Could
be because in SD its indeed 16 bits (a 2-characters ASCII string).

It is important to fix it because we are using it as one of our quirk's
token, as well as other tools, e.g. the LVFS
(https://github.com/fwupd/fwupd/).

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..4a4bab9aa726 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
-- 
2.42.0

