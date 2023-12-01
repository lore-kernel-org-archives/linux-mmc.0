Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="gxNGJ2je"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3462E1A6
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 07:31:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so21420125e9.0
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701444706; x=1702049506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrDqyx6agu66CFsaEwAwGPFt5h6we10bOzm7YE4XX+0=;
        b=gxNGJ2jeuQGtb1QsJNITbFf+iT3QGZAmiMpR9SqfX5Wr7+Jcb5dSpHE/2YFUv5+ikx
         3AJAVFGpuDmiSPIWSNkDWF39estfYTg9jwGvy1OZDDbqOXIwqZA7fnWMhFmxyYqTE+W/
         XCmSvwEYH6oZWB4uZb1rXLmgXAV8++KVLMdoyTOCUXcFdwwhWP3K1hii3yWZl1Q9EGjf
         rLUiwwYCPW6Om2jfV0iZE29/tSBoeyR7PGRFpeLjdA8arORSBrdCyShfCBC4T821UYQ0
         RS3ZHP9VFFwFPbRyQK8+75CCqubs1deteehyrhSSo3mlxRx0/KSnY1/e8wGABSBdTBwj
         AOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444706; x=1702049506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrDqyx6agu66CFsaEwAwGPFt5h6we10bOzm7YE4XX+0=;
        b=aO7IALp0UTK6woioyaHHN52pXUTi7VJ4HDINu22qjpkQmIq1ATmkLIL9JCMjUAFY8E
         1f6TBgVdwvknubbqwGtvPV+nQes84ds3FmIKUEjVn7ZZpzyurt/0/CDOs++VuB8tZ/Np
         MIieLpu0Il9/954dnQ8Ay68JpIG13qit2T9X8m0n9n2QGNnCyQ8uV1C2XfCky5lb37hR
         BXPYVe+fkrPHSdr7H127V6b29s7OT4mo5HBDnD4ZW28hzPY74/Yalxoyz5s38cgJ/kZp
         SF/fYEcSyB1oDWzJRZJZxZPOdRiIGe8EC6edMtCn9GISB9lxckusGe4xVjaBBk8CHRQO
         heIA==
X-Gm-Message-State: AOJu0YxfSoIUjTiGPN4jq3b6cjQnrT5kURTkKfcArXtB+RPIAh6AvhWr
	ZubKATRWmjeX3DiEezWNYPkoMQ==
X-Google-Smtp-Source: AGHT+IF4yZefDhQfkn3bHpMubMuak5XxvCL7T38seWdW+e8Eg9jNLWcrCT1ET5ZnEZ3m4aGk9V5qkA==
X-Received: by 2002:a05:600c:468f:b0:40b:5e59:99ca with SMTP id p15-20020a05600c468f00b0040b5e5999camr346457wmo.234.1701444706433;
        Fri, 01 Dec 2023 07:31:46 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id l5-20020adffe85000000b0033331b248acsm1771415wrr.91.2023.12.01.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:31:45 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv4] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date: Fri,  1 Dec 2023 16:31:43 +0100
Message-Id: <20231201153143.1449753-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RPMB was converted to a character device, it added support for
multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
to a character device").

One of the changes in this commit was transforming the variable
target_part defined in __mmc_blk_ioctl_cmd into a bitmask.

This inadvertedly regressed the validation check done in
mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().

This commit fixes that regression.

Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: <stable@vger.kernel.org> # v4.14+
---

  v2:
     fixes parenthesis around condition
  v3:
     adds stable to commit header
  v4:
     fixes the stable version to v4.14
     adds Reviewed-by

 drivers/mmc/core/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..13093d26bf81 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -868,9 +869,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
@@ -3143,4 +3145,3 @@ module_exit(mmc_blk_exit);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
--
2.34.1
